Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:58343 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbbBVOo1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:27 -0500
Received: by mail-wi0-f177.google.com with SMTP id bs8so11709151wib.4
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:26 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 16/31] more: remove unnecessary braces
Date: Sun, 22 Feb 2015 14:43:12 +0000
Message-Id: <1424616207-747-17-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 2813ce7..bf3ab9c 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -547,15 +547,12 @@ static int get_line(struct more_control *ctl, FILE *f, int *length)
 #endif
 		c = more_getc(ctl, f);
 	}
-	if (column >= ctl->Mcol && ctl->Mcol > 0) {
-		if (!ctl->Wrap) {
+	if (column >= ctl->Mcol && ctl->Mcol > 0)
+		if (!ctl->Wrap)
 			*p++ = '\n';
-		}
-	}
 	colflg = column == ctl->Mcol && ctl->fold_opt;
-	if (colflg && ctl->eatnl && ctl->Wrap) {
+	if (colflg && ctl->eatnl && ctl->Wrap)
 		*p++ = '\n';	/* simulate normal wrap */
-	}
 	*length = p - ctl->Line;
 	*p = 0;
 	return column;
@@ -567,9 +564,9 @@ static void erasep(struct more_control *ctl, int col)
 
 	if (ctl->promptlen == 0)
 		return;
-	if (ctl->hard) {
+	if (ctl->hard)
 		putchar('\n');
-	} else {
+	else {
 		if (col == 0)
 			putchar('\r');
 		if (!ctl->dumb && ctl->eraseln)
@@ -678,9 +675,9 @@ static void prompt(struct more_control *ctl, char *filename)
 		if (ctl->clreol)
 			my_putstring(ctl->eraseln);
 		ctl->promptlen += printf(_("--More--"));
-		if (filename != NULL) {
+		if (filename != NULL)
 			ctl->promptlen += printf(_("(Next file: %s)"), filename);
-		} else if (!ctl->no_intty) {
+		else if (!ctl->no_intty) {
 			ctl->promptlen +=
 			    printf("(%d%%)",
 				   (int)((ctl->file_pos * 100) / ctl->file_size));
@@ -846,9 +843,9 @@ static void ttyin(struct more_control *ctl, char buf[], int nmax, char pchar)
 		if (ctl->promptlen > maxlen)
 			maxlen = ctl->promptlen;
 		c = readch(ctl);
-		if (c == '\\') {
+		if (c == '\\')
 			slash++;
-		} else if (((cc_t) c == ctl->otty.c_cc[VERASE]) && !slash) {
+		else if (((cc_t) c == ctl->otty.c_cc[VERASE]) && !slash) {
 			if (sp > buf) {
 #ifdef HAVE_WIDECHAR
 				if (MB_CUR_MAX > 1) {
-- 
2.3.0

