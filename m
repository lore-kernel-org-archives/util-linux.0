Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.130]:61582 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932394AbdJZUBV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 26 Oct 2017 16:01:21 -0400
Received: from localhost ([217.87.198.192]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPSA (Nemesis) id
 0MU9sv-1dhimc3zph-00QfsJ for <util-linux@vger.kernel.org>; Thu, 26 Oct 2017
 22:01:20 +0200
Date: Thu, 26 Oct 2017 22:01:17 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] fsck.cramfs: Fix bus error on broken file system.
Message-ID: <20171026200117.GA14920@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The utility fsck.cramfs is prone to a bus error on file systems for
big endian systems with non-standard header sizes. While calculating
the crc32 checksum, it does not properly handle a possible offset
for bootcodes, resulting in out of boundary access of mmap'ed area.

You can trigger the issue with the following commands:

$ mkdir -p cramfs-poc/root/subdir
$ cd cramfs-poc
$ mkfs.cramfs -p -N big root cramfs
$ echo -ne \\00\\x4c | dd of=cramfs bs=1 seek=518 count=2 conv=notrunc
$ fsck.cramfs cramfs

Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
---
 disk-utils/fsck.cramfs.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index 50c7d33b9..3d0b9de58 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -219,24 +219,24 @@ static void test_crc(int start)
 
 	crc = crc32(0L, NULL, 0);
 
-	buf =
-	    mmap(NULL, super.size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	buf = mmap(NULL, start + super.size, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE, fd, 0);
 	if (buf == MAP_FAILED) {
-		buf =
-		    mmap(NULL, super.size, PROT_READ | PROT_WRITE,
-			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+		buf = mmap(NULL, start + super.size, PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 		if (buf != MAP_FAILED) {
-			if (lseek(fd, 0, SEEK_SET) == (off_t) -1)
+			if (lseek(fd, start, SEEK_SET) == (off_t) -1)
 				err(FSCK_EX_ERROR, _("seek on %s failed"), filename);
-			if (read(fd, buf, super.size) != (ssize_t) super.size)
+			if (read(fd, (unsigned char *) buf + start, super.size) !=
+			    (ssize_t) super.size)
 				err(FSCK_EX_ERROR, _("cannot read %s"), filename);
 		}
 	}
 	if (buf != MAP_FAILED) {
 		((struct cramfs_super *)((unsigned char *) buf + start))->fsid.crc =
 		    crc32(0L, NULL, 0);
-		crc = crc32(crc, (unsigned char *) buf + start, super.size - start);
-		munmap(buf, super.size);
+		crc = crc32(crc, (unsigned char *) buf + start, super.size);
+		munmap(buf, start + super.size);
 	} else {
 		int retval;
 		size_t length = 0;
-- 
2.14.3

