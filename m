Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:42583 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbaHBUL1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 2 Aug 2014 16:11:27 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id 4C3EFCBBC
	for <util-linux@vger.kernel.org>; Sat,  2 Aug 2014 22:11:25 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] libmount/buildsys: move SELINUX_LIBS to LDFLAGS
Date: Sat,  2 Aug 2014 22:11:01 +0200
Message-Id: <1407010261-17305-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

According to a bug report filed in the Debian bug tracking system
an unknown version of the package failed to cross-build because of
the -lfoo flags for SELinux being placed in LIBADD rather then LDFLAGS.
The build system still looks similar in this regard so it's possible
the problem still remains and hopefully this change should make things
more correct even if I still don't know if it solves the entire problem.

Reported-by: YunQiang Su <wzssyqa@gmail.com>
Addresses-Debian-Bug: #721431
Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 libmount/src/Makemodule.am | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libmount/src/Makemodule.am b/libmount/src/Makemodule.am
index 54ab51d..afe5cfa 100644
--- a/libmount/src/Makemodule.am
+++ b/libmount/src/Makemodule.am
@@ -30,7 +30,7 @@ libmount_la_SOURCES = \
 
 nodist_libmount_la_SOURCES = libmount/src/mountP.h
 
-libmount_la_LIBADD = libcommon.la libblkid.la $(SELINUX_LIBS)
+libmount_la_LIBADD = libcommon.la libblkid.la
 
 libmount_la_CFLAGS = \
 	$(SOLIB_CFLAGS) \
@@ -46,6 +46,7 @@ libmount_la_DEPENDENCIES = \
 
 libmount_la_LDFLAGS = \
 	$(SOLIB_LDFLAGS) \
+	$(SELINUX_LIBS) \
 	-Wl,--version-script=$(top_srcdir)/libmount/src/libmount.sym \
 	-version-info $(LIBMOUNT_VERSION_INFO)
 
-- 
2.0.1

