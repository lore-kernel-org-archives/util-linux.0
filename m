Return-Path: dave@gnu.org
Subject: [PATCH 2/2] mkfs.minix: add fs version options
From: Davidlohr Bueso <dave@gnu.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 09 Jun 2011 12:48:41 -0400
Message-ID: <1307638121.2155.3.camel@offworld>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Thu, 9 Jun 2011 12:41:12 -0400

Like the original minix mkfs, add the -1 and -2 argument options to specify the version of the filesystem to create.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 disk-utils/mkfs.minix.8           |    5 ++++-
 disk-utils/mkfs.minix.c           |    8 ++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/disk-utils/mkfs.minix.8 b/disk-utils/mkfs.minix.8
index 9359106..2c180e5 100644
--- a/disk-utils/mkfs.minix.8
+++ b/disk-utils/mkfs.minix.8
@@ -59,7 +59,10 @@ Read the bad blocks list from
 The file has one bad block number per line.  The count of bad blocks read
 is printed.
 .TP
-.B \-v
+.B \-1
+Make a Minix version 1 filesystem.
+.TP
+.B  \-2,\-v 
 Make a Minix version 2 filesystem.
 .SH "EXIT CODES"
 The exit code returned by
diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 1cebcda..bd773b2 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -586,7 +586,7 @@ int main(int argc, char ** argv) {
 		errx(MKFS_ERROR, _("%s: bad inode size"), device_name);
 
 	opterr = 0;
-	while ((i = getopt(argc, argv, "ci:l:n:v")) != -1)
+	while ((i = getopt(argc, argv, "ci:l:n:v12")) != -1)
 		switch (i) {
 		case 'c':
 			check=1; break;
@@ -608,7 +608,11 @@ int main(int argc, char ** argv) {
 			namelen = i;
 			dirsize = i+2;
 			break;
-		case 'v':
+		case '1':
+			fs_version = 1;
+			break;
+		case '2':
+		case 'v': /* kept for backwards compatiblitly */
 			fs_version = 2;
 			version2 = 1;
 			break;

-- 
1.7.4.1
