Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37319 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbaKBU1S (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Nov 2014 15:27:18 -0500
Received: by mail-wi0-f179.google.com with SMTP id h11so4902371wiw.0
        for <util-linux@vger.kernel.org>; Sun, 02 Nov 2014 12:27:17 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 6/8] mkswap: make remaining functions to take control structure as argument
Date: Sun,  2 Nov 2014 20:26:29 +0000
Message-Id: <1414959991-8369-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1414959991-8369-1-git-send-email-kerolasa@iki.fi>
References: <1414959991-8369-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The wipe_device() and new_prober().

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkswap.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index 7f41428..7f60013 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -225,31 +225,31 @@ get_size(const struct mkswap_control *ctl)
 
 #ifdef HAVE_LIBBLKID
 static blkid_probe
-new_prober(int fd)
+new_prober(const struct mkswap_control *ctl)
 {
 	blkid_probe pr = blkid_new_probe();
 	if (!pr)
 		errx(EXIT_FAILURE, _("unable to alloc new libblkid probe"));
-	if (blkid_probe_set_device(pr, fd, 0, 0))
+	if (blkid_probe_set_device(pr, ctl->fd, 0, 0))
 		errx(EXIT_FAILURE, _("unable to assign device to libblkid probe"));
 	return pr;
 }
 #endif
 
 static void
-wipe_device(int fd, const char *devname, int force)
+wipe_device(struct mkswap_control *ctl)
 {
 	char *type = NULL;
 	int zap = 1;
 #ifdef HAVE_LIBBLKID
 	blkid_probe pr = NULL;
 #endif
-	if (!force) {
-		if (lseek(fd, 0, SEEK_SET) != 0)
+	if (!ctl->force) {
+		if (lseek(ctl->fd, 0, SEEK_SET) != 0)
 			errx(EXIT_FAILURE, _("unable to rewind swap-device"));
 
 #ifdef HAVE_LIBBLKID
-		pr = new_prober(fd);
+		pr = new_prober(ctl);
 		blkid_probe_enable_partitions(pr, 1);
 		blkid_probe_enable_superblocks(pr, 0);
 
@@ -271,18 +271,18 @@ wipe_device(int fd, const char *devname, int force)
 		 */
 		char buf[1024];
 
-		if (lseek(fd, 0, SEEK_SET) != 0)
+		if (lseek(ctl->fd, 0, SEEK_SET) != 0)
 			errx(EXIT_FAILURE, _("unable to rewind swap-device"));
 
 		memset(buf, 0, sizeof(buf));
-		if (write_all(fd, buf, sizeof(buf)))
+		if (write_all(ctl->fd, buf, sizeof(buf)))
 			errx(EXIT_FAILURE, _("unable to erase bootbits sectors"));
 #ifdef HAVE_LIBBLKID
 		/*
 		 * Wipe rest of the device
 		 */
 		if (!pr)
-			pr = new_prober(fd);
+			pr = new_prober(ctl);
 
 		blkid_probe_enable_superblocks(pr, 1);
 		blkid_probe_enable_partitions(pr, 0);
@@ -292,13 +292,13 @@ wipe_device(int fd, const char *devname, int force)
 			const char *data = NULL;
 
 			if (blkid_probe_lookup_value(pr, "TYPE", &data, NULL) == 0 && data)
-				warnx(_("%s: warning: wiping old %s signature."), devname, data);
+				warnx(_("%s: warning: wiping old %s signature."), ctl->device_name, data);
 			blkid_do_wipe(pr, 0);
 		}
 #endif
 	} else {
 		warnx(_("%s: warning: don't erase bootbits sectors"),
-			devname);
+			ctl->device_name);
 		if (type)
 			fprintf(stderr, _("        (%s partition table detected). "), type);
 		else
@@ -450,7 +450,7 @@ main(int argc, char **argv) {
 	if (ctl.check)
 		check_blocks(&ctl);
 
-	wipe_device(ctl.fd, ctl.device_name, ctl.force);
+	wipe_device(&ctl);
 
 	ctl.hdr = (struct swap_header_v1_2 *) ctl.signature_page;
 	ctl.hdr->version = version;
-- 
2.1.3

