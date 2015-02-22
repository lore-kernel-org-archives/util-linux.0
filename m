Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f179.google.com ([74.125.82.179]:41880 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbbBVOoS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:18 -0500
Received: by wevm14 with SMTP id m14so13591739wev.8
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:17 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 13/31] more: move skipping backwards to a function from command()
Date: Sun, 22 Feb 2015 14:43:09 +0000
Message-Id: <1424616207-747-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The command() function is too long.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 73 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 0825cdb..a502716 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1403,6 +1403,34 @@ static void execute_editor(struct more_control *ctl, char *cmdbuf, char *filenam
 		execute(ctl, filename, editor, editor, cmdbuf, ctl->fnames[ctl->fnum], (char *)0);
 }
 
+static int skip_backwards(struct more_control *ctl, FILE *f, int nlines)
+{
+	int initline;
+
+	if (nlines == 0)
+		nlines++;
+	putchar('\r');
+	erasep(ctl, 0);
+	putchar('\n');
+	if (ctl->clreol)
+		my_putstring(ctl->eraseln);
+	printf(P_("...back %d page", "...back %d pages", nlines), nlines);
+	if (ctl->clreol)
+		my_putstring(ctl->eraseln);
+	putchar('\n');
+	initline = ctl->Currline - ctl->dlines * (nlines + 1);
+	if (!ctl->noscroll)
+		--initline;
+	if (initline < 0)
+		initline = 0;
+	set_pos_fseek(ctl, f, 0);
+	ctl->Currline = 0;	/* skiplns() will make Currline correct */
+	skiplns(ctl, initline, f);
+	if (!ctl->noscroll)
+		return ctl->dlines + 1;
+	return ctl->dlines;
+}
+
 /* Read a command and do it.  A command consists of an optional integer
  * argument followed by the command character.  Return the number of
  * lines to display in the next screenful.  If there is nothing more to
@@ -1445,46 +1473,13 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 			break;
 		case 'b':
 		case ctrl('B'):
-			{
-				int initline;
-
-				if (ctl->no_intty) {
-					fputc('\a', stderr);
-					return -1;
-				}
-
-				if (nlines == 0)
-					nlines++;
-
-				putchar('\r');
-				erasep(ctl, 0);
-				putchar('\n');
-				if (ctl->clreol)
-					my_putstring(ctl->eraseln);
-				printf(P_("...back %d page",
-					"...back %d pages", nlines),
-					nlines);
-				if (ctl->clreol)
-					my_putstring(ctl->eraseln);
-				putchar('\n');
-
-				initline = ctl->Currline - ctl->dlines * (nlines + 1);
-				if (!ctl->noscroll)
-					--initline;
-				if (initline < 0)
-					initline = 0;
-				set_pos_fseek(ctl, f, 0);
-				ctl->Currline = 0;	/* skiplns() will make Currline correct */
-				skiplns(ctl, initline, f);
-				if (!ctl->noscroll) {
-					retval = ctl->dlines + 1;
-					done = 1;
-					break;
-				}
-				retval = ctl->dlines;
-				done = 1;
-				break;
+			if (ctl->no_intty) {
+				fputc('\a', stderr);
+				return -1;
 			}
+			retval = skip_backwards(ctl, f, nlines);
+			done = 1;
+			break;
 		case ' ':
 		case 'z':
 			if (nlines == 0)
-- 
2.3.0

