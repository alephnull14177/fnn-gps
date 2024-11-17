#include "ap_axi_sdata.h"
#include "hls_stream.h"
#include "ap_int.h"

#define NMEA_MAX 82

typedef ap_uint<1> data_bool;

struct gnss_data_t
{
    //from time struct
    ap_uint<32> hour = 0;
    ap_uint<32> min = 0;
    ap_uint<32> sec = 0;
    ap_uint<32> day = 0;
    ap_uint<32> month = 0;
    ap_int<32> year = 0;
    
    //pos
    float latitude = 0;
    float longitude = 0;

    //misc
    ap_uint<32> sec_of_the_day = 0;
    ap_int<32> utc_timestamp = 0;
    //no nmea_rmc string needed to capture
};

ap_int<32> hls_days_from_civil(ap_int<32> y, unsigned m, unsigned d);
char *hls_get_field_from_nmea(const char *nmea, uint8_t fieldnum);
float hls_get_coordinate(const char *nmea, data_bool cnum);
void gps_translation(hls::stream<char> &msg, data_bool pps, gnss_data_t &gd, data_bool &data_valid);
