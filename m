Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:56496 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934112AbaEKT1J (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 May 2014 15:27:09 -0400
Received: by mail-wi0-f181.google.com with SMTP id n15so3501549wiw.8
        for <util-linux@vger.kernel.org>; Sun, 11 May 2014 12:27:08 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/12] term-utils: avoid error message string length couting errors
Date: Sun, 11 May 2014 20:26:44 +0100
Message-Id: <1399836409-7769-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
References: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Remove various magic numbers with either a string lenght count, or a
symbolic variable that is recognized by gdb.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/ttymsg.c | 57 ++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/term-utils/ttymsg.c b/term-utils/ttymsg.c
index fb2614f..3a2565d 100644
--- a/term-utils/ttymsg.c
+++ b/term-utils/ttymsg.c
@@ -58,6 +58,8 @@
 #include "pathnames.h"
 #include "ttymsg.h"
 
+enum { ERR_BUFLEN = MAXNAMLEN + 1024 };
+
 /*
  * Display the contents of a uio structure on a terminal.  Used by wall(1),
  * syslogd(8), and talkd(8).  Forks and finishes in child if write would block,
@@ -68,14 +70,16 @@
 char *
 ttymsg(struct iovec *iov, size_t iovcnt, char *line, int tmout) {
 	static char device[MAXNAMLEN];
-	static char errbuf[MAXNAMLEN+1024];
+	static char errbuf[ERR_BUFLEN];
 	size_t cnt, left;
 	ssize_t wret;
 	struct iovec localiov[6];
-	int fd, forked = 0, errsv;
+	int fd, forked = 0;
 
-	if (iovcnt > sizeof(localiov) / sizeof(localiov[0]))
-		return (_("internal error: too many iov's"));
+	if (iovcnt > sizeof(localiov) / sizeof(localiov[0])) {
+		sprintf(errbuf, _("internal error: too many iov's"));
+		return errbuf;
+	}
 
 	/* The old code here rejected the line argument when it contained a '/',
 	   saying: "A slash may be an attempt to break security...".
@@ -86,7 +90,7 @@ ttymsg(struct iovec *iov, size_t iovcnt, char *line, int tmout) {
 
 	if (strlen(line) + sizeof(_PATH_DEV) + 1 > sizeof(device)) {
 		sprintf(errbuf, _("excessively long line arg"));
-		return (errbuf);
+		return errbuf;
 	}
 	sprintf(device, "%s%s", _PATH_DEV, line);
 
@@ -96,12 +100,13 @@ ttymsg(struct iovec *iov, size_t iovcnt, char *line, int tmout) {
 	 */
 	if ((fd = open(device, O_WRONLY|O_NONBLOCK, 0)) < 0) {
 		if (errno == EBUSY || errno == EACCES)
-			return (NULL);
-		if (strlen(strerror(errno)) > 1000)
-			return (NULL);
-		sprintf(errbuf, "%s: %m", device);
-		errbuf[1024] = 0;
-		return (errbuf);
+			return NULL;
+		if (strlen(device) + 2 + strlen(strerror(errno)) + 1 < ERR_BUFLEN)
+			sprintf(errbuf, "%s: %s", device, strerror(errno));
+		else
+			sprintf(errbuf, _("device open error message exceeded maximum length"));
+		errbuf[ERR_BUFLEN] = 0;
+		return errbuf;
 	}
 
 	for (cnt = left = 0; cnt < iovcnt; ++cnt)
@@ -139,19 +144,16 @@ ttymsg(struct iovec *iov, size_t iovcnt, char *line, int tmout) {
 			}
 			cpid = fork();
 			if (cpid < 0) {
-				if (strlen(strerror(errno)) > 1000)
-					sprintf(errbuf, _("cannot fork"));
-				else {
-					errsv = errno;
-					sprintf(errbuf,
-						 _("fork: %s"), strerror(errsv));
-				}
+				if (6 + strlen(strerror(errno)) + 1 < ERR_BUFLEN)
+					sprintf(errbuf, _("fork: %s"), strerror(errno));
+				else
+					sprintf(errbuf, _("cannot fork and error message length exceeded"));
 				close(fd);
-				return (errbuf);
+				return errbuf;
 			}
 			if (cpid) {	/* parent */
 				close(fd);
-				return (NULL);
+				return NULL;
 			}
 			forked++;
 			/* wait at most tmout seconds */
@@ -174,19 +176,16 @@ ttymsg(struct iovec *iov, size_t iovcnt, char *line, int tmout) {
 			warn(_("write failed: %s"), device);
 		if (forked)
 			_exit(EXIT_FAILURE);
-		if (strlen(strerror(errno)) > 1000)
+		if (strlen(device) + 2 + strlen(strerror(errno)) + 1 < ERR_BUFLEN)
+			sprintf(errbuf, "%s: %s", device, strerror(errno));
+		else
 			sprintf(errbuf, _("%s: BAD ERROR, message is "
 						 "far too long"), device);
-		else {
-			errsv = errno;
-			sprintf(errbuf, "%s: %s", device,
-				       strerror(errsv));
-		}
-		errbuf[1024] = 0;
-		return (errbuf);
+		errbuf[ERR_BUFLEN] = 0;
+		return errbuf;
 	}
 
 	if (forked)
 		_exit(EXIT_SUCCESS);
-	return (NULL);
+	return NULL;
 }
-- 
1.9.2

