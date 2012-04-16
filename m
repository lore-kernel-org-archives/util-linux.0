Return-Path: dave@gnu.org
Subject: [PATCH 8/8] fdisk: simplify device opening
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 16 Apr 2012 11:44:52 +0200
Message-ID: <1334569492.2552.17.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

This patch makes fdisk open(2) the device in only one place (get_boot), instead of
having to depend on user input (ie: listing -l).

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |   39 ++++++++++++++++-----------------------
 1 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 8079f11..a91187a 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -1096,13 +1096,18 @@ static int get_boot(int try_only) {
 	disklabel = ANY_LABEL;
 	memset(MBRbuffer, 0, 512);
 
-	if (!try_only) {
+	if (try_only && (fd = open(disk_device, O_RDONLY)) < 0) {
+		fprintf(stderr, _("Cannot open %s\n"), disk_device);
+		fatal(unable_to_open);
+	}
+	else {
 		if ((fd = open(disk_device, O_RDWR)) < 0) {
+			/* ok, can we read-only the device? */
 			if ((fd = open(disk_device, O_RDONLY)) < 0)
 				fatal(unable_to_open);
 			else
 				printf(_("You will not be able to write "
-					    "the partition table.\n"));
+					 "the partition table.\n"));
 		}
 	}
 
@@ -1113,7 +1118,6 @@ static int get_boot(int try_only) {
 	}
 
 	get_geometry(fd, NULL);
-
 	update_units();
 
 	if (!check_dos_label())
@@ -2707,26 +2711,15 @@ print_partition_table_from_option(char *device)
 	if (setjmp(listingbuf))
 		return;
 	gpt_warning(device);
-	if ((fd = open(disk_device, O_RDONLY)) >= 0) {
-		gb = get_boot(1);
-		if (gb > 0) { /* I/O error */
-		} else if (gb < 0) { /* no DOS signature */
-			list_disk_geometry();
-			if (disklabel != AIX_LABEL && disklabel != MAC_LABEL)
-				btrydev(device);
-		} else {
-			list_table(0);
-		}
-		close(fd);
-	} else {
-		/* Ignore other errors, since we try IDE
-		   and SCSI hard disks which may not be
-		   installed on the system. */
-		if (errno == EACCES) {
-			fprintf(stderr, _("Cannot open %s\n"), device);
-			return;
-		}
-	}
+	gb = get_boot(1);
+	if (gb < 0) { /* no DOS signature */
+		list_disk_geometry();
+		if (disklabel != AIX_LABEL && disklabel != MAC_LABEL)
+			btrydev(device);
+	}
+	else if (!gb)
+		list_table(0);
+	close(fd);
 }
 
 /*
-- 
1.7.4.1
