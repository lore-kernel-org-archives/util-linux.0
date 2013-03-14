Return-Path: util-linux-owner@vger.kernel.org
Received: from dsl.unpythonic.net ([206.222.212.217]:53727 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755725Ab3CNAtM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 13 Mar 2013 20:49:12 -0400
Date: Wed, 13 Mar 2013 19:39:47 -0500
From: Jeff Epler <jepler@unpythonic.net>
To: LaMont Jones <lamont@debian.org>
Cc: Roger Leigh <rleigh@codelibre.net>, util-linux@vger.kernel.org
Subject: Enable findmnt on kfreebsd
Message-ID: <20130314003946.GB4068@unpythonic.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In a recent discussion on #debian-kbsd, rleigh brought up the fact that
findmnt isn't available on kfreebsd; he feels it would be useful in
initscripts.

I had a look at what it would take to enable findmnt, which needs
libmount.  It turns out that not much is required: mostly, make a few
bits of code return (-)ENOSYS.  There were also a few more bits that
needed tweaking before kfreebsd was happy (LIST_HEAD is also in some
bsd-origin header, and of course <linux/posix_types.h> was not
available).

I'm not sure I correctly intuited where it was proper to return +ENOSYS
and where it was proper to return -ENOSYS, so this merits further study.

There's also a bit of debian bookkeeping which is not of interest to
util-linux@

Once this is done, findmnt (the only libmount-relying part I tested)
seems to work properly, including listing zfs filesystems.

Please copy me on any replies as I am not subscribed to util-linux.

Jeff

diff -u util-linux-2.20.1/configure.ac util-linux-2.20.1/configure.ac
--- util-linux-2.20.1/configure.ac
+++ util-linux-2.20.1/configure.ac
@@ -446,12 +446,7 @@
   [], enable_libmount=check
 )
 build_libmount=yes
-if test "x$enable_libmount" = xcheck; then
-  if test "x$linux_os" = xno; then
-    AC_MSG_WARN([non-linux system; do not build libmount])
-    build_libmount=no
-  fi
-elif test "x$enable_libmount" = xno; then
+if test "x$enable_libmount" = xno; then
     build_libmount=no
 fi
 
diff -u util-linux-2.20.1/debian/changelog util-linux-2.20.1/debian/changelog
--- util-linux-2.20.1/debian/changelog
+++ util-linux-2.20.1/debian/changelog
@@ -1,3 +1,10 @@
+util-linux (2.20.1-5.4) UNRELEASED; urgency=low
+
+  * Non-maintainer upload.
+  * Hack libmount into building (enables findmnt)
+
+ -- Jeff Epler <jepler@localhost>  Wed, 13 Mar 2013 19:04:59 -0500
+
 util-linux (2.20.1-5.3) unstable; urgency=low
 
   * Non-maintainer upload.
diff -u util-linux-2.20.1/debian/control util-linux-2.20.1/debian/control
--- util-linux-2.20.1/debian/control
+++ util-linux-2.20.1/debian/control
@@ -130,7 +130,7 @@
 Priority: required
 Depends: ${shlibs:Depends}, ${misc:Depends}
 Pre-Depends: multiarch-support
-Architecture: linux-any
+Architecture: linux-any kfreebsd-any
 Description: block device id library
  The device mounting library, used by mount and mount helpers.
 
only in patch2:
unchanged:
--- util-linux-2.20.1.orig/include/list.h
+++ util-linux-2.20.1/include/list.h
@@ -31,6 +31,10 @@
 
 #define LIST_HEAD_INIT(name) { &(name), &(name) }
 
+#ifdef LIST_HEAD
+#undef LIST_HEAD
+#endif
+
 #define LIST_HEAD(name) \
 	struct list_head name = LIST_HEAD_INIT(name)
 
only in patch2:
unchanged:
--- util-linux-2.20.1.orig/libmount/src/context_umount.c
+++ util-linux-2.20.1/libmount/src/context_umount.c
@@ -439,6 +439,9 @@
 /* Check whether the kernel supports UMOUNT_NOFOLLOW flag */
 static int umount_nofollow_support(void)
 {
+#ifdef __FreeBSD_kernel__
+	return  0;
+#else
 	int res = umount2("", UMOUNT_UNUSED);
 	if (res != -1 || errno != EINVAL)
 		return 0;
@@ -448,10 +451,14 @@
 		return 0;
 
 	return 1;
+#endif
 }
 
 static int do_umount(struct libmnt_context *cxt)
 {
+#ifdef __FreeBSD_kernel__
+	return -ENOSYS;
+#else
 	int rc = 0, flags = 0;
 	const char *src, *target;
 	char *tgtbuf = NULL;
@@ -541,6 +548,7 @@
 	cxt->syscall_status = 0;
 	DBG(CXT, mnt_debug_h(cxt, "umount(2) success"));
 	return 0;
+#endif
 }
 
 /**
only in patch2:
unchanged:
--- util-linux-2.20.1.orig/libmount/src/context_mount.c
+++ util-linux-2.20.1/libmount/src/context_mount.c
@@ -385,6 +385,9 @@
  */
 static int do_mount(struct libmnt_context *cxt, const char *try_type)
 {
+#ifdef __FreeBSD_kernel__
+	return ENOSYS;
+#else
 	int rc = 0;
 	const char *src, *target, *type;
 	unsigned long flags;
@@ -444,6 +447,7 @@
 	 */
 
 	return rc;
+#endif
 }
 
 static int do_mount_by_pattern(struct libmnt_context *cxt, const char *pattern)
only in patch2:
unchanged:
--- util-linux-2.20.1.orig/lib/loopdev.c
+++ util-linux-2.20.1/lib/loopdev.c
@@ -29,7 +29,9 @@
 #include <sys/sysmacros.h>
 #include <inttypes.h>
 #include <dirent.h>
+#ifdef __LINUX__
 #include <linux/posix_types.h>
+#endif
 
 #include "linux_version.h"
 #include "c.h"
