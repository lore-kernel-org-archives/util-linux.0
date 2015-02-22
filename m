Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f50.google.com ([74.125.82.50]:62799 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbbBVOnH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:43:07 -0500
Received: by mail-wg0-f50.google.com with SMTP id l2so21151349wgh.9
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:43:05 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>, Wolfgang Richter <wolf@cs.cmu.edu>,
        Ruediger Meier <ruediger.meier@ga-group.nl>
Subject: [PATCH 03/12] script: use signalfd() to catch signals
Date: Sun, 22 Feb 2015 14:42:40 +0000
Message-Id: <1424616169-693-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
References: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is incomplete change.  Working command requires the subsequent
select() to poll() change as well.

Addresses: https://github.com/karelzak/util-linux/pull/62
CC: Wolfgang Richter <wolf@cs.cmu.edu>
CC: Ruediger Meier <ruediger.meier@ga-group.nl>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c | 47 ++++++++++++++---------------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 3d47362..0f27163 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -63,6 +63,8 @@
 #include <stddef.h>
 #include <sys/wait.h>
 #include <poll.h>
+#include <sys/signalfd.h>
+#include <assert.h>
 
 #include "closestream.h"
 #include "nls.h"
@@ -106,8 +108,8 @@ struct script_control {
 	 isterm:1,		/* is child process running as terminal */
 	 resized:1,		/* has terminal been resized */
 	 die:1;			/* terminate program */
-	sigset_t block_mask;	/* signals that are blocked */
-	sigset_t unblock_mask;	/* original signal mask */
+	sigset_t sigset;	/* catch SIGCHLD and SIGWINCH with signalfd() */
+	int sigfd;		/* file descriptor for signalfd() */
 };
 struct script_control *gctl;	/* global control structure, used in signal handlers */
 
@@ -248,16 +250,13 @@ static void doinput(struct script_control *ctl)
 
 	FD_ZERO(&readfds);
 
-	/* block SIGCHLD */
-	sigprocmask(SIG_SETMASK, &ctl->block_mask, &ctl->unblock_mask);
-
 	while (!ctl->die) {
 		FD_SET(STDIN_FILENO, &readfds);
 
 		errno = 0;
 		/* wait for input or signal (including SIGCHLD) */
 		if ((cc = pselect(STDIN_FILENO + 1, &readfds, NULL, NULL, NULL,
-				  &ctl->unblock_mask)) > 0) {
+				  NULL)) > 0) {
 
 			if ((cc = read(STDIN_FILENO, ibuf, BUFSIZ)) > 0) {
 				if (write_all(ctl->master, ibuf, cc)) {
@@ -281,9 +280,6 @@ static void doinput(struct script_control *ctl)
 		}
 	}
 
-	/* unblock SIGCHLD */
-	sigprocmask(SIG_SETMASK, &ctl->unblock_mask, NULL);
-
 	/* To be sure that we don't miss any data */
 	wait_for_empty_fd(ctl, ctl->slave);
 	wait_for_empty_fd(ctl, ctl->master);
@@ -352,29 +348,24 @@ static void dooutput(struct script_control *ctl)
 	do {
 		if (ctl->die || errsv == EINTR) {
 			struct pollfd fds[] = {
+				{.fd = ctl->sigfd, .events = POLLIN | POLLERR | POLLHUP},
 				{.fd = ctl->master, .events = POLLIN}
 			};
 			if (poll(fds, 1, 50) <= 0)
 				break;
 		}
 
-		/* block SIGCHLD */
-		sigprocmask(SIG_SETMASK, &ctl->block_mask, &ctl->unblock_mask);
-
 		FD_SET(ctl->master, &readfds);
 		errno = 0;
 
 		/* wait for input or signal (including SIGCHLD) */
 		if ((cc = pselect(ctl->master + 1, &readfds, NULL, NULL, NULL,
-				  &ctl->unblock_mask)) > 0) {
+				  NULL)) > 0) {
 
 			cc = read(ctl->master, obuf, sizeof(obuf));
 		}
 		errsv = errno;
 
-		/* unblock SIGCHLD */
-		sigprocmask(SIG_SETMASK, &ctl->unblock_mask, NULL);
-
 		if (ctl->tflg)
 			gettimeofday(&tv, NULL);
 
@@ -565,7 +556,6 @@ int main(int argc, char **argv)
 		.master = -1,
 		0
 	};
-	struct sigaction sa;
 	int ch;
 
 	enum { FORCE_OPTION = CHAR_MAX + 1 };
@@ -653,20 +643,16 @@ int main(int argc, char **argv)
 #ifdef HAVE_LIBUTEMPTER
 	utempter_add_record(master, NULL);
 #endif
-	/* setup SIGCHLD handler */
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags = 0;
-	sa.sa_handler = sig_finish;
-	sigaction(SIGCHLD, &sa, NULL);
-
-	/* init mask for SIGCHLD */
-	sigprocmask(SIG_SETMASK, NULL, &ctl.block_mask);
-	sigaddset(&ctl.block_mask, SIGCHLD);
+	/* setup signal handler */
+	assert(sigemptyset(&ctl.sigset) == 0);
+	assert(sigaddset(&ctl.sigset, SIGCHLD) == 0);
+	assert(sigaddset(&ctl.sigset, SIGWINCH) == 0);
+	assert(sigprocmask(SIG_BLOCK, &ctl.sigset, NULL) == 0);
+	if ((ctl.sigfd = signalfd(-1, &ctl.sigset, 0)) < 0)
+		err(EXIT_FAILURE, _("cannot set signal handler"));
 
 	fflush(stdout);
-	sigprocmask(SIG_SETMASK, &ctl.block_mask, &ctl.unblock_mask);
 	ctl.child = fork();
-	sigprocmask(SIG_SETMASK, &ctl.unblock_mask, NULL);
 
 	if (ctl.child < 0) {
 		warn(_("fork failed"));
@@ -674,9 +660,7 @@ int main(int argc, char **argv)
 	}
 	if (ctl.child == 0) {
 
-		sigprocmask(SIG_SETMASK, &ctl.block_mask, NULL);
 		ctl.subchild = ctl.child = fork();
-		sigprocmask(SIG_SETMASK, &ctl.unblock_mask, NULL);
 
 		if (ctl.child < 0) {
 			warn(_("fork failed"));
@@ -686,9 +670,6 @@ int main(int argc, char **argv)
 			dooutput(&ctl);
 		else
 			doshell(&ctl);
-	} else {
-		sa.sa_handler = resize;
-		sigaction(SIGWINCH, &sa, NULL);
 	}
 	doinput(&ctl);
 
-- 
2.3.0

