Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:58282 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753313AbaFHMZQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 8 Jun 2014 08:25:16 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: util-linux breakage with v2.24.2 on Alpha
Date: Sun, 8 Jun 2014 14:25:08 +0200
Cc: Tobias Klausmann <klausman@schwarzvogel.de>
References: <20140608104251.GA72528@skade.schwarzvogel.de>
In-Reply-To: <20140608104251.GA72528@skade.schwarzvogel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201406081425.08453.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sunday 08 June 2014, Tobias Klausmann wrote:
> Hey,
>
> I am one of the Gentoo maintainers for the Alpha arch. As of
> util-linux 2.24, the build broke reliably:
>
>   CC       libfdisk/src/libfdisk_la-bsd.lo
> libfdisk/src/bsd.c: In function bsd_translate_fstype:
> libfdisk/src/bsd.c:790:10: error: BSD_FS_MSDOS undeclared (first use
> in this function) return BSD_FS_MSDOS;
>           ^

Looks like you have to ignore this case on alpha:

diff --git a/libfdisk/src/bsd.c b/libfdisk/src/bsd.c
index a81afd2..df0fc13 100644
--- a/libfdisk/src/bsd.c
+++ b/libfdisk/src/bsd.c
@@ -773,8 +773,10 @@ static int bsd_translate_fstype (int linux_type)
        case 0x06: /* DOS 16-bit >=32M */
        case 0xe1: /* DOS access       */
        case 0xe3: /* DOS R/O          */
+#if !defined (__alpha__)
        case 0xf2: /* DOS secondary    */
                return BSD_FS_MSDOS;
+#endif
        case 0x07: /* OS/2 HPFS        */
                return BSD_FS_HPFS;
        default

> This is due to the this section in include/pt-bsd.h:
>
> /* this is annoying, but it's also the way it is :-( */
> #ifdef __alpha__
> #define BSD_FS_EXT2     8               /* ext2 file system */       
>           #else #define BSD_FS_MSDOS    8               /* MS-DOS
> file system */ #endif
>
> The problem is that libfdisk/src/bsd.c still uses that macro, even
> when compiling util-linux on Alpha.
>
> Regards,
> Tobias
>
> PS: I'm not susbscribed to the list, so please CC me on replies.
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
