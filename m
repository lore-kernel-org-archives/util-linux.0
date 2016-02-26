Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:65292 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088AbcBZDDg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 25 Feb 2016 22:03:36 -0500
Received: from tenfore.ga-group.nl ([95.114.239.233]) by mail.gmx.com
 (mrgmx101) with ESMTPSA (Nemesis) id 0LcWSI-1a6zgG02Za-00jqLF for
 <util-linux@vger.kernel.org>; Fri, 26 Feb 2016 04:03:34 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 02/14] build-sys: add openat build conditional
Date: Fri, 26 Feb 2016 04:03:25 +0100
Message-Id: <1456455812-19453-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
References: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Using this conditional for test progs only should be ok.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac                       | 2 ++
 libsmartcols/samples/Makemodule.am | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 7b6a9e7..b8b0074 100644
--- a/configure.ac
+++ b/configure.ac
@@ -397,6 +397,8 @@ AC_CHECK_FUNCS([inotify_init1], [have_inotify_init1=yes])
 AC_CHECK_FUNCS([open_memstream], [have_open_memstream=yes],[have_open_memstream=no])
 AC_CHECK_FUNCS([reboot], [have_reboot=yes],[have_reboot=no])
 
+AM_CONDITIONAL([HAVE_OPENAT], [test "x$have_openat" = xyes])
+
 dnl lib/mononotic.c may require -lrt
 AC_CHECK_FUNCS([clock_gettime], [],
 	[AC_CHECK_LIB([rt], [clock_gettime], [REALTIME_LIBS="-lrt"])]
diff --git a/libsmartcols/samples/Makemodule.am b/libsmartcols/samples/Makemodule.am
index be74fc3..0a2d892 100644
--- a/libsmartcols/samples/Makemodule.am
+++ b/libsmartcols/samples/Makemodule.am
@@ -1,6 +1,5 @@
 
 check_PROGRAMS += \
-	sample-scols-tree \
 	sample-scols-title \
 	sample-scols-wrap \
 	sample-scols-continuous
@@ -9,9 +8,12 @@ sample_scols_cflags = $(AM_CFLAGS) $(NO_UNUSED_WARN_CFLAGS) \
                       -I$(ul_libsmartcols_incdir)
 sample_scols_ldadd = $(LDADD) libsmartcols.la
 
+if HAVE_OPENAT
+check_PROGRAMS += sample-scols-tree
 sample_scols_tree_SOURCES = libsmartcols/samples/tree.c
 sample_scols_tree_LDADD = $(sample_scols_ldadd) libcommon.la
 sample_scols_tree_CFLAGS = $(sample_scols_cflags)
+endif
 
 sample_scols_title_SOURCES = libsmartcols/samples/title.c
 sample_scols_title_LDADD = $(sample_scols_ldadd)
-- 
1.8.4.5

