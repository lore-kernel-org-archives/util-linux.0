Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f50.google.com ([74.125.82.50]:59402 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbbARWDW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 18 Jan 2015 17:03:22 -0500
Received: by mail-wg0-f50.google.com with SMTP id b13so368835wgh.9
        for <util-linux@vger.kernel.org>; Sun, 18 Jan 2015 14:03:20 -0800 (PST)
Date: Sun, 18 Jan 2015 22:03:06 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Samuel Thibault <sthibault@debian.org>, util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.26-rc1
In-Reply-To: <20150118191015.GI2957@type.youpi.perso.aquilenet.fr>
Message-ID: <alpine.LNX.2.03.1501182158270.18731@iki.fi>
References: <20150118191015.GI2957@type.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, 18 Jan 2015, Samuel Thibault wrote:

> Here is a fix for systems which don't have sys/timex.h and its 
> ntp_gettime().

Hi Samuel,

I took liberty to move patch you sent to git

https://github.com/kerolasa/lelux-utiliteetit/commit/e64274deb47714c81df149a019d60d650558ca2a

And here is the altered version of it for public display.  IMHO if 
ntp_gettime() is not available the time quality stuff can still work, and 
tell there is no way knowing if time is syncronized.

--->8----
From: Samuel Thibault <sthibault@debian.org>
Date: Sun, 18 Jan 2015 21:44:54 +0000
Subject: logger: check availability of ntp_gettime()

Make compilation to work in systems which don't have sys/timex.h and its
ntp_gettime().

[Sami: make #ifdef scope near 'if (ctl->rfc5424_tq)' tighter]

Reviewed-by: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: Samuel Thibault <sthibault@debian.org>
---
 configure.ac        | 1 +
 misc-utils/logger.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 3d77307..fce7e0e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -230,6 +230,7 @@ AC_CHECK_HEADERS([ \
 	sys/swap.h \
 	sys/syscall.h \
 	sys/time.h \
+	sys/timex.h \
 	sys/ttydefaults.h \
 	sys/types.h \
 	sys/un.h \
diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 35caf9d..03031da 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -44,7 +44,6 @@
 #include <stdio.h>
 #include <ctype.h>
 #include <string.h>
-#include <sys/timex.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/un.h>
@@ -67,6 +66,10 @@
 # include <systemd/sd-journal.h>
 #endif
 
+#ifdef HAVE_SYS_TIMEX_H
+# include <sys/timex.h>
+#endif
+
 enum {
 	TYPE_UDP = (1 << 1),
 	TYPE_TCP = (1 << 2),
@@ -325,7 +328,9 @@ static void syslog_rfc5424(const  struct logger_ctl *ctl, const char *msg)
 {
 	char *buf, *tag = NULL, *hostname = NULL;
 	char pid[32], time[64], timeq[80];
+#ifdef HAVE_SYS_TIMEX_H
 	struct ntptimeval ntptv;
+#endif
 	struct timeval tv;
 	struct tm *tm;
 	int len;
@@ -364,11 +369,13 @@ static void syslog_rfc5424(const  struct logger_ctl *ctl, const char *msg)
 		snprintf(pid, sizeof(pid), " %d", ctl->pid);
 
 	if (ctl->rfc5424_tq) {
+#ifdef HAVE_SYS_TIMEX_H
 		if (ntp_gettime(&ntptv) == TIME_OK)
 			snprintf(timeq, sizeof(timeq),
 				 " [timeQuality tzKnown=\"1\" isSynced=\"1\" syncAccuracy=\"%ld\"]",
 				 ntptv.maxerror);
 		else
+#endif
 			snprintf(timeq, sizeof(timeq),
 				 " [timeQuality tzKnown=\"1\" isSynced=\"0\"]");
 	}
-- 
2.2.2

