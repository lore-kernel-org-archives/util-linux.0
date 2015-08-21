Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:56592
	"EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577AbbHUOWO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 21 Aug 2015 10:22:14 -0400
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH 3/3] hwclock: fix iopl implicit declaration warning on alpha
Date: Fri, 21 Aug 2015 16:13:29 +0200
Message-Id: <1440166409-32215-3-git-send-email-andreas@fatal.se>
In-Reply-To: <1440166409-32215-1-git-send-email-andreas@fatal.se>
References: <1440166409-32215-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Build warning:
sys-utils/hwclock-cmos.c: In function 'i386_iopl':
sys-utils/hwclock-cmos.c:611:9: warning: implicit declaration of function 'iopl' [-Wimplicit-function-declaration]
  return iopl(level);
         ^
sys-utils/hwclock-cmos.c:611:2: warning: nested extern declaration of 'iopl' [-Wnested-externs]
  return iopl(level);
  ^

Also:
checking sys/io.h usability... yes
checking sys/io.h presence... yes
checking for sys/io.h... yes

Full build log:
https://buildd.debian.org/status/fetch.php?pkg=util-linux&arch=alpha&ver=2.26.2-9&stamp=1440078034

Detected by/via:
https://qa.debian.org/bls/packages/u/util-linux.html

Please note that this has never been (build-)tested, but should hopefully
resolve the warning.

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 sys-utils/hwclock-cmos.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sys-utils/hwclock-cmos.c b/sys-utils/hwclock-cmos.c
index de678ab..7f564e7 100644
--- a/sys-utils/hwclock-cmos.c
+++ b/sys-utils/hwclock-cmos.c
@@ -79,9 +79,14 @@ int inb(int c __attribute__ ((__unused__)))
 #endif				/* __i386__ __x86_64__ */
 
 #elif defined(__alpha__)
+# ifdef HAVE_SYS_IO_H
+#  include <sys/io.h>
+# else
 /* <asm/io.h> fails to compile, probably because of u8 etc */
 extern unsigned int inb(unsigned long port);
 extern void outb(unsigned char b, unsigned long port);
+extern int iopl(int level);
+# endif
 #else
 static void outb(int a __attribute__ ((__unused__)),
 	  int b __attribute__ ((__unused__)))
-- 
2.1.4

