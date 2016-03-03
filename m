Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:56564 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917AbcCCBTE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Mar 2016 20:19:04 -0500
Received: from tenfore.site ([77.12.144.244]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lz4KW-1ZoqAv3cQa-014Ey7 for
 <util-linux@vger.kernel.org>; Thu, 03 Mar 2016 02:19:01 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/7] tests: scsi_debug sleep
Date: Thu, 3 Mar 2016 02:19:01 +0100
References: <1456967465-16128-1-git-send-email-sweet_f_a@gmx.de> <1456967465-16128-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456967465-16128-2-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201603030219.01139.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Sorry PATCH 1/7 was a mitsake here. Please skip.

On Thursday 03 March 2016, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  tests/functions.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/functions.sh b/tests/functions.sh
> index e639e73..6c29053 100644
> --- a/tests/functions.sh
> +++ b/tests/functions.sh
> @@ -647,6 +647,7 @@ function ts_scsi_debug_init {
>
>  		|| ts_skip "scsi_debug module not loaded (lsmod)"
>
>  	udevadm settle
> +	sleep 1
>
>  	devname=$(grep --with-filename scsi_debug /sys/block/*/device/model
> | awk -F '/' '{print $4}') [ "x${devname}" == "x" ] && ts_die "cannot
> find scsi_debug device"


