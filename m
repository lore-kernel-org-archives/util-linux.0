Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4519 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722Ab1KNOXT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Nov 2011 09:23:19 -0500
Date: Mon, 14 Nov 2011 15:23:15 +0100
From: Karel Zak <kzak@redhat.com>
To: Francesco Cosoleto <cosoleto@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] fdisk: avoid segfault validating a sgi label
	(boot/swap not set)
Message-ID: <20111114142315.GC23020@nb.net.home>
References: <1321278439-9392-1-git-send-email-cosoleto@gmail.com> <1321278439-9392-2-git-send-email-cosoleto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321278439-9392-2-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 14, 2011 at 02:47:18PM +0100, Francesco Cosoleto wrote:
> swap_part or boot_part can be set to -1 when they don't exist.

 Applied, thanks... but, how do you know that the number could be
 smaller than zero? Do you have any example/code?

>  int
>  sgi_get_swappartition(void)
>  {
> -	return SSWAP16(sgilabel->swap_part);
> +	return (short) SSWAP16(sgilabel->swap_part);
>  }

 It would be nice to cleanup whole fdisksgilabel.c and use
 be32_to_cpu() and be16_to_cpu() there. (See include/bitops.h).

 [...]

>  typedef struct {
>  	unsigned int   magic;		 /* expect SGI_LABEL_MAGIC */
> -	unsigned short boot_part;        /* active boot partition */
> -	unsigned short swap_part;        /* active swap partition */
> +	short boot_part;		/* active boot partition */
> +	short swap_part;		/* active swap partition */

 I prefer stdint.h types (e.g. int16_t) for things like on-disk
 labels/superblocks. But it's nothing urgent... whole fdisk should be
 refactored one day ;-)
 
 See for example libblkid/src/partitions/sgi.c. (Well, my long-term
 goal is to use libblkid for partition tables parsing in fdisk.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
