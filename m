Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:48345 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbaIFLZN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 6 Sep 2014 07:25:13 -0400
Received: by mail-we0-f174.google.com with SMTP id w61so1425139wes.5
        for <util-linux@vger.kernel.org>; Sat, 06 Sep 2014 04:25:11 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 6/6] rename: add getpriority() message lookup table
Date: Sat,  6 Sep 2014 12:24:53 +0100
Message-Id: <1410002693-16540-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410002693-16540-1-git-send-email-kerolasa@iki.fi>
References: <1410002693-16540-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/renice.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/sys-utils/renice.c b/sys-utils/renice.c
index 1fef526..a5bf50b 100644
--- a/sys-utils/renice.c
+++ b/sys-utils/renice.c
@@ -48,6 +48,12 @@
 #include "c.h"
 #include "closestream.h"
 
+const char *idtype[] = {
+	[PRIO_PROCESS]	= N_("process ID"),
+	[PRIO_PGRP]	= N_("process group ID"),
+	[PRIO_USER]	= N_("user ID"),
+};
+
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
@@ -67,38 +73,33 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-static int getprio(const int which, const int who, const char *idtype)
+static int getprio(const int which, const int who)
 {
 	int ret;
 
 	errno = 0;
 	ret = getpriority(which, who);
 	if (ret == -1 && errno) {
-		warn(_("failed to get priority for %d (%s)"), who, idtype);
+		warn(_("failed to get priority for %d (%s)"), who, idtype[which]);
 		return PRIO_MAX + 1;
 	}
 	return ret;
 }
 
-static int donice(int which, int who, int prio)
+static int donice(const int which, const int who, const int prio)
 {
 	int oldprio, newprio;
-	const char *idtype = _("process ID");
 
-	if (which == PRIO_USER)
-		idtype = _("user ID");
-	else if (which == PRIO_PGRP)
-		idtype = _("process group ID");
-	if ((oldprio = getprio(which, who, idtype)) == PRIO_MAX + 1)
+	if ((oldprio = getprio(which, who)) == PRIO_MAX + 1)
 		return 1;
 	if (setpriority(which, who, prio) < 0) {
-		warn(_("failed to set priority for %d (%s)"), who, idtype);
+		warn(_("failed to set priority for %d (%s)"), who, idtype[which]);
 		return 1;
 	}
-	if ((newprio = getprio(which, who, idtype)) == PRIO_MAX + 1)
+	if ((newprio = getprio(which, who)) == PRIO_MAX + 1)
 		return 1;
 	printf(_("%d (%s) old priority %d, new priority %d\n"),
-	       who, idtype, oldprio, newprio);
+	       who, idtype[which], oldprio, newprio);
 	return 0;
 }
 
-- 
2.1.0

