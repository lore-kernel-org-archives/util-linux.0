Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:41560 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701Ab3DMTzn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:55:43 -0400
Received: by mail-we0-f174.google.com with SMTP id u12so2797031wey.5
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:55:42 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/33] agetty: check writing to a file was successful
Date: Sat, 13 Apr 2013 20:54:40 +0100
Message-Id: <1365882901-11429-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/agetty.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index a23cf6d..dd52f70 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -235,6 +235,9 @@ static void login_options_to_argv(char *argv[], int *argc, char *str, char *user
 static char *fakehost;
 
 #ifdef DEBUGGING
+#ifndef
+# define DEBUG_OUTPUT "/dev/ttyp0"
+#endif
 #define debug(s) do { fprintf(dbf,s); fflush(dbf); } while (0)
 FILE *dbf;
 #else
@@ -270,7 +273,7 @@ int main(int argc, char **argv)
 	sigaction(SIGINT, &sa, &sa_int);
 
 #ifdef DEBUGGING
-	dbf = fopen("/dev/ttyp0", "w");
+	dbf = fopen(DEBUG_OUTPUT, "w");
 	for (int i = 1; i < argc; i++)
 		debug(argv[i]);
 #endif				/* DEBUGGING */
@@ -420,6 +423,12 @@ int main(int argc, char **argv)
 				options.tty);
 	}
 
+#ifdef DEBUGGING
+	fprintf(dbf, "read %c\n", ch);
+	if (close_stream(dbf) != 0)
+		log_err("write failed: %s", DEBUG_OUTPUT);
+#endif
+
 	/* Let the login program take care of password validation. */
 	execv(options.login, login_argv);
 	log_err(_("%s: can't exec %s: %m"), options.tty, login_argv[0]);
-- 
1.8.2.1

