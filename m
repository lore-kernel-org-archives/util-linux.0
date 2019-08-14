Return-Path: <SRS0=UJgV=WK=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8FBC41514
	for <util-linux@archiver.kernel.org>; Wed, 14 Aug 2019 16:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE2920665
	for <util-linux@archiver.kernel.org>; Wed, 14 Aug 2019 16:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AHQFZHC/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cDnS6OQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfHNQpI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:45:08 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:39815 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727273AbfHNQpI (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 14 Aug 2019 12:45:08 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 0BFCD535
        for <util-linux@vger.kernel.org>; Wed, 14 Aug 2019 12:45:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 14 Aug 2019 12:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=a5zEQMypMeQa8
        /5l7iItjkMbI8GAxRR80sEMZe/iK6A=; b=AHQFZHC/5oExIwSJYOEUsNTYPtbjx
        rBwjWkN2HEKK5oS/lSnaRmd5teT1CJyIc0v5VZ+EoB3iY7/cZHHERh3zMtP8MCjw
        CjkgfSr/EqgN+mKmyQaDy8LNzE13sSjEwhWgr1OUCn7bJMaqqMv/AgEDVLjp1h31
        28sRRO4ryu+n01hr1MZdYALIbs57d6AEZ+sBsHXUPD9tZrqBSnLLK+LJlcBKhsbS
        bWVCrlHzOIuAubBO40bdcNIgXYisqG0UWSLXlFoN/d4ZtNbex7z2KIL8C/xBJg1t
        KaBLbROqXPcw+aS6xYg90TnmmZmpxAQ6FPWLrvQksLDgk8NMNA4R+sMfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=a5zEQMypMeQa8/5l7iItjkMbI8GAxRR80sEMZe/iK6A=; b=cDnS6OQb
        374lK/F+09qUo0hl2+qy0MYlfhltn77+1tmB+SVDOgJ3FEf5torw/wiv/p/2M69C
        n3napoxxBvHgKFo95vaer9Q8ifAElvvfbJMADkZeMZDjJm786Tv9jinj2RVftR+0
        P/YTLDzdexMI+XHeGYJvcXLHLaE4y2xl1BxTX1EDAnPt/Zwaix4YSDObKcnISb4b
        KkgZHD4JzSck6PNpIuaxyCJBkGuKPCD/UfjTX5ETp+wLcHVI3Qu4yPtZGLr8Le3+
        UCWl+eQs8bmkJZwfYRj1cdAIGwC8+8WeXgXxdC358KzXfupplNt+yyvaWF6K44Le
        tW89Ije3OcqJMw==
X-ME-Sender: <xms:kjpUXRVcmbqh1354VYZwS59RVGw281BNupPRWRPEUCI5m5jw3skcQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddvledggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecukfhppeejkedrheegrddujedvrddvudehnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:kjpUXV0IiPb3F-uncKXCCjdc_bBoFOZVUaU58aUYRdq5uMb4iFyitQ>
    <xmx:kjpUXYYK1kwyuGpo832YtRbO9-lgtRN2XdUEyzc22PxAReotFgX8RA>
    <xmx:kjpUXYroHfuk8tbSVu0j7BZS3AqX7rKzMLGuASGv7N35U-C-Ykf7WQ>
    <xmx:kjpUXacXRukje0xrshQFy2HEzme7KRTI82CBmddKccGiVG7b2jHL9w>
Received: from NSJAIL (x4e36acd7.dyn.telefonica.de [78.54.172.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id C580C80069
        for <util-linux@vger.kernel.org>; Wed, 14 Aug 2019 12:45:05 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 71aaf4aa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Wed, 14 Aug 2019 16:45:01 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/4] lib/closestream: move implementation into its own compilation unit
Date:   Wed, 14 Aug 2019 18:45:06 +0200
Message-Id: <34f93e3d72cc3c4efde28dbb91ca85eded10bf99.1565800625.git.ps@pks.im>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <cover.1565800625.git.ps@pks.im>
References: <cover.1565800625.git.ps@pks.im>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Currently, functionality provided by "closestream.h" is completely
implemented in the header only and does not have a corresponding C file
in "lib/". This makes it impossible to have global static data for use
with the closestream functions, as all static variables would get
declared per compilation unit that includes "closestream.h". As this is
required to make closing standard text streams work on non-glibc
platforms, move the implementation to "lib/closestream.c" and only keep
definitions in the header.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 disk-utils/Makemodule.am                   |  2 +
 include/closestream.h                      | 90 +++-------------------
 lib/Makemodule.am                          |  1 +
 include/closestream.h => lib/closestream.c | 18 +++--
 login-utils/Makemodule.am                  |  4 +-
 misc-utils/Makemodule.am                   | 10 ++-
 sys-utils/Makemodule.am                    |  9 ++-
 text-utils/Makemodule.am                   |  6 +-
 8 files changed, 45 insertions(+), 95 deletions(-)
 copy include/closestream.h => lib/closestream.c (86%)

diff --git a/disk-utils/Makemodule.am b/disk-utils/Makemodule.am
index bea0ed6a6..1676e40fd 100644
--- a/disk-utils/Makemodule.am
+++ b/disk-utils/Makemodule.am
@@ -25,6 +25,7 @@ if BUILD_MKFS
 sbin_PROGRAMS += mkfs
 dist_man_MANS += disk-utils/mkfs.8
 mkfs_SOURCES = disk-utils/mkfs.c
+mkfs_LDADD = $(LDADD) libcommon.la
 endif
 
 
@@ -98,6 +99,7 @@ if BUILD_RAW
 sbin_PROGRAMS += raw
 dist_man_MANS += disk-utils/raw.8
 raw_SOURCES = disk-utils/raw.c
+raw_LDADD = $(LDADD) libcommon.la
 endif
 
 
diff --git a/include/closestream.h b/include/closestream.h
index 83df1ee7d..8c72dde8f 100644
--- a/include/closestream.h
+++ b/include/closestream.h
@@ -1,87 +1,17 @@
+/*
+ * Copyright (C) 2019 Patrick Steinhardt <ps@pks.im>
+ *
+ * This file may be distributed under the terms of the
+ * GNU Lesser General Public License.
+ */
+
 #ifndef UTIL_LINUX_CLOSESTREAM_H
 #define UTIL_LINUX_CLOSESTREAM_H
 
 #include <stdio.h>
-#ifdef HAVE_STDIO_EXT_H
-#include <stdio_ext.h>
-#endif
-#include <unistd.h>
 
-#include "c.h"
-#include "nls.h"
-
-#ifndef CLOSE_EXIT_CODE
-# define CLOSE_EXIT_CODE EXIT_FAILURE
-#endif
-
-static inline int
-close_stream(FILE * stream)
-{
-#ifdef HAVE___FPENDING
-	const int some_pending = (__fpending(stream) != 0);
-#endif
-	const int prev_fail = (ferror(stream) != 0);
-	const int fclose_fail = (fclose(stream) != 0);
-
-	if (prev_fail || (fclose_fail && (
-#ifdef HAVE___FPENDING
-					  some_pending ||
-#endif
-					  errno != EBADF))) {
-		if (!fclose_fail && !(errno == EPIPE))
-			errno = 0;
-		return EOF;
-	}
-	return 0;
-}
-
-/* Meant to be used atexit(close_stdout); */
-static inline void
-close_stdout(void)
-{
-	if (stdout && close_stream(stdout) != 0 && !(errno == EPIPE)) {
-		if (errno)
-			warn(_("write error"));
-		else
-			warnx(_("write error"));
-		_exit(CLOSE_EXIT_CODE);
-	}
-
-	if (stderr && close_stream(stderr) != 0)
-		_exit(CLOSE_EXIT_CODE);
-
-	stdout = NULL;
-	stderr = NULL;
-}
-
-static inline void
-close_stdout_atexit(void)
-{
-	/*
-	 * Note that close stdout at exit disables ASAN to report memory leaks
-	 */
-#if !defined(__SANITIZE_ADDRESS__)
-	atexit(close_stdout);
-#endif
-}
-
-#ifndef HAVE_FSYNC
-static inline int
-fsync(int fd __attribute__((__unused__)))
-{
-	return 0;
-}
-#endif
-
-static inline int
-close_fd(int fd)
-{
-	const int fsync_fail = (fsync(fd) != 0);
-	const int close_fail = (close(fd) != 0);
-
-	if (fsync_fail || close_fail)
-		return EOF;
-	return 0;
-}
+extern int close_stream(FILE *stream);
+extern void close_stdout_atexit(void);
+extern int close_fd(int fd);
 
 #endif /* UTIL_LINUX_CLOSESTREAM_H */
diff --git a/lib/Makemodule.am b/lib/Makemodule.am
index 862a06c17..056311a40 100644
--- a/lib/Makemodule.am
+++ b/lib/Makemodule.am
@@ -4,6 +4,7 @@ libcommon_la_CFLAGS = $(AM_CFLAGS)
 libcommon_la_SOURCES = \
 	lib/blkdev.c \
 	lib/canonicalize.c \
+	lib/closestream.c \
 	lib/crc32.c \
 	lib/crc32c.c \
 	lib/env.c \
diff --git a/include/closestream.h b/lib/closestream.c
similarity index 86%
copy from include/closestream.h
copy to lib/closestream.c
index 83df1ee7d..d735e4f01 100644
--- a/include/closestream.h
+++ b/lib/closestream.c
@@ -1,5 +1,9 @@
-#ifndef UTIL_LINUX_CLOSESTREAM_H
-#define UTIL_LINUX_CLOSESTREAM_H
+/*
+ * Copyright (C) 2019 Patrick Steinhardt <ps@pks.im>
+ *
+ * This file may be distributed under the terms of the
+ * GNU Lesser General Public License.
+ */
 
 #include <stdio.h>
 #ifdef HAVE_STDIO_EXT_H
@@ -7,6 +11,7 @@
 #endif
 #include <unistd.h>
 
+#include "closestream.h"
 #include "c.h"
 #include "nls.h"
 
@@ -14,7 +19,7 @@
 # define CLOSE_EXIT_CODE EXIT_FAILURE
 #endif
 
-static inline int
+int
 close_stream(FILE * stream)
 {
 #ifdef HAVE___FPENDING
@@ -54,8 +59,7 @@ close_stdout(void)
 	stderr = NULL;
 }
 
-static inline void
-close_stdout_atexit(void)
+void close_stdout_atexit(void)
 {
 	/*
 	 * Note that close stdout at exit disables ASAN to report memory leaks
@@ -73,7 +77,7 @@ fsync(int fd __attribute__((__unused__)))
 }
 #endif
 
-static inline int
+int
 close_fd(int fd)
 {
 	const int fsync_fail = (fsync(fd) != 0);
@@ -83,5 +87,3 @@ close_fd(int fd)
 		return EOF;
 	return 0;
 }
-
-#endif /* UTIL_LINUX_CLOSESTREAM_H */
diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
index aafbea307..740cc0721 100644
--- a/login-utils/Makemodule.am
+++ b/login-utils/Makemodule.am
@@ -122,7 +122,7 @@ chfn_SOURCES = \
 	$(chfn_chsh_sources)
 chfn_CFLAGS = $(chfn_chsh_cflags)
 chfn_LDFLAGS = $(chfn_chsh_ldflags)
-chfn_LDADD = $(LDADD) $(chfn_chsh_ldadd)
+chfn_LDADD = $(LDADD) libcommon.la $(chfn_chsh_ldadd)
 
 chsh_SOURCES = login-utils/chsh.c $(chfn_chsh_sources)
 chsh_CFLAGS = $(chfn_chsh_cflags)
@@ -226,11 +226,13 @@ check_PROGRAMS += \
 
 test_islocal_SOURCES = login-utils/islocal.c
 test_islocal_CPPFLAGS = -DTEST_PROGRAM $(AM_CPPFLAGS)
+test_islocal_LDADD = $(LDADD) libcommon.la
 
 test_logindefs_SOURCES = \
 	login-utils/logindefs.c \
 	login-utils/logindefs.h
 test_logindefs_CPPFLAGS = -DTEST_PROGRAM $(AM_CPPFLAGS)
+test_logindefs_LDADD = $(LDADD) libcommon.la
 
 
 install-exec-hook:
diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index f56a819ac..34ee3e905 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -26,7 +26,7 @@ if BUILD_LOGGER
 usrbin_exec_PROGRAMS += logger
 dist_man_MANS += misc-utils/logger.1
 logger_SOURCES = misc-utils/logger.c lib/strutils.c lib/strv.c
-logger_LDADD = $(LDADD)
+logger_LDADD = $(LDADD) libcommon.la
 logger_CFLAGS = $(AM_CFLAGS)
 if HAVE_SYSTEMD
 logger_LDADD += $(SYSTEMD_LIBS) $(SYSTEMD_DAEMON_LIBS) $(SYSTEMD_JOURNAL_LIBS)
@@ -44,6 +44,7 @@ if BUILD_LOOK
 usrbin_exec_PROGRAMS += look
 dist_man_MANS += misc-utils/look.1
 look_SOURCES = misc-utils/look.c
+look_LDADD = $(LDADD) libcommon.la
 endif
 
 if BUILD_MCOOKIE
@@ -57,6 +58,7 @@ if BUILD_NAMEI
 usrbin_exec_PROGRAMS += namei
 dist_man_MANS += misc-utils/namei.1
 namei_SOURCES = misc-utils/namei.c lib/strutils.c lib/idcache.c
+namei_LDADD = $(LDADD) libcommon.la
 endif
 
 if BUILD_WHEREIS
@@ -94,7 +96,7 @@ if BUILD_UUIDGEN
 usrbin_exec_PROGRAMS += uuidgen
 dist_man_MANS += misc-utils/uuidgen.1
 uuidgen_SOURCES = misc-utils/uuidgen.c
-uuidgen_LDADD = $(LDADD) libuuid.la
+uuidgen_LDADD = $(LDADD) libcommon.la libuuid.la
 uuidgen_CFLAGS = $(AM_CFLAGS) -I$(ul_libuuid_incdir)
 endif
 
@@ -153,7 +155,7 @@ endif # BUILD_BLKID
 if BUILD_FINDFS
 sbin_PROGRAMS += findfs
 dist_man_MANS += misc-utils/findfs.8
-findfs_LDADD = $(LDADD) libblkid.la
+findfs_LDADD = $(LDADD) libblkid.la libcommon.la
 findfs_SOURCES = misc-utils/findfs.c
 findfs_CFLAGS = $(AM_CFLAGS) -I$(ul_libblkid_incdir)
 endif
@@ -197,12 +199,14 @@ if BUILD_RENAME
 usrbin_exec_PROGRAMS += rename
 dist_man_MANS += misc-utils/rename.1
 rename_SOURCES = misc-utils/rename.c
+rename_LDADD = $(LDADD) libcommon.la
 endif
 
 if BUILD_GETOPT
 usrbin_exec_PROGRAMS += getopt
 dist_man_MANS += misc-utils/getopt.1
 getopt_SOURCES = misc-utils/getopt.c
+getopt_LDADD = $(LDADD) libcommon.la
 getoptexampledir = $(docdir)/getopt/
 dist_getoptexample_SCRIPTS = \
 	misc-utils/getopt-parse.bash \
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 98e2cc29b..1b2277321 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -64,6 +64,7 @@ if BUILD_RENICE
 usrbin_exec_PROGRAMS += renice
 dist_man_MANS += sys-utils/renice.1
 renice_SOURCES = sys-utils/renice.c
+renice_LDADD = $(LDADD) libcommon.la
 endif
 
 if BUILD_RFKILL
@@ -78,12 +79,14 @@ if BUILD_SETSID
 usrbin_exec_PROGRAMS += setsid
 dist_man_MANS += sys-utils/setsid.1
 setsid_SOURCES = sys-utils/setsid.c
+setsid_LDADD = $(LDADD) libcommon.la
 endif
 
 if BUILD_READPROFILE
 usrsbin_exec_PROGRAMS += readprofile
 dist_man_MANS += sys-utils/readprofile.8
 readprofile_SOURCES = sys-utils/readprofile.c
+readprofile_LDADD = $(LDADD) libcommon.la
 endif
 
 if BUILD_TUNELP
@@ -132,6 +135,7 @@ if BUILD_FSFREEZE
 sbin_PROGRAMS += fsfreeze
 dist_man_MANS += sys-utils/fsfreeze.8
 fsfreeze_SOURCES = sys-utils/fsfreeze.c
+fsfreeze_LDADD = $(LDADD) libcommon.la
 endif
 
 if BUILD_BLKDISCARD
@@ -167,6 +171,7 @@ if BUILD_SETARCH
 usrbin_exec_PROGRAMS += setarch
 dist_man_MANS += sys-utils/setarch.8
 setarch_SOURCES = sys-utils/setarch.c
+setarch_LDADD = $(LDADD) libcommon.la
 
 SETARCH_LINKS = uname26 linux32 linux64
 
@@ -388,7 +393,7 @@ endif
 
 if BUILD_MOUNTPOINT
 bin_PROGRAMS += mountpoint
-mountpoint_LDADD = $(LDADD) libmount.la
+mountpoint_LDADD = $(LDADD) libcommon.la libmount.la
 mountpoint_CFLAGS = $(AM_CFLAGS) -I$(ul_libmount_incdir)
 dist_man_MANS += sys-utils/mountpoint.1
 mountpoint_SOURCES = sys-utils/mountpoint.c
@@ -405,12 +410,14 @@ if BUILD_PIVOT_ROOT
 sbin_PROGRAMS += pivot_root
 dist_man_MANS += sys-utils/pivot_root.8
 pivot_root_SOURCES = sys-utils/pivot_root.c
+pivot_root_LDADD = $(LDADD) libcommon.la
 endif
 
 if BUILD_SWITCH_ROOT
 sbin_PROGRAMS += switch_root
 dist_man_MANS += sys-utils/switch_root.8
 switch_root_SOURCES = sys-utils/switch_root.c
+switch_root_LDADD = $(LDADD) libcommon.la
 endif
 
 if BUILD_UNSHARE
diff --git a/text-utils/Makemodule.am b/text-utils/Makemodule.am
index 7478eb427..f77fc2d3e 100644
--- a/text-utils/Makemodule.am
+++ b/text-utils/Makemodule.am
@@ -9,6 +9,7 @@ if BUILD_COLCRT
 usrbin_exec_PROGRAMS += colcrt
 dist_man_MANS += text-utils/colcrt.1
 colcrt_SOURCES = text-utils/colcrt.c
+colcrt_LDADD = $(LDADD) libcommon.la
 endif
 
 if BUILD_COLRM
@@ -42,6 +43,7 @@ if BUILD_REV
 usrbin_exec_PROGRAMS += rev
 dist_man_MANS += text-utils/rev.1
 rev_SOURCES = text-utils/rev.c
+rev_LDADD = $(LDADD) libcommon.la
 endif
 
 if BUILD_LINE
@@ -64,7 +66,7 @@ usrbin_exec_PROGRAMS += ul
 dist_man_MANS += text-utils/ul.1
 ul_SOURCES = text-utils/ul.c
 ul_CFLAGS = $(AM_CFLAGS)
-ul_LDADD = $(LDADD)
+ul_LDADD = $(LDADD) libcommon.la
 if HAVE_TINFO
 ul_LDADD += $(TINFO_LIBS)
 ul_LDADD += $(TINFO_CFLAGS)
@@ -80,7 +82,7 @@ bin_PROGRAMS += more
 dist_man_MANS += text-utils/more.1
 more_SOURCES = text-utils/more.c
 more_CFLAGS = $(AM_CFLAGS) $(BSD_WARN_CFLAGS)
-more_LDADD = $(LDADD)
+more_LDADD = $(LDADD) libcommon.la
 if HAVE_TINFO
 more_LDADD += $(TINFO_LIBS)
 more_LDADD += $(TINFO_CFLAGS)
-- 
2.22.1

