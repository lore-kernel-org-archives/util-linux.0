Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.130]:64251 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbdCOVTm (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 15 Mar 2017 17:19:42 -0400
Received: from localhost ([93.225.48.83]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPSA (Nemesis) id
 0MZbvZ-1cVLNd3Qrd-00LCjd for <util-linux@vger.kernel.org>; Wed, 15 Mar 2017
 22:11:52 +0100
Date: Wed, 15 Mar 2017 22:12:00 +0100
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] libblkid: prevent OOB access while probing HFS+
Message-ID: <20170315211159.GA29768@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It is possible to perform out of boundary read accesses due to
insufficient boundary checks in probe_hfsplus.

The first issue occurs if the leaf count in a B-node is too
small. The second happens while parsing a unicode description which
is longer than 255 UTF-8 characters. The length is stored in a 16 bit
integer, but the array in the struct is limited to 255 * 2, which is
in sync with Apple's Open Source HFS+ implementation (HFSUniStr255).

Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
---
You can trigger the issue with these two small proof of concepts,
which contain byte sequences which imitate a HFS+ (but are broken
beyond repair, as I was just fiddling around with bits until they
did what I wanted to happen ;) ).

echo H4sICJKhyVgCA2lzby1wb2MtMQDt1LkNgDAURMFviSt1B9SCHNCAJTo\
hpXPjEkiBmfhFG+xWai1d684uIlJrOccVMU7zEimAj9qPp+Xw45VWLwgAAAA\
AAMAr3DUKOtIAIAAA | base64 -d - | gunzip > f1

echo H4sICKelyVgCA2lzby1wb2MtMgDt2rsJgFAMBdA88Ne6gbOIhQsIbuL\
48QkOYKue09wUKcOtMi/btlRZHVVElMxxrDm0XT80AXzVuj/d/HMTTMWlAAA\
AAAAA8CYZmfdYrl+AGfi8Exgn/EMAJAAA | base64 -d - | gunzip > f2

You can trigger the issue with the tool blkid this way:

# losetup -f $file
# blkid -p -n hfsplus /dev/loop0
---
 libblkid/src/superblocks/hfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/libblkid/src/superblocks/hfs.c b/libblkid/src/superblocks/hfs.c
index ee502cf61..ef746d4e2 100644
--- a/libblkid/src/superblocks/hfs.c
+++ b/libblkid/src/superblocks/hfs.c
@@ -244,7 +244,8 @@ static int probe_hfsplus(blkid_probe pr, const struct blkid_idmag *mag)
 	leaf_node_head = be32_to_cpu(bnode->leaf_head);
 	leaf_node_size = be16_to_cpu(bnode->node_size);
 	leaf_node_count = be32_to_cpu(bnode->leaf_count);
-	if (leaf_node_count == 0)
+	if (leaf_node_size < sizeof(struct hfsplus_bnode_descriptor) +
+	    sizeof(struct hfsplus_catalog_key) || leaf_node_count == 0)
 		return 0;
 
 	leaf_block = (leaf_node_head * leaf_node_size) / blocksize;
@@ -284,7 +285,8 @@ static int probe_hfsplus(blkid_probe pr, const struct blkid_idmag *mag)
 	key = (struct hfsplus_catalog_key *)
 		&buf[sizeof(struct hfsplus_bnode_descriptor)];
 
-	if (be32_to_cpu(key->parent_id) != HFSPLUS_POR_CNID)
+	if (be32_to_cpu(key->parent_id) != HFSPLUS_POR_CNID ||
+	    be16_to_cpu(key->unicode_len > 255))
 		return 0;
 
 	blkid_probe_set_utf8label(pr, key->unicode,
-- 
2.12.0

