#include "stdio.h"
#include "stdlib.h"
#include "xparameters.h"

#include "../log/sys_log.h"
#include "../app_config.h"
#include "gps_uart.h"
#include "../sys/sys_int.h"
#include "../util/genq.h"
#include "../util/utils.h"
#include "ublox_drv.h"
#include "../sys/sys.h"

#define MSG_MAX_LEN	128

GENQ_DEF(gnss_msg, uint32_t, 2048, 256, 64);


static volatile gnss_data_t gnss_data_current;

static uint8_t msg_buf[MSG_MAX_LEN];

static void __set_msg_rate(const char *msg_type, uint8_t rate);
static void __send_msg(char *format, ...);

static void (*__pps_cb)(void * pctx);
void __pps_cb_blank(void *pctx){}

static void (*__time_upd_cb)(void * pctx);

static volatile bool gnss_fix = false;

static volatile bool pps_event = false;
static volatile bool msg_event = false;

// INTERRUPT CONTEXT. WATCH OUT FOR NON-THREADSAFE CALLS AND VARIABLES.
// This is safe. There are no shared resources with main context. Check out the callback function as well!
static void gnss_pps_handler(void *pctx)
{
	gnss_fix = true;
	pps_event = true;
	__pps_cb(pctx);
}

static char *_get_field_from_nmea(const char *nmea, uint8_t fieldnum)
{
	uint8_t sep = ',';
	char *ptr = (char *)nmea;

	uint8_t i;
	for(i=0; i<fieldnum; i++)
		ptr = strchr(ptr, sep) + 1;

	return ptr;
}

static int atoi_w_len(const char *a, uint8_t len)
{
	char temp[16];
	memset(temp, 0, sizeof(temp));

	memcpy(temp, a, len);

	return atoi(temp);
}

static float get_coordinate(const char *nmea, uint8_t cnum)
{
	// cnum = 0 is latitude, cnum = 1 is longitude

    char *coord, *hemi;
    float deg, min_int, min_frac, min, multi;


    //Latitude
    if(cnum == 0)
    {
		coord = _get_field_from_nmea(nmea, 3);
		deg = (float)atoi_w_len(coord, 2);
		min_int = (float)atoi_w_len(coord+2, 2);
		min_frac = (float)atoi_w_len(coord+5, 5);
		min = min_int + (min_frac / 100000);

		hemi = _get_field_from_nmea(nmea, 4);
		multi = (hemi[0] == 'N') ? 1.0 : -1.0;

		deg += (min/60);
		deg *= multi;

		return deg;
    }

    //Longitude
    else if(cnum == 1)
    {
		coord = _get_field_from_nmea(nmea, 5);
		deg = (float)atoi_w_len(coord, 3);
		min_int = (float)atoi_w_len(coord+3, 2);
		min_frac = (float)atoi_w_len(coord+6, 5);
		min = min_int + (min_frac / 100000);

		hemi = _get_field_from_nmea(nmea, 6);
		multi = (hemi[0] == 'E') ? 1.0 : -1.0;

		deg += (min/60);
		deg *= multi;

		return deg;
    }

    return 0;
}



// INTERRUPT CONTEXT. WATCH OUT FOR NON-THREADSAFE CALLS AND VARIABLES.
// It looks like no major problem should occur. Only shared structure is genq, which more or less separates writing and reading access.
static void gps_msg_handler(const char *msg)
{
	char *type_str = _get_field_from_nmea(msg, 0);
	bool is_rmc = ((type_str[0] == '$') && (strncmp(type_str+3, "RMC", 3) == 0));

	if(!is_rmc)
	{
		genq_data_t new_msg;
		new_msg.data = (uint8_t *)msg;
		new_msg.dlen = strlen(msg) + 1;
		uint32_t dummy = 0;
		genq_add(gnss_msg, &dummy, &new_msg);

		return;
	}

	gnss_data_t *gd = (gnss_data_t *)&gnss_data_current;
	memset(gd, 0, sizeof(gnss_data_t));

	char *ts_str = _get_field_from_nmea(msg, 1);
	char *date_str = _get_field_from_nmea(msg, 9);

	memcpy(gd->nmea_rmc, msg, strlen(msg));
	gd->time.hour = atoi_w_len(ts_str, 2);
	gd->time.min = atoi_w_len(ts_str+2, 2);
	gd->time.sec = atoi_w_len(ts_str+4, 2);
	gd->time.day = atoi_w_len(date_str, 2);
	gd->time.month = atoi_w_len(date_str+2, 2);
	gd->time.year = atoi_w_len(date_str+4, 2) + 2000;
	gd->sec_of_the_day = (((gd->time.hour * 60) + gd->time.min) * 60) + gd->time.sec;

	gd->pos.latitude = get_coordinate(msg, 0);
	gd->pos.longitude = get_coordinate(msg, 1);

	gd->utc_timestamp = gd->sec_of_the_day + (86400 * days_from_civil(
											(int)gd->time.year,
											(unsigned)gd->time.month,
											(unsigned)gd->time.day));

	msg_event = true;
}

