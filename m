Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33950 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdGOVUz (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 15 Jul 2017 17:20:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id p204so16599835wmg.1
        for <util-linux@vger.kernel.org>; Sat, 15 Jul 2017 14:20:54 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/5] reset: remove script from the package
Date: Sat, 15 Jul 2017 22:20:42 +0100
Message-Id: <20170715212046.1655-2-kerolasa@iki.fi>
In-Reply-To: <20170715212046.1655-1-kerolasa@iki.fi>
References: <20170715212046.1655-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This script requires ncurses to work, and the ncurses provides reset so
there should not be need to keep this script hanging around.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/deprecated.txt |  5 -----
 configure.ac                 |  8 --------
 term-utils/Makemodule.am     |  6 ------
 term-utils/reset             | 19 -------------------
 term-utils/reset.1           | 45 --------------------------------------------
 5 files changed, 83 deletions(-)
 delete mode 100755 term-utils/reset
 delete mode 100644 term-utils/reset.1

diff --git a/Documentation/deprecated.txt b/Documentation/deprecated.txt
index 82b80c1fd..34ea698da 100644
--- a/Documentation/deprecated.txt
+++ b/Documentation/deprecated.txt
@@ -93,11 +93,6 @@ Why:	parallel port printers are probably almost extinct devices
 
 ----------------------------
 
-What:	reset
-Why:	ncurses has better reset(1)
-
-----------------------------
-
 The Single UNIX(TM) Specification, Version 2
 Copyright (C) 1997 The Open Group
 
diff --git a/configure.ac b/configure.ac
index f1928d6b4..c76c2a0f3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1741,14 +1741,6 @@ UL_BUILD_INIT([rename])
 AM_CONDITIONAL([BUILD_RENAME], [test "x$build_rename" = xyes])
 
 
-AC_ARG_ENABLE([reset],
-  AS_HELP_STRING([--enable-reset], [build reset]),
-  [], [UL_DEFAULT_ENABLE([reset], [no])]
-)
-UL_BUILD_INIT([reset])
-AM_CONDITIONAL([BUILD_RESET], [test "x$build_reset" = xyes])
-
-
 AC_ARG_ENABLE([vipw],
   AS_HELP_STRING([--enable-vipw], [build vipw]),
   [], [UL_DEFAULT_ENABLE([vipw], [no])]
diff --git a/term-utils/Makemodule.am b/term-utils/Makemodule.am
index ad1bb1f8a..da05a722c 100644
--- a/term-utils/Makemodule.am
+++ b/term-utils/Makemodule.am
@@ -52,12 +52,6 @@ endif
 endif
 
 
-if BUILD_RESET
-dist_usrbin_exec_SCRIPTS += term-utils/reset
-dist_man_MANS += term-utils/reset.1
-endif
-
-
 if BUILD_MESG
 usrbin_exec_PROGRAMS += mesg
 dist_man_MANS += term-utils/mesg.1
diff --git a/term-utils/reset b/term-utils/reset
deleted file mode 100755
index 43f83cbda..000000000
--- a/term-utils/reset
+++ /dev/null
@@ -1,19 +0,0 @@
-#!/bin/sh
-# This command is deprecated.  The utility is in maintenance mode,
-# meaning we keep them in source tree for backward compatibility
-# only.  Do not waste time making this command better, unless the
-# fix is about security or other very critical issue.
-#
-# See Documentation/deprecated.txt for more information.
-stty sane
-tput clear
-tput rmacs
-tput rmm
-tput rmso
-tput rmul
-tput rs1
-tput rs2
-tput rs3
-bot=$((${LINES:-$(tput lines)} - 1))
-if test "${bot}" -le "0"; then bot=24; fi
-tput csr 0 ${bot}
diff --git a/term-utils/reset.1 b/term-utils/reset.1
deleted file mode 100644
index 6079b6e91..000000000
--- a/term-utils/reset.1
+++ /dev/null
@@ -1,45 +0,0 @@
-.\" Copyright 1992 Rickard E. Faith (faith@cs.unc.edu)
-.\" May be distributed under the GNU General Public License
-.TH RESET 1 "October 1993" "util-linux" "User Commands"
-.SH NAME
-reset \- reset the terminal
-.SH SYNOPSIS
-.BR reset
-.SH DESCRIPTION
-.B reset
-calls
-.BR tput (1)
-with the
-.IR clear ,
-.IR rmacs ,
-.IR rmm ,
-.IR rmul ,
-.IR rs1 ,
-.IR rs2 ,
-and
-.I rs3
-arguments.  This causes
-.B tput
-to send appropriate reset strings to the terminal based on information in
-.I /etc/termcap
-(for the GNU or BSD
-.BR tput )
-or in the terminfo database
-(for the
-.B ncurses
-.BR tput ).
-This sequence seems to be sufficient to reset a Linux VC when it
-starts printing "funny-looking" characters.  For good measure,
-.BR stty (1)
-is called with the
-.I sane
-argument in an attempt to get cooked mode back.
-.SH "SEE ALSO"
-.BR clear (1),
-.BR stty (1),
-.BR tput (1)
-.SH AUTHOR
-Rik Faith (faith@cs.unc.edu)
-.SH AVAILABILITY
-The reset command is part of the util-linux package and is available from
-https://www.kernel.org/pub/linux/utils/util-linux/.
-- 
2.13.3

