Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:57387 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbaL0RRn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 27 Dec 2014 12:17:43 -0500
Received: by mail-wi0-f180.google.com with SMTP id n3so18945898wiv.1
        for <util-linux@vger.kernel.org>; Sat, 27 Dec 2014 09:17:42 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>, Wolfgang Richter <wolf@cs.cmu.edu>,
        Ruediger Meier <ruediger.meier@ga-group.nl>
Subject: [PATCH 18/22] script: remove io vs signal race
Date: Sat, 27 Dec 2014 17:17:31 +0000
Message-Id: <1419700655-19107-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1419700655-19107-1-git-send-email-kerolasa@iki.fi>
References: <1419700655-19107-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Make do_io() to run poll() until all streams are empty.  This should
remove the signal from child versus io handling race for good.

Addresses: https://github.com/karelzak/util-linux/pull/62
CC: Wolfgang Richter <wolf@cs.cmu.edu>
CC: Ruediger Meier <ruediger.meier@ga-group.nl>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c  | 20 +++++++++++++-------
 tests/ts/script/race |  4 ----
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 4a761c6..2def44a 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -92,6 +92,7 @@ struct script_control {
 	FILE *timingfp;		/* timing file pointer */
 	int master;		/* pseudoterminal master file descriptor */
 	int slave;		/* pseudoterminal slave file descriptor */
+	int poll_timeout;	/* poll() timeout, used in end of execution */
 	pid_t child;		/* child pid */
 	int childstatus;	/* child process exit value */
 	struct termios tt;	/* slave terminal runtime attributes */
@@ -185,16 +186,11 @@ static void finish(struct script_control *ctl, int wait)
 {
 	int status;
 	pid_t pid;
-	int errsv = errno;
 	int options = wait ? 0 : WNOHANG;
 
 	while ((pid = wait3(&status, options, 0)) > 0)
-		if (pid == ctl->child) {
+		if (pid == ctl->child)
 			ctl->childstatus = status;
-			ctl->die = 1;
-		}
-
-	errno = errsv;
 }
 
 static void write_output(struct script_control *ctl, char *obuf,
@@ -250,13 +246,15 @@ static void do_io(struct script_control *ctl)
 
 	while (!ctl->die) {
 		/* wait for input or signal */
-		ret = poll(pfd, POLLFDS, -1);
+		ret = poll(pfd, POLLFDS, ctl->poll_timeout);
 		if (ret < 0) {
 			if (errno == EAGAIN)
 				continue;
 			warn(_("poll failed"));
 			fail(ctl);
 		}
+		if (ret == 0)
+			ctl->die = 1;
 		for (i = 0; i < POLLFDS; i++) {
 			if (pfd[i].revents == 0)
 				continue;
@@ -295,6 +293,13 @@ static void do_io(struct script_control *ctl)
 				switch (info.ssi_signo) {
 				case SIGCHLD:
 					finish(ctl, 0);
+					ctl->poll_timeout = 10;
+					if (!ctl->isterm)
+						/* In situation such as 'date' in
+						* $ echo date | ./script
+						* ignore input when shell has
+						* exited.  */
+						pfd[0].fd = -1;
 					break;
 				case SIGWINCH:
 					if (ctl->isterm) {
@@ -471,6 +476,7 @@ int main(int argc, char **argv)
 		.line = "/dev/ptyXX",
 #endif
 		.master = -1,
+		.poll_timeout = -1,
 		0
 	};
 	int ch;
diff --git a/tests/ts/script/race b/tests/ts/script/race
index c947402..103a14a 100755
--- a/tests/ts/script/race
+++ b/tests/ts/script/race
@@ -24,10 +24,6 @@ ts_init "$*"
 
 ts_check_test_command "$TS_CMD_SCRIPT"
 
-# TODO see comments about script design
-# https://github.com/karelzak/util-linux/pull/62
-TS_KNOWN_FAIL="yes"
-
 bingofile="$TS_OUTDIR/${TS_TESTNAME}-bingo"
 
 set -o pipefail
-- 
2.2.1

