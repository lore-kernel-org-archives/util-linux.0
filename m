Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:60142 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757499AbcLAI6D (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Dec 2016 03:58:03 -0500
Received: from tenfore.ga-group.nl ([217.186.11.144]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LomuB-1ce2AN2P9P-00glCj for <util-linux@vger.kernel.org>; Thu, 01 Dec 2016
 09:57:52 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 11/11] agetty: re-add utmp.h for Debian GNU/kFreeBSD
Date: Thu,  1 Dec 2016 09:57:51 +0100
Message-Id: <1480582671-17627-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1480582671-17627-1-git-send-email-sweet_f_a@gmx.de>
References: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
 <1480582671-17627-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

It's needed there to get login_tty(). On normal FreeBSD we would
need libutil.h.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac        | 2 ++
 term-utils/agetty.c | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index afb255e..e9901bc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -208,6 +208,7 @@ AC_CHECK_HEADERS([ \
 	getopt.h \
 	inttypes.h \
 	lastlog.h \
+	libutil.h \
 	linux/btrfs.h \
 	linux/cdrom.h \
 	linux/falloc.h \
@@ -257,6 +258,7 @@ AC_CHECK_HEADERS([ \
 	sys/un.h \
 	unistd.h \
 	shadow.h \
+	utmp.h \
 	utmpx.h \
 ])
 
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 46eea01..95236ce 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -55,7 +55,13 @@
 #endif
 
 #if defined(__FreeBSD_kernel__)
-#include <pty.h>
+# include <pty.h>
+# ifdef HAVE_UTMPX_H
+#  include <utmp.h>
+# endif
+# ifdef HAVE_LIBUTIL_H
+#  include <libutil.h>
+# endif
 #endif
 
 #ifdef __linux__
-- 
1.8.5.6

