Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([217.72.192.74]:55079 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754032AbcH0R2V (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 27 Aug 2016 13:28:21 -0400
Received: from localhost ([91.7.171.187]) by mrelayeu.kundenserver.de
 (mreue104) with ESMTPSA (Nemesis) id 0Lzrl5-1b0Dr82TMx-014zB0 for
 <util-linux@vger.kernel.org>; Sat, 27 Aug 2016 19:28:17 +0200
Date: Sat, 27 Aug 2016 19:28:16 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] Fix assert error in libfdisk's free space handling
Message-ID: <20160827172816.GA11886@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

An off-by-one issue exists in fdisk_get_freespaces. It can trigger an
assert, as seen here:

$ dd if=/dev/zero of=cfdisk.iso bs=1M count=1
$ losetup -f cfdisk.iso
$ echo w | fdisk /dev/loop0
$ echo '1,2' | sfdisk /dev/loop0 --append
$ echo '3,' | sfdisk /dev/loop0 --append
$ sfdisk --list-free /dev/loop0
Aborted
$ _

Problem here is an invalid "grain" processing. A grain is considered
expected free space between partitions which can be required for proper
alignment. Normally, it's 1 MB but in this case our iso is merely 1 MB
so the grain is reduced to 1 byte.

The if-condition in question checks for "last + grain <= pa->start" and
therefore even triggers if there is no space between them (due to equal
check). Eventually, the start block address is higher than the end block
address which triggers the assert().

Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
---
 libfdisk/src/table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libfdisk/src/table.c b/libfdisk/src/table.c
index 755c6c2..bf30d1b 100644
--- a/libfdisk/src/table.c
+++ b/libfdisk/src/table.c
@@ -616,7 +616,7 @@ int fdisk_get_freespaces(struct fdisk_context *cxt, struct fdisk_table **tb)
 		/* We ignore small free spaces (smaller than grain) to keep partitions
 		 * aligned, the exception is space before the first partition where
 		 * we assume that cxt->first_lba is aligned. */
-		if (last + grain <= pa->start
+		if (last + grain < pa->start
 		    || (last < pa->start && last == cxt->first_lba)) {
 			rc = table_add_freespace(cxt, *tb,
 				last + (last > cxt->first_lba ? 1 : 0),
-- 
2.9.3

