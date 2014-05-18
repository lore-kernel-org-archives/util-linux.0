Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33816 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaEROGS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 18 May 2014 10:06:18 -0400
Received: by mail-wi0-f173.google.com with SMTP id bs8so2945144wib.6
        for <util-linux@vger.kernel.org>; Sun, 18 May 2014 07:06:17 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/17] setterm: correct usage() bright color argument
Date: Sun, 18 May 2014 15:05:35 +0100
Message-Id: <1400421941-14244-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This has been wrong since commit 2dc8716.  The bright is a prefix
attribute to other colors.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/setterm | 15 ++++++++++++---
 term-utils/setterm.c    | 21 +++++++++------------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/bash-completion/setterm b/bash-completion/setterm
index 8e0f629..69f6620 100644
--- a/bash-completion/setterm
+++ b/bash-completion/setterm
@@ -1,6 +1,6 @@
 _setterm_module()
 {
-	local cur prev OPTS
+	local bright cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
@@ -14,8 +14,17 @@ _setterm_module()
 			COMPREPLY=( $(compgen -W "$TERM_LIST" -- $cur) )
 			return 0
 			;;
-		'-foreground'|'-background'|'-ulcolor'|'-hbcolor')
-			COMPREPLY=( $(compgen -W "default black blue cyan green magenta red white yellow" -- $cur) )
+		'-foreground'|'-background')
+			COMPREPLY=( $(compgen -W "black blue cyan default green magenta red white yellow" -- $cur) )
+			return 0
+			;;
+		'-ulcolor'|'-hbcolor'|'bright')
+			if [ $prev != 'bright' ]; then
+				bright='bright black grey'
+			else
+				bright=''
+			fi
+			COMPREPLY=( $(compgen -W "$bright blue cyan green magenta red white yellow" -- $cur) )
 			return 0
 			;;
 		'-cursor'|'-repeat'|'-appcursorkeys'|'-linewrap'|'-inversescreen'|'-bold'|'-half-bright'|'-blink'|'-reverse'|'-underline'|'-msg')
diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 2f9151c..3b4ab56 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -404,18 +404,15 @@ static int parse_bfreq(char **argv, char *optarg, int *optind)
 	return strtoint_or_err(arg);
 }
 
-static void __attribute__ ((__noreturn__))
-usage(FILE *out) {
-/* Print error message about arguments, and the command's syntax. */
-
+static void __attribute__((__noreturn__)) usage(FILE *out)
+{
 	if (out == stderr)
-		warnx(_("Argument error."));
+		warnx(_("argument error"));
 
-	fputs(_("\nUsage:\n"), out);
+	fputs(USAGE_HEADER, out);
 	fprintf(out,
 	      _(" %s [options]\n"), program_invocation_short_name);
-
-	fputs(_("\nOptions:\n"), out);
+	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -term <terminal_name>\n"), out);
 	fputs(_(" -reset\n"), out);
 	fputs(_(" -initialize\n"), out);
@@ -426,10 +423,10 @@ usage(FILE *out) {
 	fputs(_(" -default\n"), out);
 	fputs(_(" -foreground <default|black|blue|cyan|green|magenta|red|white|yellow>\n"), out);
 	fputs(_(" -background <default|black|blue|cyan|green|magenta|red|white|yellow>\n"), out);
-	fputs(_(" -ulcolor <black|blue|bright|cyan|green|grey|magenta|red|white|yellow>\n"), out);
-	fputs(_(" -ulcolor <black|blue|bright|cyan|green|grey|magenta|red|white|yellow>\n"), out);
-	fputs(_(" -hbcolor <black|blue|bright|cyan|green|grey|magenta|red|white|yellow>\n"), out);
-	fputs(_(" -hbcolor <black|blue|bright|cyan|green|grey|magenta|red|white|yellow>\n"), out);
+	fputs(_(" -ulcolor <bright> <black|blue|cyan|green|grey|magenta|red|white|yellow>\n"), out);
+	fputs(_(" -ulcolor <bright> <black|blue|cyan|green|grey|magenta|red|white|yellow>\n"), out);
+	fputs(_(" -hbcolor <bright> <black|blue|cyan|green|grey|magenta|red|white|yellow>\n"), out);
+	fputs(_(" -hbcolor <bright> <black|blue|cyan|green|grey|magenta|red|white|yellow>\n"), out);
 	fputs(_(" -inversescreen <on|off>\n"), out);
 	fputs(_(" -bold <on|off>\n"), out);
 	fputs(_(" -half-bright <on|off>\n"), out);
-- 
1.9.2

