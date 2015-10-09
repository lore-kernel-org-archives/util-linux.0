Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36986 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbbJIXaU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 9 Oct 2015 19:30:20 -0400
Received: by wicfx3 with SMTP id fx3so85177515wic.0
        for <util-linux@vger.kernel.org>; Fri, 09 Oct 2015 16:30:19 -0700 (PDT)
From: James Clarke <jrtc27@jrtc27.com>
To: util-linux@vger.kernel.org
Cc: James Clarke <jrtc27@jrtc27.com>, bug-hurd@gnu.org
Subject: [PATCH] sulogin: Use fallback method on the Hurd for detecting consoles
Date: Sat, 10 Oct 2015 00:29:47 +0100
Message-Id: <1444433387-18784-1-git-send-email-jrtc27@jrtc27.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: James Clarke <jrtc27@jrtc27.com>
---
 login-utils/sulogin-consoles.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/login-utils/sulogin-consoles.c b/login-utils/sulogin-consoles.c
index 39d24d2..1b05b38 100644
--- a/login-utils/sulogin-consoles.c
+++ b/login-utils/sulogin-consoles.c
@@ -612,6 +612,14 @@ int detect_consoles(const char *device, int fallback, struct list_head *consoles
 #ifdef TIOCGDEV
 		unsigned int devnum;
 #endif
+#ifdef __GNU__
+		/*
+		 * The Hurd always gives st_rdev as 0, which causes this
+		 * method to select the first terminal it finds.
+		 */
+		close(fd);
+		goto fallback;
+#endif
 		DBG(dbgprint("trying device/fallback file descriptor"));
 
 		if (fstat(fd, &st) < 0) {
-- 
2.5.3

