Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:41128 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163Ab2HFPW1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Aug 2012 11:22:27 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] eject: return proper 0/1 from eject_cdrom()
Date: Mon,  6 Aug 2012 11:16:12 -0400
Message-Id: <1344266172-8818-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

main() expects this method to return 0 for failure and 1 for success, as
the other eject_*() methods do. Add the missing comparison of ioctl() >= 0

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 sys-utils/eject.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 08af08e..84bd342 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -398,9 +398,9 @@ static void close_tray(int fd)
 static int eject_cdrom(int fd)
 {
 #if defined(CDROMEJECT)
-	return ioctl(fd, CDROMEJECT);
+	return ioctl(fd, CDROMEJECT) >= 0;
 #elif defined(CDIOCEJECT)
-	return ioctl(fd, CDIOCEJECT);
+	return ioctl(fd, CDIOCEJECT) >= 0;
 #else
 	warnx(_("CD-ROM eject unsupported"));
 	errno = ENOSYS;
-- 
1.7.11.4

