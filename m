Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:55669 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbaEROGa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 18 May 2014 10:06:30 -0400
Received: by mail-we0-f173.google.com with SMTP id u57so4392849wes.4
        for <util-linux@vger.kernel.org>; Sun, 18 May 2014 07:06:29 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 17/17] setterm: add set_blanking() action
Date: Sun, 18 May 2014 15:05:41 +0100
Message-Id: <1400421941-14244-18-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This make over long perform_sequence() function a little bit shorter.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 57 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index ba175f9..90d193e 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -746,6 +746,40 @@ static int open_snapshot_device(struct setterm_control *ctl)
 	return fd;
 }
 
+static void set_blanking(struct setterm_control *ctl)
+{
+	char ioctlarg;
+	int ret;
+
+	if (0 <= ctl->opt_bl_min) {
+		printf("\033[9;%d]", ctl->opt_bl_min);
+		return;
+	}
+	switch (ctl->opt_bl_min) {
+	case BLANKSCREEN:
+		ioctlarg = TIOCL_BLANKSCREEN;
+		if (ioctl(STDIN_FILENO, TIOCLINUX, &ioctlarg))
+			warn(_("cannot force blank"));
+		break;
+	case UNBLANKSCREEN:
+		ioctlarg = TIOCL_UNBLANKSCREEN;
+		if (ioctl(STDIN_FILENO, TIOCLINUX, &ioctlarg))
+			warn(_("cannot force unblank"));
+		break;
+	case BLANKEDSCREEN:
+		ioctlarg = TIOCL_BLANKEDSCREEN;
+		ret = ioctl(STDIN_FILENO, TIOCLINUX, &ioctlarg);
+		if (ret < 0)
+			warn(_("cannot get blank status"));
+		else
+			printf("%d\n", ret);
+		break;
+	default:		/* should be impossible to reach */
+		abort();
+	}
+	return;
+}
+
 static void screendump(struct setterm_control *ctl)
 {
 	unsigned char header[4];
@@ -973,27 +1007,8 @@ static void perform_sequence(struct setterm_control *ctl)
 	}
 
 	/* -blank [0-60]. */
-	if (ctl->opt_blank && vc_only(ctl, "-blank")) {
-		if (ctl->opt_bl_min >= 0)
-			printf("\033[9;%d]", ctl->opt_bl_min);
-		else if (ctl->opt_bl_min == BLANKSCREEN) {
-			char ioctlarg = TIOCL_BLANKSCREEN;
-			if (ioctl(STDIN_FILENO, TIOCLINUX, &ioctlarg))
-				warn(_("cannot force blank"));
-		} else if (ctl->opt_bl_min == UNBLANKSCREEN) {
-			char ioctlarg = TIOCL_UNBLANKSCREEN;
-			if (ioctl(STDIN_FILENO, TIOCLINUX, &ioctlarg))
-				warn(_("cannot force unblank"));
-		} else if (ctl->opt_bl_min == BLANKEDSCREEN) {
-			char ioctlarg = TIOCL_BLANKEDSCREEN;
-			int ret;
-			ret = ioctl(STDIN_FILENO, TIOCLINUX, &ioctlarg);
-			if (ret < 0)
-				warn(_("cannot get blank status"));
-			else
-				printf("%d\n", ret);
-		}
-	}
+	if (ctl->opt_blank && vc_only(ctl, "-blank"))
+		set_blanking(ctl);
 
 	/* -powersave [on|vsync|hsync|powerdown|off] (console) */
 	if (ctl->opt_powersave) {
-- 
1.9.2

