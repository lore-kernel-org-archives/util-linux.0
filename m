Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:62592 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab3AVX1w (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jan 2013 18:27:52 -0500
Received: by mail-wg0-f43.google.com with SMTP id e12so3573516wge.10
        for <util-linux@vger.kernel.org>; Tue, 22 Jan 2013 15:27:51 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 13/14] agetty: make usage() translator friendly
Date: Tue, 22 Jan 2013 23:27:12 +0000
Message-Id: <1358897233-6676-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
References: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/agetty.c | 70 ++++++++++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index ed97bc5..2f2c019 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -1629,42 +1629,42 @@ static speed_t bcode(char *s)
 	return 0;
 }
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__ ((__noreturn__)) usage(FILE *out)
 {
-	fprintf(out, _("\nUsage:\n"
-		       " %1$s [options] line baud_rate,... [termtype]\n"
-		       " %1$s [options] baud_rate,... line [termtype]\n"),
-		program_invocation_short_name);
-
-	fprintf(out, _("\nOptions:\n"
-		       " -8, --8bits                assume 8-bit tty\n"
-		       " -a, --autologin <user>     login the specified user automatically\n"
-		       " -c, --noreset              do not reset control mode\n"
-		       " -f, --issue-file <file>    display issue file\n"
-		       " -h, --flow-control         enable hardware flow control\n"
-		       " -H, --host <hostname>      specify login host\n"
-		       " -i, --noissue              do not display issue file\n"
-		       " -I, --init-string <string> set init string\n"
-		       " -l, --login-program <file> specify login program\n"
-		       " -L, --local-line           force local line\n"
-		       " -m, --extract-baud         extract baud rate during connect\n"
-		       " -n, --skip-login           do not prompt for login\n"
-		       " -o, --login-options <opts> options that are passed to login\n"
-		       " -p, --loginpause           wait for any key before the login\n"
-		       " -R, --hangup               do virtually hangup on the tty\n"
-		       " -s, --keep-baud            try to keep baud rate after break\n"
-		       " -t, --timeout <number>     login process timeout\n"
-		       " -U, --detect-case          detect uppercase terminal\n"
-		       " -w, --wait-cr              wait carriage-return\n"
-		       "     --noclear              do not clear the screen before prompt\n"
-		       "     --nohints              do not print hints\n"
-		       "     --nonewline            do not print a newline before issue\n"
-		       "     --no-hostname          no hostname at all will be shown\n"
-		       "     --long-hostname        show full qualified hostname\n"
-		       "     --erase-chars <string> additional backspace chars\n"
-		       "     --kill-chars <string>  additional kill chars\n"
-		       "     --version              output version information and exit\n"
-		       "     --help                 display this help and exit\n\n"));
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(" %1$s [options] line baud_rate,... [termtype]\n"
+		       " %1$s [options] baud_rate,... line [termtype]\n"), program_invocation_short_name);
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -8, --8bits                assume 8-bit tty\n"), out);
+	fputs(_(" -a, --autologin <user>     login the specified user automatically\n"), out);
+	fputs(_(" -c, --noreset              do not reset control mode\n"), out);
+	fputs(_(" -f, --issue-file <file>    display issue file\n"), out);
+	fputs(_(" -h, --flow-control         enable hardware flow control\n"), out);
+	fputs(_(" -H, --host <hostname>      specify login host\n"), out);
+	fputs(_(" -i, --noissue              do not display issue file\n"), out);
+	fputs(_(" -I, --init-string <string> set init string\n"), out);
+	fputs(_(" -l, --login-program <file> specify login program\n"), out);
+	fputs(_(" -L, --local-line           force local line\n"), out);
+	fputs(_(" -m, --extract-baud         extract baud rate during connect\n"), out);
+	fputs(_(" -n, --skip-login           do not prompt for login\n"), out);
+	fputs(_(" -o, --login-options <opts> options that are passed to login\n"), out);
+	fputs(_(" -p, --loginpause           wait for any key before the login\n"), out);
+	fputs(_(" -R, --hangup               do virtually hangup on the tty\n"), out);
+	fputs(_(" -s, --keep-baud            try to keep baud rate after break\n"), out);
+	fputs(_(" -t, --timeout <number>     login process timeout\n"), out);
+	fputs(_(" -U, --detect-case          detect uppercase terminal\n"), out);
+	fputs(_(" -w, --wait-cr              wait carriage-return\n"), out);
+	fputs(_("     --noclear              do not clear the screen before prompt\n"), out);
+	fputs(_("     --nohints              do not print hints\n"), out);
+	fputs(_("     --nonewline            do not print a newline before issue\n"), out);
+	fputs(_("     --no-hostname          no hostname at all will be shown\n"), out);
+	fputs(_("     --long-hostname        show full qualified hostname\n"), out);
+	fputs(_("     --erase-chars <string> additional backspace chars\n"), out);
+	fputs(_("     --kill-chars <string>  additional kill chars\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("agetty(8)"));
 
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
-- 
1.8.1.1

