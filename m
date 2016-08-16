Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44332 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753224AbcHPLnX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Aug 2016 07:43:23 -0400
Date: Tue, 16 Aug 2016 13:43:20 +0200
From: Karel Zak <kzak@redhat.com>
To: Helge Deller <deller@gmx.de>
Cc: util-linux@vger.kernel.org, Ruediger Meier <ruediger.meier@ga-group.nl>,
        827225@bugs.debian.org
Subject: Re: [PATCH] tests: really fix fdisk/bsd for hppa
Message-ID: <20160816114320.rglhni56dthdow3k@ws.net.home>
References: <20160815202630.GA14518@ls3530.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160815202630.GA14518@ls3530.box>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 15, 2016 at 10:26:30PM +0200, Helge Deller wrote:
> Finally fix the bsd testcase on the hppa architecture.
> 
> Commit 1b7be556e553cdcef6213ead6340832c306011ed tried to fix it,
> but missed the fact that "uname -m" returns "parisc" or "parisc64"
> instead of "hppa*".
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: 827225@bugs.debian.org
> 
> diff -up ./tests/ts/fdisk/bsd.org ./tests/ts/fdisk/bsd
> --- ./tests/ts/fdisk/bsd.org	2016-08-15 22:16:24.849052620 +0200
> +++ ./tests/ts/fdisk/bsd	2016-08-15 22:16:42.645094364 +0200
> @@ -48,7 +48,7 @@ BYTE_ORDER=$($TS_HELPER_SYSINFO byte-ord
>  ARCH=$(uname -m)
>  case $ARCH in
>  	# see include/pt-bsd.h
> -	*alpha* | *ppc* | *ia64* | *hppa* )
> +	*alpha* | *ppc* | *ia64* | *parisc* )

Applied, but we had hppa also in ./confugure, so I guess that "hppa"
has been also correct for some boxes. It seems more robust to use

    *alpha* | *ppc* | *ia64* | *hppa* | *parisc* ) 

for sure. Fixed.

Thanks

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
