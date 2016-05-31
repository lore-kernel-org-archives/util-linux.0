Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:57838 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbcEaUr0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 31 May 2016 16:47:26 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 9BCE0AAEF
	for <util-linux@vger.kernel.org>; Tue, 31 May 2016 20:47:25 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] Don't allow widechar with plain ncurses
Message-ID: <34855db6-f82e-d9df-6bb9-022be6d06523@suse.cz>
Date: Tue, 31 May 2016 22:47:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Standard ncurses library does not pass UTF-8 characters properly.

As widechar-enabled libsmartcols directly uses UTF-8 characters in
table.c, it is unusable in applications using ncurses (e. g. cfdisk).

Fail if widechar support is detected, ncurses is supported but
libncursesw is not found.

Example of mangled cfdisk output:
    /dev/sda1              2048  4095999  4093952    2G   5 Extended 
>>  M-b~T~TM-b~T~@/dev/sda5            4096  4095999  4091904    2G  
83 Linux    

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 configure.ac | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure.ac b/configure.ac
index f36b18c..a64fd7b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -633,6 +633,7 @@ AC_CHECK_TYPES([union semun], [], [], [[
 ]])
 AC_CHECK_TYPES([loff_t])
 
+have_widechar=no
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
 #include <wchar.h>
 #include <wctype.h>
@@ -646,6 +647,7 @@ AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
   fputwc(wc,stdout);
 ]])],
 [AC_DEFINE([HAVE_WIDECHAR], [1], [Do we have wide character support?])
+have_widechar=yes
 ])
 
 AC_CHECK_TYPES([cpu_set_t], [have_cpu_set_t=yes], [], [[
@@ -813,6 +815,8 @@ AS_IF([test "x$with_ncurses" != xno], [
 ])
 AC_SUBST([NCURSES_CFLAGS])
 AC_SUBST([NCURSES_LIBS])
+AS_IF([test x"$CURSES_LIB_NAME$have_widechar" = xncursesyes],
+  [AC_MSG_ERROR([widechar is supported but ncursesw is missing])])
 
 
 AC_ARG_WITH([slang],
-- 
2.6.6

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
