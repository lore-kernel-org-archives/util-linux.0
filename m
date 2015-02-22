Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f172.google.com ([74.125.82.172]:43982 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbbBVOnV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:43:21 -0500
Received: by wesu56 with SMTP id u56so13582397wes.10
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:43:19 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 10/12] script: use correct input type, move comment, and so on
Date: Sun, 22 Feb 2015 14:42:47 +0000
Message-Id: <1424616169-693-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
References: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Minor corrections.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 4709e10..8960ac4 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -182,7 +182,7 @@ static void finish(struct script_control *ctl, int wait)
 	pid_t pid;
 	int options = wait ? 0 : WNOHANG;
 
-	while ((pid = wait3(&status, options, 0)) > 0)
+	while ((pid = wait3(&status, options, NULL)) > 0)
 		if (pid == ctl->child)
 			ctl->childstatus = status;
 }
@@ -461,14 +461,6 @@ static void getmaster(struct script_control *ctl)
 #endif				/* not HAVE_LIBUTIL */
 }
 
-/*
- * script -t prints time delays as floating point numbers
- * The example program (scriptreplay) that we provide to handle this
- * timing output is a perl script, and does not handle numbers in
- * locale format (not even when "use locale;" is added).
- * So, since these numbers are not for human consumption, it seems
- * easiest to set LC_NUMERIC here.
- */
 int main(int argc, char **argv)
 {
 	struct script_control ctl = {
@@ -497,7 +489,14 @@ int main(int argc, char **argv)
 	};
 
 	setlocale(LC_ALL, "");
-	setlocale(LC_NUMERIC, "C");	/* see comment above */
+	/*
+	 * script -t prints time delays as floating point numbers.  The example
+	 * program (scriptreplay) that we provide to handle this timing output
+	 * is a perl script, and does not handle numbers in locale format (not
+	 * even when "use locale;" is added).  So, since these numbers are not
+	 * for human consumption, it seems easiest to set LC_NUMERIC here.
+	 */
+	setlocale(LC_NUMERIC, "C");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 	atexit(close_stdout);
@@ -534,7 +533,6 @@ int main(int argc, char **argv)
 		case 'h':
 			usage(stdout);
 			break;
-		case '?':
 		default:
 			usage(stderr);
 		}
@@ -583,6 +581,6 @@ int main(int argc, char **argv)
 	if (ctl.child == 0)
 		doshell(&ctl);
 	do_io(&ctl);
-
-	return EXIT_SUCCESS;
+	/* should not happen, do_io() calls done() */
+	return EXIT_FAILURE;
 }
-- 
2.3.0