void gnss_pps_set_callback(void (*pps_cb)(void * pctx))
{
	// Set callback
	__pps_cb = (pps_cb == NULL) ? __pps_cb_blank : pps_cb;
}

static void gnss_msg_release_handler(void *_e, genq_data_t *e_d)
{
	LOG_DEBUG("[GNSS] G -> H: %s", e_d->data);
	genq_entry_release(gnss_msg);
}

int gnss_init(uint16_t uart_dev_id, void (*pps_cb)(void * pctx), void (*time_update_cb)(void * pctx))
{
	// Set callback
	__pps_cb = (pps_cb == NULL) ? __pps_cb_blank : pps_cb;
	__time_upd_cb = time_update_cb;

	int ret = gps_uart_initialize(uart_dev_id, gps_msg_handler);

	genq_init(gnss_msg, gnss_msg_release_handler, NULL);

	// Priority is 16, third highest
	ret = scugic_connect_int(INTR_ID_GNSS_PSS, gnss_pps_handler, INT_PRIO_GNSS_PPS, true, (void *)&gnss_data_current);
    if(ret != XST_SUCCESS)
    {
    	LOG_CRITICAL("GNSS 1PPS interrupt source connect failed: %d\r\n", ret);
    }

	if(ret == XST_SUCCESS)
	{
		__set_msg_rate("GSA", 0);
		__set_msg_rate("VTG", 0);
		__set_msg_rate("GSV", 0);
		__set_msg_rate("GLL", 0);
		__set_msg_rate("GGA", 0);
	}

	return ret;
}

gnss_data_t *gnss_get_current(void)
{
	return (gnss_data_t *)&gnss_data_current;
}


void gnss_process(void)
{
	if(pps_event && msg_event)
	{
		pps_event = false;
		msg_event = false;
		if(__time_upd_cb != NULL)
			__time_upd_cb((void *)&gnss_data_current);
	}

	genq_process(gnss_msg);
}


bool gnss_check_for_fix(void)
{
	return gnss_fix;
}

void gnss_wait_for_fix(void)
{
	uint64_t time = SYS_TIME();

	if(!gnss_fix)
		LOG_INFO("Waiting for GNSS fix...");
	while(!gnss_fix)
	{
		if(TICK_SINCE(time) > 1000)
		{
			time = SYS_TIME();
			BASIC_PRINT(".");
		}
	}

	BASIC_PRINT("OK\r\n");
}

static uint8_t __calculate_checksum(const char *msg)
{
    uint8_t i, checksum = 0;
    for(i = 0; msg[i]; i++)
        checksum ^= msg[i];

    return checksum;
}

static void __send_msg(char *format, ...)
{
	uint8_t dlen;
	memset(msg_buf, 0, sizeof(msg_buf));
    va_list args;

    // First character
    msg_buf[0] = '$';

    va_start(args, format);
    vsnprintf((char *)msg_buf + 1, MSG_MAX_LEN - 1, format, args);
    va_end(args);

    // Append checksum
    uint8_t chksum = __calculate_checksum((const char *)(msg_buf + 1));
    dlen = strlen((char *)msg_buf);
    sprintf((char *)(msg_buf + dlen), "*%.2X\r\n", chksum);


    LOG_DEBUG("[GNSS] H -> G: %s", msg_buf);

    gps_uart_tx(msg_buf, strlen((char *)msg_buf));
}

static void __set_msg_rate(const char *msg_type, uint8_t rate)
{
	__send_msg("PUBX,40,%s,0,%u,0,0,0,0", msg_type, rate);
}
