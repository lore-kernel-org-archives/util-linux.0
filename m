Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:46676 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082Ab2DVOQl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 22 Apr 2012 10:16:41 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E473A99B23
	for <util-linux@vger.kernel.org>; Sun, 22 Apr 2012 16:16:39 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] libblkid: befs: declare functions static
Date: Sun, 22 Apr 2012 16:16:39 +0200
Message-Id: <1335104199-6612-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Since commit 0b0c231f64d02e682
(swapon: move generic code to swapon-common.c), if util-linux is
configured with --enable-static --disable-shared --enable-libmount-mount
options, the build fails with the following error:

  ...
  libtool: link: gcc -std=gnu99 -fsigned-char -ggdb -O1 -Wall -D_FORTIFY_SOURCE=2 -o switch_root switch_root.o
  /home/petr/upstream/util-linux/libblkid/src/.libs/libblkid.a(befs.o): In function `get_uuid':
  /home/petr/upstream/util-linux/libblkid/src/superblocks/befs.c:333: multiple definition of `get_uuid'
  swapon-swapon-common.o:/home/petr/upstream/util-linux/sys-utils/swapon-common.c:99: first defined here
  collect2: ld returned 1 exit status
  /bin/sh ../libtool  --tag=CC   --mode=link gcc -std=gnu99 -fsigned-char -ggdb -O1 -Wall -D_FORTIFY_SOURCE=2   -o flock flock.o strutils.o
  libtool: link: gcc -std=gnu99 -fsigned-char -ggdb -O1 -Wall -D_FORTIFY_SOURCE=2 -o pivot_root pivot_root.o
  make[2]: *** [swapon] Error 1
  make[2]: *** Waiting for unfinished jobs....
  /home/petr/upstream/util-linux/libblkid/src/.libs/libblkid.a(befs.o): In function `get_uuid':
  /home/petr/upstream/util-linux/libblkid/src/superblocks/befs.c:333: multiple definition of `get_uuid'
  swapoff-swapon-common.o:/home/petr/upstream/util-linux/sys-utils/swapon-common.c:99: first defined here

Fix by declaring befs funcitons static.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 libblkid/src/superblocks/befs.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/libblkid/src/superblocks/befs.c b/libblkid/src/superblocks/befs.c
index 930429a..a7f4317 100644
--- a/libblkid/src/superblocks/befs.c
+++ b/libblkid/src/superblocks/befs.c
@@ -122,7 +122,7 @@ struct bplustree_node {
 	char		name[0];
 } __attribute__((packed));
 
-unsigned char *get_block_run(blkid_probe pr, const struct befs_super_block *bs,
+static unsigned char *get_block_run(blkid_probe pr, const struct befs_super_block *bs,
 					const struct block_run *br, int fs_le)
 {
 	return blkid_probe_get_buffer(pr,
@@ -135,7 +135,7 @@ unsigned char *get_block_run(blkid_probe pr, const struct befs_super_block *bs,
 					<< FS32_TO_CPU(bs->block_shift, fs_le));
 }
 
-unsigned char *get_custom_block_run(blkid_probe pr,
+static unsigned char *get_custom_block_run(blkid_probe pr,
 				const struct befs_super_block *bs,
 				const struct block_run *br,
 				int64_t offset, uint32_t length, int fs_le)
@@ -154,7 +154,7 @@ unsigned char *get_custom_block_run(blkid_probe pr,
 			length);
 }
 
-unsigned char *get_tree_node(blkid_probe pr, const struct befs_super_block *bs,
+static unsigned char *get_tree_node(blkid_probe pr, const struct befs_super_block *bs,
 				const struct data_stream *ds,
 				int64_t start, uint32_t length, int fs_le)
 {
@@ -230,7 +230,7 @@ unsigned char *get_tree_node(blkid_probe pr, const struct befs_super_block *bs,
 	return NULL;
 }
 
-int32_t compare_keys(const char keys1[], uint16_t keylengths1[], int32_t index,
+static int32_t compare_keys(const char keys1[], uint16_t keylengths1[], int32_t index,
 			const char *key2, uint16_t keylength2, int fs_le)
 {
 	const char *key1;
@@ -251,7 +251,7 @@ int32_t compare_keys(const char keys1[], uint16_t keylengths1[], int32_t index,
 	return result;
 }
 
-int64_t get_key_value(blkid_probe pr, const struct befs_super_block *bs,
+static int64_t get_key_value(blkid_probe pr, const struct befs_super_block *bs,
 			const struct befs_inode *bi, const char *key, int fs_le)
 {
 	struct bplustree_header *bh;
@@ -328,7 +328,7 @@ int64_t get_key_value(blkid_probe pr, const struct befs_super_block *bs,
 	return 0;
 }
 
-int get_uuid(blkid_probe pr, const struct befs_super_block *bs,
+static int get_uuid(blkid_probe pr, const struct befs_super_block *bs,
 					uint64_t * const uuid, int fs_le)
 {
 	struct befs_inode *bi;
-- 
1.7.7

