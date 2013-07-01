Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13597 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974Ab3GAJZ7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 1 Jul 2013 05:25:59 -0400
Date: Mon, 1 Jul 2013 11:25:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 10/15] dmesg: add iso-8601 time format
Message-ID: <20130701092549.GB28709@x2.net.home>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
 <1371408836-16663-11-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371408836-16663-11-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 16, 2013 at 07:53:51PM +0100, Sami Kerola wrote:
>  sys-utils/dmesg.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)

 Applied, thanks. Notes:

> diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
> index 2199e7f..be08f6c 100644
> --- a/sys-utils/dmesg.c
> +++ b/sys-utils/dmesg.c
> @@ -133,7 +133,8 @@ enum {
>  	DMESG_TIMEFTM_DELTA,		/* [<delta>] */
>  	DMESG_TIMEFTM_RELTIME,		/* [relative] */
>  	DMESG_TIMEFTM_TIME,		/* [time] */
> -	DMESG_TIMEFTM_TIME_DELTA	/* [time <delta>] */
> +	DMESG_TIMEFTM_TIME_DELTA,	/* [time <delta>] */
> +	DMESG_TIMEFTM_ISO8601		/* 2013-06-13T22:11:00,123456+0100 */

    dmesg --show-delta --time-format=iso

 is unsupported, right? I have no problem with this restriction, but
 it would be nice to add some warning to the code.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
