Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f171.google.com ([74.125.82.171]:65524 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaEROGK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 18 May 2014 10:06:10 -0400
Received: by mail-we0-f171.google.com with SMTP id w62so4477490wes.30
        for <util-linux@vger.kernel.org>; Sun, 18 May 2014 07:06:08 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/17] setterm: add init_terminal() to make main() shorter
Date: Sun, 18 May 2014 15:05:31 +0100
Message-Id: <1400421941-14244-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 50 ++++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 63c912b..05ea387 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -1060,46 +1060,48 @@ static void perform_sequence(struct setterm_control *ctl)
 
 }
 
-int main(int argc, char **argv)
+static void init_terminal(struct setterm_control *ctl)
 {
-	struct setterm_control ctl;
 	int term_errno;
 
-	memset(&ctl, 0, sizeof (ctl));
-	setlocale(LC_ALL, "");
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	textdomain(PACKAGE);
-	atexit(close_stdout);
-
-	if (argc < 2)
-		usage(stderr);
-
-	/* Parse arguments. */
-	parse_option(&ctl, argc, argv);
-
-	/* Find out terminal name. */
-	if (!ctl.opt_te_terminal_name) {
-		ctl.opt_te_terminal_name = getenv("TERM");
-		if (ctl.opt_te_terminal_name == NULL)
+	if (!ctl->opt_te_terminal_name) {
+		ctl->opt_te_terminal_name = getenv("TERM");
+		if (ctl->opt_te_terminal_name == NULL)
 			errx(EXIT_FAILURE, _("$TERM is not defined."));
 	}
 
 	/* Find terminfo entry. */
-	if (setupterm(ctl.opt_te_terminal_name, 1, &term_errno))
-		switch(term_errno) {
+	if (setupterm(ctl->opt_te_terminal_name, STDOUT_FILENO, &term_errno))
+		switch (term_errno) {
 		case -1:
 			errx(EXIT_FAILURE, _("terminfo database cannot be found"));
 		case 0:
-			errx(EXIT_FAILURE, _("%s: unknown terminal type"), ctl.opt_te_terminal_name);
+			errx(EXIT_FAILURE, _("%s: unknown terminal type"), ctl->opt_te_terminal_name);
 		case 1:
 			errx(EXIT_FAILURE, _("terminal is hardcopy"));
 		}
 
 	/* See if the terminal is a virtual console terminal. */
-	ctl.vcterm = (!strncmp(ctl.opt_te_terminal_name, "con", 3) ||
-		      !strncmp(ctl.opt_te_terminal_name, "linux", 5));
+	ctl->vcterm = (!strncmp(ctl->opt_te_terminal_name, "con", 3) ||
+		       !strncmp(ctl->opt_te_terminal_name, "linux", 5));
+}
+
 
-	/* Perform the selected options. */
+int main(int argc, char **argv)
+{
+	struct setterm_control ctl;
+
+	memset(&ctl, 0, sizeof (ctl));
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	if (argc < 2)
+		usage(stderr);
+
+	parse_option(&ctl, argc, argv);
+	init_terminal(&ctl);
 	perform_sequence(&ctl);
 
 	return EXIT_SUCCESS;
-- 
1.9.2

