Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:50163 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124AbcCMNVA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 Mar 2016 09:21:00 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1af5x1-00034v-KV
	for util-linux@vger.kernel.org; Sun, 13 Mar 2016 14:20:55 +0100
Received: from ppp37-190-56-84.pppoe.spdop.ru ([37.190.56.84])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 14:20:55 +0100
Received: from yumkam by ppp37-190-56-84.pppoe.spdop.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 14:20:55 +0100
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: Re: [PATCH 03/10] lsipc, lslogins, rtcwake: replace asctime() with strftime()
Date: Sun, 13 Mar 2016 16:20:42 +0300
Message-ID: <m337ruiket.fsf@gmail.com>
References: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
	<1457865109-2881-4-git-send-email-kerolasa@iki.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--=-=-=
Content-Type: text/plain


On 03/13/16 13:31 , Sami Kerola wrote:
> POSIX.1-2008 marks asctime() and asctime_r() as obsolete, recommending the
> use of strftime(3) instead.

stftime uses locale, asctime is not. And if you want *locale-specific*
time presentation, it is "%c" --- it can be very different from your "%a
%b...", e.g. compare with attached

   gcc -o asctime asctime.c
   LC_ALL=ja_JP.UTF-8 ./asctime


--=-=-=
Content-Type: text/x-csrc
Content-Disposition: inline; filename=asctime.c

#include <stdio.h>
#include <time.h>
#include <locale.h>
int main()
{
	time_t t = time(NULL);
	char buf[64];
	struct tm *tm;
	setlocale(LC_ALL, "");
	puts(asctime(tm = localtime(&t)));
	strftime(buf, sizeof(buf), "%a %b %e %T %Y", tm);
	puts(buf);
	strftime(buf, sizeof(buf), "%c", tm);
	puts(buf);
	return 0;
}

--=-=-=
Content-Type: text/plain


> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  include/timeutils.h    |  3 +++
>  login-utils/lslogins.c |  5 ++---
>  sys-utils/lsipc.c      |  6 ++----
>  sys-utils/rtcwake.c    | 15 +++++++++------
>  4 files changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/include/timeutils.h b/include/timeutils.h
> index 8ed501b..427f833 100644
> --- a/include/timeutils.h
> +++ b/include/timeutils.h
> @@ -51,6 +51,9 @@ typedef uint64_t nsec_t;
>  #define FORMAT_TIMESTAMP_RELATIVE_MAX 256
>  #define FORMAT_TIMESPAN_MAX 64
>  
> +/* Original asctime(3) format ends to '\n' that we do not do here.  */
> +#define STRFTIME_ASCTIME_FORMAT	"%a %b %e %T %Y"
> +
>  int parse_timestamp(const char *t, usec_t *usec);
>  
>  #endif /* UTIL_LINUX_TIME_UTIL_H */
> diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
> index 40a1343..554a1a3 100644
> --- a/login-utils/lslogins.c
> +++ b/login-utils/lslogins.c
> @@ -56,6 +56,7 @@
>  #include "pathnames.h"
>  #include "logindefs.h"
>  #include "procutils.h"
> +#include "timeutils.h"
>  
>  /*
>   * column description
> @@ -333,9 +334,7 @@ static char *make_time(int mode, time_t time)
>  
>  	switch(mode) {
>  	case TIME_FULL:
> -		asctime_r(&tm, buf);
> -		if (*(s = buf + strlen(buf) - 1) == '\n')
> -			*s = '\0';
> +		strftime(buf, sizeof(buf), STRFTIME_ASCTIME_FORMAT, &tm);
>  		break;
>  	case TIME_SHORT:
>  		if (date_is_today(time))
> diff --git a/sys-utils/lsipc.c b/sys-utils/lsipc.c
> index 938728a..19cf5a8 100644
> --- a/sys-utils/lsipc.c
> +++ b/sys-utils/lsipc.c
> @@ -39,6 +39,7 @@
>  #include "xalloc.h"
>  #include "procutils.h"
>  #include "ipcutils.h"
> +#include "timeutils.h"
>  
>  /*
>   * time modes
> @@ -445,7 +446,6 @@ static int date_is_thisyear(time_t t)
>  
>  static char *make_time(int mode, time_t time)
>  {
> -	char *s;
>  	struct tm tm;
>  	char buf[64] = {0};
>  
> @@ -453,9 +453,7 @@ static char *make_time(int mode, time_t time)
>  
>  	switch(mode) {
>  	case TIME_FULL:
> -		asctime_r(&tm, buf);
> -		if (*(s = buf + strlen(buf) - 1) == '\n')
> -			*s = '\0';
> +		strftime(buf, sizeof(buf), STRFTIME_ASCTIME_FORMAT, &tm);
>  		break;
>  	case TIME_SHORT:
>  		if (date_is_today(time))
> diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
> index 7c748dc..32df785 100644
> --- a/sys-utils/rtcwake.c
> +++ b/sys-utils/rtcwake.c
> @@ -173,7 +173,7 @@ static int get_basetimes(struct rtcwake_control *ctl, int fd)
>  		return -1;
>  	}
>  	/* Convert rtc_time to normal arithmetic-friendly form,
> -	 * updating tm.tm_wday as used by asctime().
> +	 * updating tm.tm_wday as used by strftime().
>  	 */
>  	tm.tm_sec = rtc.tm_sec;
>  	tm.tm_min = rtc.tm_min;
> @@ -193,14 +193,17 @@ static int get_basetimes(struct rtcwake_control *ctl, int fd)
>  		/* Unless the system uses UTC, either delta or tzone
>  		 * reflects a seconds offset from UTC.  The value can
>  		 * help sort out problems like bugs in your C library. */
> +		char buf[64] = { 0 };
> +		struct tm sys_tm = { 0 };
> +
>  		printf("\tdelta   = %ld\n", ctl->sys_time - ctl->rtc_time);
>  		printf("\ttzone   = %ld\n", timezone);
>  		printf("\ttzname  = %s\n", tzname[daylight]);
> -		gmtime_r(&ctl->rtc_time, &tm);
> -		printf("\tsystime = %ld, (UTC) %s",
> -				(long) ctl->sys_time, asctime(gmtime(&ctl->sys_time)));
> -		printf("\trtctime = %ld, (UTC) %s",
> -				(long) ctl->rtc_time, asctime(&tm));
> +		gmtime_r(&ctl->sys_time, &sys_tm);
> +		strftime(buf, sizeof(buf), STRFTIME_ASCTIME_FORMAT, &sys_tm);
> +		printf("\tsystime = %ld, (UTC) %s\n", (long) ctl->sys_time, buf);
> +		strftime(buf, sizeof(buf), STRFTIME_ASCTIME_FORMAT, &tm);
> +		printf("\trtctime = %ld, (UTC) %s\n", (long) ctl->rtc_time, buf);
>  	}
>  	return 0;
>  }
> -- 
> 2.7.2

--=-=-=--

