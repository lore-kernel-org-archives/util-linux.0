Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49829 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbbDHI1o (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 8 Apr 2015 04:27:44 -0400
Date: Wed, 8 Apr 2015 10:27:42 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?J=F6rg?= Jenderek <joerg.jen.der.ek@gmx.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fdisk: to recognize FAT32 partitions hidden by Acronis
 software
Message-ID: <20150408082742.GJ3923@ws.net.home>
References: <201503251944.01461.joerg.jen.der.ek@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201503251944.01461.joerg.jen.der.ek@gmx.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 25, 2015 at 08:44:01PM +0200, Jörg Jenderek wrote:
> --- util-linux-2.26/include/pt-mbr.h.old	2015-02-10 10:49:46.000000000 +0100
> +++ util-linux-2.26/include/pt-mbr.h	2015-03-25 19:30:49.000000000 +0100
> @@ -150,2 +150,3 @@
>  	MBR_BOOTWIZARD_HIDDEN_PARTITION	= 0xbb,
> +	MBR_ACRONIS_FAT32LBA_PARTITION  = 0xbc, /* Acronis Secure Zone with ipl for loader F11.SYS */
>  	MBR_SOLARIS_BOOT_PARTITION	= 0xbe,
> 
> pt-mbr-partnames-acronis.diff
> --- util-linux-2.26/include/pt-mbr-partnames.h.old	2015-02-10 10:49:46.000000000 +0100
> +++ util-linux-2.26/include/pt-mbr-partnames.h	2015-03-25 19:18:53.000000000 +0100
> @@ -73,2 +73,6 @@
>  	{0xbb, N_("Boot Wizard hidden")},
> +	{0xbc, N_("Acronis FAT32 LBA")},/* hidden (+0xb0) FAT32 LBA with 
> +					   ipl for Acronis loader F11.SYS 
> +					   by Acronis partition backup software
> +					   is called Acronis Secure Zone */

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
