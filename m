Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcaib.dreamhost.com ([208.97.132.81]:32834 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752277Ab2GHVkb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Jul 2012 17:40:31 -0400
Subject: [PATCH] fdisk: API: add label probing functionality
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 08 Jul 2012 23:40:27 +0200
Message-ID: <1341783627.2628.10.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

This patch sets the initial layout for label specific operations. A new fdisk_label structure
is created that will hold all these ops, like new, delete, write and probe, among others. For
now only probing is implemented. Once this design is established, a copy of the probed label
will be copied to the main context structure, where calling the specific functions will save
'disklabel' checks. Debugging support is added as well.

This patch passes regression tests and manually passes bsd, sun, dos and sgi labels probes.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
The message that informs users that there's both DOS and BSD magic as been removed. The patch can
be updated should this present backward compatibility debates.

 fdisks/fdisk.c         |   21 ---------------------
 fdisks/fdisk.h         |   19 +++++++++++++++++++
 fdisks/fdiskaixlabel.c |    8 +++++++-
 fdisks/fdiskaixlabel.h |    2 --
 fdisks/fdiskbsdlabel.c |    8 +++++++-
 fdisks/fdiskbsdlabel.h |    1 -
 fdisks/fdiskdoslabel.c |    8 +++++++-
 fdisks/fdiskdoslabel.h |    1 -
 fdisks/fdiskmaclabel.c |    8 +++++++-
 fdisks/fdiskmaclabel.h |    1 -
 fdisks/fdisksgilabel.c |    8 +++++++-
 fdisks/fdisksgilabel.h |    1 -
 fdisks/fdisksunlabel.c |    8 +++++++-
 fdisks/fdisksunlabel.h |    1 -
 fdisks/utils.c         |   35 +++++++++++++++++++++++++++++++++++
 15 files changed, 96 insertions(+), 34 deletions(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index 748badf..ddbb357 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -520,27 +520,6 @@ update_sector_offset(struct fdisk_context *cxt)
  *    1: I/O error
  */
 static int get_boot(struct fdisk_context *cxt, int try_only) {
-
-	disklabel = ANY_LABEL;
-	update_units(cxt);
-
-	if (!check_dos_label(cxt))
-		if (check_sun_label(cxt) || check_sgi_label(cxt) || check_aix_label(cxt)
-		    || check_mac_label(cxt))
-			return 0;
-
-	if (check_osf_label(cxt)) {
-		/* intialize partitions for BSD as well */
-		dos_init(cxt);
-		if (!valid_part_table_flag(cxt->mbr)) {
-			disklabel = OSF_LABEL;
-			return 0;
-		}
-		printf(_("This disk has both DOS and BSD magic.\n"
-			 "Give the 'b' command to go to BSD mode.\n"));
-		return 0;
-	}
-
 	if (disklabel == ANY_LABEL) {
 		if (try_only)
 			return -1;
diff --git a/fdisks/fdisk.h b/fdisks/fdisk.h
index 51a63b2..64a8147 100644
--- a/fdisks/fdisk.h
+++ b/fdisks/fdisk.h
@@ -37,6 +37,7 @@
 #define FDISK_DEBUG_CONTEXT	(1 << 2)
 #define FDISK_DEBUG_TOPOLOGY    (1 << 3)
 #define FDISK_DEBUG_GEOMETRY    (1 << 4)
+#define FDISK_DEBUG_LABEL       (1 << 5)
 #define FDISK_DEBUG_ALL		0xFFFF
 
 # define ON_DBG(m, x)	do { \
@@ -125,6 +126,24 @@ struct fdisk_context {
 	struct fdisk_geometry geom;
 };
 
+/*
+ * Label specific operations
+ */
+struct fdisk_label {
+	const char *name;
+	int (*probe)(struct fdisk_context *cxt);
+};
+
+/*
+ * labels
+ */
+extern const struct fdisk_label aix_label;
+extern const struct fdisk_label dos_label;
+extern const struct fdisk_label bsd_label;
+extern const struct fdisk_label mac_label;
+extern const struct fdisk_label sun_label;
+extern const struct fdisk_label sgi_label;
+
 extern struct fdisk_context *fdisk_new_context_from_filename(const char *fname, int readonly);
 extern int fdisk_dev_has_topology(struct fdisk_context *cxt);
 extern int fdisk_dev_sectsz_is_default(struct fdisk_context *cxt);
diff --git a/fdisks/fdiskaixlabel.c b/fdisks/fdiskaixlabel.c
index 438647b..474a177 100644
--- a/fdisks/fdiskaixlabel.c
+++ b/fdisks/fdiskaixlabel.c
@@ -49,7 +49,7 @@ aix_nolabel(struct fdisk_context *cxt)
     return;
 }
 
-int check_aix_label(struct fdisk_context *cxt)
+static int check_aix_label(struct fdisk_context *cxt)
 {
     if (aixlabel->magic != AIX_LABEL_MAGIC &&
 	aixlabel->magic != AIX_LABEL_MAGIC_SWAPPED) {
@@ -65,3 +65,9 @@ int check_aix_label(struct fdisk_context *cxt)
     aix_nolabel(cxt);		/* %% */
     return 1;
 }
+
+const struct fdisk_label aix_label =
+{
+	.name = "aix",
+	.probe = check_aix_label
+};
diff --git a/fdisks/fdiskaixlabel.h b/fdisks/fdiskaixlabel.h
index bd4cb27..ea7aebd 100644
--- a/fdisks/fdiskaixlabel.h
+++ b/fdisks/fdiskaixlabel.h
@@ -22,6 +22,4 @@ typedef struct {
 
 /* fdiskaixlabel.c */
 extern struct	systypes aix_sys_types[];
-extern int	check_aix_label(struct fdisk_context *cxt);
-
 #endif /* FDISK_AIX_LABEL_H */
diff --git a/fdisks/fdiskbsdlabel.c b/fdisks/fdiskbsdlabel.c
index 53c8ad5..9ede3ef 100644
--- a/fdisks/fdiskbsdlabel.c
+++ b/fdisks/fdiskbsdlabel.c
@@ -109,7 +109,7 @@ static struct xbsd_disklabel xbsd_dlabel;
  * Note: often reformatting with DOS-type label leaves the BSD magic,
  * so this does not mean that there is a BSD disk label.
  */
-int
+static int
 check_osf_label(struct fdisk_context *cxt) {
 	if (xbsd_readlabel (cxt, NULL, &xbsd_dlabel) == 0)
 		return 0;
@@ -845,3 +845,9 @@ alpha_bootblock_checksum (char *boot)
   dp[63] = sum;
 }
 #endif /* __alpha__ */
+
+const struct fdisk_label bsd_label =
+{
+	.name = "bsd",
+	.probe = check_osf_label
+};
diff --git a/fdisks/fdiskbsdlabel.h b/fdisks/fdiskbsdlabel.h
index 3a198fe..ab6877e 100644
--- a/fdisks/fdiskbsdlabel.h
+++ b/fdisks/fdiskbsdlabel.h
@@ -239,7 +239,6 @@ static struct systypes xbsd_fstypes[] = {
 #define	BSD_D_DOSPART	0x20		/* within MSDOS partition */
 
 extern void bsd_command_prompt(struct fdisk_context *cxt);
-extern int check_osf_label(struct fdisk_context *cxt);
 extern int btrydev(struct fdisk_context *cxt);
 extern void xbsd_print_disklabel(struct fdisk_context *cxt, int);
 
diff --git a/fdisks/fdiskdoslabel.c b/fdisks/fdiskdoslabel.c
index a72a432..27536da 100644
--- a/fdisks/fdiskdoslabel.c
+++ b/fdisks/fdiskdoslabel.c
@@ -316,7 +316,7 @@ void dos_delete_partition(int i)
 	}
 }
 
-int check_dos_label(struct fdisk_context *cxt)
+static int check_dos_label(struct fdisk_context *cxt)
 {
 	int i;
 
@@ -680,3 +680,9 @@ void dos_write_table(struct fdisk_context *cxt)
 		}
 	}
 }
+
+const struct fdisk_label dos_label =
+{
+	.name = "dos",
+	.probe = check_dos_label,
+};
diff --git a/fdisks/fdiskdoslabel.h b/fdisks/fdiskdoslabel.h
index f64a4ce..608e3f7 100644
--- a/fdisks/fdiskdoslabel.h
+++ b/fdisks/fdiskdoslabel.h
@@ -47,7 +47,6 @@ extern void create_doslabel(struct fdisk_context *cxt);
 extern void dos_print_mbr_id(struct fdisk_context *cxt);
 extern void dos_set_mbr_id(struct fdisk_context *cxt);
 extern void dos_delete_partition(int i);
-extern int check_dos_label(struct fdisk_context *cxt);
 extern int is_dos_partition(int t);
 extern void dos_init(struct fdisk_context *cxt);
 extern void dos_add_partition(struct fdisk_context *cxt, int n, int sys);
diff --git a/fdisks/fdiskmaclabel.c b/fdisks/fdiskmaclabel.c
index 561189a..1b82660 100644
--- a/fdisks/fdiskmaclabel.c
+++ b/fdisks/fdiskmaclabel.c
@@ -47,7 +47,7 @@ mac_nolabel(struct fdisk_context *cxt)
     return;
 }
 
-int
+static int
 check_mac_label(struct fdisk_context *cxt)
 {
 	/*
@@ -80,3 +80,9 @@ IS_MAC:
     mac_nolabel(cxt);		/* %% */
     return 1;
 }
+
+const struct fdisk_label mac_label =
+{
+	.name = "mac",
+	.probe = check_mac_label
+};
diff --git a/fdisks/fdiskmaclabel.h b/fdisks/fdiskmaclabel.h
index 8d9430a..9966849 100644
--- a/fdisks/fdiskmaclabel.h
+++ b/fdisks/fdiskmaclabel.h
@@ -33,6 +33,5 @@ typedef struct {
 /* fdiskmaclabel.c */
 extern struct	systypes mac_sys_types[];
 extern void	mac_nolabel(struct fdisk_context *cxt);
-extern int	check_mac_label(struct fdisk_context *cxt);
 
 #endif /* FDISK_MAC_LABEL_H */
diff --git a/fdisks/fdisksgilabel.c b/fdisks/fdisksgilabel.c
index 09b3ca5..32dae78 100644
--- a/fdisks/fdisksgilabel.c
+++ b/fdisks/fdisksgilabel.c
@@ -127,7 +127,7 @@ two_s_complement_32bit_sum(unsigned int *base, int size /* in bytes */) {
 	return sum;
 }
 
-int
+static int
 check_sgi_label(struct fdisk_context *cxt) {
 	if (sizeof(sgilabel) > 512) {
 		fprintf(stderr,
@@ -877,3 +877,9 @@ fill_sgiinfo(void)
 	strcpy((char *) info->installer, "Sfx version 5.3, Oct 18, 1994");
 	return info;
 }
+
+const struct fdisk_label sgi_label =
+{
+	.name = "sgi",
+	.probe = check_sgi_label
+};
diff --git a/fdisks/fdisksgilabel.h b/fdisks/fdisksgilabel.h
index 0c76edb..f6b88e8 100644
--- a/fdisks/fdisksgilabel.h
+++ b/fdisks/fdisksgilabel.h
@@ -111,7 +111,6 @@ typedef struct {
 
 /* fdisksgilabel.c */
 extern struct	systypes sgi_sys_types[];
-extern int	check_sgi_label(struct fdisk_context *cxt);
 extern void	sgi_list_table( struct fdisk_context *cxt, int xtra );
 extern int  sgi_change_sysid(struct fdisk_context *cxt, int i, int sys);
 extern unsigned int	sgi_get_start_sector(struct fdisk_context *cxt, int i );
diff --git a/fdisks/fdisksunlabel.c b/fdisks/fdisksunlabel.c
index 985a976..d1f6054 100644
--- a/fdisks/fdisksunlabel.c
+++ b/fdisks/fdisksunlabel.c
@@ -78,7 +78,7 @@ static void init(void)
 	partitions = SUN_NUM_PARTITIONS;
 }
 
-int check_sun_label(struct fdisk_context *cxt)
+static int check_sun_label(struct fdisk_context *cxt)
 {
 	unsigned short *ush;
 	int csum;
@@ -642,3 +642,9 @@ int sun_get_sysid(struct fdisk_context *cxt, int i)
 {
 	return SSWAP16(sunlabel->part_tags[i].tag);
 }
+
+const struct fdisk_label sun_label =
+{
+	.name = "sun",
+	.probe = check_sun_label,
+};
diff --git a/fdisks/fdisksunlabel.h b/fdisks/fdisksunlabel.h
index abb29c3..9779e22 100644
--- a/fdisks/fdisksunlabel.h
+++ b/fdisks/fdisksunlabel.h
@@ -77,7 +77,6 @@ struct sun_disk_label {
 
 /* fdisksunlabel.c */
 extern struct systypes sun_sys_types[];
-extern int check_sun_label(struct fdisk_context *cxt);
 extern void create_sunlabel(struct fdisk_context *cxt);
 extern void sun_delete_partition(struct fdisk_context *cxt, int i);
 extern int sun_change_sysid(struct fdisk_context *cxt, int i, uint16_t sys);
diff --git a/fdisks/utils.c b/fdisks/utils.c
index 04ad0a5..1c075a9 100644
--- a/fdisks/utils.c
+++ b/fdisks/utils.c
@@ -31,6 +31,39 @@
 
 int fdisk_debug_mask;
 
+/*
+ * label probing functions
+ */
+static const struct fdisk_label *labels[] =
+{
+	&bsd_label,
+	&dos_label,
+	&sgi_label,
+	&sun_label,
+	&aix_label,
+	&mac_label,
+};
+
+static int __probe_labels(struct fdisk_context *cxt)
+{
+	int i, rc = 0;
+	
+	disklabel = ANY_LABEL;
+	update_units(cxt);
+
+	for (i = 0; i < ARRAY_SIZE(labels); i++) {
+		rc = labels[i]->probe(cxt);
+		if (rc) {
+			DBG(LABEL, dbgprint("detected a %s label\n",
+					    labels[i]->name));
+			goto done;
+		}
+	}
+
+done:
+	return rc;
+}
+
 static int __init_mbr_buffer(struct fdisk_context *cxt)
 {
 	DBG(TOPOLOGY, dbgprint("initialize MBR buffer"));
@@ -259,6 +292,8 @@ struct fdisk_context *fdisk_new_context_from_filename(const char *fname, int rea
 	__discover_topology(cxt);
 	__discover_geometry(cxt);
 
+	__probe_labels(cxt);
+
 	DBG(CONTEXT, dbgprint("context initialized for %s [%s]",
 			      fname, readonly ? "READ-ONLY" : "READ-WRITE"));
 	return cxt;
-- 
1.7.4.1



