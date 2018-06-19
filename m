Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33348 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937339AbeFSKd3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 19 Jun 2018 06:33:29 -0400
Received: by mail-wm0-f68.google.com with SMTP id z6-v6so18359323wma.0
        for <util-linux@vger.kernel.org>; Tue, 19 Jun 2018 03:33:29 -0700 (PDT)
From: Milan Broz <gmazyland@gmail.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <gmazyland@gmail.com>
Subject: [PATCH] lsblk: add partition table UUID and type fields.
Date: Tue, 19 Jun 2018 12:33:20 +0200
Message-Id: <20180619103320.13203-1-gmazyland@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch adds PTUUID and PTTYPE fields to lsblk, that are corresponding
fields to ID_PART_TABLE_UUID and ID_PART_TABLE_TYPE in udev database.

Signed-off-by: Milan Broz <gmazyland@gmail.com>
---
 misc-utils/lsblk.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index fadef65c4..8586ea35c 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -92,6 +92,8 @@ enum {
 	COL_TARGET,
 	COL_LABEL,
 	COL_UUID,
+	COL_PTUUID,
+	COL_PTTYPE,
 	COL_PARTTYPE,
 	COL_PARTLABEL,
 	COL_PARTUUID,
@@ -172,6 +174,9 @@ static struct colinfo infos[] = {
 	[COL_LABEL]  = { "LABEL",   0.1, 0, N_("filesystem LABEL") },
 	[COL_UUID]   = { "UUID",    36,  0, N_("filesystem UUID") },
 
+	[COL_PTUUID] = { "PTUUID",  36,  0, N_("partition table UUID") },
+	[COL_PTTYPE] = { "PTTYPE",  0.1, 0, N_("partition table type") },
+
 	[COL_PARTTYPE]  = { "PARTTYPE",  36,  0, N_("partition type UUID") },
 	[COL_PARTLABEL] = { "PARTLABEL", 0.1, 0, N_("partition LABEL") },
 	[COL_PARTUUID]  = { "PARTUUID",  36,  0, N_("partition UUID") },
@@ -285,6 +290,8 @@ struct blkdev_cxt {
 	int probed;		/* already probed */
 	char *fstype;		/* detected fs, NULL or "?" if cannot detect */
 	char *uuid;		/* filesystem UUID (or stack uuid) */
+	char *ptuuid;		/* partition table UUID */
+	char *pttype;		/* partition table type */
 	char *label;		/* filesystem label */
 	char *parttype;		/* partition type UUID */
 	char *partuuid;		/* partition UUID */
@@ -394,6 +401,8 @@ static void reset_blkdev_cxt(struct blkdev_cxt *cxt)
 	free(cxt->filename);
 	free(cxt->fstype);
 	free(cxt->uuid);
+	free(cxt->ptuuid);
+	free(cxt->pttype);
 	free(cxt->label);
 	free(cxt->parttype);
 	free(cxt->partuuid);
@@ -552,6 +561,10 @@ static int get_udev_properties(struct blkdev_cxt *cxt)
 			cxt->uuid = xstrdup(data);
 			unhexmangle_string(cxt->uuid);
 		}
+		if ((data = udev_device_get_property_value(dev, "ID_PART_TABLE_UUID")))
+			cxt->ptuuid = xstrdup(data);
+		if ((data = udev_device_get_property_value(dev, "ID_PART_TABLE_TYPE")))
+			cxt->pttype = xstrdup(data);
 		if ((data = udev_device_get_property_value(dev, "ID_PART_ENTRY_NAME"))) {
 			cxt->partlabel = xstrdup(data);
 			unhexmangle_string(cxt->partlabel);
@@ -621,6 +634,10 @@ static void probe_device(struct blkdev_cxt *cxt)
 			cxt->fstype = xstrdup(data);
 		if (!blkid_probe_lookup_value(pr, "UUID", &data, NULL))
 			cxt->uuid = xstrdup(data);
+		if (!blkid_probe_lookup_value(pr, "PTUUID", &data, NULL))
+			cxt->ptuuid = xstrdup(data);
+		if (!blkid_probe_lookup_value(pr, "PTTYPE", &data, NULL))
+			cxt->pttype = xstrdup(data);
 		if (!blkid_probe_lookup_value(pr, "LABEL", &data, NULL))
 			cxt->label = xstrdup(data);
 		if (!blkid_probe_lookup_value(pr, "PART_ENTRY_TYPE", &data, NULL))
@@ -964,6 +981,16 @@ static void set_scols_data(struct blkdev_cxt *cxt, int col, int id, struct libsc
 		if (cxt->uuid)
 			str = xstrdup(cxt->uuid);
 		break;
+	case COL_PTUUID:
+		probe_device(cxt);
+		if (cxt->ptuuid)
+			str = xstrdup(cxt->ptuuid);
+		break;
+	case COL_PTTYPE:
+		probe_device(cxt);
+		if (cxt->pttype)
+			str = xstrdup(cxt->pttype);
+		break;
 	case COL_PARTTYPE:
 		probe_device(cxt);
 		if (cxt->parttype)
-- 
2.17.1

