Return-Path: util-linux-owner@vger.kernel.org
Received: from solo.fdn.fr ([80.67.169.19]:47287 "EHLO solo.fdn.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754078Ab1FSPlk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 19 Jun 2011 11:41:40 -0400
Received: from const.ipv6 (youpi.is-a-geek.org [80.67.176.89])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by solo.fdn.fr (Postfix) with ESMTPS id 29D8B4420C
	for <util-linux@vger.kernel.org>; Sun, 19 Jun 2011 17:34:36 +0200 (CEST)
Received: from samy by const.ipv6 with local (Exim 4.76)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1QYK1D-0007iE-GV
	for util-linux@vger.kernel.org; Sun, 19 Jun 2011 17:34:35 +0200
Date: Sun, 19 Jun 2011 17:34:35 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: util-linux@vger.kernel.org
Subject: [PATCH,HURD] Fix Hurd build
Message-ID: <20110619153435.GA28888@const.famille.thibault.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

There are a lot of build failures due to BLKALIGNOFF not being available
on the Hurd, as well as a few other glitches, see log below. I've also
attached a proposed patch.

Samuel

$ make -k

[...]

make[2]: Entering directory `/home/sthibaul-guest/util-linux-ng/disk-utils'
  CC     mkswap-blkdev.o
../lib/blkdev.c: In function 'blkdev_is_misaligned':
../lib/blkdev.c:215: error: 'BLKALIGNOFF' undeclared (first use in this function)
../lib/blkdev.c:215: error: (Each undeclared identifier is reported only once
../lib/blkdev.c:215: error: for each function it appears in.)

[...]

make[4]: Entering directory `/home/sthibaul-guest/util-linux-ng/libblkid/src'
  CC     blkdev.lo
../../lib/blkdev.c: In function 'blkdev_is_misaligned':
../../lib/blkdev.c:215: error: 'BLKALIGNOFF' undeclared (first use in this function)
../../lib/blkdev.c:215: error: (Each undeclared identifier is reported only once
../../lib/blkdev.c:215: error: for each function it appears in.)

[...]

make[3]: Leaving directory `/home/sthibaul-guest/util-linux-ng/libblkid/src'
make[2]: *** [../libblkid/src/libblkid.la] Error 2
  CC     blkdev.o
../lib/blkdev.c: In function 'blkdev_is_misaligned':
../lib/blkdev.c:215: error: 'BLKALIGNOFF' undeclared (first use in this function)
../lib/blkdev.c:215: error: (Each undeclared identifier is reported only once
../lib/blkdev.c:215: error: for each function it appears in.)
make[2]: *** [blkdev.o] Error 1
  CC     swaplabel-blkdev.o
../lib/blkdev.c: In function 'blkdev_is_misaligned':
../lib/blkdev.c:215: error: 'BLKALIGNOFF' undeclared (first use in this function)
../lib/blkdev.c:215: error: (Each undeclared identifier is reported only once
../lib/blkdev.c:215: error: for each function it appears in.)

[...]

make[2]: Entering directory `/home/sthibaul-guest/util-linux-ng/fdisk'
  CC     fdisk-blkdev.o
../lib/blkdev.c: In function 'blkdev_is_misaligned':
../lib/blkdev.c:215: error: 'BLKALIGNOFF' undeclared (first use in this function)
../lib/blkdev.c:215: error: (Each undeclared identifier is reported only once
../lib/blkdev.c:215: error: for each function it appears in.)

[...]

make[4]: Entering directory
`/home/sthibaul-guest/util-linux-ng/libblkid/src'
  CC     blkdev.lo
  ../../lib/blkdev.c: In function 'blkdev_is_misaligned':
  ../../lib/blkdev.c:215: error: 'BLKALIGNOFF' undeclared (first use in
  this function)
  ../../lib/blkdev.c:215: error: (Each undeclared identifier is reported
  only once
  ../../lib/blkdev.c:215: error: for each function it appears in.)

[...]

make[2]: Entering directory `/home/sthibaul-guest/util-linux-ng/lib'
  CC     blkdev.o
blkdev.c: In function 'blkdev_is_misaligned':
blkdev.c:215: error: 'BLKALIGNOFF' undeclared (first use in this function)
blkdev.c:215: error: (Each undeclared identifier is reported only once
blkdev.c:215: error: for each function it appears in.)
make[2]: *** [blkdev.o] Error 1
  CC     procutils.o
procutils.c: In function 'proc_open_tasks':
procutils.c:35: error: 'PATH_MAX' undeclared (first use in this function)
procutils.c:35: error: (Each undeclared identifier is reported only once
procutils.c:35: error: for each function it appears in.)
make[2]: *** [procutils.o] Error 1

[...]

make[4]: Entering directory `/home/sthibaul-guest/util-linux-ng/libblkid/src'
  CC     blkdev.lo
../../lib/blkdev.c: In function 'blkdev_is_misaligned':
../../lib/blkdev.c:215: error: 'BLKALIGNOFF' undeclared (first use in this function)
../../lib/blkdev.c:215: error: (Each undeclared identifier is reported only once
../../lib/blkdev.c:215: error: for each function it appears in.)

[...]

make[4]: Entering directory `/home/sthibaul-guest/util-linux-ng/libblkid/src'
  CC     blkdev.lo
../../lib/blkdev.c: In function 'blkdev_is_misaligned':
../../lib/blkdev.c:215: error: 'BLKALIGNOFF' undeclared (first use in this function)
../../lib/blkdev.c:215: error: (Each undeclared identifier is reported only once
../../lib/blkdev.c:215: error: for each function it appears in.)

[...]

make[2]: Entering directory `/home/sthibaul-guest/util-linux-ng/schedutils'
  CC     procutils.o
../lib/procutils.c: In function 'proc_open_tasks':
../lib/procutils.c:35: error: 'PATH_MAX' undeclared (first use in this function)
../lib/procutils.c:35: error: (Each undeclared identifier is reported only once
../lib/procutils.c:35: error: for each function it appears in.)
make[2]: *** [procutils.o] Error 1

[...]

make[2]: Entering directory
`/home/sthibaul-guest/util-linux-ng/term-utils'
  CC     agetty.o
agetty.c: In function 'reset_vc':
agetty.c:1042: error: 'OFDEL' undeclared (first use in this function)
agetty.c:1042: error: (Each undeclared identifier is reported only
once
agetty.c:1042: error: for each function it appears in.)
agetty.c:1045: error: 'XCASE' undeclared (first use in this function)
agetty.c:1071: error: 'VSWTCH' undeclared (first use in this function)
agetty.c: In function 'log_err':
agetty.c:1608: error: 'LOG_ERR' undeclared (first use in this
function)
agetty.c: In function 'log_warn':
agetty.c:1621: error: 'LOG_WARNING' undeclared (first use in this
function)
make[2]: *** [agetty.o] Error 1

Samuel

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

Hurd build fixes

Make blkdev_is_misaligned return 0 when BLKALIGNOFF is not available.
Make procutils.c include c.h to get a PATH_MAX replacement
Provide agetty.c USE_SYSLOG, DEFAULT_VCTERM and DEFAULT_STERM defaults for Hurd.
Make agetty.c only deal with OFDEL, XCASE and VSWTCH if they are available.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff --git a/lib/blkdev.c b/lib/blkdev.c
index fb69e88..5cb6554 100644
--- a/lib/blkdev.c
+++ b/lib/blkdev.c
@@ -210,11 +210,15 @@ blkdev_get_sector_size(int fd, int *sector_size)
  */
 int blkdev_is_misaligned(int fd)
 {
+#ifdef BLKALIGNOFF
 	int aligned;
 
 	if (ioctl(fd, BLKALIGNOFF, &aligned) < 0)
 		return 0;			/* probably kernel < 2.6.32 */
 	return aligned;
+#else
+	return 0;
+#endif
 }
 
 #ifdef TEST_PROGRAM
diff --git a/lib/procutils.c b/lib/procutils.c
index 6a9ee74..2c9e837 100644
--- a/lib/procutils.c
+++ b/lib/procutils.c
@@ -23,6 +23,7 @@
 #include <ctype.h>
 
 #include "procutils.h"
+#include "c.h"
 
 /*
  * @pid: process ID for which we want to obtain the threads group
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 45624f5..6120a26 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -49,6 +49,14 @@
 #  ifndef DEFAULT_STERM
 #    define DEFAULT_STERM  "vt102"
 #  endif
+#elif defined(__GNU__)
+#  define USE_SYSLOG
+#  ifndef DEFAULT_VCTERM
+#    define DEFAULT_VCTERM "hurd"
+#  endif
+#  ifndef DEFAULT_STERM
+#    define DEFAULT_STERM  "vt102"
+#  endif
 #else
 #  ifndef DEFAULT_VCTERM
 #    define DEFAULT_VCTERM "vt100"
@@ -1039,15 +1047,21 @@ static void reset_vc(const struct options *op, struct termios *tp)
 	tp->c_iflag |=  (BRKINT | ICRNL | IMAXBEL);
 	tp->c_iflag &= ~(IGNBRK | INLCR | IGNCR | IXOFF | IUCLC | IXANY | ISTRIP);
 	tp->c_oflag |=  (OPOST | ONLCR | NL0 | CR0 | TAB0 | BS0 | VT0 | FF0);
-	tp->c_oflag &= ~(OLCUC | OCRNL | ONOCR | ONLRET | OFILL | OFDEL |\
+	tp->c_oflag &= ~(OLCUC | OCRNL | ONOCR | ONLRET | OFILL | \
 			    NLDLY|CRDLY|TABDLY|BSDLY|VTDLY|FFDLY);
 	tp->c_lflag |=  (ISIG | ICANON | IEXTEN | ECHO|ECHOE|ECHOK|ECHOKE);
-	tp->c_lflag &= ~(ECHONL|ECHOCTL|ECHOPRT | NOFLSH | XCASE | TOSTOP);
+	tp->c_lflag &= ~(ECHONL|ECHOCTL|ECHOPRT | NOFLSH | TOSTOP);
 
 	if ((op->flags & F_KEEPCFLAGS) == 0) {
 		tp->c_cflag |=  (CREAD | CS8 | HUPCL);
 		tp->c_cflag &= ~(PARODD | PARENB);
 	}
+#ifdef OFDEL
+	tp->c_oflag &= ~OFDEL;
+#endif
+#ifdef XCASE
+	tp->c_lflag &= ~XCASE;
+#endif
 #ifdef IUTF8
 	if (op->flags & F_UTF8)
 		tp->c_iflag |= IUTF8;	    /* Set UTF-8 input flag */
@@ -1067,7 +1081,7 @@ static void reset_vc(const struct options *op, struct termios *tp)
 	tp->c_cc[VEOF]     = CEOF;
 #ifdef VSWTC
 	tp->c_cc[VSWTC]    = _POSIX_VDISABLE;
-#else
+#elif defined(VSWTCH)
 	tp->c_cc[VSWTCH]   = _POSIX_VDISABLE;
 #endif
 	tp->c_cc[VSTART]   = CSTART;

--BOKacYhQ+x31HxR3--
