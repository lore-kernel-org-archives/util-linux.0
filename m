Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33705 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932605Ab3BKVX7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 11 Feb 2013 16:23:59 -0500
Received: by mail-lb0-f169.google.com with SMTP id m4so4979704lbo.28
        for <util-linux@vger.kernel.org>; Mon, 11 Feb 2013 13:23:57 -0800 (PST)
From: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>
To: util-linux@vger.kernel.org
Cc: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>
Subject: [PATCH 2/2] libblkid: Expose more ISO9660 headers
Date: Mon, 11 Feb 2013 23:22:12 +0200
Message-Id: <1360617732-4770-2-git-send-email-zeeshanak@gnome.org>
In-Reply-To: <1360617732-4770-1-git-send-email-zeeshanak@gnome.org>
References: <1360617732-4770-1-git-send-email-zeeshanak@gnome.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>

In order to kill libosinfo's infamous udev rule[1], we need to make blkid
report the following information as udev properties on IS09660 media so
that libosinfo can make use of that for detection:

1. Volume ID (already exposed as label).
2. System ID.
3. Publisher ID.
4. Application ID.
5. Boot record's boot system ID, (almost always 'EL TORITO
   SPECIFICATION' if boot record is present).

Example use:

$ blkid -o udev Fedora-17-x86_64-DVD.iso
ID_FS_SYSTEM_ID=LINUX
ID_FS_APPLICATION_ID=GENISOIMAGE ISO 9660/HFS FILESYSTEM CREATOR (C)
1993 E.YOUNGDALE
ID_FS_UUID=2012-05-22-20-55-32-00
ID_FS_UUID_ENC=2012-05-22-20-55-32-00
ID_FS_BOOT_SYSTEM_ID=EL TORITO SPECIFICATION
ID_FS_LABEL=Fedora_17_x86_64
ID_FS_LABEL_ENC=Fedora\x2017\x20x86_64
ID_FS_TYPE=iso9660
ID_PART_TABLE_TYPE=dos

[1] https://fedorahosted.org/libosinfo/ticket/1
---
 libblkid/src/superblocks/iso9660.c     | 112 +++++++++++++++++++++++++++++++--
 libblkid/src/superblocks/superblocks.c |  40 ++++++++++++
 libblkid/src/superblocks/superblocks.h |   5 +-
 3 files changed, 151 insertions(+), 6 deletions(-)

diff --git a/libblkid/src/superblocks/iso9660.c b/libblkid/src/superblocks/iso9660.c
index 33a8597..780bfb1 100644
--- a/libblkid/src/superblocks/iso9660.c
+++ b/libblkid/src/superblocks/iso9660.c
@@ -16,6 +16,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <stdint.h>
+#include <ctype.h>
 
 #include "superblocks.h"
 
@@ -41,14 +42,29 @@ struct iso_volume_descriptor {
 	unsigned char	unused[8];
 	unsigned char	space_size[8];
 	unsigned char	escape_sequences[8];
-	unsigned char   unused1[717];
+	unsigned char  unused1[222];
+	unsigned char  publisher_id[128];
+	unsigned char  unused2[128];
+	unsigned char  application_id[128];
+	unsigned char  unused3[111];
 	struct iso9660_date created;
 	struct iso9660_date modified;
 } __attribute__((packed));
 
+/* Boot Record */
+struct boot_record {
+	unsigned char	vd_type;
+	unsigned char	vd_id[5];
+	unsigned char	vd_version;
+	unsigned char	boot_system_id[32];
+	unsigned char	boot_id[32];
+	unsigned char	unused[1];
+} __attribute__((packed));
+
 #define ISO_SUPERBLOCK_OFFSET		0x8000
 #define ISO_SECTOR_SIZE			0x800
 #define ISO_VD_OFFSET			(ISO_SUPERBLOCK_OFFSET + ISO_SECTOR_SIZE)
