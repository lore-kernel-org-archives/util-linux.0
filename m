Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f175.google.com ([74.125.82.175]:34887 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaEROGQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 18 May 2014 10:06:16 -0400
Received: by mail-we0-f175.google.com with SMTP id t61so4349954wes.6
        for <util-linux@vger.kernel.org>; Sun, 18 May 2014 07:06:15 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/17] setterm: make -msglevel 0 to work as is did earlier
Date: Sun, 18 May 2014 15:05:34 +0100
Message-Id: <1400421941-14244-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Commit 3393c136 caused regression.  The klogctl() logging range is 1-8,
but the value 0 is special according to setterm.1 manual page.  It turns
on loging, same way as '-msg on' option.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/setterm |  2 +-
 term-utils/setterm.c    | 12 +++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/bash-completion/setterm b/bash-completion/setterm
index f47debf..8e0f629 100644
--- a/bash-completion/setterm
+++ b/bash-completion/setterm
@@ -51,7 +51,7 @@ _setterm_module()
 			return 0
 			;;
 		'-msglevel')
-			COMPREPLY=( $(compgen -W "{1..8}" -- $cur) )
+			COMPREPLY=( $(compgen -W "{0..8}" -- $cur) )
 			return 0
 			;;
 		'-powersave')
diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 3a02347..2f9151c 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -134,7 +134,7 @@ enum {
 
 /* Console log levels */
 enum {
-	CONSOLE_LEVEL_MIN = 1,
+	CONSOLE_LEVEL_MIN = 0,
 	CONSOLE_LEVEL_MAX = 8
 };
 
@@ -446,16 +446,14 @@ usage(FILE *out) {
 	fputs(_(" -append <1-NR_CONSOLES>\n"), out);
 	fputs(_(" -file dumpfilename\n"), out);
 	fputs(_(" -msg <on|off>\n"), out);
-	fputs(_(" -msglevel <0-8>\n"), out);	/* FIXME: klogctl console_log range is 1-8 */
+	fputs(_(" -msglevel <0-8>\n"), out);
 	fputs(_(" -powersave <on|vsync|hsync|powerdown|off>\n"), out);
 	fputs(_(" -powerdown <0-60>\n"), out);
 	fputs(_(" -blength <0-2000>\n"), out);
 	fputs(_(" -bfreq freqnumber\n"), out);
 	fputs(_(" -version\n"), out);
 	fputs(_(" -help\n"), out);
-
 	fprintf(out, USAGE_MAN_TAIL("setterm(1)"));
-
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
@@ -660,6 +658,10 @@ static void parse_option(struct setterm_control *ctl, int argc, char **argv)
 		case OPT_MSGLEVEL:
 			ctl->opt_msglevel = set_opt_flag(ctl->opt_msglevel);
 			ctl->opt_msglevel_num = parse_msglevel(optarg);
+			if (ctl->opt_msglevel_num == 0) {
+				ctl->opt_msg = set_opt_flag(ctl->opt_msg);
+				ctl->opt_msg_on |= 1;
+			}
 			break;
 		case OPT_POWERSAVE:
 			ctl->opt_powersave = set_opt_flag(ctl->opt_powersave);
@@ -1031,7 +1033,7 @@ static void perform_sequence(struct setterm_control *ctl)
 	}
 
 	/* -msglevel [0-8] */
-	if (ctl->opt_msglevel && ctl->vcterm) {
+	if (ctl->opt_msglevel_num && ctl->vcterm) {
 		/* 8 -- Set level of messages printed to console */
 		result = klogctl(SYSLOG_ACTION_CONSOLE_LEVEL, NULL, ctl->opt_msglevel_num);
 		if (result != 0)
-- 
1.9.2

