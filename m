Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:61466 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbeAWP7b (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 23 Jan 2018 10:59:31 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Tobias Stoeckmann <tobias@stoeckmann.org>
Subject: [PATCH 1/7] Revert "fsck.cramfs: Fix bus error on broken file system."
Date: Tue, 23 Jan 2018 16:59:22 +0100
Message-Id: <20180123155928.7629-2-sweet_f_a@gmx.de>
In-Reply-To: <20180123155928.7629-1-sweet_f_a@gmx.de>
References: <20180123155928.7629-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This reverts commit 7cb962c77015e9383b53eeb22ce732cb5216bbc3.

It can't be right that we mmap (start + super.size) bytes from a file
which is usually only super.size bytes large. The patch "fixed" a
problem when super.size is bad but now it fails for the correct case:

$ mkdir -p root/subdir
$ ./mkfs.cramfs -p root cramfs
$ ./fsck.cramfs cramfs
Bus error (core dumped)

We will fix the original problem later.

CC: Tobias Stoeckmann <tobias@stoeckmann.org>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/fsck.cramfs.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index b2a3cc153..50c7d33b9 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -220,24 +220,23 @@ static void test_crc(int start)
 	crc = crc32(0L, NULL, 0);
 
 	buf =
-	    mmap(NULL, start + super.size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	    mmap(NULL, super.size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	if (buf == MAP_FAILED) {
 		buf =
-		    mmap(NULL, start + super.size, PROT_READ | PROT_WRITE,
+		    mmap(NULL, super.size, PROT_READ | PROT_WRITE,
 			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 		if (buf != MAP_FAILED) {
-			if (lseek(fd, start, SEEK_SET) == (off_t) -1)
+			if (lseek(fd, 0, SEEK_SET) == (off_t) -1)
 				err(FSCK_EX_ERROR, _("seek on %s failed"), filename);
-			if (read(fd, (unsigned char *) buf + start, super.size) !=
-			    (ssize_t) super.size)
+			if (read(fd, buf, super.size) != (ssize_t) super.size)
 				err(FSCK_EX_ERROR, _("cannot read %s"), filename);
 		}
 	}
 	if (buf != MAP_FAILED) {
 		((struct cramfs_super *)((unsigned char *) buf + start))->fsid.crc =
 		    crc32(0L, NULL, 0);
-		crc = crc32(crc, (unsigned char *) buf + start, super.size);
-		munmap(buf, start + super.size);
+		crc = crc32(crc, (unsigned char *) buf + start, super.size - start);
+		munmap(buf, super.size);
 	} else {
 		int retval;
 		size_t length = 0;
-- 
2.13.6

