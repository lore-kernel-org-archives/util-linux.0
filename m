Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:53290 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbaIRXhT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 18 Sep 2014 19:37:19 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id 1E052E564
	for <util-linux@vger.kernel.org>; Fri, 19 Sep 2014 01:36:46 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH 2/5] libmount: only include context on linux
Date: Fri, 19 Sep 2014 01:36:34 +0200
Message-Id: <1411083397-8056-2-git-send-email-andreas@fatal.se>
In-Reply-To: <1411083397-8056-1-git-send-email-andreas@fatal.se>
References: <1411083397-8056-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is part of an attempt to make libmount buildable on non-linux.

The parts that need architecture specific porting is under
the context*.c files and the rest of libmount is useful/used
by for example fsck.

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 libmount/src/Makemodule.am | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/libmount/src/Makemodule.am b/libmount/src/Makemodule.am
index d21179a..5a03520 100644
--- a/libmount/src/Makemodule.am
+++ b/libmount/src/Makemodule.am
@@ -8,10 +8,6 @@ libmount_la_SOURCES = \
 	include/list.h \
 	\
 	libmount/src/cache.c \
-	libmount/src/context.c \
-	libmount/src/context_loopdev.c \
-	libmount/src/context_mount.c \
-	libmount/src/context_umount.c \
 	libmount/src/fs.c \
 	libmount/src/init.c \
 	libmount/src/iter.c \
@@ -28,6 +24,14 @@ libmount_la_SOURCES = \
 	libmount/src/version.c \
 	$(nodist_mountinc_HEADERS)
 
+if LINUX
+libmount_la_SOURCES += \
+	libmount/src/context.c \
+	libmount/src/context_loopdev.c \
+	libmount/src/context_mount.c \
+	libmount/src/context_umount.c
+endif
+
 nodist_libmount_la_SOURCES = libmount/src/mountP.h
 
 libmount_la_LIBADD = libcommon.la libblkid.la $(SELINUX_LIBS)
-- 
2.1.0.rc1

