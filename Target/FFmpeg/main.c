#include "Foundation.h"
#include "libavutil/avutil.h"
#include "libavutil/log.h"
#include "libavutil/error.h"

int main(int argc, const char * argv[])
{
    AVRational rational = av_make_q(4, 8); // Create a rational number 4/8
    char errbuf[AV_ERROR_MAX_STRING_SIZE];
    printf("rational.num = %d\r\n", rational.num);
    printf("rational.den = %d\r\n", rational.den);
    printf("Hello World!\r\n");

    printf("Using avutil version: %s\n", av_version_info());
    
    av_log_set_level(AV_LOG_DEBUG);
    av_log(NULL, AV_LOG_INFO, "This is an informational message.\n");
    av_log(NULL, AV_LOG_WARNING, "This is a warning message.\n");
    av_log(NULL, AV_LOG_ERROR, "This is an error message.\n");
    
    av_strerror(AVERROR(EINVAL), errbuf, sizeof(errbuf));
    printf("Error string for EINVAL: %s\n", errbuf);
    printf("Time base: %d/%d\n", av_get_time_base_q().num, av_get_time_base_q().den);
    
    return 0;
}