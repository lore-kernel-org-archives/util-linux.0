Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35783 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbcEHURZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 May 2016 16:17:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id e201so17484493wme.2
        for <util-linux@vger.kernel.org>; Sun, 08 May 2016 13:17:24 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/2] setterm: remove unnecessary translation string
Date: Sun,  8 May 2016 21:17:18 +0100
Message-Id: <1462738638-3141-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1462738638-3141-1-git-send-email-kerolasa@iki.fi>
References: <1462738638-3141-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index cfe844f..77aabb6 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -231,7 +231,7 @@ static int parse_febg_color(const char *arg)
 	else
 		color = strtos32_or_err(arg, _("argument error"));
 	if (color < BLACK || DEFAULT < color || color == GREY)
-		errx(EXIT_FAILURE, _("argument error: %s"), arg);
+		errx(EXIT_FAILURE, "%s: %s", _("argument error"), arg);
 	return color;
 }
 
@@ -249,11 +249,11 @@ static int parse_ulhb_color(char **argv, int *optind)
 		color_name = argv[*optind - 1];
 	color = parse_color(color_name);
 	if (color == DEFAULT)
-		errx(EXIT_FAILURE, _("argument error: %s"), color_name);
+		errx(EXIT_FAILURE, "%s: %s", _("argument error"), color_name);
 	if (color == NOT_FOUND) {
 		color = strtos32_or_err(color_name, _("argument error"));
 		if (color < BLACK || DEFAULT < color)
-			errx(EXIT_FAILURE, _("argument error: %s"), color_name);
+			errx(EXIT_FAILURE, "%s: %s", _("argument error"), color_name);
 	}
 	if (bright && (color == BLACK || color == GREY))
 		errx(EXIT_FAILURE, _("argument error: bright %s is not supported"), color_name);
@@ -291,7 +291,7 @@ static int parse_blank(char **argv, char *optarg, int *optind)
 
 		ret = strtos32_or_err(arg, _("argument error"));
 		if (ret < 0 || BLANK_MAX < ret)
-			errx(EXIT_FAILURE, _("argument error: %s"), arg);
+			errx(EXIT_FAILURE, "%s: %s", _("argument error"), arg);
 		return ret;
 	}
 }
@@ -308,7 +308,7 @@ static int parse_powersave(const char *arg)
 		return VESA_BLANK_MODE_POWERDOWN;
 	else if (strcmp(arg, "off") == 0)
 		return VESA_BLANK_MODE_OFF;
-	errx(EXIT_FAILURE, _("argument error: %s"), arg);
+	errx(EXIT_FAILURE, "%s: %s", _("argument error"), arg);
 }
 
 static int parse_msglevel(const char *arg)
@@ -317,7 +317,7 @@ static int parse_msglevel(const char *arg)
 
 	ret = strtos32_or_err(arg, _("argument error"));
 	if (ret < CONSOLE_LEVEL_MIN || CONSOLE_LEVEL_MAX < ret)
-		errx(EXIT_FAILURE, _("argument error: %s"), arg);
+		errx(EXIT_FAILURE, "%s: %s", _("argument error"), arg);
 	return ret;
 }
 
@@ -331,7 +331,7 @@ static int parse_snap(char **argv, char *optarg, int *optind)
 		return 0;
 	ret = strtos32_or_err(arg, _("argument error"));
 	if (ret < 1)
-		errx(EXIT_FAILURE, _("argument error: %s"), arg);
+		errx(EXIT_FAILURE, "%s: %s", _("argument error"), arg);
 	return ret;
 }
 
@@ -365,7 +365,7 @@ static int parse_regtabs(char **argv, char *optarg, int *optind)
 		return DEFAULT_TAB_LEN;
 	ret = strtos32_or_err(arg, _("argument error"));
 	if (ret < 1 || TABS_MAX < ret)
-		errx(EXIT_FAILURE, _("argument error: %s"), arg);
+		errx(EXIT_FAILURE, "%s: %s", _("argument error"), arg);
 	return ret;
 }
 
@@ -379,7 +379,7 @@ static int parse_blength(char **argv, char *optarg, int *optind)
 		return 0;
 	ret = strtos32_or_err(arg, _("argument error"));
 	if (ret < 0 || BLENGTH_MAX < ret)
-		errx(EXIT_FAILURE, _("argument error: %s"), arg);
+		errx(EXIT_FAILURE, "%s: %s", _("argument error"), arg);
 	return ret;
 }
 
-- 
2.8.2

