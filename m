Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38094 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbaIFLZH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 6 Sep 2014 07:25:07 -0400
Received: by mail-wi0-f170.google.com with SMTP id cc10so656210wib.3
        for <util-linux@vger.kernel.org>; Sat, 06 Sep 2014 04:25:06 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/6] renice: avoid having same lines of code twice
Date: Sat,  6 Sep 2014 12:24:51 +0100
Message-Id: <1410002693-16540-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410002693-16540-1-git-send-email-kerolasa@iki.fi>
References: <1410002693-16540-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add getprio() function to avoid duplication of a simple task.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/renice.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/sys-utils/renice.c b/sys-utils/renice.c
index 2075d40..1c4b840 100644
--- a/sys-utils/renice.c
+++ b/sys-utils/renice.c
@@ -67,8 +67,21 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-static int
-donice(int which, int who, int prio) {
+static int getprio(const int which, const int who, const char *idtype)
+{
+	int ret;
+
+	errno = 0;
+	ret = getpriority(which, who);
+	if (ret == -1 && errno) {
+		warn(_("failed to get priority for %d (%s)"), who, idtype);
+		return PRIO_MAX + 1;
+	}
+	return ret;
+}
+
+static int donice(int which, int who, int prio)
+{
 	int oldprio, newprio;
 	const char *idtype = _("process ID");
 
@@ -76,24 +89,14 @@ donice(int which, int who, int prio) {
 		idtype = _("user ID");
 	else if (which == PRIO_PGRP)
 		idtype = _("process group ID");
-
-	errno = 0;
-	oldprio = getpriority(which, who);
-	if (oldprio == -1 && errno) {
-		warn(_("failed to get priority for %d (%s)"), who, idtype);
+	if ((oldprio = getprio(which, who, idtype)) == PRIO_MAX + 1)
 		return 1;
-	}
 	if (setpriority(which, who, prio) < 0) {
 		warn(_("failed to set priority for %d (%s)"), who, idtype);
 		return 1;
 	}
-	errno = 0;
-	newprio = getpriority(which, who);
-	if (newprio == -1 && errno) {
-		warn(_("failed to get priority for %d (%s)"), who, idtype);
+	if ((newprio = getprio(which, who, idtype)) == PRIO_MAX + 1)
 		return 1;
-	}
-
 	printf(_("%d (%s) old priority %d, new priority %d\n"),
 	       who, idtype, oldprio, newprio);
 	return 0;
@@ -103,8 +106,7 @@ donice(int which, int who, int prio) {
  * Change the priority (the nice value) of processes
  * or groups of processes which are already running.
  */
-int
-main(int argc, char **argv)
+int main(int argc, char **argv)
 {
 	int which = PRIO_PROCESS;
 	int who = 0, prio, errs = 0;
-- 
2.1.0

