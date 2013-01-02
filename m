Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:32904 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709Ab3ABOLN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 2 Jan 2013 09:11:13 -0500
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] mount.8: document options for debugfs
Date: Wed,  2 Jan 2013 09:11:10 -0500
Message-Id: <1357135870-27606-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Since 3.4, debugfs allows uid, gid, and mode options.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 sys-utils/mount.8 | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 2fdf655..44218cc 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -1183,8 +1183,13 @@ The debugfs filesystem is a pseudo filesystem, traditionally mounted on
 .IR /sys/kernel/debug .
 .\" or just /debug
 .\" present since 2.6.11
-There are no mount options.
-
+As of kernel version 3.4, debugfs has the following options:
+.TP
+.BI uid= n ", gid=" n
+Set the owner and group of the mountpoint.
+.TP
+.BI mode= value
+Sets the mode of the mountpoint.
 .SH "Mount options for devpts"
 The devpts filesystem is a pseudo filesystem, traditionally mounted on
 .IR /dev/pts .
-- 
1.8.0.3

