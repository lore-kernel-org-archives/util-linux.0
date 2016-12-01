Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:53785 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756998AbcLAIwR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Dec 2016 03:52:17 -0500
Received: from tenfore.ga-group.nl ([217.186.11.144]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M3u86-1d2Pin43v8-00rZoA for <util-linux@vger.kernel.org>; Thu, 01 Dec 2016
 09:52:16 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 07/11] agetty: remove obsolete HAVE_UPDWTMP fallback
Date: Thu,  1 Dec 2016 09:52:10 +0100
Message-Id: <1480582332-17407-8-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
References: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac                   |  1 -
 include/pathnames.h            |  2 --
 term-utils/agetty.c            | 21 +--------------------
 tests/expected/paths/built-in  |  1 -
 tests/helpers/test_pathnames.c |  1 -
 5 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/configure.ac b/configure.ac
index 73c1b29..5917126 100644
--- a/configure.ac
+++ b/configure.ac
@@ -412,7 +412,6 @@ AC_CHECK_FUNCS([ \
 	strnlen \
 	sysconf \
 	sysinfo \
-	updwtmp \
 	usleep \
 	warn \
 	warnx \
diff --git a/include/pathnames.h b/include/pathnames.h
index 05fb082..a5e8507 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -35,8 +35,6 @@
 # define _PATH_DEFPATH_ROOT	"/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin"
 #endif
 
-#define _PATH_WTMPLOCK		"/etc/wtmplock"
-
 #define	_PATH_HUSHLOGIN		".hushlogin"
 #define	_PATH_HUSHLOGINS	"/etc/hushlogins"
 
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index dbf499e..0f114a5 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -28,7 +28,6 @@
 #include <utmp.h>
 #include <getopt.h>
 #include <time.h>
-#include <sys/file.h>
 #include <sys/socket.h>
 #include <langinfo.h>
 #include <grp.h>
@@ -951,25 +950,7 @@ static void update_utmp(struct options *op)
 	pututline(&ut);
 	endutent();
 
-	{
-#ifdef HAVE_UPDWTMP
-		updwtmp(_PATH_WTMP, &ut);
-#else
-		int ut_fd;
-		int lf;
-
-		if ((lf = open(_PATH_WTMPLOCK, O_CREAT | O_WRONLY, 0660)) >= 0) {
-			flock(lf, LOCK_EX);
-			if ((ut_fd =
-			     open(_PATH_WTMP, O_APPEND | O_WRONLY)) >= 0) {
-				write_all(ut_fd, &ut, sizeof(ut));
-				close(ut_fd);
-			}
-			flock(lf, LOCK_UN);
-			close(lf);
-		}
-#endif				/* HAVE_UPDWTMP */
-	}
+	updwtmp(_PATH_WTMP, &ut);
 }
 
 #endif				/* SYSV_STYLE */
diff --git a/tests/expected/paths/built-in b/tests/expected/paths/built-in
index 197f67f..7274afa 100644
--- a/tests/expected/paths/built-in
+++ b/tests/expected/paths/built-in
@@ -1,7 +1,6 @@
        _PATH_DEFPATH /usr/local/bin:/bin:/usr/bin
   _PATH_DEFPATH_ROOT /usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
       _PATH_DEV_LOOP /dev/loop
-      _PATH_WTMPLOCK /etc/wtmplock
      _PATH_HUSHLOGIN .hushlogin
        _PATH_MAILDIR /var/mail
       _PATH_MOTDFILE /etc/motd
diff --git a/tests/helpers/test_pathnames.c b/tests/helpers/test_pathnames.c
index 2c9ec55..d5cdad8 100644
--- a/tests/helpers/test_pathnames.c
+++ b/tests/helpers/test_pathnames.c
@@ -34,7 +34,6 @@ struct hlpPath paths[] =
 	DEF_HLPPATH(_PATH_DEFPATH),
 	DEF_HLPPATH(_PATH_DEFPATH_ROOT),
 	DEF_HLPPATH(_PATH_DEV_LOOP),
-	DEF_HLPPATH(_PATH_WTMPLOCK),
 	DEF_HLPPATH(_PATH_HUSHLOGIN),
 	DEF_HLPPATH(_PATH_MAILDIR),
 	DEF_HLPPATH(_PATH_MOTDFILE),
-- 
1.8.5.6

