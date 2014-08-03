Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.17.10]:62542 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbaHCWTp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Aug 2014 18:19:45 -0400
Message-ID: <53DEB57F.3080806@bernhard-voelker.de>
Date: Mon, 04 Aug 2014 00:19:43 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/7] zramctl: print all devices as a default action
References: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 08/03/2014 04:17 PM, Sami Kerola wrote:
> diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
> index a26cd8e..04744fd 100644
> --- a/sys-utils/zramctl.c
> +++ b/sys-utils/zramctl.c
> @@ -193,18 +193,18 @@ static int zram_set_strparm(struct zram *z, const char *attr, const char *str)
>  }
>  
>  
> -static int zram_used(struct zram *z)
> +static int zram_used(struct zram *z, int find_unused)
>  {
>  	uint64_t size;
>  	struct sysfs_cxt *sysfs = zram_get_sysfs(z);
>  
> -	if (sysfs &&
> -	    sysfs_read_u64(sysfs, "disksize", &size) == 0 &&
> -	    size > 0) {
> -
> +	if (sysfs && sysfs_read_u64(sysfs, "disksize", &size) == 0) {
> +		if (find_unused && size == 0)
> +			goto unused;
>  		DBG(fprintf(stderr, "%s used", z->devname));
>  		return 1;
>  	}
> + unused:
>  	DBG(fprintf(stderr, "%s unused", z->devname));
>  	return 0;
>  }

Do we want to give the same message for both 'unused' and the case
when sysfs or disksize can't be determined?

And IMO the 'goto' here is a big gun for skipping 2 lines and a '}';
just reversing the condition would have done it, too.

Have a nice day,
Berny
