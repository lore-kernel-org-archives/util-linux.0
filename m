Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.17.10]:64279 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246AbcE2Q4n (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 29 May 2016 12:56:43 -0400
Received: from localhost ([79.234.43.175]) by mrelayeu.kundenserver.de
 (mreue104) with ESMTPSA (Nemesis) id 0LdmXT-1boPBz0z2p-00j0m8 for
 <util-linux@vger.kernel.org>; Sun, 29 May 2016 18:56:40 +0200
Date: Sun, 29 May 2016 18:56:58 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] fsck.minix: Verify more fields in super-block.
Message-ID: <20160529165658.GA7092@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The field s_ninodes in super-block is used for memory allocation and
division without verifications. The memory allocation increments the
unchecked value by 1, making it vulnerable to an integer overflow
on 32 bit systems with minix 3 file systems. I did not find a (good)
way to exploit this by crafting a malicious file system, so I consider
it as a reliability issue. If it's 0, a division by zero occurs when
"-v" has been used. A filesystem without any inodes is definitely
wrong, because it means that there's not even the root inode, which is
accessed unchecked later on.

The field s_firstdatazone has to be checked against s_(n)zones. If it
is larger than the highest allowed index, the file system is definitely
corrupted -- hard to say which value is wrong though, therefore I
decided to simply call die(). A maliciously created file system could
do more harm in this way: single bits inside the memory area could be
flipped because range checks would fail. Hard to consider it as a
security issue though, because these addresses are not arbitrarily
accessible without very careful crafting (if at all possible).
---
 disk-utils/fsck.minix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index aa64569..931658f 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -573,8 +573,12 @@ read_superblock(void) {
 		die(_("bad magic number in super-block"));
 	if (get_zone_size() != 0 || MINIX_BLOCK_SIZE != 1024)
 		die(_("Only 1k blocks/zones supported"));
+	if (get_ninodes() == 0 || get_ninodes() == UINT32_MAX)
+		die(_("bad s_ninodes field in super-block"));
 	if (get_nimaps() * MINIX_BLOCK_SIZE * 8 < get_ninodes() + 1)
 		die(_("bad s_imap_blocks field in super-block"));
+	if (get_first_zone() > get_nzones())
+		die(_("bad s_firstdatazone field in super-block"));
 	if (get_nzmaps() * MINIX_BLOCK_SIZE * 8 <
 	    get_nzones() - get_first_zone() + 1)
 		die(_("bad s_zmap_blocks field in super-block"));
-- 
2.8.3

