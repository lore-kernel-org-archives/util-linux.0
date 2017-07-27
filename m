Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:45368
        "EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbdG0OHZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 27 Jul 2017 10:07:25 -0400
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>,
        Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] build: use --runstatedir instead of --localstatedir
Date: Thu, 27 Jul 2017 16:00:42 +0200
Message-Id: <1501164042-27281-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The util-linux code was previously aligned to use @localstatedir@ and
the util-linux build system was set to override the default to use /run.

Current GNU Coding Standards introduced the @runstatedir@ variable
for this purpose. Lets use that instead.

The GNU default for @runstatedir@ is ${localstatedir}/run so util-linux
still override the default to be /run to preserve the status quo from
before. The only difference is that you'll now pass --runstatedir to
override the location on the command line instead of --localstatedir.

(FWIW, Debhelper in compat 11 will automatically start passing
--runstatedir=/run to all autotools configured builds. It already
passes --localstatedir=/var (to avoid it ending up with the GNU default
/usr/local/var) which breaks the util-linux build system code that
tries to default it to /run. This change will thus allow util-linux
and debhelper to work better together and avoid the need for a
package-specific override.)

Relevant historic commits:
 * commit 07a16b9d1e5a48550a0d19abb9a900853433ffa2
   "build-sys: change --localstatedir to /run"
 * commit 80c51185d50f00a2701f9379f10fc48a0f885dfc
   "uuidd: use run configured state directory"
 * commit 01c5b787947aeaffc7e56000827e3edefa357c59
   "agetty: use configured run state directory"

CC: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 Makefile.am                |  4 ++--
 configure.ac               | 14 +++++++-------
 include/pathnames.h        |  2 +-
 libuuid/src/uuidd.h        |  2 +-
 misc-utils/test_uuidd.c    |  4 ++--
 misc-utils/uuidd.8.in      |  4 ++--
 misc-utils/uuidd.rc.in     |  2 +-
 misc-utils/uuidd.socket.in |  2 +-
 8 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 54c85e16f..e7657afe9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -2,7 +2,7 @@ AM_CPPFLAGS = \
 	-include config.h \
 	-I$(top_srcdir)/include \
 	-DLOCALEDIR=\"$(localedir)\" \
-	-D_PATH_LOCALSTATEDIR=\"${localstatedir}\"
+	-D_PATH_RUNSTATEDIR=\"${runstatedir}\"
 AM_CFLAGS = -fsigned-char $(WARN_CFLAGS)
 AM_LDFLAGS =
 
@@ -119,7 +119,7 @@ edit_cmd = sed \
 	 -e 's|@sbindir[@]|$(sbindir)|g' \
 	 -e 's|@bindir[@]|$(bindir)|g' \
 	 -e 's|@includedir[@]|$(includedir)|g' \
-	 -e 's|@localstatedir[@]|$(localstatedir)|g' \
+	 -e 's|@runstatedir[@]|$(runstatedir)|g' \
 	 -e 's|@usrlib_execdir[@]|$(usrlib_execdir)|g' \
 	 -e 's|@usrbin_execdir[@]|$(usrbin_execdir)|g' \
 	 -e 's|@usrsbin_execdir[@]|$(usrsbin_execdir)|g' \
diff --git a/configure.ac b/configure.ac
index 38b968878..9d4242ec4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -72,13 +72,13 @@ AS_CASE([$exec_prefix:$prefix],
   ]
 )
 
