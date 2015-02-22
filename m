Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f172.google.com ([74.125.82.172]:36838 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbbBVOoq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:46 -0500
Received: by wevk48 with SMTP id k48so13642903wev.3
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:46 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 28/31] more: speed up command_expansion()
Date: Sun, 22 Feb 2015 14:43:24 +0000
Message-Id: <1424616207-747-29-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Simply copy the command string if there is nothing to expand.

Additionally make variable names easier to understand in
command_expansion(), and remove possible buffer overflow in do_shell().

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 8cbc62f..84c2108 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -971,22 +971,25 @@ static void ttyin(struct more_control *ctl, char buf[], int nmax, char pchar)
 static int command_expansion(struct more_control *ctl, char **outbuf, char *inbuf)
 {
 	char *inpstr = inbuf;
+	char *allocation;
 	char *outstr;
 	char c;
-	char *temp;
 	int changed = 0;
-	int tempsz, xtra, offset;
+	size_t xtra;
+	ptrdiff_t offset;
 
-	xtra = strlen(ctl->fnames[ctl->argv_position]) + strlen(ctl->shell_line) + 1;
-	tempsz = 200 + xtra;
-	temp = xmalloc(tempsz);
-	outstr = temp;
+	if (!strpbrk(inbuf, "%!\\")) {
+		*outbuf = xstrdup(inbuf);
+		return 0;
+	}
+	xtra = strlen(ctl->fnames[ctl->argv_position]) + strlen(ctl->shell_line) + COMMAND_BUF + 1;
+	outstr = allocation = xmalloc(xtra);
 	while ((c = *inpstr++) != '\0') {
-		offset = outstr - temp;
-		if (tempsz - offset - 1 < xtra) {
-			tempsz += 200 + xtra;
-			temp = xrealloc(temp, tempsz);
-			outstr = temp + offset;
+		offset = outstr - allocation;
+		if (xtra - offset - 1 < xtra) {
+			xtra += COMMAND_BUF;
+			allocation = xrealloc(allocation, xtra);
+			outstr = allocation + offset;
 		}
 		switch (c) {
 		case '%':
@@ -1015,7 +1018,7 @@ static int command_expansion(struct more_control *ctl, char **outbuf, char *inbu
 		}
 	}
 	*outstr++ = '\0';
-	*outbuf = temp;
+	*outbuf = allocation;
 	return changed;
 }
 
@@ -1122,8 +1125,8 @@ static void do_shell(struct more_control *ctl, char *filename)
 		ttyin(ctl, cmdbuf, sizeof(cmdbuf) - 2, '!');
 		rc = command_expansion(ctl, &expanded, cmdbuf);
 		if (expanded) {
-			if (strlen(expanded) < sizeof(ctl->shell_line))
-				strcpy(ctl->shell_line, expanded);
+			if (strlen(expanded) < sizeof(ctl->shell_line) - 1)
+				xstrncpy(ctl->shell_line, expanded, sizeof ctl->shell_line);
 			else
 				rc = -1;
 			free(expanded);
-- 
2.3.0

