Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63508 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab1JIDbl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Oct 2011 23:31:41 -0400
Received: by mail-vw0-f46.google.com with SMTP id 1so3945851vws.19
        for <util-linux@vger.kernel.org>; Sat, 08 Oct 2011 20:31:41 -0700 (PDT)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 2/2] mountpoint: fallback on stat when /proc isn't mounted
Date: Sat,  8 Oct 2011 23:31:51 -0400
Message-Id: <1318131111-30395-2-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1318131111-30395-1-git-send-email-dreisner@archlinux.org>
References: <1318131111-30395-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

mountpoint will fail when /proc isn't available, which lessens its
usefulness as a tool to detect mountpoints. In this case, mimic what
sysvinit's mountpoint tool does and compare the device and inode values
of root and specified target.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
Rationale: I think this patch is especially important for folks who are still
using sysvinit. Particularly in the case of a user not having an initramfs, the
userspace initscripts need to be able to detect, without fail, the presence of
/proc, /sys, and /dev being mounted (and mount them when they aren't). While
checking for /proc first and mounting it when mountpoint returns failure will
result in the correct action, it's reliant on broken behavior -- that is,
mountpoint returned false because /proc isn't mounted, not because /proc isn't
a mountpoint.

 sys-utils/mountpoint.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/sys-utils/mountpoint.c b/sys-utils/mountpoint.c
index 065d96b..1297d82 100644
--- a/sys-utils/mountpoint.c
+++ b/sys-utils/mountpoint.c
@@ -46,8 +46,19 @@ static dev_t dir_to_device(const char *spec)
 	struct libmnt_fs *fs;
 	dev_t res = (dev_t)-1;
 
-	if (!tb)
-		return (dev_t)-1;
+	if (!tb) {
+		struct stat root_st, spec_st;
+
+		/* fallback on using stat when /proc isn't available. return success when
+		 * we're examining different devices or encounter an exact match for the
+		 * root device */
+		if (stat(spec, &spec_st) == 0 && stat("/", &root_st) == 0 &&
+				root_st.st_dev != spec_st.st_dev ||
+				(root_st.st_dev == spec_st.st_dev && root_st.st_ino == spec_st.st_ino))
+			res = spec_st.st_dev;
+
+		return res;
+	}
 
 	fs = mnt_table_find_target(tb, spec, MNT_ITER_BACKWARD);
 	if (fs && mnt_fs_get_target(fs))
-- 
1.7.7

