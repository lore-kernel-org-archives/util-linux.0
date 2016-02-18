Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:62875 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946087AbcBRNXI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Feb 2016 08:23:08 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0MgbTj-1aIJfZ209v-00NzwM for
 <util-linux@vger.kernel.org>; Thu, 18 Feb 2016 14:23:06 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 13/15] lib: fix ismounted includes for FreeBSD
Date: Thu, 18 Feb 2016 14:23:05 +0100
Message-Id: <1455801785-10872-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
References: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac    |  2 ++
 lib/ismounted.c | 11 ++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 969c2cc..c42e475 100644
--- a/configure.ac
+++ b/configure.ac
@@ -231,6 +231,7 @@ AC_CHECK_HEADERS([ \
 	sys/ioccom.h \
 	sys/ioctl.h \
 	sys/mkdev.h \
+	sys/mount.h \
 	sys/param.h \
 	sys/prctl.h \
 	sys/queue.h \
@@ -245,6 +246,7 @@ AC_CHECK_HEADERS([ \
 	sys/timex.h \
 	sys/ttydefaults.h \
 	sys/types.h \
+	sys/ucred.h \
 	sys/un.h \
 	unistd.h \
 ])
diff --git a/lib/ismounted.c b/lib/ismounted.c
index 9095290..f83be65 100644
--- a/lib/ismounted.c
+++ b/lib/ismounted.c
@@ -18,9 +18,14 @@
 #include <sys/stat.h>
 #include <ctype.h>
 #include <sys/param.h>
-#ifdef __APPLE__
-#include <sys/ucred.h>
-#include <sys/mount.h>
+
+#ifndef __linux__
+# ifdef HAVE_SYS_UCRED_H
+#  include <sys/ucred.h>
+# endif
+# ifdef HAVE_SYS_MOUNT_H
+#  include <sys/mount.h>
+# endif
 #endif
 
 #include "pathnames.h"
-- 
1.8.4.5

