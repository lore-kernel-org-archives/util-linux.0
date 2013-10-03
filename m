Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f47.google.com ([209.85.160.47]:37060 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357Ab3JCJj2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 3 Oct 2013 05:39:28 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so2198931pbb.34
        for <util-linux@vger.kernel.org>; Thu, 03 Oct 2013 02:39:28 -0700 (PDT)
From: Michael Forney <mforney@mforney.org>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/4] Add missing includes
Date: Thu,  3 Oct 2013 02:39:17 -0700
Message-Id: <1380793159-27602-2-git-send-email-mforney@mforney.org>
In-Reply-To: <1380792968-1176-1-git-send-email-mforney@mforney.org>
References: <1380792968-1176-1-git-send-email-mforney@mforney.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

sys/types.h: For u_char typedef
sys/params.h: For MAXNAMLEN
sys/ttydefaults.h: For various tty definitions (also add configure check)
---
 configure.ac         | 1 +
 include/ttyutils.h   | 3 +++
 term-utils/ttymsg.c  | 1 +
 text-utils/display.c | 1 +
 4 files changed, 6 insertions(+)

diff --git a/configure.ac b/configure.ac
index 95ff8b3..12d0bab 100644
--- a/configure.ac
+++ b/configure.ac
@@ -204,6 +204,7 @@ AC_CHECK_HEADERS([ \
 	sys/swap.h \
 	sys/syscall.h \
 	sys/time.h \
+	sys/ttydefaults.h \
 	sys/types.h \
 	sys/un.h \
 	unistd.h \
diff --git a/include/ttyutils.h b/include/ttyutils.h
index 13495ba..4f2fd88 100644
--- a/include/ttyutils.h
+++ b/include/ttyutils.h
@@ -13,6 +13,9 @@
 #ifdef HAVE_SYS_IOCTL_H
 #include <sys/ioctl.h>
 #endif
+#ifdef HAVE_SYS_TTYDEFAULTS_H
+#include <sys/ttydefaults.h>
+#endif
 
 /* Some shorthands for control characters. */
 #define CTL(x)		((x) ^ 0100)	/* Assumes ASCII dialect */
diff --git a/term-utils/ttymsg.c b/term-utils/ttymsg.c
index d610826..8bf993c 100644
--- a/term-utils/ttymsg.c
+++ b/term-utils/ttymsg.c
@@ -41,6 +41,7 @@
   */
 
 #include <sys/types.h>
+#include <sys/param.h>
 #include <sys/uio.h>
 #include <signal.h>
 #include <fcntl.h>
diff --git a/text-utils/display.c b/text-utils/display.c
index 1f9a11b..1130366 100644
--- a/text-utils/display.c
+++ b/text-utils/display.c
@@ -33,6 +33,7 @@
 
 #include <sys/param.h>
 #include <sys/stat.h>
+#include <sys/types.h>
 #include <unistd.h>
 #include <errno.h>
 #include <ctype.h>
-- 
1.8.4

