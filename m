Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f170.google.com ([74.125.82.170]:34137 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbbBVOnW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:43:22 -0500
Received: by wesq59 with SMTP id q59so13673180wes.1
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:43:20 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 11/12] script: use gettime_monotonic() to get timing file timestamps
Date: Sun, 22 Feb 2015 14:42:48 +0000
Message-Id: <1424616169-693-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
References: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This moves the previous time to script control structure, and does
timeval calculation with timersub() that is more appropriate than
making a timeval to a double.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/Makemodule.am |  4 ++--
 term-utils/script.c      | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/term-utils/Makemodule.am b/term-utils/Makemodule.am
index 2bf916c..a360f22 100644
--- a/term-utils/Makemodule.am
+++ b/term-utils/Makemodule.am
@@ -1,9 +1,9 @@
 if BUILD_SCRIPT
 usrbin_exec_PROGRAMS += script
 dist_man_MANS += term-utils/script.1
-script_SOURCES = term-utils/script.c
+script_SOURCES = term-utils/script.c lib/monotonic.c
 script_CFLAGS = $(AM_CFLAGS) -Wno-format-y2k
-script_LDADD = $(LDADD)
+script_LDADD = $(LDADD) libcommon.la $(CLOCKGETTIME_LIBS)
 if HAVE_UTIL
 script_LDADD += -lutil
 endif
diff --git a/term-utils/script.c b/term-utils/script.c
index 8960ac4..54e10b4 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -71,6 +71,7 @@
 #include "c.h"
 #include "ttyutils.h"
 #include "all-io.h"
+#include "monotonic.h"
 
 #if defined(HAVE_LIBUTIL) && defined(HAVE_PTY_H)
 # include <pty.h>
@@ -90,6 +91,7 @@ struct script_control {
 	char *fname;		/* output file path */
 	FILE *typescriptfp;	/* output file pointer */
 	FILE *timingfp;		/* timing file pointer */
+	struct timeval oldtime;	/* previous write or command start time */
 	int master;		/* pseudoterminal master file descriptor */
 	int slave;		/* pseudoterminal slave file descriptor */
 	int poll_timeout;	/* poll() timeout, used in end of execution */
@@ -188,19 +190,17 @@ static void finish(struct script_control *ctl, int wait)
 }
 
 static void write_output(struct script_control *ctl, char *obuf,
-			    ssize_t bytes, double *oldtime)
+			    ssize_t bytes)
 {
-
 	if (ctl->tflg && ctl->timingfp) {
-		struct timeval tv;
-		double newtime;
+		struct timeval now, delta;
 
-		gettimeofday(&tv, NULL);
-		newtime = tv.tv_sec + (double)tv.tv_usec / 1000000;
-		fprintf(ctl->timingfp, "%f %zd\n", newtime - *oldtime, bytes);
+		gettime_monotonic(&now);
+		timersub(&now, &ctl->oldtime, &delta);
+		fprintf(ctl->timingfp, "%ld.%06ld %zd\n", delta.tv_sec, delta.tv_usec, bytes);
 		if (ctl->fflg)
 			fflush(ctl->timingfp);
-		*oldtime = newtime;
+		ctl->oldtime = now;
 	}
 	if (fwrite_all(obuf, 1, bytes, ctl->typescriptfp)) {
 		warn(_("cannot write script file"));
@@ -214,7 +214,7 @@ static void write_output(struct script_control *ctl, char *obuf,
 	}
 }
 
-static void handle_io(struct script_control *ctl, int fd, double *oldtime, int i)
+static void handle_io(struct script_control *ctl, int fd, int i)
 {
 	char buf[BUFSIZ];
 	ssize_t bytes;
@@ -238,7 +238,7 @@ static void handle_io(struct script_control *ctl, int fd, double *oldtime, int i
 			write_all(ctl->master, &c, 1);
 		}
 	} else
-		write_output(ctl, buf, bytes, oldtime);
+		write_output(ctl, buf, bytes);
 }
 
 static void handle_signal(struct script_control *ctl, int fd)
@@ -268,7 +268,6 @@ static void do_io(struct script_control *ctl)
 {
 	struct pollfd pfd[POLLFDS];
 	int ret, i;
-	double oldtime = time(NULL);
 	time_t tvec = time((time_t *)NULL);
 	char buf[128];
 
@@ -284,6 +283,7 @@ static void do_io(struct script_control *ctl)
 
 	strftime(buf, sizeof buf, "%c\n", localtime(&tvec));
 	fprintf(ctl->typescriptfp, _("Script started on %s"), buf);
+	gettime_monotonic(&ctl->oldtime);
 
 	while (!ctl->die) {
 		/* wait for input or signal */
@@ -300,7 +300,7 @@ static void do_io(struct script_control *ctl)
 			if (pfd[i].revents == 0)
 				continue;
 			if (i < 2) {
-				handle_io(ctl, pfd[i].fd, &oldtime, i);
+				handle_io(ctl, pfd[i].fd, i);
 				continue;
 			}
 			if (i == 2) {
-- 
2.3.0

