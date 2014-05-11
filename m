Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f49.google.com ([74.125.82.49]:40551 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934131AbaEKT1N (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 May 2014 15:27:13 -0400
Received: by mail-wg0-f49.google.com with SMTP id m15so6109052wgh.32
        for <util-linux@vger.kernel.org>; Sun, 11 May 2014 12:27:12 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/12] wall: replace magic number by named value
Date: Sun, 11 May 2014 20:26:45 +0100
Message-Id: <1399836409-7769-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
References: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/wall.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/term-utils/wall.c b/term-utils/wall.c
index 1bae9d6..3031a0e 100644
--- a/term-utils/wall.c
+++ b/term-utils/wall.c
@@ -69,7 +69,10 @@
 #include "fileutils.h"
 #include "closestream.h"
 
-#define WRITE_TIME_OUT	300		/* in seconds */
+enum {
+	TERM_WIDTH = 79,
+	WRITE_TIME_OUT = 300		/* in seconds */
+};
 
 /* Function prototypes */
 static char *makemsg(char *fname, char **mvec, int mvecsz,
@@ -225,14 +228,14 @@ static char *makemsg(char *fname, char **mvec, int mvecsz,
 		 */
 		/* snprintf is not always available, but the sprintf's here
 		   will not overflow as long as %d takes at most 100 chars */
-		fprintf(fp, "\r%79s\r\n", " ");
+		fprintf(fp, "\r%*s\r\n", TERM_WIDTH, " ");
 		sprintf(lbuf, _("Broadcast message from %s@%s (%s) (%s):"),
 			      whom, hostname, where, date);
-		fprintf(fp, "%-79.79s\007\007\r\n", lbuf);
+		fprintf(fp, "%-*.*s\007\007\r\n", TERM_WIDTH, TERM_WIDTH, lbuf);
 		free(hostname);
 		free(date);
 	}
-	fprintf(fp, "%79s\r\n", " ");
+	fprintf(fp, "%*s\r\n", TERM_WIDTH, " ");
 
 	 if (mvec) {
 		/*
@@ -274,8 +277,8 @@ static char *makemsg(char *fname, char **mvec, int mvecsz,
 		 */
 		while (fgets(lbuf, line_max, stdin)) {
 			for (cnt = 0, p = lbuf; (ch = *p) != '\0'; ++p, ++cnt) {
-				if (cnt == 79 || ch == '\n') {
-					for (; cnt < 79; ++cnt)
+				if (cnt == TERM_WIDTH || ch == '\n') {
+					for (; cnt < TERM_WIDTH; ++cnt)
 						putc(' ', fp);
 					putc('\r', fp);
 					putc('\n', fp);
@@ -288,7 +291,7 @@ static char *makemsg(char *fname, char **mvec, int mvecsz,
 			}
 		}
 	}
-	fprintf(fp, "%79s\r\n", " ");
+	fprintf(fp, "%*s\r\n", TERM_WIDTH, " ");
 
 	free(lbuf);
 	rewind(fp);
-- 
1.9.2

