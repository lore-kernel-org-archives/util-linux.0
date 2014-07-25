Return-Path: util-linux-owner@vger.kernel.org
Received: from mondschein.lichtvoll.de ([194.150.191.11]:43393 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbaGYMsY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 25 Jul 2014 08:48:24 -0400
From: Martin Steigerwald <Martin@lichtvoll.de>
To: Andreas Henriksson <andreas@fatal.se>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] cfdisk: reenable cursor when quitting
Date: Fri, 25 Jul 2014 14:40:07 +0200
Message-ID: <20411543.z4pDo5dfJP@merkaba>
In-Reply-To: <1406290922-25357-1-git-send-email-andreas@fatal.se>
References: <1406290922-25357-1-git-send-email-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Am Freitag, 25. Juli 2014, 14:22:01 schrieb Andreas Henriksson:
> After quitting cfdisk (built with slang) the cursor would be
> missing at the command prompt.
> 
> Reported-by: Martin Steigerwald <Martin@Lichtvoll.de>
> Addresses-Debian-Bug: #755991
> Signed-off-by: Andreas Henriksson <andreas@fatal.se>
> ---
>  disk-utils/cfdisk.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
> index 5a42ab1..dfdaaf0 100644
> --- a/disk-utils/cfdisk.c
> +++ b/disk-utils/cfdisk.c
> @@ -1966,6 +1966,7 @@ static int ui_run(struct cfdisk *cf)
> 
>  	menu_pop(cf);
> 
> +	curs_set(1);
>  	DBG(FRONTEND, ul_debug("ui: end"));
> 
>  	return 0;

Thanks Andreas!

I will test this as soon as I have the systemd related build deps of newer 
util-linux sorted.

-- 
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
