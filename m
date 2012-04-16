Return-Path: dave@gnu.org
Subject: [PATCH 7/8] fdisk: remove action enum
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 16 Apr 2012 11:44:49 +0200
Message-ID: <1334569489.2552.16.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |   16 +++++++---------
 fdisk/fdisk.h |    2 --
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 15fb56c..8079f11 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -53,7 +53,6 @@
 
 #include "gpt.h"
 
-static int get_boot(enum action what);
 static void delete_partition(int i);
 
 #define hex_val(c)	({ \
@@ -1009,7 +1008,7 @@ get_geometry(int fd, struct geom *g) {
 		kern_heads ? kern_heads : 255;
 	sectors = user_sectors ? user_sectors :
 		pt_sectors ? pt_sectors :
-		kern_sectors ? kern_sectors : 63;
+		kern_sectors ? kern_sectors : 63;	
 
 	/* get number of 512-byte sectors, and convert it the real sectors */
 	if (blkdev_get_sectors(fd, &nsects) == 0)
@@ -1092,13 +1091,12 @@ static int check_dos_label(void)
  *    0: found or created label
  *    1: I/O error
  */
-static int
-get_boot(enum action what) {
+static int get_boot(int try_only) {
 
 	disklabel = ANY_LABEL;
 	memset(MBRbuffer, 0, 512);
 
-	if (what != try_only) {
+	if (!try_only) {
 		if ((fd = open(disk_device, O_RDWR)) < 0) {
 			if ((fd = open(disk_device, O_RDONLY)) < 0)
 				fatal(unable_to_open);
@@ -1109,7 +1107,7 @@ get_boot(enum action what) {
 	}
 
 	if (512 != read(fd, MBRbuffer, 512)) {
-		if (what == try_only)
+		if (try_only)
 			return 1;
 		fatal(unable_to_read);
 	}
@@ -1133,7 +1131,7 @@ get_boot(enum action what) {
 	}
 
 	if (disklabel == ANY_LABEL) {
-		if (what == try_only)
+		if (try_only)
 			return -1;
 
 		fprintf(stderr,
@@ -2710,7 +2708,7 @@ print_partition_table_from_option(char *device)
 		return;
 	gpt_warning(device);
 	if ((fd = open(disk_device, O_RDONLY)) >= 0) {
-		gb = get_boot(try_only);
+		gb = get_boot(1);
 		if (gb > 0) { /* I/O error */
 		} else if (gb < 0) { /* no DOS signature */
 			list_disk_geometry();
@@ -3004,7 +3002,7 @@ main(int argc, char **argv) {
 		"Be careful before using the write command.\n\n"), PACKAGE_STRING);
 
 	gpt_warning(disk_device);
-	get_boot(fdisk);
+	get_boot(0);
 
 	command_prompt();
 
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index fed575b..01e3d72 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -48,8 +48,6 @@ enum failure {ioctl_error,
 	unable_to_open, unable_to_read, unable_to_seek,
 	unable_to_write};
 
-enum action {fdisk, try_only};
-
 struct geom {
 	unsigned int heads;
 	unsigned int sectors;
-- 
1.7.4.1
