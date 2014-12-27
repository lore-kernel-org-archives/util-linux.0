Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:38296 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbaL0RRx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 27 Dec 2014 12:17:53 -0500
Received: by mail-wg0-f43.google.com with SMTP id l18so16090730wgh.30
        for <util-linux@vger.kernel.org>; Sat, 27 Dec 2014 09:17:51 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 22/22] script: use correct input type, move comment, and so on
Date: Sat, 27 Dec 2014 17:17:35 +0000
Message-Id: <1419700655-19107-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1419700655-19107-1-git-send-email-kerolasa@iki.fi>
References: <1419700655-19107-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Minor corrections.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 7a992da..c784f8a 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -179,7 +179,7 @@ static void finish(struct script_control *ctl, int wait)
 	pid_t pid;
 	int options = wait ? 0 : WNOHANG;
 
-	while ((pid = wait3(&status, options, 0)) > 0)
+	while ((pid = wait3(&status, options, NULL)) > 0)
 		if (pid == ctl->child)
 			ctl->childstatus = status;
 }
@@ -458,14 +458,6 @@ static void getmaster(struct script_control *ctl)
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
@@ -494,7 +486,14 @@ int main(int argc, char **argv)
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
@@ -531,7 +530,6 @@ int main(int argc, char **argv)
 		case 'h':
 			usage(stdout);
 			break;
-		case '?':
 		default:
 			usage(stderr);
 		}
@@ -579,6 +577,6 @@ int main(int argc, char **argv)
 	if (ctl.child == 0)
 		doshell(&ctl);
 	do_io(&ctl);
-
-	return EXIT_SUCCESS;
+	/* should not happen, do_io() calls done() */
+	return EXIT_FAILURE;
 }
-- 
2.2.1

