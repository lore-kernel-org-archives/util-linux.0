Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52220 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100Ab3FCIpz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 3 Jun 2013 04:45:55 -0400
Date: Mon, 3 Jun 2013 10:45:45 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 13/19] dmesg: make time format parsing to use enum bit
 field
Message-ID: <20130603084545.GI30341@x2.net.home>
References: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
 <1370195485-27907-14-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370195485-27907-14-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 02, 2013 at 06:51:19PM +0100, Sami Kerola wrote:
> +enum {
> +	TIMEFTM_NONE	= (1 << 0),
> +	TIMEFTM_CTIME	= (1 << 1),
> +	TIMEFTM_DELTA	= (1 << 2),
> +	TIMEFTM_RELTIME = (1 << 3),
> +};

 Do we really need to use the time formats as flags? Would be better
 to use it as a real enums?

 I know that it means that for "delta" we need more types, but it's
 probably better than assume arbitrary combination of all the types.

enum {
    DMESG_TIMEFTM_NONE = 0
    DMESG_TIMEFTM_TIME,           /* [time] */
	DMESG_TIMEFTM_CTIME,          /* [ctime] */
    DMESG_TIMEFTM_CTIME_DELTA,    /* [ctime <delta>] */
	DMESG_TIMEFTM_TIME_DELTA,     /* [time <delta>] */
    DMESG_TIMEFTM_DELTA,          /* [<delta>] */
	DMESG_TIMEFTM_RELTIME         /* [relative] */
};

and all you need is to set any default (DMESG_TIMEFTM_TIME) and clear the
default if --notime is specified.

In the code you can check for "if (ctl->time_fmt)" or add

    #define is_timefmt(c, f)   (c->time_fmt == (TIMEFTM_ ##f))

and use

    if (is_timefmt(ctl, DELTA))


  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
