Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:52755 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753430AbdFMPdI (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 13 Jun 2017 11:33:08 -0400
Received: from adsiz.fritz.box ([146.52.24.88]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWxtA-1dHcQq2e3g-00W1TO for
 <util-linux@vger.kernel.org>; Tue, 13 Jun 2017 17:32:36 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/5] libfdisk: fix guid usage of packed structure gpt_entry
Date: Tue, 13 Jun 2017 17:32:32 +0200
Message-Id: <20170613153235.11164-3-sweet_f_a@gmx.de>
In-Reply-To: <20170613153235.11164-1-sweet_f_a@gmx.de>
References: <20170613153235.11164-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

clang issued warnings like this:

../libfdisk/src/gpt.c:371:18: warning: taking address of packed member 'type' of class or structure 'gpt_entry' may result in an unaligned pointer value [-Waddress-of-packed-member]
        guid_to_string(&e->type, str);
                        ^~~~~~~

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libfdisk/src/gpt.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index 249feb74d..40d0912ec 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -367,8 +367,9 @@ static struct fdisk_parttype *gpt_partition_parttype(
 {
 	struct fdisk_parttype *t;
 	char str[37];
+	struct gpt_guid guid = e->type;
 
-	guid_to_string(&e->type, str);
+	guid_to_string(&guid, str);
 	t = fdisk_label_get_parttype_from_string(cxt->label, str);
 	return t ? : fdisk_new_unknown_parttype(0, str);
 }
@@ -376,7 +377,7 @@ static struct fdisk_parttype *gpt_partition_parttype(
 static void gpt_entry_set_type(struct gpt_entry *e, struct gpt_guid *uuid)
 {
 	e->type = *uuid;
-	DBG(LABEL, gpt_debug_uuid("new type", &(e->type)));
+	DBG(LABEL, gpt_debug_uuid("new type", uuid));
 }
 
 static void gpt_entry_set_name(struct gpt_entry *e, char *str)
@@ -480,8 +481,9 @@ static inline int gpt_sizeof_ents(struct gpt_header *hdr, size_t *sz)
 static char *gpt_get_header_id(struct gpt_header *header)
 {
 	char str[37];
+	struct gpt_guid guid = header->disk_guid;
 
-	guid_to_string(&header->disk_guid, str);
+	guid_to_string(&guid, str);
 
 	return strdup(str);
 }
@@ -742,13 +744,18 @@ static int gpt_mknew_header(struct fdisk_context *cxt,
 
 	if (cxt->script) {
 		const char *id = fdisk_script_get_header(cxt->script, "label-id");
-		if (id && string_to_guid(id, &header->disk_guid) == 0)
+		struct gpt_guid guid = header->disk_guid;
+		if (id && string_to_guid(id, &guid) == 0)
 			has_id = 1;
+		header->disk_guid = guid;
 	}
 
 	if (!has_id) {
+		struct gpt_guid guid;
+
 		uuid_generate_random((unsigned char *) &header->disk_guid);
-		swap_efi_guid(&header->disk_guid);
+		guid = header->disk_guid;
+		swap_efi_guid(&guid);
 	}
 	return 0;
 }
@@ -1727,6 +1734,7 @@ static int gpt_get_partition(struct fdisk_context *cxt, size_t n,
 	struct gpt_entry *e;
 	char u_str[37];
 	int rc = 0;
+	struct gpt_guid guid;
 
 	assert(cxt);
 	assert(cxt->label);
@@ -1748,7 +1756,8 @@ static int gpt_get_partition(struct fdisk_context *cxt, size_t n,
 	pa->size = gpt_partition_size(e);
 	pa->type = gpt_partition_parttype(cxt, e);
 
-	if (guid_to_string(&e->partition_guid, u_str)) {
+	guid = e->partition_guid;
+	if (guid_to_string(&guid, u_str)) {
 		pa->uuid = strdup(u_str);
 		if (!pa->uuid) {
 			rc = -errno;
@@ -1794,12 +1803,15 @@ static int gpt_set_partition(struct fdisk_context *cxt, size_t n,
 
 	if (pa->uuid) {
 		char new_u[37], old_u[37];
+		struct gpt_guid guid;
 
-		guid_to_string(&e->partition_guid, old_u);
+		guid = e->partition_guid;
+		guid_to_string(&guid, old_u);
 		rc = gpt_entry_set_uuid(e, pa->uuid);
 		if (rc)
 			return rc;
-		guid_to_string(&e->partition_guid, new_u);
+		guid = e->partition_guid;
+		guid_to_string(&guid, new_u);
 		fdisk_info(cxt, _("Partition UUID changed from %s to %s."),
 			old_u, new_u);
 	}
@@ -2404,8 +2416,11 @@ static int gpt_add_partition(
 		 * generated for that partition, and every partition is guaranteed
 		 * to have a unique GUID.
 		 */
+		struct gpt_guid guid;
+
 		uuid_generate_random((unsigned char *) &e->partition_guid);
-		swap_efi_guid(&e->partition_guid);
+		guid = e->partition_guid;
+		swap_efi_guid(&guid);
 	}
 
 	if (pa && pa->name && *pa->name)
@@ -2451,6 +2466,7 @@ static int gpt_create_disklabel(struct fdisk_context *cxt)
 	size_t esz = 0;
 	char str[37];
 	struct fdisk_gpt_label *gpt;
+	struct gpt_guid guid;
 
 	assert(cxt);
 	assert(cxt->label);
@@ -2508,7 +2524,8 @@ static int gpt_create_disklabel(struct fdisk_context *cxt)
 	cxt->label->nparts_max = gpt_get_nentries(gpt);
 	cxt->label->nparts_cur = 0;
 
-	guid_to_string(&gpt->pheader->disk_guid, str);
+	guid = gpt->pheader->disk_guid;
+	guid_to_string(&guid, str);
 	fdisk_label_set_changed(cxt->label, 1);
 	fdisk_info(cxt, _("Created a new GPT disklabel (GUID: %s)."), str);
 done:
-- 
2.12.3

