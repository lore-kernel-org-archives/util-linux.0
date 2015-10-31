Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37805 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbbJaTVn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 31 Oct 2015 15:21:43 -0400
Received: by wmff134 with SMTP id f134so33207969wmf.0
        for <util-linux@vger.kernel.org>; Sat, 31 Oct 2015 12:21:42 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 09/12] mkfs.minix: fix block device open race
Date: Sat, 31 Oct 2015 19:21:21 +0000
Message-Id: <1446319284-24778-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
References: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This fix makes mkfs.minix also to warn if block is misaligned.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.minix.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index f2a442e..5c94fbf 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -819,14 +819,11 @@ int main(int argc, char ** argv)
 	if (is_mounted(ctl.device_name))
 		errx(MKFS_EX_ERROR, _("%s is mounted; will not make a filesystem here!"),
 			ctl.device_name);
-	if (stat(ctl.device_name, &statbuf) < 0)
-		err(MKFS_EX_ERROR, _("stat of %s failed"), ctl.device_name);
-	if (S_ISBLK(statbuf.st_mode))
-		ctl.device_fd = open(ctl.device_name, O_RDWR | O_EXCL);
-	else
-		ctl.device_fd = open(ctl.device_name, O_RDWR);
+	ctl.device_fd = open_blkdev_or_file(ctl.device_name, O_RDWR);
 	if (ctl.device_fd < 0)
 		err(MKFS_EX_ERROR, _("cannot open %s"), ctl.device_name);
+	if (fstat(ctl.device_fd, &statbuf) < 0)
+		err(MKFS_EX_ERROR, _("stat of %s failed"), ctl.device_name);
 	determine_device_blocks(&ctl, &statbuf);
 	setup_tables(&ctl);
 	if (ctl.check_blocks)
-- 
2.6.2

