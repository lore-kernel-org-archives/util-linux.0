Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 22/49] login: remove unused code and tests
Date: Mon, 17 Oct 2011 13:15:01 +0200
Message-Id: <1318850128-23458-23-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/Makefile.am |    2 +-
 login-utils/login.c     |   10 ++++------
 login-utils/login.h     |    9 ---------
 tests/commands.sh.in    |    1 -
 tests/ts/login/checktty |   26 --------------------------
 5 files changed, 5 insertions(+), 43 deletions(-)
 delete mode 100644 login-utils/login.h
 delete mode 100755 tests/ts/login/checktty

diff --git a/login-utils/Makefile.am b/login-utils/Makefile.am
index 7866f7b..a07279e 100644
--- a/login-utils/Makefile.am
+++ b/login-utils/Makefile.am
@@ -25,7 +25,7 @@ chfn_SOURCES = chfn.c $(chfn_chsh_common)
 chsh_SOURCES = chsh.c $(chfn_chsh_common)
 chfn_chsh_common = islocal.c setpwnam.c islocal.h setpwnam.h \
 	$(top_srcdir)/lib/env.c
-login_SOURCES = login.c login.h $(top_srcdir)/lib/setproctitle.c
+login_SOURCES = login.c $(top_srcdir)/lib/setproctitle.c
 vipw_SOURCES = vipw.c setpwnam.h
 
 chfn_LDADD = $(login_ldadd_common)
diff --git a/login-utils/login.c b/login-utils/login.c
index 7f6048c..fa28c1b 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -63,7 +63,6 @@
 #include "c.h"
 #include "setproctitle.h"
 #include "pathnames.h"
-#include "login.h"
 #include "strutils.h"
 #include "nls.h"
 #include "xalloc.h"
@@ -117,6 +116,7 @@ int timeout = LOGIN_TIMEOUT;
 static void timedout(int);
 static void sigint(int);
 static void motd(void);
+static void sleepexit(int eval);
 
 /*
  * Nice and simple code provided by Linus Torvalds 16-Feb-93
@@ -661,7 +661,6 @@ static int get_hushlogin_status(struct passwd *pwd)
 	return 0;
 }
 
-
 int main(int argc, char **argv)
 {
 	extern int optind;
@@ -1224,7 +1223,6 @@ int main(int argc, char **argv)
  * What I did was add a second timeout while trying to write the message so
  * the process just exits if the second timeout expires.
  */
-
 static void timedout2(int sig __attribute__ ((__unused__)))
 {
 	struct termios ti;
@@ -1249,7 +1247,7 @@ static void timedout(int sig __attribute__ ((__unused__)))
 
 jmp_buf motdinterrupt;
 
-void motd(void)
+static void motd(void)
 {
 	int fd, nchars;
 	void (*oldint) (int);
@@ -1268,14 +1266,14 @@ void motd(void)
 	close(fd);
 }
 
-void sigint(int sig __attribute__ ((__unused__)))
+static void sigint(int sig __attribute__ ((__unused__)))
 {
 	longjmp(motdinterrupt, 1);
 }
 
 
 /* Should not be called from PAM code... */
-void sleepexit(int eval)
+static void sleepexit(int eval)
 {
 	sleep(LOGIN_EXIT_TIMEOUT);
 	exit(eval);
diff --git a/login-utils/login.h b/login-utils/login.h
deleted file mode 100644
index 92b94b9..0000000
--- a/login-utils/login.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* defined in login.c */
-extern void badlogin(const char *s);
-extern void sleepexit(int);
-extern char hostaddress[16];
-extern char *hostname;
-extern sa_family_t hostfamily;
-
-/* defined in checktty.c */
-extern void checktty(const char *user, const char *tty, struct passwd *pwd);
diff --git a/tests/commands.sh.in b/tests/commands.sh.in
index 4f70da7..462a4f5 100644
--- a/tests/commands.sh.in
+++ b/tests/commands.sh.in
@@ -55,7 +55,6 @@ TS_CMD_LOOK=${TS_CMD_LOOK-"$top_builddir/misc-utils/look"}
 TS_CMD_CAL=${TS_CMD_CAL-"$top_builddir/misc-utils/cal"}
 TS_CMD_SCRIPT=${TS_CMD_SCRIPT-"$top_builddir/term-utils/script"}
 
-TS_CMD_CHECKTTY=${TS_CMD_CHECKTTY-"$top_builddir/login-utils/checktty_test"}
 TS_CMD_ISLOCAL=${TS_CMD_ISLOCAL-"$top_builddir/login-utils/islocal_test"}
 
 TS_CMD_HWCLOCK=${TS_CMD_HWCLOCK-"$top_builddir/hwclock/hwclock"}
diff --git a/tests/ts/login/checktty b/tests/ts/login/checktty
deleted file mode 100755
index 9917d63..0000000
--- a/tests/ts/login/checktty
+++ /dev/null
@@ -1,26 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (C) 2007 Karel Zak <kzak@redhat.com>
-#
-# This file is part of util-linux.
-#
-# This file is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This file is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-TS_TOPDIR="$(dirname $0)/../.."
-TS_DESC="checktty"
-
-. $TS_TOPDIR/functions.sh
-ts_init "$*"
-
-$TS_CMD_CHECKTTY  >> $TS_OUTPUT
-ts_finalize
-
-- 
1.7.6.4
