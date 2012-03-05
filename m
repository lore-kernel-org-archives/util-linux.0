Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58484 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757512Ab2CETjN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Mar 2012 14:39:13 -0500
Received: by mail-ey0-f174.google.com with SMTP id q12so1565228eaa.19
        for <util-linux@vger.kernel.org>; Mon, 05 Mar 2012 11:39:13 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/17] mesg: use rpmatch to yes/no question
Date: Mon,  5 Mar 2012 20:38:41 +0100
Message-Id: <1330976334-10751-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
References: <20120305123847.GD486@x2.net.home>
 <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/mesg.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/term-utils/mesg.c b/term-utils/mesg.c
index 13d4fb7..4fad6f5 100644
--- a/term-utils/mesg.c
+++ b/term-utils/mesg.c
@@ -66,6 +66,8 @@
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fputs(_("\nUsage:\n"), out);
+	/* TRANSLATORS: this program uses for y and n rpmatch(3),
+	 * which means they can be translated.  */
 	fprintf(out,
 	      _(" %s [options] [y | n]\n"), program_invocation_short_name);
 
@@ -127,8 +129,8 @@ int main(int argc, char *argv[])
 		return IS_NOT_ALLOWED;
 	}
 
-	switch (*argv[0]) {
-	case 'y':
+	switch (rpmatch(argv[0])) {
+	case 1:
 #ifdef USE_TTY_GROUP
 		if (chmod(tty, sb.st_mode | S_IWGRP) < 0)
 #else
@@ -138,14 +140,16 @@ int main(int argc, char *argv[])
 		if (verbose)
 			puts(_("write access to your terminal is allowed"));
 		return IS_ALLOWED;
-	case 'n':
+	case 0:
 		if (chmod(tty, sb.st_mode & ~(S_IWGRP|S_IWOTH)) < 0)
 			 err(MESG_EXIT_FAILURE, _("change %s mode failed"), tty);
 		if (verbose)
 			puts(_("write access to your terminal is denied"));
 		return IS_NOT_ALLOWED;
-	default:
-		warnx(_("invalid argument: %c"), *argv[0]);
+        case -1:
+		warnx(_("invalid argument: %s"), argv[0]);
 		usage(stderr);
+        default:
+                abort();
 	}
 }
-- 
1.7.9.2

