Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32944 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbdCEUwk (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Mar 2017 15:52:40 -0500
Received: by mail-wm0-f67.google.com with SMTP id n11so10897128wma.0
        for <util-linux@vger.kernel.org>; Sun, 05 Mar 2017 12:52:38 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 01/13] misc: stop mixing declarations and code
Date: Sun,  5 Mar 2017 20:52:20 +0000
Message-Id: <20170305205232.24030-2-kerolasa@iki.fi>
In-Reply-To: <20170305205232.24030-1-kerolasa@iki.fi>
References: <20170305205232.24030-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/cfdisk.c              | 4 +++-
 disk-utils/sfdisk.c              | 2 +-
 libblkid/src/superblocks/minix.c | 7 +++----
 text-utils/hexdump-display.c     | 4 ++--
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index f06dad1c8..cb9f3421d 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -2092,6 +2092,8 @@ static int ui_create_label(struct cfdisk *cf)
 
 
 	do {
+		int key;
+
 		if (refresh_menu) {
 			ui_draw_menu(cf);
 			ui_hint(_("Select a type to create a new label or press 'L' to load script file."));
@@ -2099,7 +2101,7 @@ static int ui_create_label(struct cfdisk *cf)
 			refresh_menu = 0;
 		}
 
-		int key = getch();
+		key = getch();
 
 		if (ui_resize)
 			ui_menu_resize(cf);
diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index f4f9b6b1a..cf5dd0052 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -1495,7 +1495,7 @@ static void follow_wipe_mode(struct sfdisk *sf)
 static int wipe_partition(struct sfdisk *sf, size_t partno)
 {
 	int rc, yes = 0;
-	char *fstype = NULL;;
+	char *fstype = NULL;
 	struct fdisk_partition *tmp = NULL;
 
 	DBG(MISC, ul_debug("checking for signature"));
diff --git a/libblkid/src/superblocks/minix.c b/libblkid/src/superblocks/minix.c
index feebc96ad..b8881e574 100644
--- a/libblkid/src/superblocks/minix.c
+++ b/libblkid/src/superblocks/minix.c
@@ -77,6 +77,9 @@ static int probe_minix(blkid_probe pr,
 	unsigned char *ext;
 	const unsigned char *data;
 	int version = 0, swabme = 0;
+	unsigned long zones, ninodes, imaps, zmaps;
+	off_t firstz;
+	size_t zone_size;
 
 	data = blkid_probe_get_buffer(pr, 1024,
 			max(sizeof(struct minix_super_block),
@@ -87,10 +90,6 @@ static int probe_minix(blkid_probe pr,
 	if (version < 1)
 		return 1;
 
-	unsigned long zones, ninodes, imaps, zmaps;
-	off_t firstz;
-	size_t zone_size;
-
 	if (version <= 2) {
 		struct minix_super_block *sb = (struct minix_super_block *) data;
 
diff --git a/text-utils/hexdump-display.c b/text-utils/hexdump-display.c
index ce714f68c..3e017635b 100644
--- a/text-utils/hexdump-display.c
+++ b/text-utils/hexdump-display.c
@@ -299,9 +299,9 @@ void display(struct hexdump *hex)
 			eaddress = address;
 		}
 		list_for_each (p, &endfu->prlist) {
-			pr = list_entry(p, struct hexdump_pr, prlist);
-
 			const char *color = NULL;
+
+			pr = list_entry(p, struct hexdump_pr, prlist);
 			if (colors_wanted() && pr->colorlist
 			    && (color = color_cond(pr, bp, pr->bcnt))) {
 				color_enable(color);
-- 
2.12.0

