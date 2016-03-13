Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:65269 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754311AbcCMWb0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 Mar 2016 18:31:26 -0400
Received: from tenfore.ga-group.nl ([2.247.85.77]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MOkQc-1aj6QE2fMk-0063Yp for
 <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 23:31:24 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 09/12] build-sys: use AC_PROG_MKDIR_P and remove a few gnuisms
Date: Sun, 13 Mar 2016 23:31:17 +0100
Message-Id: <1457908280-15588-10-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
References: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 Makefile.am                    | 2 +-
 configure.ac                   | 1 +
 libblkid/src/Makemodule.am     | 2 +-
 libfdisk/src/Makemodule.am     | 2 +-
 libmount/src/Makemodule.am     | 2 +-
 libsmartcols/src/Makemodule.am | 2 +-
 libuuid/src/Makemodule.am      | 2 +-
 sys-utils/Makemodule.am        | 2 +-
 8 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index f5322b3..3a8f471 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -144,7 +144,7 @@ EXTRA_DIST += $(PATHFILES:=.in)
 
 $(PATHFILES): Makefile
 	@ rm -f $@ $@.tmp
-	$(AM_V_at) test -d $(dir $@) || mkdir -p $(dir $@)
+	$(AM_V_at) $(MKDIR_P) $$(dirname $@)
 	$(AM_V_GEN) srcdir=''; \
 		test -f ./$@.in || srcdir=$(srcdir)/; \
 		$(edit_cmd) $${srcdir}$@.in >$@.tmp
diff --git a/configure.ac b/configure.ac
index bfb12ca..5e89e3b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -99,6 +99,7 @@ AC_SUBST([usrlib_execdir])
 
 
 AM_PROG_CC_C_O
+AC_PROG_MKDIR_P
 AC_PROG_CC_STDC
 AC_CANONICAL_HOST
 AC_C_CONST
diff --git a/libblkid/src/Makemodule.am b/libblkid/src/Makemodule.am
index 7839813..1fa00e9 100644
--- a/libblkid/src/Makemodule.am
+++ b/libblkid/src/Makemodule.am
@@ -224,7 +224,7 @@ endif # BUILD_LIBBLKID_TESTS
 # move lib from $(usrlib_execdir) to $(libdir) if needed
 install-exec-hook-libblkid:
 	if test "$(usrlib_execdir)" != "$(libdir)" -a -f "$(DESTDIR)$(usrlib_execdir)/libblkid.so"; then \
-		mkdir -p $(DESTDIR)$(libdir); \
+		$(MKDIR_P) $(DESTDIR)$(libdir); \
 		mv $(DESTDIR)$(usrlib_execdir)/libblkid.so.* $(DESTDIR)$(libdir); \
 		so_img_name=$$(readlink $(DESTDIR)$(usrlib_execdir)/libblkid.so); \
 		so_img_rel_target=$$(echo $(usrlib_execdir) | sed 's,\(^/\|\)[^/][^/]*,..,g'); \
diff --git a/libfdisk/src/Makemodule.am b/libfdisk/src/Makemodule.am
index 3516d12..bc7f1a3 100644
--- a/libfdisk/src/Makemodule.am
+++ b/libfdisk/src/Makemodule.am
@@ -111,7 +111,7 @@ endif # BUILD_LIBFDISK_TESTS
 # move lib from $(usrlib_execdir) to $(libdir) if needed
 install-exec-hook-libfdisk:
 	if test "$(usrlib_execdir)" != "$(libdir)" -a -f "$(DESTDIR)$(usrlib_execdir)/libfdisk.so"; then \
-		mkdir -p $(DESTDIR)$(libdir); \
+		$(MKDIR_P) $(DESTDIR)$(libdir); \
 		mv $(DESTDIR)$(usrlib_execdir)/libfdisk.so.* $(DESTDIR)$(libdir); \
 		so_img_name=$$(readlink $(DESTDIR)$(usrlib_execdir)/libfdisk.so); \
 		so_img_rel_target=$$(echo $(usrlib_execdir) | sed 's,\(^/\|\)[^/][^/]*,..,g'); \
