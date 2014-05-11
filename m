Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:45418 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934102AbaEKT1H (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 May 2014 15:27:07 -0400
Received: by mail-wi0-f174.google.com with SMTP id r20so3491060wiv.7
        for <util-linux@vger.kernel.org>; Sun, 11 May 2014 12:27:06 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/12] build-sys: remove unnecessary void casts
Date: Sun, 11 May 2014 20:26:43 +0100
Message-Id: <1399836409-7769-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
References: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c |  2 +-
 term-utils/ttymsg.c | 26 +++++++++++++-------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index b7f9064..a862e55 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -275,7 +275,7 @@ static void mysyslog(int fd, int logflags, int pri, char *tag, char *msg)
 		       if (!cp)
 			       cp = "<someone>";
 	       }
-               (void)time(&now);
+	       time(&now);
 	       tp = ctime(&now)+4;
 
                snprintf(buf, sizeof(buf), "<%d>%.15s %.200s%s: %.400s",
diff --git a/term-utils/ttymsg.c b/term-utils/ttymsg.c
index 8bf993c..fb2614f 100644
--- a/term-utils/ttymsg.c
+++ b/term-utils/ttymsg.c
@@ -85,10 +85,10 @@ ttymsg(struct iovec *iov, size_t iovcnt, char *line, int tmout) {
 	   also wrong since people use /dev/pts/xxx. */
 
 	if (strlen(line) + sizeof(_PATH_DEV) + 1 > sizeof(device)) {
-		(void) sprintf(errbuf, _("excessively long line arg"));
+		sprintf(errbuf, _("excessively long line arg"));
 		return (errbuf);
 	}
-	(void) sprintf(device, "%s%s", _PATH_DEV, line);
+	sprintf(device, "%s%s", _PATH_DEV, line);
 
 	/*
 	 * open will fail on slip lines or exclusive-use lines
@@ -99,7 +99,7 @@ ttymsg(struct iovec *iov, size_t iovcnt, char *line, int tmout) {
 			return (NULL);
 		if (strlen(strerror(errno)) > 1000)
 			return (NULL);
-		(void) sprintf(errbuf, "%s: %m", device);
+		sprintf(errbuf, "%s: %m", device);
 		errbuf[1024] = 0;
 		return (errbuf);
 	}
@@ -134,32 +134,32 @@ ttymsg(struct iovec *iov, size_t iovcnt, char *line, int tmout) {
 			sigset_t sigmask;
 
 			if (forked) {
-				(void) close(fd);
+				close(fd);
 				_exit(EXIT_FAILURE);
 			}
 			cpid = fork();
 			if (cpid < 0) {
 				if (strlen(strerror(errno)) > 1000)
-					(void) sprintf(errbuf, _("cannot fork"));
+					sprintf(errbuf, _("cannot fork"));
 				else {
 					errsv = errno;
-					(void) sprintf(errbuf,
+					sprintf(errbuf,
 						 _("fork: %s"), strerror(errsv));
 				}
-				(void) close(fd);
+				close(fd);
 				return (errbuf);
 			}
 			if (cpid) {	/* parent */
-				(void) close(fd);
+				close(fd);
 				return (NULL);
 			}
 			forked++;
 			/* wait at most tmout seconds */
-			(void) signal(SIGALRM, SIG_DFL);
-			(void) signal(SIGTERM, SIG_DFL); /* XXX */
+			signal(SIGALRM, SIG_DFL);
+			signal(SIGTERM, SIG_DFL); /* XXX */
 			sigemptyset(&sigmask);
 			sigprocmask (SIG_SETMASK, &sigmask, NULL);
-			(void) alarm((u_int)tmout);
+			alarm((u_int)tmout);
 			flags = fcntl(fd, F_GETFL);
 			fcntl(flags, F_SETFL, (long) (flags & ~O_NONBLOCK));
 			continue;
@@ -175,11 +175,11 @@ ttymsg(struct iovec *iov, size_t iovcnt, char *line, int tmout) {
 		if (forked)
 			_exit(EXIT_FAILURE);
 		if (strlen(strerror(errno)) > 1000)
-			(void) sprintf(errbuf, _("%s: BAD ERROR, message is "
+			sprintf(errbuf, _("%s: BAD ERROR, message is "
 						 "far too long"), device);
 		else {
 			errsv = errno;
-			(void) sprintf(errbuf, "%s: %s", device,
+			sprintf(errbuf, "%s: %s", device,
 				       strerror(errsv));
 		}
 		errbuf[1024] = 0;
-- 
1.9.2

