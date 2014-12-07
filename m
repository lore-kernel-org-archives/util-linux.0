Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:36787 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152AbaLGKON (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Dec 2014 05:14:13 -0500
Received: by mail-wg0-f48.google.com with SMTP id y19so4064516wgg.21
        for <util-linux@vger.kernel.org>; Sun, 07 Dec 2014 02:14:12 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>,
        Frodo Looijaard <frodo@frodo.looijaard.name>
Subject: [PATCH 10/11] getopt: change --shell argument parsing function
Date: Sun,  7 Dec 2014 10:13:54 +0000
Message-Id: <1417947235-24229-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
References: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Avoid passing getopt_control stucture in when returning a value is enough.

CC: Frodo Looijaard <frodo@frodo.looijaard.name>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/getopt.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index 8134558..2940a7d 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -295,19 +295,17 @@ static void add_long_options(struct getopt_control *ctl, char *options)
 	}
 }
 
-static void set_shell(struct getopt_control *ctl, const char *new_shell)
+static shell_t shell_type(const char *new_shell)
 {
 	if (!strcmp(new_shell, "bash"))
-		ctl->shell = BASH;
-	else if (!strcmp(new_shell, "tcsh"))
-		ctl->shell = TCSH;
-	else if (!strcmp(new_shell, "sh"))
-		ctl->shell = BASH;
-	else if (!strcmp(new_shell, "csh"))
-		ctl->shell = TCSH;
-	else
-		parse_error(_
-			    ("unknown shell after -s or --shell argument"));
+		return BASH;
+	if (!strcmp(new_shell, "sh"))
+		return BASH;
+	if (!strcmp(new_shell, "tcsh"))
+		return TCSH;
+	if (!strcmp(new_shell, "csh"))
+		return TCSH;
+	parse_error(_("unknown shell after -s or --shell argument"));
 }
 
 static void __attribute__ ((__noreturn__)) print_help(void)
@@ -419,7 +417,7 @@ int main(int argc, char *argv[])
 			ctl.quiet_output = 1;
 			break;
 		case 's':
-			set_shell(&ctl, optarg);
+			ctl.shell = shell_type(optarg);
 			break;
 		case 'T':
 			return TEST_EXIT_CODE;
-- 
2.1.3