diff --git a/libmount/src/Makemodule.am b/libmount/src/Makemodule.am
index 40a05c6..fd007a4 100644
--- a/libmount/src/Makemodule.am
+++ b/libmount/src/Makemodule.am
@@ -154,7 +154,7 @@ endif # BUILD_LIBMOUNT_TESTS
 # move lib from $(usrlib_execdir) to $(libdir) if needed
 install-exec-hook-libmount:
 	if test "$(usrlib_execdir)" != "$(libdir)" -a -f "$(DESTDIR)$(usrlib_execdir)/libmount.so"; then \
-		mkdir -p $(DESTDIR)$(libdir); \
+		$(MKDIR_P) $(DESTDIR)$(libdir); \
 		mv $(DESTDIR)$(usrlib_execdir)/libmount.so.* $(DESTDIR)$(libdir); \
 		so_img_name=$$(readlink $(DESTDIR)$(usrlib_execdir)/libmount.so); \
 		so_img_rel_target=$$(echo $(usrlib_execdir) | sed 's,\(^/\|\)[^/][^/]*,..,g'); \
diff --git a/libsmartcols/src/Makemodule.am b/libsmartcols/src/Makemodule.am
index 3f814d2..83c12ca 100644
--- a/libsmartcols/src/Makemodule.am
+++ b/libsmartcols/src/Makemodule.am
@@ -48,7 +48,7 @@ EXTRA_DIST += \
 # move lib from $(usrlib_execdir) to $(libdir) if needed
 install-exec-hook-libsmartcols:
 	if test "$(usrlib_execdir)" != "$(libdir)" -a -f "$(DESTDIR)$(usrlib_execdir)/libsmartcols.so"; then \
-		mkdir -p $(DESTDIR)$(libdir); \
+		$(MKDIR_P) $(DESTDIR)$(libdir); \
 		mv $(DESTDIR)$(usrlib_execdir)/libsmartcols.so.* $(DESTDIR)$(libdir); \
 		so_img_name=$$(readlink $(DESTDIR)$(usrlib_execdir)/libsmartcols.so); \
 		so_img_rel_target=$$(echo $(usrlib_execdir) | sed 's,\(^/\|\)[^/][^/]*,..,g'); \
diff --git a/libuuid/src/Makemodule.am b/libuuid/src/Makemodule.am
index 2e17677..d3fc811 100644
--- a/libuuid/src/Makemodule.am
+++ b/libuuid/src/Makemodule.am
@@ -48,7 +48,7 @@ EXTRA_DIST += libuuid/src/libuuid.sym
 # move lib from $(usrlib_execdir) to $(libdir) if needed
 install-exec-hook-libuuid:
 	if test "$(usrlib_execdir)" != "$(libdir)" -a -f "$(DESTDIR)$(usrlib_execdir)/libuuid.so"; then \
-		mkdir -p $(DESTDIR)$(libdir); \
+		$(MKDIR_P) $(DESTDIR)$(libdir); \
 		mv $(DESTDIR)$(usrlib_execdir)/libuuid.so.* $(DESTDIR)$(libdir); \
 		so_img_name=$$(readlink $(DESTDIR)$(usrlib_execdir)/libuuid.so); \
 		so_img_rel_target=$$(echo $(usrlib_execdir) | sed 's,\(^/\|\)[^/][^/]*,..,g'); \
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index c62d77c..ad60360 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -163,7 +163,7 @@ man_MANS += $(SETARCH_MAN_LINKS)
 CLEANFILES += $(SETARCH_MAN_LINKS)
 
 $(SETARCH_MAN_LINKS):
-	$(AM_V_at) test -d $(dir $@) || mkdir -p $(dir $@)
+	$(AM_V_at) $(MKDIR_P) sys-utils
 	$(AM_V_GEN)echo ".so man8/setarch.8" > $@
 
 install-exec-hook-setarch:
-- 
1.8.4.5

