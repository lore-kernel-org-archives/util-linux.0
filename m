Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:53957 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbaIFLZA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 6 Sep 2014 07:25:00 -0400
Received: by mail-wg0-f52.google.com with SMTP id m15so12738561wgh.23
        for <util-linux@vger.kernel.org>; Sat, 06 Sep 2014 04:24:59 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/6] renice: reorder functions to avoid need of function prototype
Date: Sat,  6 Sep 2014 12:24:48 +0100
Message-Id: <1410002693-16540-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410002693-16540-1-git-send-email-kerolasa@iki.fi>
References: <1410002693-16540-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/renice.c | 65 +++++++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/sys-utils/renice.c b/sys-utils/renice.c
index c0378e1..5d643fb 100644
--- a/sys-utils/renice.c
+++ b/sys-utils/renice.c
@@ -48,8 +48,6 @@
 #include "c.h"
 #include "closestream.h"
 
-static int donice(int,int,int);
-
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(_("\nUsage:\n"), out);
@@ -72,6 +70,38 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
+static int
+donice(int which, int who, int prio) {
+	int oldprio, newprio;
+	const char *idtype = _("process ID");
+
+	if (which == PRIO_USER)
+		idtype = _("user ID");
+	else if (which == PRIO_PGRP)
+		idtype = _("process group ID");
+
+	errno = 0;
+	oldprio = getpriority(which, who);
+	if (oldprio == -1 && errno) {
+		warn(_("failed to get priority for %d (%s)"), who, idtype);
+		return 1;
+	}
+	if (setpriority(which, who, prio) < 0) {
+		warn(_("failed to set priority for %d (%s)"), who, idtype);
+		return 1;
+	}
+	errno = 0;
+	newprio = getpriority(which, who);
+	if (newprio == -1 && errno) {
+		warn(_("failed to get priority for %d (%s)"), who, idtype);
+		return 1;
+	}
+
+	printf(_("%d (%s) old priority %d, new priority %d\n"),
+	       who, idtype, oldprio, newprio);
+	return 0;
+}
+
 /*
  * Change the priority (the nice value) of processes
  * or groups of processes which are already running.
@@ -155,34 +185,3 @@ main(int argc, char **argv)
 	return errs != 0 ? EXIT_FAILURE : EXIT_SUCCESS;
 }
 
-static int
-donice(int which, int who, int prio) {
-	int oldprio, newprio;
-	const char *idtype = _("process ID");
-
-	if (which == PRIO_USER)
-		idtype = _("user ID");
-	else if (which == PRIO_PGRP)
-		idtype = _("process group ID");
-
-	errno = 0;
-	oldprio = getpriority(which, who);
-	if (oldprio == -1 && errno) {
-		warn(_("failed to get priority for %d (%s)"), who, idtype);
-		return 1;
-	}
-	if (setpriority(which, who, prio) < 0) {
-		warn(_("failed to set priority for %d (%s)"), who, idtype);
-		return 1;
-	}
-	errno = 0;
-	newprio = getpriority(which, who);
-	if (newprio == -1 && errno) {
-		warn(_("failed to get priority for %d (%s)"), who, idtype);
-		return 1;
-	}
-
-	printf(_("%d (%s) old priority %d, new priority %d\n"),
-	       who, idtype, oldprio, newprio);
-	return 0;
-}
-- 
2.1.0

