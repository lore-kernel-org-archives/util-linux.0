Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42931 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755470Ab2CDVIm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 4 Mar 2012 16:08:42 -0500
Received: by vcqp1 with SMTP id p1so2861260vcq.19
        for <util-linux@vger.kernel.org>; Sun, 04 Mar 2012 13:08:42 -0800 (PST)
MIME-Version: 1.0
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] libmount: avoid infinite loop in child fs iteration
Date: Sun,  4 Mar 2012 16:08:39 -0500
Message-Id: <1330895319-1818-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In early userspace, the rootfs is mounted with itself as its parent.
Example /proc/self/mountinfo:

1 1 0:1 / / rw - rootfs rootfs rw
14 1 0:3 / /proc rw,nosuid,nodev,noexec,relatime - proc proc rw
15 1 0:13 / /sys rw,nosuid,nodev,noexec,relatime - sysfs sys rw
16 1 0:5 / /dev rw,nosuid,relatime - devtmpfs dev rw,size=506956k
17 1 0:14 / /run rw,nosuid,nodev,relatime - tmpfs run rw,mode=755

This causes an infinite loop in mnt_table_next_child_fs, and is
evidenced by a crash via infinite recursion in findmnt. Simply catch the
condition where the ID of the parent is the ID of the current fs we're
examining and skip over it to the next mount in the table.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 libmount/src/tab.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index 9992c9c..54d58c8 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -286,6 +286,11 @@ int mnt_table_next_child_fs(struct libmnt_table *tb, struct libmnt_iter *itr,
 
 		id = mnt_fs_get_id(fs);
 
+		/* avoid infinite loop. This only happens in rare cases
+		 * such as in early userspace when the rootfs is its own parent */
+		if (id == parent_id)
+			continue;
+
 		if ((!lastchld_id || id > lastchld_id) &&
 		    (!*chld || id < chld_id)) {
 			*chld = fs;
-- 
1.7.9.2

