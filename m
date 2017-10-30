Return-Path: tobias@stoeckmann.org
Date: Mon, 30 Oct 2017 13:47:00 +0100
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fsck.cramfs: Fix bus error on broken file system.
Message-ID: <20171030124700.GA1870@localhost>
References: <20171026200117.GA14920@localhost>
 <20171027054743.GA1907@localhost>
 <20171030104357.lpl7a6vu5snvhznn@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171030104357.lpl7a6vu5snvhznn@ws.net.home>
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
This version avoids mmap offset again and properly sets lseek offset.
---
 disk-utils/fsck.cramfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index 50c7d33b9..2da14d17a 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -220,23 +220,23 @@ static void test_crc(int start)
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
+			if (read(fd, buf + start, super.size) != (ssize_t) super.size)
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
