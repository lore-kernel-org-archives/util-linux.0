Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f176.google.com ([74.125.82.176]:32840 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbbCOMzN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 Mar 2015 08:55:13 -0400
Received: by wejb47 with SMTP id b47so20858834wej.0
        for <util-linux@vger.kernel.org>; Sun, 15 Mar 2015 05:55:12 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 7/8] logger: use errx() when checking user input
Date: Sun, 15 Mar 2015 12:54:53 +0000
Message-Id: <1426424094-25451-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
References: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Additionally inform in usage() the --msgid requires an argument.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index b007377..45d427e 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -684,7 +684,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	fputs(_("     --rfc3164            use the obsolete BSD syslog protocol\n"), out);
 	fputs(_("     --rfc5424[=<snip>]   use the syslog protocol (the default for remote);\n"
 		"                            <snip> can be notime, or notq, and/or nohost\n"), out);
-	fputs(_("     --msgid              set rfc5424 MSGID field, ignored for non-rfc5424 format\n"), out);
+	fputs(_("     --msgid <msgid>      set rfc5424 message id field\n"), out);
 	fputs(_(" -u, --socket <socket>    write to this Unix socket\n"), out);
 	fputs(_("     --socket-errors[=<on|off|auto>]\n"
 		"                          print connection errors when using Unix sockets\n"), out);
@@ -842,7 +842,7 @@ int main(int argc, char **argv)
 			break;
 		case OPT_MSGID:
 			if (strchr(optarg, ' '))
-				err(EXIT_FAILURE, _("--msgid cannot contain space"));
+				errx(EXIT_FAILURE, _("--msgid cannot contain space"));
 			ctl.msgid = optarg;
 			break;
 #ifdef HAVE_LIBSYSTEMD
-- 
2.3.2

