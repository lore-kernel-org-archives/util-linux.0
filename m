Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.131]:53713 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754032AbcH0R2w (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 27 Aug 2016 13:28:52 -0400
Received: from localhost ([91.7.171.187]) by mrelayeu.kundenserver.de
 (mreue004) with ESMTPSA (Nemesis) id 0LouWl-1bBFPe3ZoB-00go4o for
 <util-linux@vger.kernel.org>; Sat, 27 Aug 2016 19:28:49 +0200
Date: Sat, 27 Aug 2016 19:28:48 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] Distinguish between first LBA sector and partition
Message-ID: <20160827172848.GB11886@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

An insufficient check leads to an invalid free space output, as seen here:

$ dd if=/dev/zero of=cfdisk.iso bs=1M count=1
$ losetup -f cfdisk.iso
$ echo w | fdisk /dev/loop0
$ echo '1,1' | sfdisk /dev/loop0 --append
$ echo '3,' | sfdisk /dev/loop0 --append
$ sfdisk --list-free /dev/loop0
Start End Sectors Size
    1   2       2   1K
$ _

In this case, libfdisk fails to notice that it tries to calculate space
between two partitions, not between start of disk and first partition.
Currently, the code tries to achieve that by checking the address of the
last "partition", which is the first_lba block.  Now if the first
partition is merely 1 block in size, the "last" address is still equal
to the first_lba block, which renders the check in libfdisk for the next
partition invalid.

I chose to use "nparts == 0" for this check, because the partitions are
properly sorted before iterating over them.

Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
---
 libfdisk/src/table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libfdisk/src/table.c b/libfdisk/src/table.c
index bf30d1b..f975168 100644
--- a/libfdisk/src/table.c
+++ b/libfdisk/src/table.c
@@ -617,9 +617,9 @@ int fdisk_get_freespaces(struct fdisk_context *cxt, struct fdisk_table **tb)
 		 * aligned, the exception is space before the first partition where
 		 * we assume that cxt->first_lba is aligned. */
 		if (last + grain < pa->start
-		    || (last < pa->start && last == cxt->first_lba)) {
+		    || (last < pa->start && nparts == 0)) {
 			rc = table_add_freespace(cxt, *tb,
-				last + (last > cxt->first_lba ? 1 : 0),
+				last + (nparts == 0 ? 0 : 1),
 				pa->start - 1, NULL);
 		}
 		/* add gaps between logical partitions */
-- 
2.9.3

