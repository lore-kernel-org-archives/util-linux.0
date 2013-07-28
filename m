Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:55539 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650Ab3G1VL3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Jul 2013 17:11:29 -0400
Received: by mail-wg0-f48.google.com with SMTP id f12so3666516wgh.15
        for <util-linux@vger.kernel.org>; Sun, 28 Jul 2013 14:11:28 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/7] setarch: prefer preprocessor rather than autotools check
Date: Sun, 28 Jul 2013 22:11:16 +0100
Message-Id: <1375045881-11978-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1375045881-11978-1-git-send-email-kerolasa@iki.fi>
References: <1375045881-11978-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It seems to be pointless to spend time in ./configure phase when
preprocessor has to perform #ifndef check anyway.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac        | 12 ------------
 sys-utils/setarch.c | 22 +++++++++++-----------
 2 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/configure.ac b/configure.ac
index 398aaf0..006de93 100644
--- a/configure.ac
+++ b/configure.ac
@@ -252,18 +252,6 @@ AC_CHECK_MEMBERS([struct termios.c_line],,,
 AC_CHECK_MEMBERS([struct stat.st_mtim.tv_nsec],,,
 	[#include <sys/stat.h>])
 
-AC_CHECK_DECLS([
- UNAME26,
- ADDR_NO_RANDOMIZE,
- FDPIC_FUNCPTRS,
- MMAP_PAGE_ZERO,
- ADDR_COMPAT_LAYOUT,
- READ_IMPLIES_EXEC,
- ADDR_LIMIT_32BIT,
- WHOLE_SECONDS,
- STICKY_TIMEOUTS,
- ADDR_LIMIT_3GB], [], [], [#include <linux/personality.h>])
-
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM(
 [[
 #ifdef HAVE_SYS_SWAP_H
diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index 051cbef..99724c6 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -53,37 +53,37 @@ enum {
 	} while(0)
 
 
-#if !HAVE_DECL_UNAME26
+#ifndef UNAME26
 # define UNAME26                 0x0020000
 #endif
-#if !HAVE_DECL_ADDR_NO_RANDOMIZE
+#ifndef ADDR_NO_RANDOMIZE
 # define ADDR_NO_RANDOMIZE       0x0040000
 #endif
-#if !HAVE_DECL_FDPIC_FUNCPTRS
+#ifndef FDPIC_FUNCPTRS
 # define FDPIC_FUNCPTRS          0x0080000
 #endif
-#if !HAVE_DECL_MMAP_PAGE_ZERO
+#ifndef MMAP_PAGE_ZERO
 # define MMAP_PAGE_ZERO          0x0100000
 #endif
-#if !HAVE_DECL_ADDR_COMPAT_LAYOUT
+#ifndef ADDR_COMPAT_LAYOUT
 # define ADDR_COMPAT_LAYOUT      0x0200000
 #endif
-#if !HAVE_DECL_READ_IMPLIES_EXEC
+#ifndef READ_IMPLIES_EXEC
 # define READ_IMPLIES_EXEC       0x0400000
 #endif
-#if !HAVE_DECL_ADDR_LIMIT_32BIT
+#ifndef ADDR_LIMIT_32BIT
 # define ADDR_LIMIT_32BIT        0x0800000
 #endif
-#if !HAVE_DECL_SHORT_INODE
+#ifndef SHORT_INODE
 # define SHORT_INODE             0x1000000
 #endif
-#if !HAVE_DECL_WHOLE_SECONDS
+#ifndef WHOLE_SECONDS
 # define WHOLE_SECONDS           0x2000000
 #endif
-#if !HAVE_DECL_STICKY_TIMEOUTS
+#ifndef STICKY_TIMEOUTS
 # define STICKY_TIMEOUTS         0x4000000
 #endif
-#if !HAVE_DECL_ADDR_LIMIT_3GB
+#ifndef ADDR_LIMIT_3GB
 # define ADDR_LIMIT_3GB          0x8000000
 #endif
 
-- 
1.8.3.4

