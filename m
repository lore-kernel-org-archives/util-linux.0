Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:59138 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932474AbcCML2Y (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 Mar 2016 07:28:24 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH 03/10] lsipc, lslogins, rtcwake: replace asctime() with strftime()
Date: Sun, 13 Mar 2016 12:28:06 +0100
Cc: util-linux@vger.kernel.org
References: <1457865109-2881-1-git-send-email-kerolasa@iki.fi> <1457865109-2881-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1457865109-2881-4-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201603131228.06562.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sunday 13 March 2016, Sami Kerola wrote:
> POSIX.1-2008 marks asctime() and asctime_r() as obsolete,
> recommending the use of strftime(3) instead.
>
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
> +/* Original asctime(3) format ends to '\n' that we do not do here. 
> */ +#define STRFTIME_ASCTIME_FORMAT	"%a %b %e %T %Y"
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

char *s is now unused and could be removed.

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
> @@ -173,7 +173,7 @@ static int get_basetimes(struct rtcwake_control
> *ctl, int fd) return -1;
>  	}
>  	/* Convert rtc_time to normal arithmetic-friendly form,
> -	 * updating tm.tm_wday as used by asctime().
> +	 * updating tm.tm_wday as used by strftime().
>  	 */
>  	tm.tm_sec = rtc.tm_sec;
>  	tm.tm_min = rtc.tm_min;
> @@ -193,14 +193,17 @@ static int get_basetimes(struct rtcwake_control
> *ctl, int fd) /* Unless the system uses UTC, either delta or tzone
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


