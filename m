Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36933 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392AbbBXKVj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Feb 2015 05:21:39 -0500
Date: Tue, 24 Feb 2015 11:21:28 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 03/16] flock: improve timeout handling
Message-ID: <20150224102128.GF19430@ws.net.home>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
 <1424616106-580-4-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424616106-580-4-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 22, 2015 at 02:41:33PM +0000, Sami Kerola wrote:
> Signal ALRM raised by the timer, and the timer only, will be considered
> as a timeout criteria.
> 
> Secondly time interval is made to use monotonic clock.  Documentation of
> ITIMER_REAL is unclear whether that time is affected various sources of
> clock skew, or does it even tick when system is suspended.

I agree, setitimer() API is also obsolete.

> This code is moved from libcommon.la to flock.c because of two reasons.
> This is the only utility using the function, and setup_timer() along with
> cancel_timer() need to be linked with -lrt option.

Hmm... yes, it's used by flock only, but I still think it would be
better to keep it in common lib/ code. Maybe we can use the timers on
another places later (uuidd, login, sulogin, ...).

What about to keep all -lrt stuff in lib/monotonic.c?

> --- a/sys-utils/Makemodule.am
> +++ b/sys-utils/Makemodule.am
> @@ -2,7 +2,7 @@ if BUILD_FLOCK
>  usrbin_exec_PROGRAMS += flock
>  dist_man_MANS += sys-utils/flock.1
>  flock_SOURCES = sys-utils/flock.c lib/monotonic.c
> -flock_LDADD = $(LDADD) libcommon.la $(CLOCKGETTIME_LIBS)
> +flock_LDADD = $(LDADD) libcommon.la -lrt

Don't use -l<foo> in Makefiles, always use $(FOO) and initialize the
variable in ./configure, $(CLOCKGETTIME_LIBS) is fine (although the
name of the variable is not perfect in this context).

> +static void timeout_handler(int sig __attribute__((__unused__)),
> +			    siginfo_t *info,
> +			    void *context __attribute__((__unused__)))
>  {
> -	timeout_expired = 1;
> +	if (info->si_code == SI_TIMER)
> +		timeout_expired = 1;
>  }

BTW, it mean that "kill -ALRM" does not force the program to set 
timeout_expired, right? Nice.

> +static int setup_timer(timer_t *t_id, struct itimerval *timeout)

if you move it to lib/ than add a pointer to timeout_handler() too

Anyway, it seems more elegant than the previous implementation.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
