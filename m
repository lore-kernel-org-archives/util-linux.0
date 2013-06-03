Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36237 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423Ab3FCJfO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 3 Jun 2013 05:35:14 -0400
Date: Mon, 3 Jun 2013 11:35:04 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 18/19] dmesg: more deterministic boot time detection
Message-ID: <20130603093504.GK30341@x2.net.home>
References: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
 <1370195485-27907-19-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370195485-27907-19-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 02, 2013 at 06:51:24PM +0100, Sami Kerola wrote:
> diff --git a/include/pathnames.h b/include/pathnames.h
> index cc8a20b..84eabd4 100644
> --- a/include/pathnames.h
> +++ b/include/pathnames.h
> @@ -48,7 +48,8 @@
>  #define _PATH_SECURE		"/etc/securesingle"
>  #define _PATH_USERTTY           "/etc/usertty"
>  
> -/* used in login-utils/shutdown.c */
> +/* used in sys-utils/dmesg.c */
> +#define _PATH_PROC_PID1		"/proc/1"
>  
>  /* used in login-utils/setpwnam.h and login-utils/islocal.c */
>  #define _PATH_PASSWD		"/etc/passwd"
> diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
> index d80b3e9..da58c42 100644
> --- a/sys-utils/dmesg.c
> +++ b/sys-utils/dmesg.c
> @@ -34,6 +34,7 @@
>  #include "optutils.h"
>  #include "mangle.h"
>  #include "pager.h"
> +#include "pathnames.h"
>  
>  /* Close the log.  Currently a NOP. */
>  #define SYSLOG_ACTION_CLOSE          0
> @@ -141,7 +142,7 @@ struct dmesg_control {
>  
>  	struct timeval	lasttime;	/* last printed timestamp */
>  	struct tm	lasttm;		/* last localtime */
> -	time_t		boot_time;	/* system boot time */
> +	struct timeval	boot_time;	/* system boot time */
>  
>  	int		action;		/* SYSLOG_ACTION_* */
>  	int		method;		/* DMESG_METHOD_* */
> @@ -464,18 +465,17 @@ static int get_syslog_buffer_size(void)
>  	return n > 0 ? n : 0;
>  }
>  
> -static time_t get_boot_time(void)
> +static struct timeval get_boot_time(void)
>  {
> -	struct sysinfo info;
> -	struct timeval tv;
> +	struct stat st;
> +	struct timeval ret;
> +	memset(&ret, 0, sizeof(struct timeval));
>  
> -	if (sysinfo(&info) != 0)
> -		warn(_("sysinfo failed"));
> -	else if (gettimeofday(&tv, NULL) != 0)
> -		warn(_("gettimeofday failed"));
> +	if (stat(_PATH_PROC_PID1, &st))
> +		warn(_("stat failed %s"), _PATH_PROC_PID1);

Nice idea, but what about the delay between kernel boot and init
start -- in this time kernel already writes to the log.

Maybe we need to study systemd code, I guess they already have all the
information:

# systemd-analyze time
Startup finished in 11.306s (firmware) + 31ms (loader) + 864ms
(kernel) + 1.971s (initrd) + 52.068s (userspace) = 1min 6.243s

>  	else
> -		return tv.tv_sec -= info.uptime;
> -	return 0;
> +		ret.tv_sec = st.st_ctime;
> +	return ret;
>  }

 stat() usually provides nanoseconds resolution

#ifdef HAVE_STRUCT_STAT_ST_MTIM_TV_NSEC
     ret.tv_sec = st.st_ctime;
     ret.tv_usec = st.st_mtim.tv_nsec / 1000;
#endif

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
