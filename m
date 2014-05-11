Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f49.google.com ([74.125.82.49]:42327 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934169AbaEKT1T (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 May 2014 15:27:19 -0400
Received: by mail-wg0-f49.google.com with SMTP id m15so6109100wgh.32
        for <util-linux@vger.kernel.org>; Sun, 11 May 2014 12:27:17 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/12] setterm: convert various constant number definitions to enums
Date: Sun, 11 May 2014 20:26:48 +0100
Message-Id: <1399836409-7769-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
References: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The enum strings are visible when using debugger.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index ef820b3..2de555e 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -141,28 +141,34 @@ extern int klogctl(int type, char *buf, int len);
 #define EXIT_DUMPFILE	-1
 
 /* Colors. */
-#define BLACK   0
-#define RED     1
-#define GREEN   2
-#define YELLOW  3
-#define BLUE    4
-#define MAGENTA 5
-#define CYAN    6
-#define WHITE   7
-#define GREY	8
-#define DEFAULT 9
+enum {
+	BLACK = 0,
+	RED,
+	GREEN,
+	YELLOW,
+	BLUE,
+	MAGENTA,
+	CYAN,
+	WHITE,
+	GREY,
+	DEFAULT
+};
 
 /* Blank commands */
-#define BLANKSCREEN	-1
-#define UNBLANKSCREEN	-2
-#define BLANKEDSCREEN	-3
+enum {
+	BLANKSCREEN	= -1,
+	UNBLANKSCREEN	= -2,
+	BLANKEDSCREEN	= -3
+};
 
 /* <linux/tiocl.h> fallback */
 #ifndef TIOCL_BLANKSCREEN
-# define TIOCL_UNBLANKSCREEN	4       /* unblank screen */
-# define TIOCL_SETVESABLANK	10      /* set vesa blanking mode */
-# define TIOCL_BLANKSCREEN	14	/* keep screen blank even if a key is pressed */
-# define TIOCL_BLANKEDSCREEN	15	/* return which vt was blanked */
+enum {
+	TIOCL_UNBLANKSCREEN	=  4,	/* unblank screen */
+	TIOCL_SETVESABLANK	= 10,	/* set vesa blanking mode */
+	TIOCL_BLANKSCREEN	= 14,	/* keep screen blank even if a key is pressed */
+	TIOCL_BLANKEDSCREEN	= 15	/* return which vt was blanked */
+};
 #endif
 
 /* Static variables. */
@@ -298,7 +304,7 @@ par_color(int argc, char **argv, int *option, int *opt_color, int *bad_arg) {
 		else
 			*bad_arg = TRUE;
 
-		if(*opt_color < 0 || *opt_color > 9 || *opt_color == 8)
+		if(*opt_color < BLACK || DEFAULT < *opt_color || *opt_color == GREY)
 			*bad_arg = TRUE;
 	}
 }
@@ -319,7 +325,7 @@ par_color2(int argc, char **argv, int *option, int *opt_color, int *bad_arg) {
 	*opt_color = 0;
 	if (argc == 2) {
 		if (strcmp(argv[0], "bright") == 0)
-			*opt_color = 8;
+			*opt_color = GREY;
 		else {
 			*bad_arg = TRUE;
 			return;
@@ -354,7 +360,7 @@ par_color2(int argc, char **argv, int *option, int *opt_color, int *bad_arg) {
 			*opt_color = atoi(argv[argc-1]);
 		else
 			*bad_arg = TRUE;
-		if(*opt_color < 0 || *opt_color > 15)
+		if(*opt_color < BLACK || DEFAULT < *opt_color )
 			*bad_arg = TRUE;
 	}
 }
-- 
1.9.2

