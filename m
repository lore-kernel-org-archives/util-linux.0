Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:63482 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426397AbcBRNMx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Feb 2016 08:12:53 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0MPDaC-1aaoEO2944-004OrD for
 <util-linux@vger.kernel.org>; Thu, 18 Feb 2016 14:12:52 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 09/15] include: check for sys/sysmacros.h
Date: Thu, 18 Feb 2016 14:12:49 +0100
Message-Id: <1455801169-10470-10-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
References: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac             | 1 +
 disk-utils/fsck.cramfs.c | 2 ++
 disk-utils/raw.c         | 2 ++
 login-utils/login.c      | 2 ++
 4 files changed, 7 insertions(+)

diff --git a/configure.ac b/configure.ac
index 17917af..969c2cc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -238,6 +238,7 @@ AC_CHECK_HEADERS([ \
 	sys/socket.h \
 	sys/sockio.h \
 	sys/stat.h \
+	sys/sysmacros.h \
 	sys/swap.h \
 	sys/syscall.h \
 	sys/time.h \
diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index 6ca6094..7df5390 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -53,7 +53,9 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
+#ifdef HAVE_SYS_SYSMACROS_H
 #include <sys/sysmacros.h>	/* for major, minor */
+#endif
 
 #include "cramfs.h"
 #include "nls.h"
diff --git a/disk-utils/raw.c b/disk-utils/raw.c
index d29ff1b..6c4b6de 100644
--- a/disk-utils/raw.c
+++ b/disk-utils/raw.c
@@ -20,7 +20,9 @@
 #include <string.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
+#ifdef HAVE_SYS_SYSMACROS_H
 #include <sys/sysmacros.h>
+#endif
 #include <unistd.h>
 
 #include "c.h"
diff --git a/login-utils/login.c b/login-utils/login.c
index 6f51039..e1f11eb 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -48,7 +48,9 @@
 #include <utmp.h>
 #include <stdlib.h>
 #include <sys/syslog.h>
+#ifdef HAVE_SYS_SYSMACROS_H
 #include <sys/sysmacros.h>
+#endif
 #ifdef HAVE_LINUX_MAJOR_H
 # include <linux/major.h>
 #endif
-- 
1.8.4.5

