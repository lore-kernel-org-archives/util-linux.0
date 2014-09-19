Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:50583 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbaISA17 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 18 Sep 2014 20:27:59 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id 8DC11E4FE
	for <util-linux@vger.kernel.org>; Fri, 19 Sep 2014 02:27:27 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] build-sys: link swapoff to libblkid
Date: Fri, 19 Sep 2014 02:27:19 +0200
Message-Id: <1411086439-8247-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The swapoff utility seems to need linking with libblkid otherwise
this build error occurs:

$ git describe
v2.25-180-g29607ed
$ ./autogen.sh && ./configure --without-python  && make
[....]
  CCLD     swapoff
/usr/bin/ld: sys-utils/swapoff-swapon-common.o: undefined reference to symbol 'blkid_probe_lookup_value@@BLKID_2.15'
//home/ah/opt/pkg-util-linux/util-linux/.libs/libblkid.so.1: error adding symbols: DSO missing from command line
collect2: error: ld returned 1 exit status
Makefile:5992: recipe for target 'swapoff' failed
make[2]: *** [swapoff] Error 1
make[2]: Leaving directory '/home/ah/opt/pkg-util-linux/util-linux'
Makefile:10220: recipe for target 'all-recursive' failed
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory '/home/ah/opt/pkg-util-linux/util-linux'
Makefile:4433: recipe for target 'all' failed
make: *** [all] Error 2

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 sys-utils/Makemodule.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 058bb62..62e26f4 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -275,7 +275,7 @@ swapon_LDADD = $(LDADD) \
 
 swapoff_SOURCES = sys-utils/swapoff.c sys-utils/swapon-common.c
 swapoff_CFLAGS = $(AM_CFLAGS) -I$(ul_libmount_incdir) -I$(ul_libblkid_incdir)
-swapoff_LDADD = $(LDADD) libmount.la
+swapoff_LDADD = $(LDADD) libmount.la libblkid.la
 endif
 
 if BUILD_LSCPU
-- 
2.1.0

