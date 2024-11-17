#include <iostream>
#include <vector>
#include "parser.h"
#include "stdio.h"
#include "stdlib.h"

#define println(label, c) \
std::cout << label << " " << c << std::endl \

#define printcln(label, a, b) \
std::cout << label << " " << a << " " << b << std::endl \

int days_from_civil(int y, unsigned m, unsigned d) noexcept
{
    y -= m <= 2;
    const int era = (y >= 0 ? y : y-399) / 400;
    const unsigned yoe = static_cast<unsigned>(y - era * 400);      // [0, 399]
    const unsigned doy = (153*(m > 2 ? m-3 : m+9) + 2)/5 + d-1;  // [0, 365]
    const unsigned doe = yoe * 365 + yoe/4 - yoe/100 + doy;         // [0, 146096]
    return era * 146097 + static_cast<int>(doe) - 719468;
}

int atoi_w_len(const char *a, uint8_t len)
{
	char temp[16];
	memset(temp, 0, sizeof(temp));

	memcpy(temp, a, len);

	return atoi(temp);
}


char *_get_field_from_nmea(const char *nmea, uint8_t fieldnum)
{
	uint8_t sep = ',';
	char *ptr = (char *)nmea;

	uint8_t i;
	for(i=0; i<fieldnum; i++)
		ptr = strchr(ptr, sep) + 1;

	return ptr;
}

float get_coordinate(const char *nmea, uint8_t cnum)
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



gnss_data_t gps_msg_handler(const char *msg)
{
	char *type_str = _get_field_from_nmea(msg, 0);
	bool is_rmc = ((type_str[0] == '$') && (strncmp(type_str+3, "RMC", 3) == 0));

	if(!is_rmc)
	{
		return gnss_data_t();
	}

	gnss_data_t gd;

	char *ts_str = _get_field_from_nmea(msg, 1);
	char *date_str = _get_field_from_nmea(msg, 9);

	gd.hour = atoi_w_len(ts_str, 2);
	gd.min = atoi_w_len(ts_str+2, 2);
	gd.sec = atoi_w_len(ts_str+4, 2);
	gd.day = atoi_w_len(date_str, 2);
	gd.month = atoi_w_len(date_str+2, 2);
	gd.year = atoi_w_len(date_str+4, 2) + 2000;
	gd.sec_of_the_day = (((gd.hour * 60) + gd.min) * 60) + gd.sec;

	gd.latitude = get_coordinate(msg, 0);
	gd.longitude = get_coordinate(msg, 1);

	gd.utc_timestamp = gd.sec_of_the_day + (86400 * days_from_civil(
											(int)gd.year,
											(unsigned)gd.month,
											(unsigned)gd.day));

	return gd;
}

void printg(gnss_data_t &gd)
{
	println("hour", gd.hour);
	println("min", gd.min);
	println("sec", gd.sec);
	println("day", gd.day);
	println("month", gd.month);
	println("year", gd.year);
	println("latitude", gd.latitude);
	println("longitude", gd.longitude);
	println("sec_of_the_day", gd.sec_of_the_day);
	println("utc_timestamp", gd.utc_timestamp);
} 

void printc(gnss_data_t &gd1, gnss_data_t &gd2)
{
	printcln("hour", gd1.hour, gd2.hour);
	printcln("min", gd1.min, gd2.min);
	printcln("sec", gd1.sec, gd2.sec);
	printcln("day", gd1.day, gd2.day);
	printcln("month", gd1.month, gd2.month);
	printcln("year", gd1.year, gd2.year);
	printcln("latitude", gd1.latitude, gd2.latitude);
	printcln("longitude", gd1.longitude, gd2.longitude);
	printcln("sec_of_the_day", gd1.sec_of_the_day, gd2.sec_of_the_day);
	printcln("utc_timestamp", gd1.utc_timestamp, gd2.utc_timestamp);
} 


int main() 
{
    char msg[] = "$GPRMC,123519,A,4807.038,N,01131.000,E,022.4,084.4,230394,003.1,W*6A";
    //char msg[] = "$GPRMC,1";
    hls::stream<char> msg_stream;

    std::cout << "Input stream: ";
    for(int i=strlen(msg)-1; i>=0; i--) {
        std::cout << msg[i];
        msg_stream << msg[i];
    }
    std::cout << "\n\n" << std::endl;

    
    gnss_data_t hw_gd;
    data_bool pps = 1;
    data_bool data_valid = 1;
    while(!msg_stream.empty()) {
        gps_translation(msg_stream, pps, hw_gd, data_valid);
    }
    
    gnss_data_t gold_gd = gps_msg_handler(msg);

	printc(hw_gd, gold_gd);



}



