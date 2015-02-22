Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:32865 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbbBVOo3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:29 -0500
Received: by mail-wg0-f48.google.com with SMTP id l18so21217087wgh.7
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:28 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 18/31] more: split run time help screen to multiple translatable lines
Date: Sun, 22 Feb 2015 14:43:14 +0000
Message-Id: <1424616207-747-19-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 1afb593..3e7f5e7 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1344,31 +1344,31 @@ notfound:
 
 static void runtime_usage(void)
 {
-	fputs(_("\n"
-		"Most commands optionally preceded by integer argument k.  "
-		"Defaults in brackets.\n"
-		"Star (*) indicates argument becomes new default.\n"), stdout);
-	fputs(	"-------------------------------------------------------------------------------", stdout);
-	fputs(_("<space>                 Display next k lines of text [current screen size]\n"
-		"z                       Display next k lines of text [current screen size]*\n"
-		"<return>                Display next k lines of text [1]*\n"
-		"d or ctrl-D             Scroll k lines [current scroll size, initially 11]*\n"
-		"q or Q or <interrupt>   Exit from more\n"
-		"s                       Skip forward k lines of text [1]\n"
-		"f                       Skip forward k screenfuls of text [1]\n"
-		"b or ctrl-B             Skip backwards k screenfuls of text [1]\n"
-		"'                       Go to place where previous search started\n"
-		"=                       Display current line number\n"
-		"/<regular expression>   Search for kth occurrence of regular expression [1]\n"
-		"n                       Search for kth occurrence of last r.e [1]\n"
-		"!<cmd> or :!<cmd>       Execute <cmd> in a subshell\n"
-		"v                       Start up /usr/bin/vi at current line\n"
-		"ctrl-L                  Redraw screen\n"
-		":n                      Go to kth next file [1]\n"
-		":p                      Go to kth previous file [1]\n"
-		":f                      Display current file name and line number\n"
-		".                       Repeat previous command\n"), stdout);
-	fputs(	"-------------------------------------------------------------------------------", stdout);
+	fputs(  "\n", stdout);
+	fputs(_("Most commands optionally preceded by integer argument k.\n"), stdout);
+	fputs(_("Defaults in brackets.\n"), stdout);
+	fputs(_("Star (*) indicates argument becomes new default.\n"), stdout);
+	fputs(  "-------------------------------------------------------------------------------\n", stdout);
+	fputs(_("<space>                 Display next k lines of text [current screen size]\n"), stdout);
+	fputs(_("z                       Display next k lines of text [current screen size]*\n"), stdout);
+	fputs(_("<return>                Display next k lines of text [1]*\n"), stdout);
+	fputs(_("d or ctrl-D             Scroll k lines [current scroll size, initially 11]*\n"), stdout);
+	fputs(_("q or Q or <interrupt>   Exit from more\n"), stdout);
+	fputs(_("s                       Skip forward k lines of text [1]\n"), stdout);
+	fputs(_("f                       Skip forward k screenfuls of text [1]\n"), stdout);
+	fputs(_("b or ctrl-B             Skip backwards k screenfuls of text [1]\n"), stdout);
+	fputs(_("'                       Go to place where previous search started\n"), stdout);
+	fputs(_("=                       Display current line number\n"), stdout);
+	fputs(_("/<regular expression>   Search for kth occurrence of regular expression [1]\n"), stdout);
+	fputs(_("n                       Search for kth occurrence of last r.e [1]\n"), stdout);
+	fputs(_("!<cmd> or :!<cmd>       Execute <cmd> in a subshell\n"), stdout);
+	fputs(_("v                       Start up /usr/bin/vi at current line\n"), stdout);
+	fputs(_("ctrl-L                  Redraw screen\n"), stdout);
+	fputs(_(":n                      Go to kth next file [1]\n"), stdout);
+	fputs(_(":p                      Go to kth previous file [1]\n"), stdout);
+	fputs(_(":f                      Display current file name and line number\n"), stdout);
+	fputs(_(".                       Repeat previous command\n"), stdout);
+	fputs(  "-------------------------------------------------------------------------------\n", stdout);
 }
 
 static void execute_editor(struct more_control *ctl, char *cmdbuf, char *filename)
-- 
2.3.0

