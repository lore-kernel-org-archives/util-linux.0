Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:49306 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934558AbaEFKAF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 May 2014 06:00:05 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH 02/12] dmesg: move get_boot_time() to lib/timeutils
Date: Tue, 6 May 2014 12:00:00 +0200
Cc: util-linux@vger.kernel.org
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi> <1398629138-31718-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1398629138-31718-3-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201405061200.00836.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sunday 27 April 2014, Sami Kerola wrote:
> In future the last(1) will use get_boot_time() as well.
>
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  include/timeutils.h |  1 +
>  lib/timeutils.c     | 29 +++++++++++++++++++++++++++++
>  sys-utils/dmesg.c   | 27 ---------------------------
>  3 files changed, 30 insertions(+), 27 deletions(-)
>
> [...]
> -
> -#ifdef CLOCK_BOOTTIME
> -	if (clock_gettime(CLOCK_BOOTTIME, &hires_uptime) == 0) {
> -		TIMESPEC_TO_TIMEVAL(&lores_uptime, &hires_uptime);
> -		timersub(&now, &lores_uptime, boot_time);
> -		return 0;
> -	}

clock_gettime() needs -lrt on some systems. That's why we had 
dmesg_LDADD += -lrt. Now every binary which links against libcommon 
needs that.

cu,
Rudi
