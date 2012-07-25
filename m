Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:54496 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab2GYTPw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:15:52 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1068839wgb.1
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:15:51 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/19] mkswap: fix shadow declaration
Date: Wed, 25 Jul 2012 21:15:22 +0200
Message-Id: <1343243745-1172-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

disk-utils/mkswap.c:366:57: warning: declaration of 'is_blkdev' shadows a global declaration [-Wshadow]
./include/blkdev.h:92:5: warning: shadowed declaration is here [-Wshadow]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkswap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index ca49d0e..34fe687 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -363,7 +363,7 @@ new_prober(int fd)
 #endif
 
 static void
-wipe_device(int fd, const char *devname, int force, int is_blkdev)
+wipe_device(int fd, const char *devname, int force, int is_blkdevice)
 {
 	char *type = NULL;
 	int whole = 0;
@@ -375,7 +375,7 @@ wipe_device(int fd, const char *devname, int force, int is_blkdev)
 		if (lseek(fd, 0, SEEK_SET) != 0)
 			errx(EXIT_FAILURE, _("unable to rewind swap-device"));
 
-		if (is_blkdev && is_whole_disk_fd(fd, devname)) {
+		if (is_blkdevice && is_whole_disk_fd(fd, devname)) {
 			/* don't zap bootbits on whole disk -- we know nothing
 			 * about bootloaders on the device */
 			whole = 1;
-- 
1.7.11.3

