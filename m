Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:44349 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197AbbBVOoR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:17 -0500
Received: by mail-wi0-f173.google.com with SMTP id bs8so11858549wib.0
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:16 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 12/31] more: move editor execution to a function from command()
Date: Sun, 22 Feb 2015 14:43:08 +0000
Message-Id: <1424616207-747-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The command() function is too long.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 72 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 34 insertions(+), 38 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 6b07d95..0825cdb 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1370,6 +1370,39 @@ static void runtime_usage(void)
 	fputs(	"-------------------------------------------------------------------------------", stdout);
 }
 
+static void execute_editor(struct more_control *ctl, char *cmdbuf, char *filename)
+{
+	char *editor, *p;
+	int n = (ctl->Currline - ctl->dlines <= 0 ? 1 : ctl->Currline - (ctl->dlines + 1) / 2);
+	int split = 0;
+
+	editor = getenv("VISUAL");
+	if (editor == NULL || *editor == '\0')
+		editor = getenv("EDITOR");
+	if (editor == NULL || *editor == '\0')
+		editor = _PATH_VI;
+	p = strrchr(editor, '/');
+	if (p)
+		p++;
+	else
+		p = editor;
+	/* Earlier: call vi +n file.  This also works for emacs.  POSIX:
+	 * call vi -c n file (when editor is vi or ex).  */
+	if (!strcmp(p, "vi") || !strcmp(p, "ex")) {
+		sprintf(cmdbuf, "-c %d", n);
+		split = 1;
+	} else
+		sprintf(cmdbuf, "+%d", n);
+	kill_line(ctl);
+	printf("%s %s %s", editor, cmdbuf, ctl->fnames[ctl->fnum]);
+	if (split) {
+		cmdbuf[2] = 0;
+		execute(ctl, filename, editor, editor,
+			cmdbuf, cmdbuf + 3, ctl->fnames[ctl->fnum], (char *)0);
+	} else
+		execute(ctl, filename, editor, editor, cmdbuf, ctl->fnames[ctl->fnum], (char *)0);
+}
+
 /* Read a command and do it.  A command consists of an optional integer
  * argument followed by the command character.  Return the number of
  * lines to display in the next screenful.  If there is nothing more to
@@ -1579,44 +1612,7 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 			break;
 		case 'v':	/* This case should go right before default */
 			if (!ctl->no_intty) {
-				/* Earlier: call vi +n file. This also
-				 * works for emacs.  POSIX: call vi -c n
-				 * file (when editor is vi or ex). */
-				char *editor, *p;
-				int n = (ctl->Currline - ctl->dlines <= 0 ? 1 :
-					 ctl->Currline - (ctl->dlines + 1) / 2);
-				int split = 0;
-
-				editor = getenv("VISUAL");
-				if (editor == NULL || *editor == '\0')
-					editor = getenv("EDITOR");
-				if (editor == NULL || *editor == '\0')
-					editor = _PATH_VI;
-
-				p = strrchr(editor, '/');
-				if (p)
-					p++;
-				else
-					p = editor;
-				if (!strcmp(p, "vi") || !strcmp(p, "ex")) {
-					sprintf(cmdbuf, "-c %d", n);
-					split = 1;
-				} else {
-					sprintf(cmdbuf, "+%d", n);
-				}
-
-				kill_line(ctl);
-				printf("%s %s %s", editor, cmdbuf,
-				       ctl->fnames[ctl->fnum]);
-				if (split) {
-					cmdbuf[2] = 0;
-					execute(ctl, filename, editor, editor,
-						cmdbuf, cmdbuf + 3,
-						ctl->fnames[ctl->fnum], (char *)0);
-				} else
-					execute(ctl, filename, editor, editor,
-						cmdbuf, ctl->fnames[ctl->fnum],
-						(char *)0);
+				execute_editor(ctl, cmdbuf, filename);
 				break;
 			}
 			/* fall through */
-- 
2.3.0

