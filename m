Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:37819 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbbBVOoa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:30 -0500
Received: by mail-wg0-f44.google.com with SMTP id k14so21310391wgh.3
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:29 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 19/31] more: tell in run time help what the 'v' will execute as editor
Date: Sun, 22 Feb 2015 14:43:15 +0000
Message-Id: <1424616207-747-20-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 3e7f5e7..524ce44 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1342,6 +1342,18 @@ notfound:
 	}
 }
 
+static char *find_editor(void)
+{
+	char *editor;
+
+	editor = getenv("VISUAL");
+	if (editor == NULL || *editor == '\0')
+		editor = getenv("EDITOR");
+	if (editor == NULL || *editor == '\0')
+		editor = _PATH_VI;
+	return editor;
+}
+
 static void runtime_usage(void)
 {
 	fputs(  "\n", stdout);
@@ -1361,8 +1373,8 @@ static void runtime_usage(void)
 	fputs(_("=                       Display current line number\n"), stdout);
 	fputs(_("/<regular expression>   Search for kth occurrence of regular expression [1]\n"), stdout);
 	fputs(_("n                       Search for kth occurrence of last r.e [1]\n"), stdout);
-	fputs(_("!<cmd> or :!<cmd>       Execute <cmd> in a subshell\n"), stdout);
-	fputs(_("v                       Start up /usr/bin/vi at current line\n"), stdout);
+	fputs(_("!<cmd> or :!<cmd>       Execute <cmd> in a subshell\n"), stdout);	fprintf(stdout, _(
+		"v                       Start up '%s' at current line\n"), find_editor());
 	fputs(_("ctrl-L                  Redraw screen\n"), stdout);
 	fputs(_(":n                      Go to kth next file [1]\n"), stdout);
 	fputs(_(":p                      Go to kth previous file [1]\n"), stdout);
@@ -1377,11 +1389,7 @@ static void execute_editor(struct more_control *ctl, char *cmdbuf, char *filenam
 	int n = (ctl->Currline - ctl->dlines <= 0 ? 1 : ctl->Currline - (ctl->dlines + 1) / 2);
 	int split = 0;
 
-	editor = getenv("VISUAL");
-	if (editor == NULL || *editor == '\0')
-		editor = getenv("EDITOR");
-	if (editor == NULL || *editor == '\0')
-		editor = _PATH_VI;
+	editor = find_editor();
 	p = strrchr(editor, '/');
 	if (p)
 		p++;
-- 
2.3.0

