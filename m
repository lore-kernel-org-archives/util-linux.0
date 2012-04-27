Return-Path: dave@gnu.org
Date: Fri, 27 Apr 2012 13:23:51 +0200
From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH 3/4] fdisk: rework fatal errors
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1335525831.11068.6.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

When the device cannot be opened, there's no point calling fatal() when we can just use err(3). When any other kind of fatal
error occurs it's Ok, in addition we can also go ahead and close the descriptor before exiting the program as it's currently leaking.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |   18 ++++++------------
 fdisk/fdisk.h |    9 ++++++---
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index f49efd0..a16b672 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -264,10 +264,8 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 
 void fatal(enum failure why)
 {
+	close(fd);
 	switch (why) {
-		case unable_to_open:
-			err(EXIT_FAILURE, _("unable to open %s"), disk_device);
-
 		case unable_to_read:
 			err(EXIT_FAILURE, _("unable to read %s"), disk_device);
 
@@ -1087,18 +1085,14 @@ static int get_boot(int try_only) {
 	disklabel = ANY_LABEL;
 	memset(MBRbuffer, 0, 512);
 
-	if (try_only && (fd = open(disk_device, O_RDONLY)) < 0) {
-		fprintf(stderr, _("Cannot open %s\n"), disk_device);
-		fatal(unable_to_open);
-	}
+	if (try_only && (fd = open(disk_device, O_RDONLY)) < 0)
+		err(EXIT_FAILURE, _("unable to open %s"), disk_device);
 	else {
 		if ((fd = open(disk_device, O_RDWR)) < 0) {
 			/* ok, can we read-only the device? */
 			if ((fd = open(disk_device, O_RDONLY)) < 0)
-				fatal(unable_to_open);
-			else
-				printf(_("You will not be able to write "
-					 "the partition table.\n"));
+				err(EXIT_FAILURE, _("unable to open %s"), disk_device);
+			printf(_("You will not be able to write the partition table.\n"));
 		}
 	}
 
@@ -2958,7 +2952,7 @@ main(int argc, char **argv) {
 		for (j = optind; j < argc; j++) {
 			disk_device = argv[j];
 			if ((fd = open(disk_device, O_RDONLY)) < 0)
-				fatal(unable_to_open);
+				err(EXIT_FAILURE, _("unable to open %s"), disk_device);
 			if (blkdev_get_sectors(fd, &size) == -1)
 				fatal(ioctl_error);
 			close(fd);
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index 01e3d72..cff6b60 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -44,9 +44,12 @@ enum menutype {
 	EXPERT_MENU,
 };
 
-enum failure {ioctl_error,
-	unable_to_open, unable_to_read, unable_to_seek,
-	unable_to_write};
+enum failure {
+	ioctl_error,
+	unable_to_read, 
+	unable_to_seek,
+	unable_to_write
+};
 
 struct geom {
 	unsigned int heads;
-- 
1.7.4.1
