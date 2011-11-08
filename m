Return-Path: util-linux-owner@vger.kernel.org
Received: from hapkido.dreamhost.com ([66.33.216.122]:52656 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943Ab1KHXk2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Nov 2011 18:40:28 -0500
Received: from homiemail-a7.g.dreamhost.com (caiajhbdcbbj.dreamhost.com [208.97.132.119])
	by hapkido.dreamhost.com (Postfix) with ESMTP id DCCEC275A21
	for <util-linux@vger.kernel.org>; Tue,  8 Nov 2011 15:40:28 -0800 (PST)
Subject: mount/fstab: fix build
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Nov 2011 00:39:46 +0100
Message-ID: <1320795586.3005.2.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

With the new build changes when libmount is not defined the compilation breaks:

fstab.c:440: undefined reference to `streq_except_trailing_slash'
collect2: ld returned 1 exit status
make[2]: *** [mtab_lock_test] Error 1
make[2]: Leaving directory `/home/dave/projects/ut/mount'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/dave/projects/ut'
make: *** [all] Error 2

This patch adds strutils to the fstab.c rule.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 mount/Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mount/Makefile.am b/mount/Makefile.am
index 1181550..01b9567 100644
--- a/mount/Makefile.am
+++ b/mount/Makefile.am
@@ -102,7 +102,7 @@ endif
 
 if !BUILD_LIBMOUNT_MOUNT
 noinst_PROGRAMS = mtab_lock_test
-mtab_lock_test_SOURCES = fstab.c $(srcs_common) $(hdrs_mount)
+mtab_lock_test_SOURCES = fstab.c $(srcs_common) $(top_srcdir)/lib/strutils.c $(hdrs_mount)
 mtab_lock_test_CPPFLAGS = -DMAIN_TEST_MTABLOCK $(AM_CPPFLAGS)
 endif
 
-- 
1.7.4.1



