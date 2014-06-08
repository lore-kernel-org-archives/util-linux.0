Return-Path: util-linux-owner@vger.kernel.org
Received: from skade.schwarzvogel.de ([144.76.18.87]:60899 "EHLO
	mail.schwarzvogel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299AbaFHNQ2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Jun 2014 09:16:28 -0400
Received: from klausman by mail.schwarzvogel.de with local (Exim 4.83_RC1)
	(envelope-from <klausman@schwarzvogel.de>)
	id 1WtcxW-000NXp-8z
	for util-linux@vger.kernel.org; Sun, 08 Jun 2014 15:16:26 +0200
Date: Sun, 8 Jun 2014 14:44:31 +0200
From: Tobias Klausmann <klausman@schwarzvogel.de>
To: Ruediger Meier <sweet_f_a@gmx.de>
Subject: Re: util-linux breakage with v2.24.2 on Alpha
Message-ID: <20140608124431.GA121104@skade.schwarzvogel.de>
References: <20140608104251.GA72528@skade.schwarzvogel.de>
 <201406081425.08453.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201406081425.08453.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi! 

On Sun, 08 Jun 2014, Ruediger Meier wrote:
> On Sunday 08 June 2014, Tobias Klausmann wrote:
> > Hey,
> >
> > I am one of the Gentoo maintainers for the Alpha arch. As of
> > util-linux 2.24, the build broke reliably:
> >
> >   CC       libfdisk/src/libfdisk_la-bsd.lo
> > libfdisk/src/bsd.c: In function bsd_translate_fstype:
> > libfdisk/src/bsd.c:790:10: error: BSD_FS_MSDOS undeclared (first use
> > in this function) return BSD_FS_MSDOS;
> >           ^
> 
> Looks like you have to ignore this case on alpha:
> 
> diff --git a/libfdisk/src/bsd.c b/libfdisk/src/bsd.c
> index a81afd2..df0fc13 100644
> --- a/libfdisk/src/bsd.c
> +++ b/libfdisk/src/bsd.c
> @@ -773,8 +773,10 @@ static int bsd_translate_fstype (int linux_type)
>         case 0x06: /* DOS 16-bit >=32M */
>         case 0xe1: /* DOS access       */
>         case 0xe3: /* DOS R/O          */
> +#if !defined (__alpha__)
>         case 0xf2: /* DOS secondary    */
>                 return BSD_FS_MSDOS;
> +#endif
>         case 0x07: /* OS/2 HPFS        */
>                 return BSD_FS_HPFS;
>         default

This seems to work when used against
404891fa9ea6a7ca86a838e809fc0b168169c286 aka tag v2.24.2:

$ make -j4 fdisk
[...]
  CCLD     libcommon.la
  CCLD     libuuid.la
  CCLD     libblkid.la
copying selected object files to avoid basename conflicts...
  CCLD     libfdisk.la
  CCLD     fdisk
$ sudo ./fdisk -l sda
Password: 
Disk /dev/sda: 17 GiB, 18209320960 bytes, 35565080 sectors
Geometry: 64 heads, 32 sectors/track, 17365 cylinders
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: bsd
partitions: 3

#     Start       End      Size Type     fsize bsize cpg
a      4096   1959935   1955840 swap                 
b   1959936  35563519  33603584 ext2                 
c         0  35563519  35563520 unused   0     0     

I'll get the patch into our distro for now. I presume this will
be picked up for one of the next versions of u-l?

Regards,
Tobias
