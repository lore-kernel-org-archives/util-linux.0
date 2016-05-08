Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34145 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbcEHURX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 May 2016 16:17:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id n129so17427238wmn.1
        for <util-linux@vger.kernel.org>; Sun, 08 May 2016 13:17:23 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/2] setterm: deduplicate color optiong string parsing
Date: Sun,  8 May 2016 21:17:17 +0100
Message-Id: <1462738638-3141-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 94 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 41 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 594134a..cfe844f 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -98,7 +98,8 @@ enum {
 	CYAN,
 	WHITE,
 	GREY,
-	DEFAULT
+	DEFAULT,
+	NOT_FOUND
 };
 
 /* Blank commands */
@@ -178,28 +179,55 @@ struct setterm_control {
 	    opt_powerdown:1, opt_blength:1, opt_bfreq:1;
 };
 
+static int parse_color(const char *arg)
+{
+	switch (arg[0]) {
+	case 'b':
+		if (strcmp(arg, "black") == 0)
+			return BLACK;
+		if (strcmp(arg, "blue") == 0)
+			return BLUE;
+		break;
+	case 'c':
+		if (strcmp(arg, "cyan") == 0)
+			return CYAN;
+		break;
+	case 'd':
+		if (strcmp(arg, "default") == 0)
+			return DEFAULT;
+		break;
+	case 'g':
+		if (strcmp(arg, "green") == 0)
+			return GREEN;
+		if (strcmp(arg, "grey") == 0)
+			return GREY;
+		break;
+	case 'm':
+		if (strcmp(arg, "magenta") == 0)
+			return MAGENTA;
+		break;
+	case 'r':
+		if (strcmp(arg, "red") == 0)
+			return RED;
+		break;
+	case 'w':
+		if (strcmp(arg, "white") == 0)
+			return WHITE;
+		break;
+	case 'y':
+		if (strcmp(arg, "yellow") == 0)
+			return YELLOW;
+		break;
+	}
+	return NOT_FOUND;
+}
+
 static int parse_febg_color(const char *arg)
 {
-	int color;
-
-	if (strcmp(arg, "black") == 0)
-		return BLACK;
-	else if (strcmp(arg, "red") == 0)
-		return RED;
-	else if (strcmp(arg, "green") == 0)
-		return GREEN;
-	else if (strcmp(arg, "yellow") == 0)
-		return YELLOW;
-	else if (strcmp(arg, "blue") == 0)
-		return BLUE;
-	else if (strcmp(arg, "magenta") == 0)
-		return MAGENTA;
-	else if (strcmp(arg, "cyan") == 0)
-		return CYAN;
-	else if (strcmp(arg, "white") == 0)
-		return WHITE;
-	else if (strcmp(arg, "default") == 0)
-		return DEFAULT;
+	int color = parse_color(arg);
+
+	if (color != GREY && color != NOT_FOUND)
+		return color;
 	else
 		color = strtos32_or_err(arg, _("argument error"));
 	if (color < BLACK || DEFAULT < color || color == GREY)
@@ -219,26 +247,10 @@ static int parse_ulhb_color(char **argv, int *optind)
 		(*optind)++;
 	} else
 		color_name = argv[*optind - 1];
-
-	if (strcmp(color_name, "black") == 0)
-		color = BLACK;
-	else if (strcmp(color_name, "grey") == 0)
-		color = GREY;
-	else if (strcmp(color_name, "red") == 0)
-		color = RED;
-	else if (strcmp(color_name, "green") == 0)
-		color = GREEN;
-	else if (strcmp(color_name, "yellow") == 0)
-		color = YELLOW;
-	else if (strcmp(color_name, "blue") == 0)
-		color = BLUE;
-	else if (strcmp(color_name, "magenta") == 0)
-		color = MAGENTA;
-	else if (strcmp(color_name, "cyan") == 0)
-		color = CYAN;
-	else if (strcmp(color_name, "white") == 0)
-		color = WHITE;
-	else {
+	color = parse_color(color_name);
+	if (color == DEFAULT)
+		errx(EXIT_FAILURE, _("argument error: %s"), color_name);
+	if (color == NOT_FOUND) {
 		color = strtos32_or_err(color_name, _("argument error"));
 		if (color < BLACK || DEFAULT < color)
 			errx(EXIT_FAILURE, _("argument error: %s"), color_name);
-- 
2.8.2

