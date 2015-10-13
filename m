Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35148 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099AbbJML33 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 13 Oct 2015 07:29:29 -0400
Received: by wicge5 with SMTP id ge5so186607187wic.0
        for <util-linux@vger.kernel.org>; Tue, 13 Oct 2015 04:29:28 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 6/8] ctrlaltdel: improve error messaging
Date: Tue, 13 Oct 2015 12:29:12 +0100
Message-Id: <1444735754-18976-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1444735754-18976-1-git-send-email-kerolasa@iki.fi>
References: <1444735754-18976-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Tell user what is wrong rather than print usage().

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ctrlaltdel.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/sys-utils/ctrlaltdel.c b/sys-utils/ctrlaltdel.c
index 8f646e5..64de94f 100644
--- a/sys-utils/ctrlaltdel.c
+++ b/sys-utils/ctrlaltdel.c
@@ -21,7 +21,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fprintf(out, _(" %s hard|soft\n"), program_invocation_short_name);
 
 	fprintf(out, USAGE_SEPARATOR);
-	fprintf(out, "Set the function of the Ctrl-Alt-Del combination.\n");
+	fprintf(out, _("Set the function of the Ctrl-Alt-Del combination.\n"));
 
 	fprintf(out, USAGE_OPTIONS);
 	fprintf(out, USAGE_HELP);
@@ -33,6 +33,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 int main(int argc, char **argv)
 {
 	int ch;
+	unsigned int cmd;
 	static const struct option longopts[] = {
 		{"version", no_argument, NULL, 'V'},
 		{"help", no_argument, NULL, 'h'},
@@ -59,15 +60,15 @@ int main(int argc, char **argv)
 		errx(EXIT_FAILURE,
 		     _("You must be root to set the Ctrl-Alt-Del behavior"));
 
-	if (argc == 2 && !strcmp("hard", argv[1])) {
-		if (my_reboot(LINUX_REBOOT_CMD_CAD_ON) < 0)
-			err(EXIT_FAILURE, "reboot");
-	} else if (argc == 2 && !strcmp("soft", argv[1])) {
-		if (my_reboot(LINUX_REBOOT_CMD_CAD_OFF) < 0)
-			err(EXIT_FAILURE, "reboot");
-	} else {
-		usage(stderr);
-	}
-
+	if (argc < 2)
+		errx(EXIT_FAILURE, _("not enough arguments"));
+	if (!strcmp("hard", argv[1]))
+		cmd = LINUX_REBOOT_CMD_CAD_ON;
+	else if (!strcmp("soft", argv[1]))
+		cmd = LINUX_REBOOT_CMD_CAD_OFF;
+	else
+		errx(EXIT_FAILURE, _("unknown argument: %s"), argv[1]);
+	if (my_reboot(cmd) < 0)
+		err(EXIT_FAILURE, "reboot");
 	return EXIT_SUCCESS;
 }
-- 
2.6.1

