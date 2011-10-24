Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46107 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358Ab1JXSvL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 24 Oct 2011 14:51:11 -0400
Received: by mail-ey0-f174.google.com with SMTP id 27so5932864eye.19
        for <util-linux@vger.kernel.org>; Mon, 24 Oct 2011 11:51:10 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/2] build-sys: build prstat only when prlimit() is present
Date: Mon, 24 Oct 2011 20:50:45 +0200
Message-Id: <1319482245-5515-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1319482245-5515-1-git-send-email-kerolasa@iki.fi>
References: <1319482245-5515-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The prlimit() appeared kernel in 2.6.36 at October 2010, and to
glic in 2.13 at February 2011.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac          |    3 +++
 sys-utils/Makefile.am |    9 +++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 873f1b2..f2e257f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -227,6 +227,9 @@ AC_CHECK_FUNCS([openat fstatat unlinkat], [have_openat=yes], [have_openat=no])
 AC_CHECK_FUNCS([ioperm iopl], [have_io=yes])
 AM_CONDITIONAL([BUILD_HWCLOCK], test "x$have_io" = xyes -o "x$linux_os" = xyes)
 
+AC_CHECK_FUNCS([prlimit], [have_prlimit=yes])
+AM_CONDITIONAL([BUILD_PRLIMIT], test "x$have_prlimit" = xyes)
+
 AC_CHECK_MEMBER(struct sockaddr.sa_len,
 		AC_DEFINE_UNQUOTED(HAVE_SA_LEN,1,[Define if struct sockaddr contains sa_len]),,
 	[#include <sys/types.h>
diff --git a/sys-utils/Makefile.am b/sys-utils/Makefile.am
index 48595da..39b064c 100644
--- a/sys-utils/Makefile.am
+++ b/sys-utils/Makefile.am
@@ -2,11 +2,11 @@ include $(top_srcdir)/config/include-Makefile.am
 
 bin_PROGRAMS =
 sbin_PROGRAMS =
-usrbin_exec_PROGRAMS = flock ipcrm ipcs ipcmk renice setsid prlimit
+usrbin_exec_PROGRAMS = flock ipcrm ipcs ipcmk renice setsid
 usrsbin_exec_PROGRAMS = readprofile
 
 dist_man_MANS = flock.1 ipcrm.1 ipcs.1 ipcmk.1 renice.1 setsid.1 \
-		readprofile.8 prlimit.1
+		readprofile.8
 
 if LINUX
 bin_PROGRAMS += dmesg
@@ -41,9 +41,14 @@ dmesg_SOURCES = dmesg.c $(top_srcdir)/lib/strutils.c
 ipcmk_SOURCES = ipcmk.c $(top_srcdir)/lib/strutils.c
 ipcrm_SOURCES = ipcrm.c  $(top_srcdir)/lib/strutils.c
 flock_SOURCES = flock.c $(top_srcdir)/lib/strutils.c
+
+if BUILD_PRLIMIT
+usrbin_exec_PROGRAMS += prlimit
+dist_man_MANS += prlimit.1
 prlimit_SOURCES = prlimit.c $(top_srcdir)/lib/strutils.c \
 			$(top_srcdir)/lib/mbsalign.c \
 			$(top_srcdir)/lib/tt.c
+endif
 
 if BUILD_MOUNTPOINT
 bin_PROGRAMS += mountpoint
-- 
1.7.7

