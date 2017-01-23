Return-Path: util-linux-owner@vger.kernel.org
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:12086 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbdAWHix (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 23 Jan 2017 02:38:53 -0500
Subject: Re: [PATCH] Add blkzonecmd and blkreport ZAC/ZBC drives
To: Shaun Tancheff <shaun@tancheff.com>, Karel Zak <kzak@redhat.com>
References: <1484816545-28033-1-git-send-email-shaun@tancheff.com>
Cc: util-linux@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <3425316c-b457-daea-58f9-8e0d9dacf417@wdc.com>
Date: Mon, 23 Jan 2017 16:38:43 +0900
MIME-Version: 1.0
In-Reply-To: <1484816545-28033-1-git-send-email-shaun@tancheff.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Shaun,

On 1/19/17 18:02, Shaun Tancheff wrote:
> +++ b/sys-utils/blkreset.c
> @@ -0,0 +1,192 @@
> +/*
[...]
> +
> +	if (ioctl(fd, BLKGETSIZE64, &blksize))
> +		err(EXIT_FAILURE, _("%s: BLKGETSIZE64 ioctl failed"), path);
> +
> +	blksectors = blksize << 9;

blksize being in bytes here, it looks like the shift is in the wrong
direction here... i.e.

blksectors = blksize >> 9;

> +
> +	/* check offset alignment to the chunk size */
> +	if (zsector & (zsize - 1))
> +		errx(EXIT_FAILURE, _("%s: zone %" PRIu64 " is not aligned "
> +			 "to zone size %" PRIu64), path, zsector, zsize);
> +	if (zsector > blksectors)
> +		errx(EXIT_FAILURE, _("%s: zone %" PRIu64 " is too large "
> +			 "for device %" PRIu64), path, zsector, blksectors);
> +
> +	zlen = zcount * zsize;
> +	if (zsector + zlen > blksectors)
> +		zlen = blksectors - zsector;
> +
> +	za.sector = zsector;
> +	za.nr_sectors = zlen;
> +	rc = ioctl(fd, BLKRESETZONE, &za);
> +	if (rc == -1)
> +		err(EXIT_FAILURE, _("%s: BLKRESETZONE ioctl failed"), path);
> +
> +	close(fd);
> +	return EXIT_SUCCESS;
> +}
> 

Best regards.

-- 
Damien Le Moal, Ph.D.
Sr Manager, System Software Research Group,
Western Digital
Damien.LeMoal@hgst.com
Tel: (+81) 0466-98-3593 (Ext. 51-3593)
1 kirihara-cho, Fujisawa, Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
