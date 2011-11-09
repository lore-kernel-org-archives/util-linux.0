Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ww0-f42.google.com ([74.125.82.42]:56127 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab1KIP6A (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Nov 2011 10:58:00 -0500
Received: by wwf22 with SMTP id 22so7982657wwf.1
        for <util-linux@vger.kernel.org>; Wed, 09 Nov 2011 07:57:58 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH] fsck.minix: fix zone_map memory allocation failure check
Date: Wed,  9 Nov 2011 16:57:28 +0100
Message-Id: <1320854248-14207-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 disk-utils/fsck.minix.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index ccbb7a9..95e3ecf 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -609,7 +609,7 @@ read_tables(void) {
 	if (!inode_map)
 		die(_("Unable to allocate buffer for inode map"));
 	zone_map = malloc(zmaps * MINIX_BLOCK_SIZE);
-	if (!inode_map)
+	if (!zone_map)
 		die(_("Unable to allocate buffer for zone map"));
 	inode_buffer = malloc(buffsz);
 	if (!inode_buffer)
-- 
1.7.3.4

