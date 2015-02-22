Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f177.google.com ([74.125.82.177]:37287 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbbBVOoQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:16 -0500
Received: by wesw55 with SMTP id w55so13660259wes.4
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:15 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 11/31] more: move runtime usage output away from command()
Date: Sun, 22 Feb 2015 14:43:07 +0000
Message-Id: <1424616207-747-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The command() function is too long.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 58 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index c8b28a1..6b07d95 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1341,6 +1341,35 @@ notfound:
 	}
 }
 
+static void runtime_usage(void)
+{
+	fputs(_("\n"
+		"Most commands optionally preceded by integer argument k.  "
+		"Defaults in brackets.\n"
+		"Star (*) indicates argument becomes new default.\n"), stdout);
+	fputs(	"-------------------------------------------------------------------------------", stdout);
+	fputs(_("<space>                 Display next k lines of text [current screen size]\n"
+		"z                       Display next k lines of text [current screen size]*\n"
+		"<return>                Display next k lines of text [1]*\n"
+		"d or ctrl-D             Scroll k lines [current scroll size, initially 11]*\n"
+		"q or Q or <interrupt>   Exit from more\n"
+		"s                       Skip forward k lines of text [1]\n"
+		"f                       Skip forward k screenfuls of text [1]\n"
+		"b or ctrl-B             Skip backwards k screenfuls of text [1]\n"
+		"'                       Go to place where previous search started\n"
+		"=                       Display current line number\n"
+		"/<regular expression>   Search for kth occurrence of regular expression [1]\n"
+		"n                       Search for kth occurrence of last r.e [1]\n"
+		"!<cmd> or :!<cmd>       Execute <cmd> in a subshell\n"
+		"v                       Start up /usr/bin/vi at current line\n"
+		"ctrl-L                  Redraw screen\n"
+		":n                      Go to kth next file [1]\n"
+		":p                      Go to kth previous file [1]\n"
+		":f                      Display current file name and line number\n"
+		".                       Repeat previous command\n"), stdout);
+	fputs(	"-------------------------------------------------------------------------------", stdout);
+}
+
 /* Read a command and do it.  A command consists of an optional integer
  * argument followed by the command character.  Return the number of
  * lines to display in the next screenful.  If there is nothing more to
@@ -1545,34 +1574,7 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 		case 'h':
 			if (ctl->noscroll)
 				doclear(ctl);
-			fputs(_("\n"
-				  "Most commands optionally preceded by integer argument k.  "
-				  "Defaults in brackets.\n"
-				  "Star (*) indicates argument becomes new default.\n"), stdout);
-			fputs("---------------------------------------"
-			     "----------------------------------------", stdout);
-			fputs(_
-				("<space>                 Display next k lines of text [current screen size]\n"
-				 "z                       Display next k lines of text [current screen size]*\n"
-				 "<return>                Display next k lines of text [1]*\n"
-				 "d or ctrl-D             Scroll k lines [current scroll size, initially 11]*\n"
-				 "q or Q or <interrupt>   Exit from more\n"
-				 "s                       Skip forward k lines of text [1]\n"
-				 "f                       Skip forward k screenfuls of text [1]\n"
-				 "b or ctrl-B             Skip backwards k screenfuls of text [1]\n"
-				 "'                       Go to place where previous search started\n"
-				 "=                       Display current line number\n"
-				 "/<regular expression>   Search for kth occurrence of regular expression [1]\n"
-				 "n                       Search for kth occurrence of last r.e [1]\n"
-				 "!<cmd> or :!<cmd>       Execute <cmd> in a subshell\n"
-				 "v                       Start up /usr/bin/vi at current line\n"
-				 "ctrl-L                  Redraw screen\n"
-				 ":n                      Go to kth next file [1]\n"
-				 ":p                      Go to kth previous file [1]\n"
-				 ":f                      Display current file name and line number\n"
-				 ".                       Repeat previous command\n"), stdout);
-			fputs("---------------------------------------"
-			      "----------------------------------------", stdout);
+			runtime_usage();
 			prompt(ctl, filename);
 			break;
 		case 'v':	/* This case should go right before default */
-- 
2.3.0

