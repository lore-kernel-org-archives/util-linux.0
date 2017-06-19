Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:60289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753252AbdFSAnH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 18 Jun 2017 20:43:07 -0400
Subject: [PATCH 05/12] include: update pathnames.h
To: Karel Zak <kzak@redhat.com>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <154d3dd1-21c1-aa9f-8148-e14e97e10e10@gmx.com>
Date: Sun, 18 Jun 2017 20:42:55 -0400
MIME-Version: 1.0
In-Reply-To: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


* use /dev/rtc0 (/dev/rtc was for the 'old' driver)
* remove hwclock Award workaround and alpha cmos paths
* relocate _PATH_BTMP from hwclock to login-utils
* add a comment for _PATH_BTMP and fix other login-utils comments
* add a comment for proc/cpuinfo
* remove empty shutdown.c comment from 4d43977f

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 include/pathnames.h | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/include/pathnames.h b/include/pathnames.h
index de6abe6..c07f9a6 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -57,12 +57,10 @@
 #define _PATH_TERMCOLORS_DIRNAME "terminal-colors.d"
 #define _PATH_TERMCOLORS_DIR	"/etc/" _PATH_TERMCOLORS_DIRNAME
 
-/* used in login-utils/shutdown.c */
-
-/* used in login-utils/setpwnam.h and login-utils/islocal.c */
+/* used in login-utils/{setpwnam.h,islocal.c} */
 #define _PATH_PASSWD		"/etc/passwd"
 
-/* used in login-utils/newgrp and login-utils/setpwnam.h*/
+/* used in login-utils/{newgrp.c,setpwnam.h} */
 #define _PATH_GSHADOW		"/etc/gshadow"
 
 /* used in login-utils/setpwnam.h */
@@ -70,6 +68,11 @@
 #define _PATH_SHADOW_PASSWD	"/etc/shadow"
 #define _PATH_SHELLS		"/etc/shells"
 
+/* used in login-utils/{login.c,su-common.c,last.c,lslogins.c}  */
+#ifndef _PATH_BTMP
+#define _PATH_BTMP		"/var/log/btmp"
+#endif
+
 /* used in term-utils/agetty.c */
 #define _PATH_ISSUE		"/etc/issue"
 #define _PATH_OS_RELEASE_ETC	"/etc/os-release"
@@ -154,15 +157,10 @@
 # define _PATH_ADJTIME		"/etc/adjtime"
 #endif
 
-#define _PATH_LASTDATE		"/var/lib/lastdate"
 #ifdef __ia64__
 # define _PATH_RTC_DEV		"/dev/efirtc"
 #else
-# define _PATH_RTC_DEV		"/dev/rtc"
-#endif
-
-#ifndef _PATH_BTMP
-#define _PATH_BTMP		"/var/log/btmp"
+# define _PATH_RTC_DEV		"/dev/rtc0"
 #endif
 
 /* raw paths*/
@@ -195,8 +193,7 @@
 /* ctrlaltdel paths */
 #define _PATH_PROC_CTRL_ALT_DEL	"/proc/sys/kernel/ctrl-alt-del"
 
-/* hwclock-cmos paths */
-#define _PATH_DEV_PORT		"/dev/port"
+/* lscpu paths */
 #define _PATH_PROC_CPUINFO	"/proc/cpuinfo"
 
 #endif /* PATHNAMES_H */
