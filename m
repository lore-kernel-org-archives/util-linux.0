Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63175 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137Ab1KHWPT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Nov 2011 17:15:19 -0500
Received: by bke11 with SMTP id 11so873205bke.19
        for <util-linux@vger.kernel.org>; Tue, 08 Nov 2011 14:15:18 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH] fsck.minix: remove unnecessary memset calls
Date: Tue,  8 Nov 2011 23:14:52 +0100
Message-Id: <1320790495-29290-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The program aborts without using this unintialized allocated memory,
setting to zero doesn't look needed.

memset calls with sizeof() of pointer as argument (reported by clang).

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 disk-utils/fsck.minix.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index eb02f9e..90c9200 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -611,8 +611,6 @@ read_tables(void) {
 	zone_map = malloc(zmaps * MINIX_BLOCK_SIZE);
 	if (!inode_map)
 		die(_("Unable to allocate buffer for zone map"));
-	memset(inode_map,0,sizeof(inode_map));
-	memset(zone_map,0,sizeof(zone_map));
 	inode_buffer = malloc(buffsz);
 	if (!inode_buffer)
 		die(_("Unable to allocate buffer for inodes"));
-- 
1.7.3.4

