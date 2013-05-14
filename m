Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:30264 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756422Ab3ENIHH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 May 2013 04:07:07 -0400
Date: Tue, 14 May 2013 10:07:02 +0200
From: Karel Zak <kzak@redhat.com>
To: Dennis H Jensen <dennis.h.jensen@siemens.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH RFC] logger: add support for --loglevel-prefix when
 logging stdin
Message-ID: <20130514080702.GA18123@x2.net.home>
References: <1368482238-6023-1-git-send-email-dennis.h.jensen@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368482238-6023-1-git-send-email-dennis.h.jensen@siemens.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi Dennis,

On Mon, May 13, 2013 at 11:57:18PM +0200, Dennis H Jensen wrote:
> This patch adds a new option to logger that will make it look for a
> loglevel prefix <[0-7]> at the beginning of every line.
> 
> If a loglevel is found logger will log the message using the found
> loglevel combined with the facility specified by --priority. When no
> loglevel is found the default level provided by the --priority option
> will be used.

I have doubts if this is a good idea. 

It seems that you're trying to introduce a new meaning of the <n>
convention.  The <n> in the syslog API is not only log level, it's
((lev & LOG_PRIMASK) | (fac & LOG_FACMASK)) -- bottom 3 bits are the
priority and the top 28 bits are the facility). 

It would be better to follow this already existing convention. It means 
to use something like

    --prio-prefix

and use the <n> number as whole priority number. The result will be
command line interface with pretty simple semantic.

The problem is that <n> encoding is not user friendly, but I guess we
should be able to explain all in the logger man page (for example in
an EXAMPLE section). For example user.debug:

    LOG_USER=$((1<<3))
    LOG_DEBUG=7
    echo $(( $LOG_USER & 0x03f8 | $LOG_DEBUG & 0x07 ))

to get the number in shell.

> --- a/misc-utils/logger.c
> +++ b/misc-utils/logger.c
> @@ -64,6 +64,10 @@ enum {
>  	ALL_TYPES = TYPE_UDP | TYPE_TCP
>  };
>  
> +enum {
> +	ARG_LOGLEVEL_PREFIX = 0x100

 We usually use OPT_* and CHAR_MAX, for example:

        OPT_PRIO_PREFIX = CHAR_MAX + 1


    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