-AS_CASE([$prefix:$localstatedir],
-  [NONE:'${prefix}/var' | /usr:'${prefix}/var'],
-    [localstatedir=/run
-     AC_MSG_NOTICE([  --localstatedir defaults to /run])
-    ]
+AS_CASE([$prefix:$runstatedir],
+    [NONE:'${localstatedir}/run' | /usr:'${localstatedir}/run'],
+      [runstatedir=/run
+       AC_MSG_NOTICE([  --runstatedir defaults to /run])
+      ]
 )
-AC_SUBST([localstatedir])
+AC_SUBST([runstatedir])
 
 
 # The original default values of {bin,sbin,lib}dir
@@ -2277,7 +2277,7 @@ AC_MSG_RESULT([
 	prefix:            ${prefix}
 	exec prefix:       ${exec_prefix}
 
-	localstatedir:     ${localstatedir}
+	runstatedir:       ${runstatedir}
 	bindir:            ${bindir}
 	sbindir:           ${sbindir}
 	libdir:            ${libdir}
diff --git a/include/pathnames.h b/include/pathnames.h
index 8af386457..747382dae 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -71,7 +71,7 @@
 #define _PATH_ISSUE		"/etc/issue"
 #define _PATH_OS_RELEASE_ETC	"/etc/os-release"
 #define _PATH_OS_RELEASE_USR	"/usr/lib/os-release"
-#define _PATH_NUMLOCK_ON	_PATH_LOCALSTATEDIR "/numlock-on"
+#define _PATH_NUMLOCK_ON	_PATH_RUNSTATEDIR "/numlock-on"
 #define _PATH_LOGINDEFS		"/etc/login.defs"
 
 /* misc paths */
diff --git a/libuuid/src/uuidd.h b/libuuid/src/uuidd.h
index 2f709680b..e55c86f2f 100644
--- a/libuuid/src/uuidd.h
+++ b/libuuid/src/uuidd.h
@@ -35,7 +35,7 @@
 #ifndef _UUID_UUIDD_H
 #define _UUID_UUIDD_H
 
-#define UUIDD_DIR		_PATH_LOCALSTATEDIR "/uuidd"
+#define UUIDD_DIR		_PATH_RUNSTATEDIR "/uuidd"
 #define UUIDD_SOCKET_PATH	UUIDD_DIR "/request"
 #define UUIDD_PIDFILE_PATH	UUIDD_DIR "/uuidd.pid"
 #define UUIDD_PATH		"/usr/sbin/uuidd"
diff --git a/misc-utils/test_uuidd.c b/misc-utils/test_uuidd.c
index 7bbd3a948..de5ae3ab2 100644
--- a/misc-utils/test_uuidd.c
+++ b/misc-utils/test_uuidd.c
@@ -18,10 +18,10 @@
  *
  *	uuidd --debug --no-fork --no-pid --socket /run/uuidd/request
  *
- * if the $localstatedir (as defined by build-system) is /run. If you want
+ * if the $runstatedir (as defined by build-system) is /run. If you want
  * to overwrite the built-in default then use:
  *
- *	make uuidd uuidgen localstatedir=/var
+ *	make uuidd uuidgen runstatedir=/var/run
  */
 #include <pthread.h>
 #include <stdio.h>
diff --git a/misc-utils/uuidd.8.in b/misc-utils/uuidd.8.in
index e25582564..0a5cf471b 100644
--- a/misc-utils/uuidd.8.in
+++ b/misc-utils/uuidd.8.in
@@ -37,7 +37,7 @@ Do not create a pid file.
 .TP
 .BR \-p , " \-\-pid " \fIpath\fR
 Specify the pathname where the pid file should be written.  By default,
-the pid file is written to @localstatedir@/uuidd/uuidd.pid.
+the pid file is written to @runstatedir@/uuidd/uuidd.pid.
 .TP
 .BR \-q , " \-\-quiet "
 Suppress some failure messages.
@@ -54,7 +54,7 @@ a configure option.
 .TP
 .BR \-s , " \-\-socket " \fIpath\fR
 Make uuidd use this pathname for the unix-domain socket.  By default, the
-pathname used is @localstatedir@/uuidd/request.  This option is primarily
+pathname used is @runstatedir@/uuidd/request.  This option is primarily
 for debugging purposes, since the pathname is hard-coded in the libuuid
 library.
 .TP
diff --git a/misc-utils/uuidd.rc.in b/misc-utils/uuidd.rc.in
index 26273e5c5..794394562 100644
--- a/misc-utils/uuidd.rc.in
+++ b/misc-utils/uuidd.rc.in
@@ -17,7 +17,7 @@ PATH=/bin:/usr/bin:/sbin:/usr/sbin
 DAEMON=/usr/sbin/uuidd
 UUIDD_USER=uuidd
 UUIDD_GROUP=uuidd
-UUIDD_DIR=@localstatedir@/uuidd
+UUIDD_DIR=@runstatedir@/uuidd
 PIDFILE=$UUIDD_DIR/uuidd.pid
 
 test -x $DAEMON || exit 0
diff --git a/misc-utils/uuidd.socket.in b/misc-utils/uuidd.socket.in
index d8be72fd6..8ddcac26f 100644
--- a/misc-utils/uuidd.socket.in
+++ b/misc-utils/uuidd.socket.in
@@ -2,7 +2,7 @@
 Description=UUID daemon activation socket
 
 [Socket]
-ListenStream=@localstatedir@/uuidd/request
+ListenStream=@runstatedir@/uuidd/request
 
 [Install]
 WantedBy=sockets.target
-- 
2.11.0

