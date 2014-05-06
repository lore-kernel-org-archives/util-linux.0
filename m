Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:17597 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbaEFLVI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 May 2014 07:21:08 -0400
Date: Tue, 6 May 2014 13:20:54 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 02/12] dmesg: move get_boot_time() to lib/timeutils
Message-ID: <20140506112054.GP5962@x2.net.home>
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
 <1398629138-31718-3-git-send-email-kerolasa@iki.fi>
 <201405061200.00836.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201405061200.00836.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 06, 2014 at 12:00:00PM +0200, Ruediger Meier wrote:
> On Sunday 27 April 2014, Sami Kerola wrote:
> > In future the last(1) will use get_boot_time() as well.
> >
> > Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> > ---
> >  include/timeutils.h |  1 +
> >  lib/timeutils.c     | 29 +++++++++++++++++++++++++++++
> >  sys-utils/dmesg.c   | 27 ---------------------------
> >  3 files changed, 30 insertions(+), 27 deletions(-)
> >
> > [...]
> > -
> > -#ifdef CLOCK_BOOTTIME
> > -	if (clock_gettime(CLOCK_BOOTTIME, &hires_uptime) == 0) {
> > -		TIMESPEC_TO_TIMEVAL(&lores_uptime, &hires_uptime);
> > -		timersub(&now, &lores_uptime, boot_time);
> > -		return 0;
> > -	}
> 
> clock_gettime() needs -lrt on some systems. That's why we had 
> dmesg_LDADD += -lrt. Now every binary which links against libcommon 
> needs that.

 Fixed, I have moved get_boot_time() outside libcommon. The question
 is how portable will be last(1), maybe it will necessary to add
 something like "if HAVE_LIBRT" to the build system, now there is 
 hardcoded -lrt.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
