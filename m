Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbhh.dreamhost.com ([208.97.132.177]:52929 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752128Ab2GVRFJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 22 Jul 2012 13:05:09 -0400
Subject: [PATCH 02/10] fdisk: API: add to label operations to context
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 22 Jul 2012 19:05:01 +0200
Message-ID: <1342976701.2863.12.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

The context structure is the fdisk API's main data type as it keeps all data together. Add the
label structure to it, so that the pt-specific operations can be called from the context.

The internal probing function is updated so that if a label is not probed, for example when a
disk is not formated, it will default to use either sun or dos label operations. This avoids
scenarios that could crash the program if no label is detected - ie: right after creating a device.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/fdisk.c |    4 ++--
 fdisks/fdisk.h |   23 +++++++++++++++--------
 fdisks/utils.c |   35 ++++++++++++++++++++++++++++-------
 3 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index 3b9bd7b..46322bc 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -68,7 +68,7 @@ int MBRbuffer_changed;
 struct menulist_descr {
 	char command;				/* command key */
 	char *description;			/* command description */
-	enum labeltype label[2];		/* disklabel types associated with main and expert menu */
+	enum fdisk_labeltype label[2];		/* disklabel types associated with main and expert menu */
 };
 
 static const struct menulist_descr menulist[] = {
@@ -138,7 +138,7 @@ unsigned int	user_cylinders, user_heads, user_sectors;
 sector_t sector_offset = 1;
 unsigned int units_per_sector = 1, display_in_cyl_units = 0;
 unsigned long grain = DEFAULT_SECTOR_SIZE;
-enum labeltype disklabel;	/* Current disklabel */
+enum fdisk_labeltype disklabel;	/* Current disklabel */
 
 static void __attribute__ ((__noreturn__)) usage(FILE *out)
 {
diff --git a/fdisks/fdisk.h b/fdisks/fdisk.h
index 8107aa8..d716824 100644
--- a/fdisks/fdisk.h
+++ b/fdisks/fdisk.h
@@ -132,6 +132,8 @@ struct fdisk_context {
 	/* geometry */
 	sector_t total_sectors; /* in logical sectors */
 	struct fdisk_geometry geom;
+
+	struct fdisk_label *label;
 };
 
 /*
@@ -139,6 +141,8 @@ struct fdisk_context {
  */
 struct fdisk_label {
 	const char *name;
+
+	/* probe disk label */
 	int (*probe)(struct fdisk_context *cxt);
 };
 
@@ -206,17 +210,20 @@ extern const char * str_units(int);
 
 extern sector_t get_nr_sects(struct partition *p);
 
-enum labeltype {
+/*
+ * Supported partition table types (labels)
+ */
+enum fdisk_labeltype {
+	ANY_LABEL = -1,
 	DOS_LABEL = 1,
-	SUN_LABEL = 2,
-	SGI_LABEL = 4,
-	AIX_LABEL = 8,
-	OSF_LABEL = 16,
-	MAC_LABEL = 32,
-	ANY_LABEL = -1
+	SUN_LABEL,
+	SGI_LABEL,
+	AIX_LABEL,
+	OSF_LABEL,
+	MAC_LABEL,
 };
 
-extern enum labeltype disklabel;
+extern enum fdisk_labeltype disklabel;
 extern int MBRbuffer_changed;
 extern unsigned long grain;
 
diff --git a/fdisks/utils.c b/fdisks/utils.c
index 363f7aa..cf9484c 100644
--- a/fdisks/utils.c
+++ b/fdisks/utils.c
@@ -36,11 +36,11 @@ int fdisk_debug_mask;
  */
 static const struct fdisk_label *labels[] =
 {
-	&bsd_label,
 	&dos_label,
-	&sgi_label,
 	&sun_label,
+	&sgi_label,
 	&aix_label,
+	&bsd_label,
 	&mac_label,
 };
 
@@ -51,14 +51,34 @@ static int __probe_labels(struct fdisk_context *cxt)
 	disklabel = ANY_LABEL;
 	update_units(cxt);
 
+	cxt->label = calloc(1, sizeof(struct fdisk_label));
+	if (!cxt->label) {
+		rc = FDISK_ERROR_MEM;
+		goto done;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(labels); i++) {
 		rc = labels[i]->probe(cxt);
-		if (!rc) {
-			DBG(LABEL, dbgprint("detected a %s label\n",
-					    labels[i]->name));
-			goto done;
-		}
+		if (rc)
+			continue;
+		
+		/* found the label */
+		DBG(LABEL, dbgprint("detected a %s label\n", labels[i]->name));
+		goto copy;
 	}
+
+	/*
+	 * Did not find any label - perhaps un formated;
+	 * initialize with default partition operations.
+	 */
+#ifdef __sparc__
+	i = OSF_LABEL - 1;
+#else
+	i = DOS_LABEL - 1;
+#endif
+	DBG(LABEL, dbgprint("defaulting to a %s label\n", labels[i]->name));
+copy:
+	memcpy(cxt->label, labels[i], sizeof(struct fdisk_label));
 done:
 	return rc;
 }
@@ -380,6 +400,7 @@ void fdisk_free_context(struct fdisk_context *cxt)
 	DBG(CONTEXT, dbgprint("freeing context for %s", cxt->dev_path));
 	close(cxt->dev_fd);
 	free(cxt->dev_path);
+	free(cxt->label);
 	free(cxt->mbr);
 	free(cxt);
 }
-- 
1.7.4.1




