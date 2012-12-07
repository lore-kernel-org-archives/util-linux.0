Return-Path: util-linux-owner@vger.kernel.org
Received: from charybdis-ext.suse.de ([195.135.221.2]:57588 "EHLO g231.suse.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753883Ab2LGIWI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 7 Dec 2012 03:22:08 -0500
From: Werner Fink <werner@suse.de>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Werner Fink <werner@suse.de>
Subject: [PATCH 3/5] sulogin: use alarm function to indicate if a timeout occurs
Date: Fri,  7 Dec 2012 09:00:56 +0100
Message-Id: <1354867258-14206-3-git-send-email-werner@suse.de>
In-Reply-To: <1354867258-14206-1-git-send-email-werner@suse.de>
References: <1354867258-14206-1-git-send-email-werner@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

A small change to use the alarm handler to indicate if a timeout occurs.

Signed-off-by: Werner Fink <werner@suse.de>
---
 login-utils/sulogin.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git login-utils/sulogin.c login-utils/sulogin.c
index db783a2..dbcc855 100644
--- login-utils/sulogin.c
+++ login-utils/sulogin.c
@@ -8,6 +8,7 @@
  *
  * Copyright (C) 1998-2003 Miquel van Smoorenburg.
  * Copyright (C) 2012 Karel Zak <kzak@redhat.com>
+ * Copyright (C) 2012 Werner Fink <werner@suse.de>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -60,12 +61,15 @@ struct sigaction saved_sigint;
 struct sigaction saved_sigtstp;
 struct sigaction saved_sigquit;
 
+static volatile sig_atomic_t alarm_rised;
+
 /*
  * Called at timeout.
  */
 static void alrm_handler(int sig __attribute__((unused)))
 {
-	return;
+	/* Timeout expired */
+	alarm_rised++;
 }
 
 static void mask_signal(int signal, void (*handler)(int),
@@ -594,17 +598,27 @@ int main(int argc, char **argv)
 	 * Ask for the password.
 	 */
 	while (pwd) {
+		int failed = 0;
 		if ((p = getpasswd(pwd->pw_passwd)) == NULL)
 			break;
 		if (pwd->pw_passwd[0] == 0 ||
-		    strcmp(crypt(p, pwd->pw_passwd), pwd->pw_passwd) == 0)
+		    strcmp(crypt(p, pwd->pw_passwd), pwd->pw_passwd) == 0) {
 			sushell(pwd);
+			failed++;
+		}
 		mask_signal(SIGQUIT, SIG_IGN, &saved_sigquit);
 		mask_signal(SIGTSTP, SIG_IGN, &saved_sigtstp);
 		mask_signal(SIGINT,  SIG_IGN, &saved_sigint);
-		fprintf(stderr, _("Login incorrect\n\n"));
+		if (failed) {
+		    fprintf(stderr, _("Can not execute su shell\n\n"));
+		    break;
+		} else
+		    fprintf(stderr, _("Login incorrect\n\n"));
 	}
 
+	if (alarm_rised)
+		fprintf(stderr, _("Timed out\n\n"));
+
 	/*
 	 * User pressed Control-D.
 	 */
-- 
1.7.10.4

