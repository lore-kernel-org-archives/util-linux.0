Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35228 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbcCHWNo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Mar 2016 17:13:44 -0500
Received: by mail-wm0-f43.google.com with SMTP id l68so152336163wml.0
        for <util-linux@vger.kernel.org>; Tue, 08 Mar 2016 14:13:43 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] misc: remove path name definitions that are unused
Date: Tue,  8 Mar 2016 22:13:38 +0000
Message-Id: <1457475218-26733-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

After this commit the following produces zero matches.

$ for i in \
_PATH_DEV_TTY \
_PATH_INITTAB \
_PATH_MNTTAB_DIR \
_PATH_MOUNTED_LOCK \
_PATH_MOUNTED_TMP \
_PATH_RC \
_PATH_REBOOT \
_PATH_SECURE \
_PATH_SECURETTY \
_PATH_SHUTDOWN_CONF \
_PATH_SINGLE \
_PATH_UMOUNT \
_PATH_USERTTY
do git grep $i; done

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/pathnames.h            | 18 ------------------
 tests/expected/paths/built-in  | 13 -------------
 tests/helpers/test_pathnames.c | 13 -------------
 3 files changed, 44 deletions(-)

diff --git a/include/pathnames.h b/include/pathnames.h
index 81efcfa..de6a13c 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -35,7 +35,6 @@
 # define _PATH_DEFPATH_ROOT	"/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin"
 #endif
 
-#define _PATH_SECURETTY		"/etc/securetty"
 #define _PATH_WTMPLOCK		"/etc/wtmplock"
 
 #define	_PATH_HUSHLOGIN		".hushlogin"
@@ -51,15 +50,7 @@
 #define	_PATH_VAR_NOLOGIN	"/var/run/nologin"
 
 #define _PATH_LOGIN		"/bin/login"
-#define _PATH_INITTAB		"/etc/inittab"
-#define _PATH_RC		"/etc/rc"
-#define _PATH_REBOOT		"/sbin/reboot"
 #define _PATH_SHUTDOWN		"/sbin/shutdown"
-#define _PATH_SINGLE		"/etc/singleboot"
-#define _PATH_SHUTDOWN_CONF	"/etc/shutdown.conf"
-
-#define _PATH_SECURE		"/etc/securesingle"
-#define _PATH_USERTTY           "/etc/usertty"
 
 #define _PATH_TERMCOLORS_DIRNAME "terminal-colors.d"
 #define _PATH_TERMCOLORS_DIR	"/etc/" _PATH_TERMCOLORS_DIRNAME
@@ -91,8 +82,6 @@
 #define _PATH_WORDS_ALT         "/usr/share/dict/web2"
 
 /* mount paths */
-#define _PATH_UMOUNT		"/bin/umount"
-
 #define _PATH_FILESYSTEMS	"/etc/filesystems"
 #define _PATH_PROC_SWAPS	"/proc/swaps"
 #define _PATH_PROC_FILESYSTEMS	"/proc/filesystems"
@@ -136,11 +125,6 @@
 # endif
 #endif
 
-#define _PATH_MNTTAB_DIR	_PATH_MNTTAB ".d"
-
-#define _PATH_MOUNTED_LOCK	_PATH_MOUNTED "~"
-#define _PATH_MOUNTED_TMP	_PATH_MOUNTED ".tmp"
-
 #ifndef _PATH_DEV
   /*
    * The tailing '/' in _PATH_DEV is there for compatibility with libc.
@@ -152,8 +136,6 @@
 
 #define _PATH_DEV_LOOP		"/dev/loop"
 #define _PATH_DEV_LOOPCTL	"/dev/loop-control"
-#define _PATH_DEV_TTY		"/dev/tty"
-
 
 /* udev paths */
 #define _PATH_DEV_BYLABEL	"/dev/disk/by-label"
diff --git a/tests/expected/paths/built-in b/tests/expected/paths/built-in
index 38356ba..197f67f 100644
--- a/tests/expected/paths/built-in
+++ b/tests/expected/paths/built-in
@@ -1,35 +1,22 @@
        _PATH_DEFPATH /usr/local/bin:/bin:/usr/bin
   _PATH_DEFPATH_ROOT /usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
-       _PATH_DEV_TTY /dev/tty
       _PATH_DEV_LOOP /dev/loop
