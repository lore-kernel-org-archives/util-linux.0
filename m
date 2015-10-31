Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37451 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbbJaTVo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 31 Oct 2015 15:21:44 -0400
Received: by wicfv8 with SMTP id fv8so28975744wic.0
        for <util-linux@vger.kernel.org>; Sat, 31 Oct 2015 12:21:43 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 10/12] mkswap: fix block device open race
Date: Sat, 31 Oct 2015 19:21:22 +0000
Message-Id: <1446319284-24778-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
References: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkswap.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index c7166f7..02639ce 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -238,25 +238,16 @@ static void open_device(struct mkswap_control *ctl)
 	assert(ctl);
 	assert(ctl->devname);
 
-	if (stat(ctl->devname, &ctl->devstat) < 0)
-		err(EXIT_FAILURE, _("stat of %s failed"), ctl->devname);
-
-	if (S_ISBLK(ctl->devstat.st_mode))
-		ctl->fd = open(ctl->devname, O_RDWR | O_EXCL);
-	else {
-		if (ctl->check) {
-			ctl->check = 0;
-			warnx(_("warning: checking bad blocks from swap file is not supported: %s"),
-				ctl->devname);
-		}
-		ctl->fd = open(ctl->devname, O_RDWR);
-	}
+	ctl->fd = open_blkdev_or_file(ctl->devname, O_RDWR);
 	if (ctl->fd < 0)
 		err(EXIT_FAILURE, _("cannot open %s"), ctl->devname);
-
-	if (S_ISBLK(ctl->devstat.st_mode))
-		if (blkdev_is_misaligned(ctl->fd))
-			warnx(_("warning: %s is misaligned"), ctl->devname);
+	if (fstat(ctl->fd, &ctl->devstat) < 0)
+		err(EXIT_FAILURE, _("stat of %s failed"), ctl->devname);
+	if (ctl->check && S_ISREG(ctl->devstat.st_mode)) {
+		ctl->check = 0;
+		warnx(_("warning: checking bad blocks from swap file is not supported: %s"),
+		       ctl->devname);
+	}
 }
 
 static void wipe_device(struct mkswap_control *ctl)
-- 
2.6.2

