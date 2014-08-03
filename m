Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:57594 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbaHCOSB (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Aug 2014 10:18:01 -0400
Received: by mail-wi0-f174.google.com with SMTP id d1so3686967wiv.13
        for <util-linux@vger.kernel.org>; Sun, 03 Aug 2014 07:18:00 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 6/7] zramctl: fix mount point printout
Date: Sun,  3 Aug 2014 15:17:42 +0100
Message-Id: <1407075463-19586-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
References: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

See sample belo how a device mount point was printed without and with
full <device> path.  This change adds the mount point markup to the short
device name printout.

$ zramctl zram3
NAME  ALGORITHM DISKSIZE DATA COMPR TOTAL STREAMS MOUNTPOINT
zram3 lz4             1M   4K   62B    4K       1

$ zramctl /dev/zram3
NAME       ALGORITHM DISKSIZE DATA COMPR TOTAL STREAMS MOUNTPOINT
/dev/zram3 lz4             1M   4K   62B    4K       1 [SWAP]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/zramctl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
index 9c5b6ed..afbc0e8 100644
--- a/sys-utils/zramctl.c
+++ b/sys-utils/zramctl.c
@@ -294,7 +294,15 @@ static int fill_table_row(struct libscols_table *tb, struct zram *z)
 			char path[PATH_MAX] = { '\0' };
 			int fl;
 
-			check_mount_point(z->devname, &fl, path, sizeof(path));
+			if (!access(z->devname, F_OK))
+				check_mount_point(z->devname, &fl, path, sizeof(path));
+			else {
+				char *zdevpath;
+
+				xasprintf(&zdevpath, "/dev/%s", z->devname);
+				check_mount_point(zdevpath, &fl, path, sizeof(path));
+				free(zdevpath);
+			}
 			if (*path)
 				str = xstrdup(path);
 			break;
-- 
2.0.3

