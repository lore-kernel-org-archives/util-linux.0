Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48599 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964951Ab2B1Qpf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Feb 2012 11:45:35 -0500
Received: by mail-vx0-f174.google.com with SMTP id p1so2644946vcq.19
        for <util-linux@vger.kernel.org>; Tue, 28 Feb 2012 08:45:35 -0800 (PST)
MIME-Version: 1.0
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 05/13] sulogin: replace older signal() with sigaction()
Date: Tue, 28 Feb 2012 11:45:13 -0500
Message-Id: <1330447521-886-6-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This provides a more reliable means of saving and restoring signal
handlers and avoids ugly (invalid) function pointer assignments. This
also removes the #ifdef blocking usage of a GCC attribute, which is
widely used in the rest of the codebase.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 login-utils/sulogin.c |   55 +++++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index a444af1..27099ab 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -62,9 +62,9 @@
 static int timeout;
 static int profile;
 
-static void (*saved_sigint)  = SIG_DFL;
-static void (*saved_sigtstp) = SIG_DFL;
-static void (*saved_sigquit) = SIG_DFL;
+struct sigaction saved_sigint;
+struct sigaction saved_sigtstp;
+struct sigaction saved_sigquit;
 
 #ifndef IUCLC
 #  define IUCLC	0
@@ -142,13 +142,27 @@ out:
 /*
  *	Called at timeout.
  */
-static
-# ifdef __GNUC__
-void alrm_handler(int sig __attribute__((unused)))
-# else
-void alrm_handler(int sig)
-# endif
+static void alrm_handler(int sig __attribute__((unused)))
 {
+	return;
+}
+
+static void mask_signal(int signal, void (*handler)(int),
+		struct sigaction *origaction)
+{
+	struct sigaction newaction;
+
+	newaction.sa_handler = handler;
+	sigemptyset(&newaction.sa_mask);
+	newaction.sa_flags = 0;
+
+	sigaction(signal, NULL, origaction);
+	sigaction(signal, &newaction, NULL);
+}
+
+static void unmask_signal(int signal, struct sigaction *sa)
+{
+	sigaction(signal, sa, NULL);
 }
 
 /*
@@ -447,9 +461,9 @@ static void sushell(struct passwd *pwd)
 	 *	Try to execute a shell.
 	 */
 	setenv("SHELL", sushell, 1);
-	signal(SIGINT,  saved_sigint);
-	signal(SIGTSTP, saved_sigtstp);
-	signal(SIGQUIT, saved_sigquit);
+	unmask_signal(SIGINT, &saved_sigint);
+	unmask_signal(SIGTSTP, &saved_sigtstp);
+	unmask_signal(SIGQUIT, &saved_sigquit);
 #ifdef WITH_SELINUX
 	if (is_selinux_enabled() > 0) {
 		security_context_t scon=NULL;
@@ -493,6 +507,7 @@ int main(int argc, char **argv)
 	int c, fd = -1;
 	int opt_e = 0;
 	pid_t pid, pgrp, ppgrp, ttypgrp;
+	struct sigaction saved_sighup;
 
 	/*
 	 *	See if we have a timeout flag.
@@ -524,9 +539,9 @@ int main(int argc, char **argv)
 	/*
 	 *	See if we need to open an other tty device.
 	 */
-	saved_sigint  = signal(SIGINT,  SIG_IGN);
-	saved_sigtstp = signal(SIGQUIT, SIG_IGN);
-	saved_sigquit = signal(SIGTSTP, SIG_IGN);
+	mask_signal(SIGQUIT, SIG_IGN, &saved_sigquit);
+	mask_signal(SIGTSTP, SIG_IGN, &saved_sigtstp);
+	mask_signal(SIGINT,  SIG_IGN, &saved_sigint);
 	if (optind < argc)
 		tty = argv[optind];
 
@@ -558,10 +573,10 @@ int main(int argc, char **argv)
 					setsid();
 				}
 
-				signal(SIGHUP, SIG_IGN);
+				sigaction(SIGHUP, NULL, &saved_sighup);
 				if (ttypgrp > 0)
 					ioctl(0, TIOCNOTTY, (char *)1);
-				signal(SIGHUP, SIG_DFL);
+				sigaction(SIGHUP, &saved_sighup, NULL);
 				close(0);
 				close(1);
 				close(2);
@@ -610,9 +625,9 @@ int main(int argc, char **argv)
 		if (pwd->pw_passwd[0] == 0 ||
 		    strcmp(crypt(p, pwd->pw_passwd), pwd->pw_passwd) == 0)
 			sushell(pwd);
-		saved_sigquit = signal(SIGQUIT, SIG_IGN);
-		saved_sigtstp = signal(SIGTSTP, SIG_IGN);
-		saved_sigint  = signal(SIGINT,  SIG_IGN);
+		mask_signal(SIGQUIT, SIG_IGN, &saved_sigquit);
+		mask_signal(SIGTSTP, SIG_IGN, &saved_sigtstp);
+		mask_signal(SIGINT,  SIG_IGN, &saved_sigint);
 		printf("Login incorrect.\n");
 	}
 
-- 
1.7.9.2

