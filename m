Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58352 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742AbaGVKeM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 22 Jul 2014 06:34:12 -0400
Date: Tue, 22 Jul 2014 12:33:57 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] swapon: share get_swap_prober() with swaplabel to print
 uuid and label
Message-ID: <20140722103357.GB26781@x2.net.home>
References: <1404247204-1751-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404247204-1751-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 01, 2014 at 09:40:04PM +0100, Sami Kerola wrote:
>  disk-utils/Makemodule.am  |  6 +++---
>  disk-utils/swaplabel.c    | 46 ----------------------------------------------
>  sys-utils/Makemodule.am   | 14 ++++++++++----
>  sys-utils/swapon-common.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  sys-utils/swapon-common.h |  2 ++
>  sys-utils/swapon.c        | 38 ++++++++++++++++++++++++++++++++++++--
>  6 files changed, 95 insertions(+), 55 deletions(-)

 Applied, thanks.

> +		case COL_UUID:
> +			if (pr && !blkid_probe_lookup_value(pr, "UUID", &data, NULL))
> +				xasprintf(&str, "%s", data);
> +			else if (pr)
> +				xasprintf(&str, "");

 This is unnecessary, it's fine to keep cells in smartcols table empty
 (NULL).

> +			else
> +				xasprintf(&str, _("read failed"));

 I have removed this, it's bad idea to use data fields to report error
 messages (or so). It's too complicated semantic for scripts. On
 another places we usually silently keep the fields empty when we have
 no rights to read UUID/LABEL,...

    Karel



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
