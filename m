Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f42.google.com ([74.125.82.42]:54399 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbaD0UGY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Apr 2014 16:06:24 -0400
Received: by mail-wg0-f42.google.com with SMTP id k14so2861445wgh.1
        for <util-linux@vger.kernel.org>; Sun, 27 Apr 2014 13:06:23 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/12] lib/pager: use names when referring to standard file descriptors
Date: Sun, 27 Apr 2014 21:05:38 +0100
Message-Id: <1398629138-31718-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/pager.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/pager.c b/lib/pager.c
index c6e74e8..9e09cd5 100644
--- a/lib/pager.c
+++ b/lib/pager.c
@@ -63,10 +63,10 @@ static int start_command(struct child_process *cmd)
 	cmd->pid = fork();
 	if (!cmd->pid) {
 		if (need_in) {
-			dup2(fdin[0], 0);
+			dup2(fdin[0], STDIN_FILENO);
 			close_pair(fdin);
 		} else if (cmd->in > 0) {
-			dup2(cmd->in, 0);
+			dup2(cmd->in, STDIN_FILENO);
 			close(cmd->in);
 		}
 
@@ -134,7 +134,7 @@ static void pager_preexec(void)
 	fd_set in;
 
 	FD_ZERO(&in);
-	FD_SET(0, &in);
+	FD_SET(STDIN_FILENO, &in);
 	select(1, &in, NULL, &in, NULL);
 
 	setenv("LESS", "FRSX", 0);
@@ -145,8 +145,8 @@ static void wait_for_pager(void)
 	fflush(stdout);
 	fflush(stderr);
 	/* signal EOF to pager */
-	close(1);
-	close(2);
+	close(STDOUT_FILENO);
+	close(STDERR_FILENO);
 	finish_command(&pager_process);
 }
 
@@ -160,7 +160,7 @@ void setup_pager(void)
 {
 	const char *pager = getenv("PAGER");
 
-	if (!isatty(1))
+	if (!isatty(STDOUT_FILENO))
 		return;
 
 	if (!pager)
@@ -178,9 +178,9 @@ void setup_pager(void)
 		return;
 
 	/* original process continues, but writes to the pipe */
-	dup2(pager_process.in, 1);
-	if (isatty(2))
-		dup2(pager_process.in, 2);
+	dup2(pager_process.in, STDOUT_FILENO);
+	if (isatty(STDERR_FILENO))
+		dup2(pager_process.in, STDERR_FILENO);
 	close(pager_process.in);
 
 	/* this makes sure that the parent terminates after the pager */
-- 
1.9.2

