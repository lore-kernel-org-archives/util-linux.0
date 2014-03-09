Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f169.google.com ([209.85.214.169]:54109 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbaCIUaf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Mar 2014 16:30:35 -0400
Received: by mail-ob0-f169.google.com with SMTP id va2so6138407obc.14
        for <util-linux@vger.kernel.org>; Sun, 09 Mar 2014 13:30:34 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/10] kill: move magic numbers in beginning of the file
Date: Sun,  9 Mar 2014 15:30:17 -0500
Message-Id: <1394397023-7050-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
References: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/kill.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index 877c24e..b95e03d 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -57,6 +57,11 @@
 #include "ttyutils.h"
 #include "xalloc.h"
 
+enum {
+	KILL_FIELD_WIDTH = 11,
+	KILL_OUTPUT_WIDTH = 72
+};
+
 struct signv {
 	const char *name;
 	int val;
@@ -388,15 +393,14 @@ static void printsig(int sig)
 	printf("%d\n", sig);
 }
 
-#define FIELD_WIDTH 11
 static void pretty_print_signal(FILE *fp, size_t term_width, size_t *lpos,
 				int signum, const char *name)
 {
-	if (term_width < (*lpos + FIELD_WIDTH)) {
+	if (term_width < (*lpos + KILL_FIELD_WIDTH)) {
 		fputc('\n', fp);
 		*lpos = 0;
 	}
-	*lpos += FIELD_WIDTH;
+	*lpos += KILL_FIELD_WIDTH;
 	fprintf(fp, "%2d %-8s", signum, name);
 }
 
@@ -407,7 +411,7 @@ static void printsignals(FILE *fp, int pretty)
 	if (!pretty) {
 		for (n = 0; n < ARRAY_SIZE(sys_signame); n++) {
 			lth = 1 + strlen(sys_signame[n].name);
-			if (72 < lpos + lth) {
+			if (KILL_OUTPUT_WIDTH < lpos + lth) {
 				fputc('\n', fp);
 				lpos = 0;
 			} else if (lpos)
@@ -424,7 +428,7 @@ static void printsignals(FILE *fp, int pretty)
 	/* pretty print */
 	width = get_terminal_width();
 	if (width == 0)
-		width = 72;
+		width = KILL_OUTPUT_WIDTH;
 	else
 		width -= 1;
 	for (n = 0; n < ARRAY_SIZE(sys_signame); n++)
-- 
1.9.0

