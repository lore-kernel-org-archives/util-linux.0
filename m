Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f44.google.com ([209.85.215.44]:49837 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932675Ab3BLBde (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 11 Feb 2013 20:33:34 -0500
Received: by mail-la0-f44.google.com with SMTP id eb20so6434364lab.3
        for <util-linux@vger.kernel.org>; Mon, 11 Feb 2013 17:33:32 -0800 (PST)
From: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>
To: util-linux@vger.kernel.org
Cc: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>
Subject: [PATCH] libblkid: Probe UDF volumes for ISO9660 info as well
Date: Tue, 12 Feb 2013 03:33:18 +0200
Message-Id: <1360632798-26184-1-git-send-email-zeeshanak@gnome.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>

I have seen blkid failing to report any meaningful data on some of UDF
volumes I have (Windows installer media):

$ ./blkid -o udev en_windows_7_professional_with_sp1_x64_dvd_u_676939.iso
ID_FS_LABEL=UDF_Volume
ID_FS_LABEL_ENC=UDF\x20Volume
ID_FS_TYPE=udf

Also, once my patches to expose more of ISO9660 info get merged, we'd
also need the same info to be exposed for UDF volumes.

This patch adds ISO9660 probing to UDF volumes and here is the result I
see on my example UDF volume (together with my pending patch to expose
more ISO9660 information):

$ ./blkid -o udev en_windows_7_professional_with_sp1_x64_dvd_u_676939.iso
ID_FS_PUBLISHER_ID=MICROSOFT CORPORATION
ID_FS_APPLICATION_ID=CDIMAGE 2.54 (01/01/2005 TM)
ID_FS_UUID=2011-04-12-02-38-58-00
ID_FS_UUID_ENC=2011-04-12-02-38-58-00
ID_FS_BOOT_SYSTEM_ID=EL TORITO SPECIFICATION
ID_FS_LABEL=GSP1RMCPRXFRER_EN_DVD
ID_FS_LABEL_ENC=GSP1RMCPRXFRER_EN_DVD
ID_FS_TYPE=iso9660

$ ./blkid -o udev en_windows_xp_professional_with_service_pack_3_x86_cd_x14-80428.iso
ID_FS_PUBLISHER_ID=MICROSOFT CORPORATION
ID_FS_APPLICATION_ID=CDIMAGE 2.52 (03/09/2004 TM)
ID_FS_UUID=2008-04-14-12-00-00-00
ID_FS_UUID_ENC=2008-04-14-12-00-00-00
ID_FS_BOOT_SYSTEM_ID=EL TORITO SPECIFICATION
ID_FS_LABEL=GRTMPFPP_EN
ID_FS_LABEL_ENC=GRTMPFPP_EN
ID_FS_TYPE=iso9660

Before anyone asks, Yes! The UDF media I have is all legal and downloaded
directly from MSDN. :)
---
 libblkid/src/Makemodule.am         |  1 +
 libblkid/src/superblocks/iso9660.c |  2 +-
 libblkid/src/superblocks/iso9660.h | 14 ++++++++++++++
 libblkid/src/superblocks/udf.c     |  4 +++-
 4 files changed, 19 insertions(+), 2 deletions(-)
 create mode 100644 libblkid/src/superblocks/iso9660.h

diff --git a/libblkid/src/Makemodule.am b/libblkid/src/Makemodule.am
index de60458..8152564 100644
--- a/libblkid/src/Makemodule.am
+++ b/libblkid/src/Makemodule.am
@@ -59,6 +59,7 @@ libblkid_la_SOURCES = \
 	libblkid/src/superblocks/highpoint_raid.c \
 	libblkid/src/superblocks/hpfs.c \
 	libblkid/src/superblocks/iso9660.c \
+	libblkid/src/superblocks/iso9660.h \
 	libblkid/src/superblocks/isw_raid.c \
 	libblkid/src/superblocks/jfs.c \
 	libblkid/src/superblocks/jmicron_raid.c \
diff --git a/libblkid/src/superblocks/iso9660.c b/libblkid/src/superblocks/iso9660.c
index 780bfb1..c53ed9f 100644
--- a/libblkid/src/superblocks/iso9660.c
+++ b/libblkid/src/superblocks/iso9660.c
@@ -201,7 +201,7 @@ strchomp (char *string, size_t len)
 }
 
 /* iso9660 [+ Microsoft Joliet Extension] */
-static int probe_iso9660(blkid_probe pr, const struct blkid_idmag *mag)
+int probe_iso9660(blkid_probe pr, const struct blkid_idmag *mag)
 {
 	struct iso_volume_descriptor *iso;
 	unsigned char label[32];
diff --git a/libblkid/src/superblocks/iso9660.h b/libblkid/src/superblocks/iso9660.h
new file mode 100644
index 0000000..a8d729d
--- /dev/null
+++ b/libblkid/src/superblocks/iso9660.h
@@ -0,0 +1,14 @@
+/*
+ * Copyright (C) 2013 Zeeshan Ali (Khattak) <zeeshanak@gnome.org>
+ *
+ * This file may be redistributed under the terms of the
+ * GNU Lesser General Public License.
+ */
+#ifndef _BLKID_ISO9660_H
+#define _BLKID_ISO9660_H
+
+#include "blkidP.h"
+
+extern int probe_iso9660(blkid_probe pr, const struct blkid_idmag *mag);
+
+#endif /* _BLKID_ISO9660_H */
diff --git a/libblkid/src/superblocks/udf.c b/libblkid/src/superblocks/udf.c
index a5afc5c..6d66627 100644
--- a/libblkid/src/superblocks/udf.c
+++ b/libblkid/src/superblocks/udf.c
@@ -17,6 +17,7 @@
 #include <stdint.h>
 
 #include "superblocks.h"
+#include "iso9660.h"
 
 struct volume_descriptor {
 	struct descriptor_tag {
@@ -145,7 +146,8 @@ anchor:
 		}
 	}
 
-	return 0;
+	/* Also extract all possible ISO9660 information */
+	return probe_iso9660(pr, mag);
 }
 
 
-- 
1.8.1.2