+#define ISO_VD_BOOT_RECORD		0x0
 #define ISO_VD_SUPPLEMENTARY		0x2
 #define ISO_VD_END			0xff
 #define ISO_VD_MAX			16
@@ -136,6 +152,54 @@ static int probe_iso9660_set_uuid (blkid_probe pr, const struct iso9660_date *da
 	return 1;
 }
 
+/* Adapted copy from libosinfo. */
+static unsigned int is_str_empty(const char *str, size_t len) {
+	unsigned int i;
+	unsigned int ret = 1;
+
+	if (str == NULL || str[0] == 0)
+		return 1;
+
+	for (i = 0; i < len; i++)
+		if (!isspace(str[i])) {
+			ret = 0;
+
+			break;
+		}
+
+	return ret;
+}
+
+/* Adapted copies of g_strstrip, g_strchug and g_strchomp from glib. */
+
+#define strstrip(string, len) strchomp(strchug(string, len), len)
+
+static char *
+strchug (char *string, size_t len)
+{
+	size_t i;
+
+	for (i = 0;  i < len && isspace(string[i]); i++);
+
+	memmove (string, string + i, len - i);
+
+	return string;
+}
+
+static char *
+strchomp (char *string, size_t len)
+{
+	size_t i = len;
+	while (i--) {
+		if (isspace((unsigned char) string[i]))
+			string[i] = '\0';
+		else
+			break;
+}
+
+	return string;
+}
+
 /* iso9660 [+ Microsoft Joliet Extension] */
 static int probe_iso9660(blkid_probe pr, const struct blkid_idmag *mag)
 {
@@ -152,21 +216,59 @@ static int probe_iso9660(blkid_probe pr, const struct blkid_idmag *mag)
 		return -1;
 
 	memcpy(label, iso->volume_id, sizeof(label));
+   if (! is_str_empty(iso->system_id, sizeof(iso->system_id))) {
+		unsigned char system_id[32];
+
+		memcpy(system_id, iso->system_id, sizeof(system_id));
+		strstrip(system_id, sizeof(system_id));
+		blkid_probe_set_system_id(pr, system_id, sizeof(system_id));
+	}
+   if (! is_str_empty(iso->publisher_id, sizeof(iso->publisher_id))) {
+		unsigned char publisher_id[128];
+
+		memcpy(publisher_id, iso->publisher_id, sizeof(publisher_id));
+		strstrip(publisher_id, sizeof(publisher_id));
+		blkid_probe_set_publisher_id(pr, publisher_id, sizeof(publisher_id));
+	}
+   if (! is_str_empty(iso->application_id, sizeof(iso->application_id))) {
+		unsigned char application_id[128];
+
+		memcpy(application_id, iso->application_id, sizeof(application_id));
+		strstrip(application_id, sizeof(application_id));
+		blkid_probe_set_application_id(pr, application_id, sizeof(application_id));
+	}
 
 	/* create an UUID using the modified/created date */
 	if (! probe_iso9660_set_uuid(pr, &iso->modified))
 		probe_iso9660_set_uuid(pr, &iso->created);
 
-	/* Joliet Extension */
+	/* Joliet Extension and Boot Record */
 	off = ISO_VD_OFFSET;
 	for (i = 0; i < ISO_VD_MAX; i++) {
-		iso = (struct iso_volume_descriptor *)
+		struct boot_record *boot= (struct boot_record *)
 			blkid_probe_get_buffer(pr,
 					off,
-					sizeof(struct iso_volume_descriptor));
+					sizeof(struct boot_record));
 
-		if (iso == NULL || iso->vd_type == ISO_VD_END)
+		if (boot == NULL || boot->vd_type == ISO_VD_END)
 			break;
+
+		if (boot->vd_type == ISO_VD_BOOT_RECORD) {
+			if (! is_str_empty(boot->boot_system_id, sizeof(boot->boot_system_id))) {
+				unsigned char boot_system_id[32];
+
+				memcpy(boot_system_id, boot->boot_system_id, sizeof(boot_system_id));
+				strstrip(boot_system_id, sizeof(boot_system_id));
+				blkid_probe_set_boot_system_id(pr, boot_system_id, sizeof(boot_system_id));
+			}
+
+			off += ISO_SECTOR_SIZE;
+			continue;
+		}
+
+		/* Not a Boot record, lets see if its supplemntary volume descriptor */
+		iso = (struct iso_volume_descriptor *) boot;
+
 		if (iso->vd_type != ISO_VD_SUPPLEMENTARY) {
 			off += ISO_SECTOR_SIZE;
 			continue;
diff --git a/libblkid/src/superblocks/superblocks.c b/libblkid/src/superblocks/superblocks.c
index 2929a5f..22f65d5 100644
--- a/libblkid/src/superblocks/superblocks.c
+++ b/libblkid/src/superblocks/superblocks.c
@@ -494,6 +494,46 @@ int blkid_probe_set_version(blkid_probe pr, const char *version)
 	return 0;
 }
 
+int blkid_probe_set_system_id(blkid_probe pr, const char *system_id, size_t len)
+{
+	struct blkid_chain *chn = blkid_probe_get_chain(pr);
+
+	if (chn->flags & BLKID_SUBLKS_LABEL)
+		return blkid_probe_set_value(pr, "SYSTEM_ID",
+					 (unsigned char *) system_id, len);
+	return 0;
+}
+
+int blkid_probe_set_publisher_id(blkid_probe pr, const char *publisher_id, size_t len)
+{
+	struct blkid_chain *chn = blkid_probe_get_chain(pr);
+
+	if (chn->flags & BLKID_SUBLKS_LABEL)
+		return blkid_probe_set_value(pr, "PUBLISHER_ID",
+					 (unsigned char *) publisher_id, len);
+	return 0;
+}
+
+int blkid_probe_set_application_id(blkid_probe pr, const char *application_id, size_t len)
+{
+	struct blkid_chain *chn = blkid_probe_get_chain(pr);
+
+	if (chn->flags & BLKID_SUBLKS_LABEL)
+		return blkid_probe_set_value(pr, "APPLICATION_ID",
+					(unsigned char *) application_id, len);
+	return 0;
+}
+
+int blkid_probe_set_boot_system_id(blkid_probe pr, const char *boot_system_id, size_t len)
+{
+	struct blkid_chain *chn = blkid_probe_get_chain(pr);
+
+	if (chn->flags & BLKID_SUBLKS_LABEL)
+		return blkid_probe_set_value(pr, "BOOT_SYSTEM_ID",
+					 (unsigned char *) boot_system_id, len);
+	return 0;
+}
+
 int blkid_probe_sprintf_version(blkid_probe pr, const char *fmt, ...)
 {
 	struct blkid_chain *chn = blkid_probe_get_chain(pr);
diff --git a/libblkid/src/superblocks/superblocks.h b/libblkid/src/superblocks/superblocks.h
index 08f1438..f20ed42 100644
--- a/libblkid/src/superblocks/superblocks.h
+++ b/libblkid/src/superblocks/superblocks.h
@@ -87,6 +87,9 @@ extern int blkid_probe_strncpy_uuid(blkid_probe pr, unsigned char *str, size_t l
 
 extern int blkid_probe_set_uuid(blkid_probe pr, unsigned char *uuid);
 extern int blkid_probe_set_uuid_as(blkid_probe pr, unsigned char *uuid, const char *name);
-
+extern int blkid_probe_set_system_id(blkid_probe pr, const char *system_id, size_t len);
+extern int blkid_probe_set_publisher_id(blkid_probe pr, const char *publisher_id, size_t len);
+extern int blkid_probe_set_application_id(blkid_probe pr, const char *application_id, size_t len);
+extern int blkid_probe_set_boot_system_id(blkid_probe pr, const char *boot_system_id, size_t len);
 
 #endif /* _BLKID_SUPERBLOCKS_H */
-- 
1.8.1.2

