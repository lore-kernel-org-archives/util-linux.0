Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:52047 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497AbbGBKKV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 2 Jul 2015 06:10:21 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0MVvi4-1ZYuhf1uNE-00X312 for
 <util-linux@vger.kernel.org>; Thu, 02 Jul 2015 12:10:19 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] script: evaluate errno only if read() sets it
Date: Thu,  2 Jul 2015 12:10:17 +0200
Message-Id: <1435831817-13227-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <201507021206.47499.sweet_f_a@gmx.de>
References: <201507021206.47499.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 term-utils/script.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 9fdef2e..75881a6 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -322,7 +322,6 @@ static void handle_io(struct script_control *ctl, int fd, int *eof)
 
 	DBG(IO, ul_debug("%d FD active", fd));
 	*eof = 0;
-	errno = 0;
 
 	/* read from active FD */
 	bytes = read(fd, buf, sizeof(buf));
@@ -334,8 +333,7 @@ static void handle_io(struct script_control *ctl, int fd, int *eof)
 	}
 
 	if (bytes == 0) {
-		if (errno == 0)
-			*eof = 1;
+		*eof = 1;
 		return;
 	}
 
@@ -367,7 +365,7 @@ static void handle_signal(struct script_control *ctl, int fd)
 
 	bytes = read(fd, &info, sizeof(info));
 	if (bytes != sizeof(info)) {
-		if (errno == EAGAIN)
+		if (bytes < 0 && errno == EAGAIN)
 			return;
 		fail(ctl);
 	}
@@ -463,7 +461,7 @@ static void do_io(struct script_control *ctl)
 					handle_io(ctl, pfd[i].fd, &eof);
 				/* EOF maybe detected by two ways:
 				 *	A) poll() return POLLHUP event after close()
-				 *	B) read() returns no error and no data */
+				 *	B) read() returns 0 (no data) */
 				if ((pfd[i].revents & POLLHUP) || eof) {
 					DBG(POLL, ul_debug(" ignore FD"));
 					pfd[i].fd = -1;
-- 
1.8.4.5

