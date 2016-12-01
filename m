Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:53015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757082AbcLAIwS (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Dec 2016 03:52:18 -0500
Received: from tenfore.ga-group.nl ([217.186.11.144]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M2FhY-1d1rC02WcW-00s7VU for <util-linux@vger.kernel.org>; Thu, 01 Dec 2016
 09:52:16 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 09/11] build-sys: check for POSIX utmpx usage
Date: Thu,  1 Dec 2016 09:52:12 +0100
Message-Id: <1480582332-17407-10-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
References: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

We simply check for utmpxname and updwtmpx functions to disable
all programs which are not POSIX utmpx compatible, even though
last(1) and utmpdump(1) does not use them, see below.

utmpx.h is used in:
  login agetty write lslogins last runuser su utmpdump wall

Non-Posix utmpx usage:
   utmpxname        -> login agetty write lslogins
   updwtmpx         -> login agetty                     runuser su
   _PATH_.TMP       -> login agetty write lslogins last runuser su
   utmpx.ut_addr_v6 -> login                       last            utmpdump

POSIX utmpx usage:
   wall

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/configure.ac b/configure.ac
index bfcd218..afb255e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -424,6 +424,7 @@ AC_CHECK_FUNCS([futimens], [have_futimens=yes])
 AC_CHECK_FUNCS([inotify_init1], [have_inotify_init1=yes])
 AC_CHECK_FUNCS([open_memstream], [have_open_memstream=yes],[have_open_memstream=no])
 AC_CHECK_FUNCS([reboot], [have_reboot=yes],[have_reboot=no])
+AC_CHECK_FUNCS([updwtmpx updwtmpx], [have_gnu_utmpx=yes], [have_gnu_utmpx=no])
 
 AM_CONDITIONAL([HAVE_OPENAT], [test "x$have_openat" = xyes])
 
@@ -1244,6 +1245,7 @@ AC_ARG_ENABLE([agetty],
 )
 UL_BUILD_INIT([agetty])
 UL_REQUIRES_HAVE([agetty], [utmpx_h], [utmpx.h header])
+UL_REQUIRES_HAVE([agetty], [gnu_utmpx], [GNU utmpx fucntions])
 AM_CONDITIONAL([BUILD_AGETTY], [test "x$build_agetty" = xyes])
 AS_IF([test "x$have_futimens" = xyes -a "x$have_inotify_init1" = xyes ], [
   AC_DEFINE([AGETTY_RELOAD], [1], [Enable agetty --reload feature])
@@ -1365,6 +1367,7 @@ UL_BUILD_INIT([lslogins])
 UL_REQUIRES_BUILD([lslogins], [libsmartcols])
 UL_REQUIRES_HAVE([lslogins], [shadow_h], [shadow.h header])
 UL_REQUIRES_HAVE([lslogins], [utmpx_h], [utmpx.h header])
+UL_REQUIRES_HAVE([lslogins], [gnu_utmpx], [GNU utmpx fucntions])
 AM_CONDITIONAL([BUILD_LSLOGINS], [test "x$build_lslogins" = xyes])
 
 
@@ -1615,6 +1618,7 @@ AC_ARG_ENABLE([last],
 )
 UL_BUILD_INIT([last])
 UL_REQUIRES_HAVE([last], [utmpx_h], [utmpx.h header])
+UL_REQUIRES_HAVE([last], [gnu_utmpx], [GNU utmpx fucntions])
 AM_CONDITIONAL([BUILD_LAST], [test "x$build_last" = xyes])
 
 
@@ -1624,6 +1628,7 @@ AC_ARG_ENABLE([utmpdump],
 )
 UL_BUILD_INIT([utmpdump])
 UL_REQUIRES_HAVE([utmpdump], [utmpx_h], [utmpx.h header])
+UL_REQUIRES_HAVE([utmpdump], [gnu_utmpx], [GNU utmpx fucntions])
 AM_CONDITIONAL([BUILD_UTMPDUMP], [test "x$build_utmpdump" = xyes])
 
 
@@ -1743,6 +1748,7 @@ UL_BUILD_INIT([login])
 UL_REQUIRES_HAVE([login], [security_pam_appl_h], [PAM header file])
 UL_REQUIRES_HAVE([login], [security_pam_misc_h, security_openpam_h], [PAM conversation functions])
 UL_REQUIRES_HAVE([login], [utmpx_h], [utmpx.h header])
+UL_REQUIRES_HAVE([login], [gnu_utmpx], [GNU utmpx fucntions])
 AM_CONDITIONAL([BUILD_LOGIN], [test "x$build_login" = xyes])
 
 AC_ARG_ENABLE([login-chown-vcs],
@@ -1788,6 +1794,7 @@ AC_ARG_ENABLE([su],
 UL_BUILD_INIT([su])
 UL_REQUIRES_HAVE([su], [security_pam_appl_h], [PAM header file])
 UL_REQUIRES_HAVE([su], [utmpx_h], [utmpx.h header])
+UL_REQUIRES_HAVE([su], [gnu_utmpx], [GNU utmpx fucntions])
 AM_CONDITIONAL([BUILD_SU], [test "x$build_su" = xyes])
 
 
@@ -1798,6 +1805,7 @@ AC_ARG_ENABLE([runuser],
 UL_BUILD_INIT([runuser])
 UL_REQUIRES_HAVE([runuser], [security_pam_appl_h], [PAM header file])
 UL_REQUIRES_HAVE([runuser], [utmpx_h], [utmpx.h header])
+UL_REQUIRES_HAVE([runuser], [gnu_utmpx], [GNU utmpx fucntions])
 AM_CONDITIONAL([BUILD_RUNUSER], [test "x$build_runuser" = xyes])
 
 
@@ -1911,6 +1919,7 @@ AC_ARG_ENABLE([write],
 )
 UL_BUILD_INIT([write])
 UL_REQUIRES_HAVE([write], [utmpx_h], [utmpx.h header])
+UL_REQUIRES_HAVE([write], [gnu_utmpx], [GNU utmpx fucntions])
 AM_CONDITIONAL([BUILD_WRITE], [test "x$build_write" = xyes])
 
 
-- 
1.8.5.6

