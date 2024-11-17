#include "parser.h"

int hls_atoi_w_len(char* s, uint8_t n) 
{
    #pragma HLS INLINE OFF
    int res = 0;
    bool is_neg = false; 
    for(int i=0; s[i]!=(char)0 && i<n; i++) {
        if(s[i] == '-') {
            is_neg = true;
            continue;
        }
        res = res * 10 + (int)(s[i] - '0');
    }
    if(is_neg == true) {
        res *= -1;
    }
    return res;
}

data_bool hls_strncmp(char msg[], const char* c, uint8_t len)
{
    for(int i=0; i<len; i++) {
        if(msg[i] != c[i]) {
            return 0; 
        } 
    }
    return 1;
}



ap_int<32> hls_days_from_civil(ap_int<32> y, unsigned m, unsigned d)
{
    y -= m <= 2;
    ap_int<32> era = (y>=0 ? y : static_cast<ap_int<32>>(y-399))/400 ;
    ap_uint<32> yoe = static_cast<ap_uint<32>>(y - era * 400);      // [0, 399]
    ap_uint<32> doy = (153*(m > 2 ? m-3 : m+9) + 2)/5 + d-1;  // [0, 365]
    ap_uint<32> doe = yoe * 365 + yoe/4 - yoe/100 + doy;         // [0, 146096]
    return era * 146097 + static_cast<ap_uint<32>>(doe) - 719468;
}

char *hls_get_field_from_nmea(const char nmea[], uint8_t fieldnum)
{
    #pragma HLS INLINE OFF
    //#pragma HLS FUNCTION_INSTANTIATE variable = fieldnum
	char sep = ',';
	char *ptr = (char *)nmea;

	uint8_t i;
	for(i=0; i<fieldnum; i++) 
    {
        for(uint8_t j=0; ptr[0]!=sep && ptr[0]!=0; j++)
        {
            ptr++;
        }
        ptr++;
    }
	return ptr;
}

float hls_get_coordinate(const char *nmea, data_bool cnum)
{
    #pragma HLS INLINE OFF
    #pragma HLS FUNCTION_INSTANTIATE variable = cnum

	// cnum = 0 is latitude, cnum = 1 is longitude

    char *coord, *hemi;
    float deg, min_int, min_frac, min, multi;

    //Latitude
    if(cnum == 0)
    {
		coord = hls_get_field_from_nmea(nmea, 3);
		deg = (float)hls_atoi_w_len(coord, 2);
		min_int = (float)hls_atoi_w_len(coord+2, 2);
		min_frac = (float)hls_atoi_w_len(coord+5, 5);
		min = min_int + (min_frac / 100000);

		hemi = hls_get_field_from_nmea(nmea, 4);
		multi = (hemi[0] == 'N') ? 1.0 : -1.0;

		deg += (min/60);
		deg *= multi;

		return deg;
    }
    //Longitude
    else if(cnum == 1)
    {
		coord = hls_get_field_from_nmea(nmea, 5);
		deg = (float)hls_atoi_w_len(coord, 3);
		min_int = (float)hls_atoi_w_len(coord+3, 2);
		min_frac = (float)hls_atoi_w_len(coord+6, 5);
		min = min_int + (min_frac / 100000);

		hemi = hls_get_field_from_nmea(nmea, 6);
		multi = (hemi[0] == 'E') ? 1.0 : -1.0;

		deg += (min/60);
		deg *= multi;

		return deg;
    }

    return 0;
}


//note that input is an input axi stream
//output is routed on the fgpa fabric to another systemverilog component, so no need for interface pragma
void gps_translation(hls::stream<char> &msg, data_bool pps, gnss_data_t &gd, data_bool &data_valid) {
    #pragma HLS interface mode=axis port=msg

    static char msg_shift[NMEA_MAX] = {(char) 0};
    static char stored_msg[NMEA_MAX] = {(char) 0};

    //shift register
    //sample_loop: for(int i=0; msg_shift[0] != '$' && i<NMEA_MAX ;i++) {
        shift_loop: for(uint8_t j=NMEA_MAX-1; j>0; j--) {
            msg_shift[j] = msg_shift[j-1];
        }
        if(!msg.empty()) msg_shift[0] = msg.read();
    //}

    data_bool is_rmc = (msg_shift[0] == '$') && (hls_strncmp(msg_shift+3, "RMC", 3)) && (pps == 1);
    gd = gnss_data_t();

    if(!is_rmc) return;

    for(uint8_t i=0; i<NMEA_MAX; i++) {
        stored_msg[i] = msg_shift[i];
    }

    data_valid = 0;
	char *ts_str = hls_get_field_from_nmea(stored_msg, 1);
	char *date_str = hls_get_field_from_nmea(stored_msg, 9);

	gd.hour = hls_atoi_w_len(ts_str, 2);
	gd.min = hls_atoi_w_len(ts_str+2, 2);
	gd.sec = hls_atoi_w_len(ts_str+4, 2);
	gd.day = hls_atoi_w_len(date_str, 2);
	gd.month = hls_atoi_w_len(date_str+2, 2);
	gd.year = hls_atoi_w_len(date_str+4, 2) + 2000;
	gd.sec_of_the_day = (((gd.hour * 60) + gd.min) * 60) + gd.sec;

	gd.latitude = hls_get_coordinate(stored_msg, 0);
	gd.longitude = hls_get_coordinate(stored_msg, 1);

	gd.utc_timestamp = gd.sec_of_the_day + (86400 * hls_days_from_civil(gd.year, gd.month, gd.day));
    data_valid = 1;
}

