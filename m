Return-Path: util-linux-owner@vger.kernel.org
Received: from kawka.in.waw.pl ([178.63.212.103]:45932 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753641Ab3DUOuw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 21 Apr 2013 10:50:52 -0400
From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: "Eric W. Biederman" <ebiederm@xmission.com>, util-linux@vger.kernel.org
Cc: systemd-devel@lists.freedesktop.org,
        =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [not-for-applying PATCH] nsenter: do not self-suspend if child is suspended
Date: Sun, 21 Apr 2013 10:50:19 -0400
Message-Id: <1366555819-9208-1-git-send-email-zbyszek@in.waw.pl>
In-Reply-To: <20130421144523.GW3394@in.waw.pl>
References: <20130421144523.GW3394@in.waw.pl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

nsenter would kill(self, SIGSTOP) when the child was stopped,
making it possible to use 'suspend -f' in the child shell to
suspend both the shell and the parent nsenter process. Unfortunately
this interferes with other uses of SIGSTOP, since nsenter process
is not visible in the child PID namespace and can be only resumed
from outside.
---
 sys-utils/nsenter.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index 106349c..5cef4bf 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -129,7 +129,6 @@ static void continue_as_child(void)
 {
 	pid_t child = fork();
 	int status;
-	pid_t ret;
 
 	if (child < 0)
 		err(EXIT_FAILURE, _("fork failed"));
@@ -138,16 +137,8 @@ static void continue_as_child(void)
 	if (child == 0)
 		return;
 
-	for (;;) {
-		ret = waitpid(child, &status, WUNTRACED);
-		if ((ret == child) && (WIFSTOPPED(status))) {
-			/* The child suspended so suspend us as well */
-			kill(getpid(), SIGSTOP);
-			kill(child, SIGCONT);
-		} else {
-			break;
-		}
-	}
+	waitpid(child, &status, 0);
+
 	/* Return the child's exit code if possible */
 	if (WIFEXITED(status)) {
 		exit(WEXITSTATUS(status));
-- 
1.8.2.562.g931e949