-     _PATH_SECURETTY /etc/securetty
       _PATH_WTMPLOCK /etc/wtmplock
      _PATH_HUSHLOGIN .hushlogin
        _PATH_MAILDIR /var/mail
       _PATH_MOTDFILE /etc/motd
        _PATH_NOLOGIN /etc/nologin
          _PATH_LOGIN /bin/login
-       _PATH_INITTAB /etc/inittab
-            _PATH_RC /etc/rc
-        _PATH_REBOOT /sbin/reboot
-        _PATH_SINGLE /etc/singleboot
- _PATH_SHUTDOWN_CONF /etc/shutdown.conf
-        _PATH_SECURE /etc/securesingle
-       _PATH_USERTTY /etc/usertty
-        _PATH_UMOUNT /bin/umount
         _PATH_PASSWD /etc/passwd
        _PATH_GSHADOW /etc/gshadow
          _PATH_GROUP /etc/group
  _PATH_SHADOW_PASSWD /etc/shadow
          _PATH_WORDS /usr/share/dict/words
      _PATH_WORDS_ALT /usr/share/dict/web2
-        _PATH_UMOUNT /bin/umount
    _PATH_FILESYSTEMS /etc/filesystems
     _PATH_PROC_SWAPS /proc/swaps
 _PATH_PROC_FILESYSTEMS /proc/filesystems
        _PATH_MOUNTED /etc/mtab
         _PATH_MNTTAB /etc/fstab
-  _PATH_MOUNTED_LOCK /etc/mtab~
-   _PATH_MOUNTED_TMP /etc/mtab.tmp
    _PATH_DEV_BYLABEL /dev/disk/by-label
     _PATH_DEV_BYUUID /dev/disk/by-uuid
diff --git a/tests/helpers/test_pathnames.c b/tests/helpers/test_pathnames.c
index ebd5249..2c9ec55 100644
--- a/tests/helpers/test_pathnames.c
+++ b/tests/helpers/test_pathnames.c
@@ -33,37 +33,24 @@ struct hlpPath paths[] =
 {
 	DEF_HLPPATH(_PATH_DEFPATH),
 	DEF_HLPPATH(_PATH_DEFPATH_ROOT),
-	DEF_HLPPATH(_PATH_DEV_TTY),
 	DEF_HLPPATH(_PATH_DEV_LOOP),
-	DEF_HLPPATH(_PATH_SECURETTY),
 	DEF_HLPPATH(_PATH_WTMPLOCK),
 	DEF_HLPPATH(_PATH_HUSHLOGIN),
 	DEF_HLPPATH(_PATH_MAILDIR),
 	DEF_HLPPATH(_PATH_MOTDFILE),
 	DEF_HLPPATH(_PATH_NOLOGIN),
 	DEF_HLPPATH(_PATH_LOGIN),
-	DEF_HLPPATH(_PATH_INITTAB),
-	DEF_HLPPATH(_PATH_RC),
-	DEF_HLPPATH(_PATH_REBOOT),
-	DEF_HLPPATH(_PATH_SINGLE),
-	DEF_HLPPATH(_PATH_SHUTDOWN_CONF),
-	DEF_HLPPATH(_PATH_SECURE),
-	DEF_HLPPATH(_PATH_USERTTY),
-	DEF_HLPPATH(_PATH_UMOUNT),
 	DEF_HLPPATH(_PATH_PASSWD),
 	DEF_HLPPATH(_PATH_GSHADOW),
 	DEF_HLPPATH(_PATH_GROUP),
 	DEF_HLPPATH(_PATH_SHADOW_PASSWD),
 	DEF_HLPPATH(_PATH_WORDS),
 	DEF_HLPPATH(_PATH_WORDS_ALT),
-	DEF_HLPPATH(_PATH_UMOUNT),
 	DEF_HLPPATH(_PATH_FILESYSTEMS),
 	DEF_HLPPATH(_PATH_PROC_SWAPS),
 	DEF_HLPPATH(_PATH_PROC_FILESYSTEMS),
 	DEF_HLPPATH(_PATH_MOUNTED),
 	DEF_HLPPATH(_PATH_MNTTAB),
-	DEF_HLPPATH(_PATH_MOUNTED_LOCK),
-	DEF_HLPPATH(_PATH_MOUNTED_TMP),
 	DEF_HLPPATH(_PATH_DEV_BYLABEL),
 	DEF_HLPPATH(_PATH_DEV_BYUUID),
 	{ NULL, NULL }
-- 
2.7.2

