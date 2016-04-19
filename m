Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:37577 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209AbcDSWw6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Apr 2016 18:52:58 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1aseVm-0002ww-Fa
	for util-linux@vger.kernel.org; Wed, 20 Apr 2016 00:52:50 +0200
Received: from 95.131.151.139 ([95.131.151.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 20 Apr 2016 00:52:50 +0200
Received: from yumkam by 95.131.151.139 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 20 Apr 2016 00:52:50 +0200
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: Re: [PATCH 4/5] lib: avoid double free in loopdev.c
Date: Wed, 20 Apr 2016 01:52:38 +0300
Message-ID: <m3ega1jjnt.fsf@gmail.com>
References: <1461098145-2988-1-git-send-email-kerolasa@iki.fi>
	<1461098145-2988-5-git-send-email-kerolasa@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Sami Kerola <kerolasa@iki.fi> writes:

> Found with scan-build.
>
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  lib/loopdev.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/loopdev.c b/lib/loopdev.c
> index 9ae61da..ca5d2f4 100644
> --- a/lib/loopdev.c
> +++ b/lib/loopdev.c
> @@ -460,6 +460,7 @@ static int loop_scandir(const char *dirname, int **ary, int hasprefix)
>  			tmp = realloc(*ary, arylen * sizeof(int));
>  			if (!tmp) {
>  				free(*ary);
> +				ary = NULL;

This cannot have any effect. Probably you wanted
                                *ary = NULL;
                                
>  				closedir(dir);
>  				return -1;
>  			}

