Return-Path: util-linux-owner@vger.kernel.org
Received: from top.free-electrons.com ([176.31.233.9]:42326 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751856AbaFLUKa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 12 Jun 2014 16:10:30 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: util-linux@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH] Only move shared libraries to /lib if they exists
Date: Thu, 12 Jun 2014 22:10:27 +0200
Message-Id: <1402603827-29129-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In several Makemodule.am, there is a install-exec-hook-<library>
target whose role is to move the shared library from /usr/lib to /lib,
while keeping a symbolic link /usr/lib/libuuid.so ->
../../lib/<library>.so.<version>.

However, when util-linux is built with --enable-static
--disable-shared (as is needed on noMMU platforms that don't support
shared libraries), no <library>.so is built, but the
install-exec-hook-libuuid creates an invalid /usr/lib/<library>.so
symbolic link, pointing to ../../lib (yes, the directory). This causes
troubles later one when other libraries/programs are compiled with
-l<library>, as gcc thinks a shared library is available because
there's a file named /usr/lib/<library>.so.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 libblkid/src/Makemodule.am | 2 +-
 libmount/src/Makemodule.am | 2 +-
 libuuid/src/Makemodule.am  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libblkid/src/Makemodule.am b/libblkid/src/Makemodule.am
index 013877e..d9f9276 100644
--- a/libblkid/src/Makemodule.am
+++ b/libblkid/src/Makemodule.am
@@ -220,7 +220,7 @@ endif # BUILD_LIBBLKID_TESTS
 
 # move lib from $(usrlib_execdir) to $(libdir) if needed
 install-exec-hook-libblkid:
-	if test "$(usrlib_execdir)" != "$(libdir)"; then \
+	if test "$(usrlib_execdir)" != "$(libdir)" -a -f "$(DESTDIR)$(usrlib_execdir)/libblkid.so"; then \
 		mkdir -p $(DESTDIR)$(libdir); \
 		mv $(DESTDIR)$(usrlib_execdir)/libblkid.so.* $(DESTDIR)$(libdir); \
 		so_img_name=$$(readlink $(DESTDIR)$(usrlib_execdir)/libblkid.so); \
diff --git a/libmount/src/Makemodule.am b/libmount/src/Makemodule.am
index 9101811..54ab51d 100644
--- a/libmount/src/Makemodule.am
+++ b/libmount/src/Makemodule.am
@@ -123,7 +123,7 @@ endif # BUILD_LIBMOUNT_TESTS
 
 # move lib from $(usrlib_execdir) to $(libdir) if needed
 install-exec-hook-libmount:
-	if test "$(usrlib_execdir)" != "$(libdir)"; then \
+	if test "$(usrlib_execdir)" != "$(libdir)" -a -f "$(DESTDIR)$(usrlib_execdir)/libmount.so"; then \
 		mkdir -p $(DESTDIR)$(libdir); \
 		mv $(DESTDIR)$(usrlib_execdir)/libmount.so.* $(DESTDIR)$(libdir); \
 		so_img_name=$$(readlink $(DESTDIR)$(usrlib_execdir)/libmount.so); \
diff --git a/libuuid/src/Makemodule.am b/libuuid/src/Makemodule.am
index a20cb4c..a5fd561 100644
--- a/libuuid/src/Makemodule.am
+++ b/libuuid/src/Makemodule.am
@@ -44,7 +44,7 @@ EXTRA_DIST += libuuid/src/uuid.sym
 
 # move lib from $(usrlib_execdir) to $(libdir) if needed
 install-exec-hook-libuuid:
-	if test "$(usrlib_execdir)" != "$(libdir)"; then \
+	if test "$(usrlib_execdir)" != "$(libdir)" -a -f "$(DESTDIR)$(usrlib_execdir)/libuuid.so"; then \
 		mkdir -p $(DESTDIR)$(libdir); \
 		mv $(DESTDIR)$(usrlib_execdir)/libuuid.so.* $(DESTDIR)$(libdir); \
 		so_img_name=$$(readlink $(DESTDIR)$(usrlib_execdir)/libuuid.so); \
-- 
2.0.0

