Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:51737 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbaIFLZK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 6 Sep 2014 07:25:10 -0400
Received: by mail-wi0-f178.google.com with SMTP id n3so393572wiv.5
        for <util-linux@vger.kernel.org>; Sat, 06 Sep 2014 04:25:09 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 5/6] renice: fix numeric uid argument parsing
Date: Sat,  6 Sep 2014 12:24:52 +0100
Message-Id: <1410002693-16540-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410002693-16540-1-git-send-email-kerolasa@iki.fi>
References: <1410002693-16540-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The following was inconflict with what usage() tells are valid option
arguments.

$ renice 1 -u 1000
renice: unknown user 1000
$ id
uid=1000(kerolasa) ...

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/renice.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/sys-utils/renice.c b/sys-utils/renice.c
index 1c4b840..1fef526 100644
--- a/sys-utils/renice.c
+++ b/sys-utils/renice.c
@@ -111,6 +111,7 @@ int main(int argc, char **argv)
 	int which = PRIO_PROCESS;
 	int who = 0, prio, errs = 0;
 	char *endptr = NULL;
+	const char *error_msg;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -162,18 +163,20 @@ int main(int argc, char **argv)
 			continue;
 		}
 		if (which == PRIO_USER) {
-			register struct passwd *pwd = getpwnam(*argv);
+			struct passwd *pwd = getpwnam(*argv);
 
-			if (pwd == NULL) {
-				warnx(_("unknown user %s"), *argv);
-				errs = 1;
-				continue;
+			if (pwd != NULL)
+				who = pwd->pw_uid;
+			else {
+				error_msg = _("unknown user %s");
+				goto numeric_pid;
 			}
-			who = pwd->pw_uid;
 		} else {
+			error_msg = _("bad value %s");
+ numeric_pid:
 			who = strtol(*argv, &endptr, 10);
 			if (who < 0 || *endptr) {
-				warnx(_("bad value %s"), *argv);
+				warnx(error_msg, *argv);
 				errs = 1;
 				continue;
 			}
-- 
2.1.0

