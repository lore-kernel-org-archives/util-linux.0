Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:58398 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbaL0RRp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 27 Dec 2014 12:17:45 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so18903278wid.15
        for <util-linux@vger.kernel.org>; Sat, 27 Dec 2014 09:17:44 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 20/22] script: move do_io() content to small functions
Date: Sat, 27 Dec 2014 17:17:33 +0000
Message-Id: <1419700655-19107-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1419700655-19107-1-git-send-email-kerolasa@iki.fi>
References: <1419700655-19107-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The do_io() got to be a bit long with relatively deep indentation.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c | 108 ++++++++++++++++++++++++++++------------------------
 1 file changed, 58 insertions(+), 50 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 6e11fa3..c1a9f5d 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -220,14 +220,63 @@ static void write_output(struct script_control *ctl, char *obuf,
 	}
 }
 
-static void do_io(struct script_control *ctl)
+static void handle_io(struct script_control *ctl, int fd, double *oldtime, int i)
 {
 	char buf[BUFSIZ];
+	ssize_t bytes;
+
+	bytes = read(fd, buf, sizeof(buf));
+	if (bytes < 0) {
+		if (errno == EAGAIN)
+			return;
+		fail(ctl);
+	}
+	if (i == 0) {
+		if (write_all(ctl->master, buf, bytes)) {
+			warn(_("write failed"));
+			fail(ctl);
+		} else
+			/* without sync write_output() will write both input &
+			 * shell output that looks like double echoing */
+			fdatasync(ctl->master);
+		if (!ctl->isterm && !feof(stdin)) {
+			int c = DEF_EOF;
+			write_all(ctl->master, &c, 1);
+		}
+	} else
+		write_output(ctl, buf, bytes, oldtime);
+}
+
+static void handle_signal(struct script_control *ctl, int fd)
+{
+	struct signalfd_siginfo info;
+	ssize_t bytes;
+
+	bytes = read(fd, &info, sizeof(info));
+	assert(bytes == sizeof(info));
+	switch (info.ssi_signo) {
+	case SIGCHLD:
+		finish(ctl, 0);
+		ctl->poll_timeout = 10;
+		return;
+	case SIGWINCH:
+		if (ctl->isterm) {
+			ioctl(STDIN_FILENO, TIOCGWINSZ, (char *)&ctl->win);
+			ioctl(ctl->slave, TIOCSWINSZ, (char *)&ctl->win);
+		}
+		break;
+	default:
+		abort();
+	}
+}
+
+static void do_io(struct script_control *ctl)
+{
 	struct pollfd pfd[POLLFDS];
 	int ret, i;
-	ssize_t bytes;
 	double oldtime = time(NULL);
 	time_t tvec = time((time_t *)NULL);
+	char buf[128];
 
 	if (ctl->tflg && !ctl->timingfp)
 		ctl->timingfp = fdopen(STDERR_FILENO, "w");
@@ -257,57 +306,16 @@ static void do_io(struct script_control *ctl)
 			if (pfd[i].revents == 0)
 				continue;
 			if (i < 2) {
-				bytes = read(pfd[i].fd, buf, BUFSIZ);
-				if (bytes < 0) {
-					if (errno == EAGAIN)
-						continue;
-					fail(ctl);
-				}
-				if (i == 0) {
-					if (write_all(ctl->master, buf, bytes)) {
-						warn(_("write failed"));
-						fail(ctl);
-					} else
-
-						/* without sync write_output()
-						 * will write both input &
-						 * shell output that looks like
-						 * double echoing */
-						fdatasync(ctl->master);
-					if (!ctl->isterm && !feof(stdin)) {
-						int c = DEF_EOF;
-						write_all(ctl->master, &c, 1);
-					}
-				} else
-					write_output(ctl, buf, bytes, &oldtime);
+				handle_io(ctl, pfd[i].fd, &oldtime, i);
 				continue;
 			}
 			if (i == 2) {
-				struct signalfd_siginfo info;
-				ssize_t bytes;
-
-				bytes = read(pfd[i].fd, &info, sizeof(info));
-				assert(bytes == sizeof(info));
-				switch (info.ssi_signo) {
-				case SIGCHLD:
-					finish(ctl, 0);
-					ctl->poll_timeout = 10;
-					if (!ctl->isterm)
-						/* In situation such as 'date' in
-						* $ echo date | ./script
-						* ignore input when shell has
-						* exited.  */
-						pfd[0].fd = -1;
-					break;
-				case SIGWINCH:
-					if (ctl->isterm) {
-						ioctl(STDIN_FILENO, TIOCGWINSZ, (char *)&ctl->win);
-						ioctl(ctl->slave, TIOCSWINSZ, (char *)&ctl->win);
-					}
-					break;
-				default:
-					abort();
-				}
+				handle_signal(ctl, pfd[i].fd);
+				if (!ctl->isterm && -1 < ctl->poll_timeout)
+					/* In situation such as 'date' in
+					* $ echo date | ./script
+					* ignore input when shell has exited.  */
+					pfd[0].fd = -1;
 			}
 		}
 	}
-- 
2.2.1

