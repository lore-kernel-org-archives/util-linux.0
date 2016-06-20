Return-Path: util-linux-owner@vger.kernel.org
Received: from a.mx.secunet.com ([62.96.220.36]:54202 "EHLO a.mx.secunet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696AbcFTFJP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 20 Jun 2016 01:09:15 -0400
Received: from localhost (alg1 [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id DAC671A065E
	for <util-linux@vger.kernel.org>; Mon, 20 Jun 2016 07:09:09 +0200 (CEST)
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id o2cxbEzWwZfe for <util-linux@vger.kernel.org>;
	Mon, 20 Jun 2016 07:09:08 +0200 (CEST)
Received: from mail-essen-01.secunet.de (unknown [10.53.40.204])
	by a.mx.secunet.com (Postfix) with ESMTP id EC2FE1A0651
	for <util-linux@vger.kernel.org>; Mon, 20 Jun 2016 07:09:08 +0200 (CEST)
Subject: Re: [PATCHv2] liblkid: Add length check in probe_nilfs2 before crc32
To: <util-linux@vger.kernel.org>
References: <576384D1.4000602@secunet.com>
From: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Message-ID: <57677A76.1040503@secunet.com>
Date: Mon, 20 Jun 2016 07:09:10 +0200
MIME-Version: 1.0
In-Reply-To: <576384D1.4000602@secunet.com>
Content-Type: text/plain; charset="utf-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I have feedback on my first version of the patch sent to the kernel maintainers, so
 I'm sending you the result of this discussion as well.

The following changes were made:

- add const to the newly introduced variable
- renaming it to crc_start
- fix check for maximum size, bytes is the end of the area to crc32-check, not its
  length

	Torsten

------PATCH starts here -------------------------------------------------------

The bytes variable is read from the file system to probe and must be
checked before used as length parameter in the crc32 call.

The following problems may occur here:

- bytes smaller than sumoff + 4: underflow in length calculation
- bytes larger than remaining space in sb: overflow of buffer

This fixes a problem where an encrypted volume had the correct magic
values 0x3434 at offset 0x406 and the following uint16_t (which is
read into the nilfs_super_block.s_bytes struct) was parsed as 1.

Then crc32 was called with the length value 18446744073709551597
causing a segmentation fault.
---
 libblkid/src/superblocks/nilfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/libblkid/src/superblocks/nilfs.c b/libblkid/src/superblocks/nilfs.c
index d12472c..fbafb8d 100644
--- a/libblkid/src/superblocks/nilfs.c
+++ b/libblkid/src/superblocks/nilfs.c
@@ -72,6 +72,7 @@ static int nilfs_valid_sb(blkid_probe pr, struct nilfs_super_block *sb, int is_b
 	static unsigned char sum[4];
 	const int sumoff = offsetof(struct nilfs_super_block, s_sum);
 	size_t bytes;
+	const size_t crc_start = sumoff + 4;
 	uint32_t crc;
 
 	if (!sb || le16_to_cpu(sb->s_magic) != NILFS_SB_MAGIC)
@@ -82,9 +83,15 @@ static int nilfs_valid_sb(blkid_probe pr, struct nilfs_super_block *sb, int is_b
 		return 0;
 
 	bytes = le16_to_cpu(sb->s_bytes);
+	/* ensure that no underrun can happen in the length parameter
+	 * of the crc32 call or more data are processed than read into
+	 * sb */
+	if (bytes < crc_start || bytes > sizeof(struct nilfs_super_block))
+		return -1;
+
 	crc = crc32(le32_to_cpu(sb->s_crc_seed), (unsigned char *)sb, sumoff);
 	crc = crc32(crc, sum, 4);
-	crc = crc32(crc, (unsigned char *)sb + sumoff + 4, bytes - sumoff - 4);
+	crc = crc32(crc, (unsigned char *)sb + crc_start, bytes - crc_start);
 
 	return blkid_probe_verify_csum(pr, crc, le32_to_cpu(sb->s_sum));
 }
-- 
2.1.4


