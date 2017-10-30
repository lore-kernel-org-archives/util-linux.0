Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([217.72.192.73]:61502 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbdJ3MuC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 30 Oct 2017 08:50:02 -0400
Date: Mon, 30 Oct 2017 13:49:53 +0100
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fsck.cramfs: Fix bus error on broken file system.
Message-ID: <20171030124953.GA2109@localhost>
References: <20171026200117.GA14920@localhost>
 <20171027054743.GA1907@localhost>
 <20171030104357.lpl7a6vu5snvhznn@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171030104357.lpl7a6vu5snvhznn@ws.net.home>
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
Update to last patch: read lacked a proper cast to (unsigned char *).
---
 disk-utils/fsck.cramfs.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index 50c7d33b9..b2a3cc153 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -220,23 +220,24 @@ static void test_crc(int start)
 	crc = crc32(0L, NULL, 0);
 
 	buf =
-	    mmap(NULL, super.size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	    mmap(NULL, start + super.size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	if (buf == MAP_FAILED) {
 		buf =
-		    mmap(NULL, super.size, PROT_READ | PROT_WRITE,
+		    mmap(NULL, start + super.size, PROT_READ | PROT_WRITE,
 			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
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

