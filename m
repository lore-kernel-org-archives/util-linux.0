Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:39680 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434Ab2DVBxQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 21 Apr 2012 21:53:16 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] sys-utils: avoid duplicate reference to fstab.5
Date: Sat, 21 Apr 2012 21:44:32 -0400
Message-Id: <1335059072-15126-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is no longer in sys-utils/ anyways, and its unconditionally
distributed by an earlier dist_man_MANS declare in the Makefile.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 sys-utils/Makefile.am |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/Makefile.am b/sys-utils/Makefile.am
index 9849429..9c27de6 100644
--- a/sys-utils/Makefile.am
+++ b/sys-utils/Makefile.am
@@ -96,7 +96,7 @@ if BUILD_NEW_MOUNT
 # -- temporary we share some man pages
 #
 bin_PROGRAMS += mount umount
-dist_man_MANS += mount.8 ../mount/fstab.5 ../mount/umount.8
+dist_man_MANS += mount.8 ../mount/umount.8
 
 mount_SOURCES = \
 	mount.c \
-- 
1.7.10

