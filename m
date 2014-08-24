Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:45603 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959AbaHXQFs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 24 Aug 2014 12:05:48 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id 80977140F1
	for <util-linux@vger.kernel.org>; Sun, 24 Aug 2014 18:05:17 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Christoph Egger <christoph@debian.org>
Subject: [PATCH 3/4] Fixing FTBFS on !linux (Debian util-linux 2.20.1-1.2)
Date: Sun, 24 Aug 2014 18:04:43 +0200
Message-Id: <1408896284-14467-4-git-send-email-andreas@fatal.se>
In-Reply-To: <1408896284-14467-1-git-send-email-andreas@fatal.se>
References: <1408896284-14467-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Christoph Egger <christoph@debian.org>

Handle vc flags missing on FreeBSD
Fix tty creation on kFreeBSD taking patch from 2.19

Addresses-Debian-Bug: #650185
---
 include/ttyutils.h       | 40 ++++++++++++++++++++++++++++++++++++++++
 term-utils/Makemodule.am |  1 +
 term-utils/agetty.c      | 16 ++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/include/ttyutils.h b/include/ttyutils.h
index 4f2fd88..e842f9f 100644
--- a/include/ttyutils.h
+++ b/include/ttyutils.h
@@ -74,6 +74,46 @@ static inline void reset_virtual_console(struct termios *tp, int flags)
 	/* Sane setting, allow eight bit characters, no carriage return delay
 	 * the same result as `stty sane cr0 pass8'
 	 */
+#ifndef IUCLC
+# define IUCLC 0
+#endif
+#ifndef NL0
+# define NL0 0
+#endif
+#ifndef CR0
+# define CR0 0
+#endif
+#ifndef BS0
+# define BS0 0
+#endif
+#ifndef VT0
+# define VT0 0
+#endif
+#ifndef FF0
+# define FF0 0
+#endif
+#ifndef OLCUC
+# define OLCUC 0
+#endif
+#ifndef OFILL
+# define OFILL 0
+#endif
+#ifndef NLDLY
+# define NLDLY 0
+#endif
+#ifndef CRDLY
+# define CRDLY 0
+#endif
+#ifndef BSDLY
+# define BSDLY 0
+#endif
+#ifndef VTDLY
+# define VTDLY 0
+#endif
+#ifndef FFDLY
+# define FFDLY 0
+#endif
+
 	tp->c_iflag |=  (BRKINT | ICRNL | IMAXBEL);
 	tp->c_iflag &= ~(IGNBRK | INLCR | IGNCR | IXOFF | IUCLC | IXANY | ISTRIP);
 	tp->c_oflag |=  (OPOST | ONLCR | NL0 | CR0 | TAB0 | BS0 | VT0 | FF0);
diff --git a/term-utils/Makemodule.am b/term-utils/Makemodule.am
index 5c73f3e..627aca0 100644
--- a/term-utils/Makemodule.am
+++ b/term-utils/Makemodule.am
@@ -23,6 +23,7 @@ sbin_PROGRAMS += agetty
 dist_man_MANS += term-utils/agetty.8
 agetty_SOURCES = term-utils/agetty.c
 agetty_LDADD = $(LDADD) libcommon.la
+agetty_LDADD += -lutil
 endif # BUILD_AGETTY
 
 
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 3c30a5f..a7044f0 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -10,6 +10,7 @@
  *
  * This program is freely distributable.
  */
+
 #include <stdio.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -44,6 +45,12 @@
 #include "widechar.h"
 #include "ttyutils.h"
 
+#if defined(__FreeBSD_kernel__)
+#include <pty.h>
+#include <sys/param.h>
+#endif
+
+
 #ifdef __linux__
 #  include <sys/kd.h>
 #  include <sys/param.h>
@@ -76,6 +83,10 @@
 #  endif
 #endif
 
+#ifdef __FreeBSD_kernel__
+#define USE_SYSLOG
+#endif
+
 /* If USE_SYSLOG is undefined all diagnostics go to /dev/console. */
 #ifdef	USE_SYSLOG
 #  include <syslog.h>
@@ -1110,6 +1121,11 @@ static void open_tty(char *tty, struct termios *tp, struct options *op)
 			op->term = DEFAULT_TTYS1;
 	}
 #endif
+
+#if defined(__FreeBSD_kernel__)
+	login_tty (0);
+#endif
+
 	/*
 	 * Detect if this is a virtual console or serial/modem line.
 	 * In case of a virtual console the ioctl KDGKBMODE succeeds
-- 
2.1.0.rc1

