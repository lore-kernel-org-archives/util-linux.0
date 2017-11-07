Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:51659 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754785AbdKGQJB (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 7 Nov 2017 11:09:01 -0500
Received: by mail-wr0-f193.google.com with SMTP id j15so12313884wre.8
        for <util-linux@vger.kernel.org>; Tue, 07 Nov 2017 08:09:01 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] rfkill: allow user to exit gracefully from event watching loop
Date: Tue,  7 Nov 2017 16:08:56 +0000
Message-Id: <20171107160856.7648-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When SIGINT is raised by something else than an user running rfkill the
watch loop will be killed by that signal with appropriate exit code.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/rfkill.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/sys-utils/rfkill.c b/sys-utils/rfkill.c
index c9559ef48..d12942de0 100644
--- a/sys-utils/rfkill.c
+++ b/sys-utils/rfkill.c
@@ -27,6 +27,7 @@
 #include <sys/poll.h>
 #include <sys/syslog.h>
 #include <sys/time.h>
+#include <signal.h>
 
 #include "c.h"
 #include "closestream.h"
@@ -218,6 +219,21 @@ static int rfkill_read_event(int fd, struct rfkill_event *event)
 	return 0;
 }
 
+sig_atomic_t user_ctrl_c = 0;
+
+static void event_signal(int signo, siginfo_t *info,
+			 void *context __attribute__((__unused__)))
+{
+	if (!info->si_pid)
+		user_ctrl_c = 1;
+	else {
+		if (info->si_code == SI_USER)
+			warnx(_("uid: %d pid: %d sent signal %d, exiting"),
+			      info->si_uid, info->si_pid, info->si_signo);
+		signal(signo, SIG_DFL);
+		kill(getpid(), signo);
+	}
+}
 
 static int rfkill_event(void)
 {
@@ -226,6 +242,7 @@ static int rfkill_event(void)
 	char date_buf[ISO_8601_BUFSIZ];
 	struct pollfd p;
 	int fd, n;
+	struct sigaction sigact;
 
 	fd = rfkill_ro_open(0);
 	if (fd < 0)
@@ -235,13 +252,19 @@ static int rfkill_event(void)
 	p.fd = fd;
 	p.events = POLLIN | POLLHUP;
 
+	sigemptyset(&sigact.sa_mask);
+	sigact.sa_flags = SA_SIGINFO;
+	sigact.sa_sigaction = event_signal;
+	sigaction(SIGINT, &sigact, NULL);
+
 	/* interrupted by signal only */
-	while (1) {
+	while (!user_ctrl_c) {
 		int rc = 1;	/* recover-able error */
 
 		n = poll(&p, 1, -1);
 		if (n < 0) {
-			warn(_("failed to poll %s"), _PATH_DEV_RFKILL);
+			if (!user_ctrl_c)
+				warn(_("failed to poll %s"), _PATH_DEV_RFKILL);
 			goto failed;
 		}
 
@@ -267,7 +290,7 @@ static int rfkill_event(void)
 
 failed:
 	close(fd);
-	return -1;
+	return user_ctrl_c ? 0 : -1;
 }
 
 static const char *get_sys_attr(uint32_t idx, const char *attr)
-- 
2.15.0

