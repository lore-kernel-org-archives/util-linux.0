Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:57324 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbaJOVTh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 15 Oct 2014 17:19:37 -0400
Received: by mail-wi0-f179.google.com with SMTP id d1so3065716wiv.12
        for <util-linux@vger.kernel.org>; Wed, 15 Oct 2014 14:19:36 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/4] eject: move unreachable code to preprocessor #else block [smatch scan]
Date: Wed, 15 Oct 2014 22:19:25 +0100
Message-Id: <1413407968-2289-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

eject.c:466 toggle_tray() info: ignoring unreachable code.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/eject.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 91f1102..860610f 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -433,9 +433,6 @@ static int eject_cdrom(int fd)
  */
 static void toggle_tray(int fd)
 {
-	struct timeval time_start, time_stop;
-	int time_elapsed;
-
 #ifdef CDROM_DRIVE_STATUS
 	/* First ask the CDROM for info, otherwise fall back to manual.  */
 	switch (ioctl(fd, CDROM_DRIVE_STATUS)) {
@@ -457,7 +454,9 @@ static void toggle_tray(int fd)
 	default:
 		abort();
 	}
-#endif
+#else
+	struct timeval time_start, time_stop;
+	int time_elapsed;
 
 	/* Try to open the CDROM tray and measure the time therefor
 	 * needed.  In my experience the function needs less than 0.05
@@ -481,6 +480,7 @@ static void toggle_tray(int fd)
 	 * closed before. This would mean that we are done.  */
 	if (time_elapsed < TRAY_WAS_ALREADY_OPEN_USECS)
 		close_tray(fd);
+#endif
 }
 
 /*
-- 
2.1.2

