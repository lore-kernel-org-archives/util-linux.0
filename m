Return-Path: util-linux-owner@vger.kernel.org
Received: from skade.schwarzvogel.de ([144.76.18.87]:60174 "EHLO
	mail.schwarzvogel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbaFHLKB convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Jun 2014 07:10:01 -0400
Received: from klausman by mail.schwarzvogel.de with local (Exim 4.83_RC1)
	(envelope-from <klausman@schwarzvogel.de>)
	id 1WtaYt-000Jei-L3
	for util-linux@vger.kernel.org; Sun, 08 Jun 2014 12:42:51 +0200
Date: Sun, 8 Jun 2014 12:42:51 +0200
From: Tobias Klausmann <klausman@schwarzvogel.de>
To: util-linux@vger.kernel.org
Subject: util-linux breakage with v2.24.2 on Alpha
Message-ID: <20140608104251.GA72528@skade.schwarzvogel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hey,

I am one of the Gentoo maintainers for the Alpha arch. As of
util-linux 2.24, the build broke reliably:

  CC       libfdisk/src/libfdisk_la-bsd.lo
libfdisk/src/bsd.c: In function ‘bsd_translate_fstype’:
libfdisk/src/bsd.c:790:10: error: ‘BSD_FS_MSDOS’ undeclared (first use in this function)
   return BSD_FS_MSDOS;
          ^

This is due to the this section in include/pt-bsd.h:

/* this is annoying, but it's also the way it is :-( */                         
#ifdef __alpha__                                                                
#define BSD_FS_EXT2     8               /* ext2 file system */                  #else                                                                           
#define BSD_FS_MSDOS    8               /* MS-DOS file system */                
#endif                                                                          
                                                                                
The problem is that libfdisk/src/bsd.c still uses that macro, even
when compiling util-linux on Alpha. 

Regards,
Tobias

PS: I'm not susbscribed to the list, so please CC me on replies.
