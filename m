Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36998 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936AbbCPK5T (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Mar 2015 06:57:19 -0400
Date: Mon, 16 Mar 2015 11:57:07 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/8] tests: add test_logger helper command
Message-ID: <20150316105707.GI28925@ws.net.home>
References: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
 <1426424094-25451-4-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426424094-25451-4-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 15, 2015 at 12:54:49PM +0000, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  misc-utils/Makemodule.am |  4 ++++
>  misc-utils/logger.c      | 36 ++++++++++++++++++++++++++++++++++++
>  tests/commands.sh        |  1 +
>  3 files changed, 41 insertions(+)
> 
> diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
> index f7485c9..309727b 100644
> --- a/misc-utils/Makemodule.am
> +++ b/misc-utils/Makemodule.am
> @@ -26,6 +26,10 @@ if HAVE_SYSTEMD
>  logger_LDADD = $(SYSTEMD_LIBS) $(SYSTEMD_DAEMON_LIBS) $(SYSTEMD_JOURNAL_LIBS)
>  logger_CFLAGS = $(SYSTEMD_CFLAGS) $(SYSTEMD_DAEMON_CFLAGS) $(SYSTEMD_JOURNAL_CFLAGS)
>  endif
> +check_PROGRAMS += test_logger
> +test_logger_SOURCES = $(logger_SOURCES)
> +test_logger_LDADD = $(logger_LDADD)
> +test_logger_CFLAGS = -DTEST_LOGGER $(logger_CFLAGS)
>  endif # BUILD_LOGGER
>  
>  
> diff --git a/misc-utils/logger.c b/misc-utils/logger.c
> index 2e37d14..838d225 100644
> --- a/misc-utils/logger.c
> +++ b/misc-utils/logger.c
> @@ -310,7 +310,12 @@ static const char *rfc3164_current_time(void)
>  		"Sep", "Oct", "Nov", "Dec"
>  	};
>  
> +#ifndef TEST_LOGGER
>  	gettimeofday(&tv, NULL);
> +#else
> +	tv.tv_sec = 1234567890;
> +	tv.tv_usec = 123456;
> +#endif

 Hmm... this (many #ifdefs and hardcoded constants) is really not
 elegant solution. I'll try to implement it in another way. Thanks for
 the tests.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
