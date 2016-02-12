Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:51877 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940AbcBLQZ5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 12 Feb 2016 11:25:57 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0Lbi2Z-1ZjyEy3x3T-00lDre for
 <util-linux@vger.kernel.org>; Fri, 12 Feb 2016 17:25:56 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: mkfs.ext3 image-file needs option -F
Date: Fri, 12 Feb 2016 17:25:54 +0100
References: <201507021206.47499.sweet_f_a@gmx.de> <1455294198-25046-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1455294198-25046-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201602121725.54903.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Oops, by accident I've used the wrong --in-reply-to from my shell 
history.

On Friday 12 February 2016, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> Maybe on newer systems it's not needed anymore.
>
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  tests/ts/mount/fstab-loop | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/ts/mount/fstab-loop b/tests/ts/mount/fstab-loop
> index 3178b95..9e17943 100755
> --- a/tests/ts/mount/fstab-loop
> +++ b/tests/ts/mount/fstab-loop
> @@ -30,7 +30,7 @@ ts_check_prog "mkfs.ext3"
>
>  IMG=$(ts_image_init)
>
> -mkfs.ext3 $IMG &> /dev/null || ts_die "Cannot make ext3 on $DEVICE"
> +mkfs.ext3 -F $IMG &> /dev/null || ts_die "Cannot make ext3 on $IMG"
>
>  [ -d "$TS_MOUNTPOINT-1" ] || mkdir -p $TS_MOUNTPOINT-1
>  [ -d "$TS_MOUNTPOINT-2" ] || mkdir -p $TS_MOUNTPOINT-2
