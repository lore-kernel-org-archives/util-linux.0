Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:7122 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480Ab2IJK6t (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Sep 2012 06:58:49 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q8AAwn9p025699
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 10 Sep 2012 06:58:49 -0400
From: Milan Broz <mbroz@redhat.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <mbroz@redhat.com>
Subject: [PATCH] mkswap: wipe old signature if there is no part table by default
Date: Mon, 10 Sep 2012 12:58:39 +0200
Message-Id: <1347274719-26869-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Historically mkswap avoids wiping any signature on "whole disk",
until force option is given.

While the idea is that it should not wipe possible boot loader,
in reality it leads to many situations where e.g. LUKS device
is overwritten but still can be detected as LUKS (but unusable).

Patch chnges behaviour that only if partition table is detected,
signatures are not wiped.

Also it removes check for block device - loop device can now
map partitions in-kernel, so using mkswap on disk image in file
should behave the same as on disk.

Also it adds warning that know signature was wiped.

Signed-off-by: Milan Broz <mbroz@redhat.com>
---
 disk-utils/mkswap.8 |    5 ++---
 disk-utils/mkswap.c |   47 ++++++++++++++++++++---------------------------
 2 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/disk-utils/mkswap.8 b/disk-utils/mkswap.8
index ad9b4b9..219c49f 100644
--- a/disk-utils/mkswap.8
+++ b/disk-utils/mkswap.8
@@ -54,7 +54,7 @@ like many others mkfs-like utils,
 However,
 .B mkswap
 refuses to erase the first block on a device with a disk
-label (SUN, BSD, ...) and on a whole disk (e.g. /dev/sda).
+label (SUN, BSD, ...).
 
 .SH OPTIONS
 .TP
@@ -70,8 +70,7 @@ or partition it resides on.
 
 Also, without this option,
 .B mkswap
-will refuse to erase the first block on a device with a partition table and on
-a whole disk (e.g. /dev/sda).
+will refuse to erase the first block on a device with a partition table.
 .TP
 .BR \-L , " \-\-label " \fIlabel\fR
 Specify a \fIlabel\fR for the device, to allow
diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index 34fe687..0144921 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -363,10 +363,9 @@ new_prober(int fd)
 #endif
 
 static void
-wipe_device(int fd, const char *devname, int force, int is_blkdevice)
+wipe_device(int fd, const char *devname, int force)
 {
 	char *type = NULL;
-	int whole = 0;
 	int zap = 1;
 #ifdef HAVE_LIBBLKID
 	blkid_probe pr = NULL;
@@ -375,29 +374,21 @@ wipe_device(int fd, const char *devname, int force, int is_blkdevice)
 		if (lseek(fd, 0, SEEK_SET) != 0)
 			errx(EXIT_FAILURE, _("unable to rewind swap-device"));
 
-		if (is_blkdevice && is_whole_disk_fd(fd, devname)) {
-			/* don't zap bootbits on whole disk -- we know nothing
-			 * about bootloaders on the device */
-			whole = 1;
-			zap = 0;
-		} else {
 #ifdef HAVE_LIBBLKID
-			pr = new_prober(fd);
-			blkid_probe_enable_partitions(pr, 1);
-			blkid_probe_enable_superblocks(pr, 0);
-
-			if (blkid_do_fullprobe(pr) == 0 &&
-			    blkid_probe_lookup_value(pr, "PTTYPE",
-					(const char **) &type, NULL) == 0 &&
-			    type) {
-				type = xstrdup(type);
-				zap = 0;
-			}
-#else
-			/* don't zap if compiled without libblkid */
+		pr = new_prober(fd);
+		blkid_probe_enable_partitions(pr, 1);
+		blkid_probe_enable_superblocks(pr, 0);
+
+		if (blkid_do_fullprobe(pr) == 0 &&
+		    blkid_probe_lookup_value(pr, "PTTYPE",
+				(const char **) &type, NULL) == 0 && type) {
+			type = xstrdup(type);
 			zap = 0;
-#endif
 		}
+#else
+		/* don't zap if compiled without libblkid */
+		zap = 0;
+#endif
 	}
 
 	if (zap) {
@@ -405,6 +396,7 @@ wipe_device(int fd, const char *devname, int force, int is_blkdevice)
 		 * Wipe boodbits
 		 */
 		char buf[1024];
+		const char *data = NULL;
 
 		if (lseek(fd, 0, SEEK_SET) != 0)
 			errx(EXIT_FAILURE, _("unable to rewind swap-device"));
@@ -421,18 +413,19 @@ wipe_device(int fd, const char *devname, int force, int is_blkdevice)
 
 		blkid_probe_enable_superblocks(pr, 1);
 		blkid_probe_enable_partitions(pr, 0);
-		blkid_probe_set_superblocks_flags(pr, BLKID_SUBLKS_MAGIC);
+		blkid_probe_set_superblocks_flags(pr, BLKID_SUBLKS_MAGIC|BLKID_SUBLKS_TYPE);
 
-		while (blkid_do_probe(pr) == 0)
+		while (blkid_do_probe(pr) == 0) {
+			if (blkid_probe_lookup_value(pr, "TYPE", &data, NULL) == 0 && data)
+				warnx(_("%s: warning: wiping old %s signature."), devname, data);
 			blkid_do_wipe(pr, 0);
+		}
 #endif
 	} else {
 		warnx(_("%s: warning: don't erase bootbits sectors"),
 			devname);
 		if (type)
 			fprintf(stderr, _("        (%s partition table detected). "), type);
-		else if (whole)
-			fprintf(stderr, _("        on whole disk. "));
 		else
 			fprintf(stderr, _("        (compiled without libblkid). "));
 		fprintf(stderr, "Use -f to force.\n");
@@ -603,7 +596,7 @@ main(int argc, char **argv) {
 	if (check)
 		check_blocks();
 
-	wipe_device(DEV, device_name, force, S_ISBLK(statbuf.st_mode));
+	wipe_device(DEV, device_name, force);
 
 	hdr = (struct swap_header_v1_2 *) signature_page;
 	hdr->version = 1;
-- 
1.7.10.4

