Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:33417 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753031Ab1JJNMU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Oct 2011 09:12:20 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 9C5788F0D1
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 15:12:18 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 1/2] fdisk: don't shorten long path to disk device
Date: Mon, 10 Oct 2011 15:12:17 +0200
Message-Id: <1318252338-11200-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

fdisk/partname.c:partname() uses fixed 80 char static buffer for partition
name. This might be not enough if the used path to the disk device is long
enough, e.g.

----------------------------
> fdisk -l /dev/disk/by-path/ip-galileo.suse.de:3260-iscsi-iqn.2011-10.cz.suse:multipath-lun-0

Disk /dev/disk/by-path/ip-galileo.suse.de:3260-iscsi-iqn.2011-10.cz.suse:multipath-lun-0: 1073 MB, 1073741824 bytes
71 heads, 5 sectors/track, 5907 cylinders, total 2097152 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x0004a52e

                                                                               Device Boot      Start         End      Blocks   Id  System
/dev/disk/by-path/ip-galileo.suse.de:3260-iscsi-iqn.2011-10.cz.suse:multipath-l           2048       20479        9216   83  Linux
----------------------------

Fix by dynamically allocating memory in partname() and freeing the memory in
the calling functions.

Reported-by: Tim Serong <tserong@suse.com>
Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisk/fdisk.c         |    6 ++++--
 fdisk/fdiskbsdlabel.c |   33 ++++++++++++++++++++++-----------
 fdisk/fdisksgilabel.c |    4 +++-
 fdisk/fdisksunlabel.c |    4 +++-
 fdisk/partname.c      |   12 ++++++++----
 fdisk/sfdisk.c        |   20 ++++++++++++++------
 6 files changed, 54 insertions(+), 25 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 249de71..a20a396 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -2117,9 +2117,10 @@ list_table(int xtra) {
 			}
 			if (sector_size > 1024)
 				pblocks *= (sector_size / 1024);
-                        printf(
+				char *pname = partname(disk_device, i+1, w+2);
+				printf(
 			    "%s  %c %11lu %11lu %11lu%c  %2x  %s\n",
-			partname(disk_device, i+1, w+2),
+			pname,
 /* boot flag */		!p->boot_ind ? ' ' : p->boot_ind == ACTIVE_FLAG
 			? '*' : '?',
 /* start */		(unsigned long) cround(get_partition_start(pe)),
@@ -2129,6 +2130,7 @@ list_table(int xtra) {
 /* type id */		p->sys_ind,
 /* type name */		(type = partition_type(p->sys_ind)) ?
 			type : _("Unknown"));
+			free(pname);
 			check_consistency(p, i);
 			check_alignment(get_partition_start(pe), i);
 		}
diff --git a/fdisk/fdiskbsdlabel.c b/fdisk/fdiskbsdlabel.c
index aa27bad..8a2b05c 100644
--- a/fdisk/fdiskbsdlabel.c
+++ b/fdisk/fdiskbsdlabel.c
@@ -164,6 +164,7 @@ bselect (void) {
 #if !defined (__alpha__)
   int t, ss;
   struct partition *p;
+  char *pname;
 
   for (t=0; t<4; t++) {
     p = get_part_table(t);
@@ -172,13 +173,18 @@ bselect (void) {
       xbsd_part_index = t;
       ss = get_start_sect(xbsd_part);
       if (ss == 0) {
+	pname = partname(disk_device, t+1, 0);
 	fprintf (stderr, _("Partition %s has invalid starting sector 0.\n"),
-		 partname(disk_device, t+1, 0));
+		 pname);
+	free(pname);
 	return;
       }
-      printf (_("Reading disklabel of %s at sector %d.\n"),
-	      partname(disk_device, t+1, 0), ss + BSD_LABELSECTOR);
-      if (xbsd_readlabel (xbsd_part, &xbsd_dlabel) == 0)
+
+	pname = partname(disk_device, t+1, 0);
+	printf (_("Reading disklabel of %s at sector %d.\n"),
+	      pname, ss + BSD_LABELSECTOR);
+	free(pname);
+	if (xbsd_readlabel (xbsd_part, &xbsd_dlabel) == 0)
 	if (xbsd_create_disklabel () == 0)
 	  return;
       break;
@@ -311,7 +317,9 @@ xbsd_print_disklabel (int show_all) {
 #if defined (__alpha__)
     fprintf(f, "# %s:\n", disk_device);
 #else
-    fprintf(f, "# %s:\n", partname(disk_device, xbsd_part_index+1, 0));
+    char *pname = partname(disk_device, xbsd_part_index+1, 0);
+    fprintf(f, "# %s:\n", pname);
+    free(pname);
 #endif
     if ((unsigned) lp->d_type < BSD_DKMAXTYPES)
       fprintf(f, _("type: %s\n"), xbsd_dktypenames[lp->d_type]);
@@ -404,8 +412,9 @@ xbsd_write_disklabel (void) {
 	printf (_("Writing disklabel to %s.\n"), disk_device);
 	xbsd_writelabel (NULL, &xbsd_dlabel);
 #else
-	printf (_("Writing disklabel to %s.\n"),
-		partname(disk_device, xbsd_part_index+1, 0));
+	char *pname = partname(disk_device, xbsd_part_index+1, 0);
+	printf (_("Writing disklabel to %s.\n"), pname);
+	free(pname);
 	xbsd_writelabel (xbsd_part, &xbsd_dlabel);
 #endif
 	reread_partition_table(0);	/* no exit yet */
@@ -418,8 +427,9 @@ xbsd_create_disklabel (void) {
 #if defined (__alpha__)
 	fprintf (stderr, _("%s contains no disklabel.\n"), disk_device);
 #else
-	fprintf (stderr, _("%s contains no disklabel.\n"),
-		 partname(disk_device, xbsd_part_index+1, 0));
+	char *pname = partname(disk_device, xbsd_part_index+1, 0);
+	fprintf (stderr, _("%s contains no disklabel.\n"), pname);
+	free(pname);
 #endif
 
 	while (1) {
@@ -573,8 +583,9 @@ xbsd_write_bootstrap (void)
 #if defined (__alpha__)
   printf (_("Bootstrap installed on %s.\n"), disk_device);
 #else
-  printf (_("Bootstrap installed on %s.\n"),
-    partname (disk_device, xbsd_part_index+1, 0));
+  char *pname = partname (disk_device, xbsd_part_index+1, 0);
+  printf (_("Bootstrap installed on %s.\n"), pname);
+  free(pname);
 #endif
 
   sync_disks ();
diff --git a/fdisk/fdisksgilabel.c b/fdisk/fdisksgilabel.c
index 091902a..7e97c44 100644
--- a/fdisk/fdisksgilabel.c
+++ b/fdisk/fdisksgilabel.c
@@ -214,10 +214,11 @@ sgi_list_table(int xtra) {
 			uint32_t start = sgi_get_start_sector(i);
 			uint32_t len = sgi_get_num_sectors(i);
 			kpi++;		/* only count nonempty partitions */
+                        char *pname = partname(disk_device, kpi, w+2);
 			printf(
 				"%2d: %s %4s %9ld %9ld %9ld  %2x  %s\n",
 /* fdisk part number */   i+1,
-/* device */              partname(disk_device, kpi, w+2),
+/* device */              pname,
 /* flags */               (sgi_get_swappartition() == i) ? "swap" :
 /* flags */               (sgi_get_bootpartition() == i) ? "boot" : "    ", 
 /* start */               (long) scround(start),
@@ -226,6 +227,7 @@ sgi_list_table(int xtra) {
 /* type id */             sgi_get_sysid(i),
 /* type name */           (type = partition_type(sgi_get_sysid(i)))
 				? type : _("Unknown"));
+                        free(pname);
 		}
 	}
 	printf(_("----- Bootinfo -----\nBootfile: %s\n"
diff --git a/fdisk/fdisksunlabel.c b/fdisk/fdisksunlabel.c
index 80408dd..25de323 100644
--- a/fdisk/fdisksunlabel.c
+++ b/fdisk/fdisksunlabel.c
@@ -604,9 +604,10 @@ void sun_list_table(int xtra)
 		if (part->num_sectors) {
 			uint32_t start = SSWAP32(part->start_cylinder) * heads * sectors;
 			uint32_t len = SSWAP32(part->num_sectors);
+                        char *pname = partname(disk_device, i+1, w);
 			printf(
 			    "%s %c%c %9lu %9lu %9lu%c  %2x  %s\n",
-/* device */		  partname(disk_device, i+1, w),
+/* device */		  pname,
 /* flags */		  (tag->flag & SSWAP16(SUN_FLAG_UNMNT)) ? 'u' : ' ',
 			  (tag->flag & SSWAP16(SUN_FLAG_RONLY)) ? 'r' : ' ',
 /* start */		  (unsigned long) scround(start),
@@ -615,6 +616,7 @@ void sun_list_table(int xtra)
 /* type id */		  SSWAP16(tag->tag),
 /* type name */		  (type = partition_type(SSWAP16(tag->tag)))
 			        ? type : _("Unknown"));
+                        free(pname);
 		}
 	}
 }
diff --git a/fdisk/partname.c b/fdisk/partname.c
index 1fe3087..d3dc372 100644
--- a/fdisk/partname.c
+++ b/fdisk/partname.c
@@ -5,13 +5,14 @@
 #include "blkdev.h"
 #include "pathnames.h"
 #include "common.h"
+#include "xalloc.h"
 
 /*
- * return partition name - uses static storage unless buf is supplied
+ * return partition name - allocates new memory, to be freed by the caller
  */
 char *
 partname(char *dev, int pno, int lth) {
-	static char bufp[80];
+	char *bufp;
 	char *p;
 	int w, wp;
 
@@ -37,11 +38,14 @@ partname(char *dev, int pno, int lth) {
 
 	wp = strlen(p);
 
+    size_t buflen = w + wp + 5;
+    bufp = xmalloc(buflen);
+
 	if (lth) {
-		snprintf(bufp, sizeof(bufp), "%*.*s%s%-2u",
+		snprintf(bufp, buflen, "%*.*s%s%-2u",
 			 lth-wp-2, w, dev, p, pno);
 	} else {
-		snprintf(bufp, sizeof(bufp), "%.*s%s%-2u", w, dev, p, pno);
+		snprintf(bufp, buflen, "%.*s%s%-2u", w, dev, p, pno);
 	}
 	return bufp;
 }
diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index db1a6d7..4583d3e 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -1054,10 +1054,13 @@ out_partition(char *dev, int format, struct part_desc *p,
     if (!format && !(format = specified_format))
 	format = default_format;
 
-    pno = p - &(z->partitions[0]);	/* our index */
+    pno = p - &(z->partitions[0]);  	/* our index */
     lpno = index_to_linux(pno, z);	/* name of next one that has a name */
-    if (pno == linux_to_index(lpno, z))	/* was that us? */
-	printf("%s", partname(dev, lpno, 10));	/* yes */
+    if (pno == linux_to_index(lpno, z))	{ /* was that us? */
+        char *pname = partname(dev, lpno, 10);
+	printf("%s", pname);	/* yes */
+        free(pname);
+    }
     else if (show_extended)
 	printf("    -     ");
     else
@@ -2122,7 +2125,9 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
     if (interactive) {
 	if (pct == 0 && (show_extended || pno == 0))
 	    my_warn("\n");
-	my_warn("%s:", partname(dev, lpno, 10));
+    char *pname = partname(dev, lpno, 10);
+	my_warn("%s:", pname);
+    free(pname);
     }
 
     /* read input line - skip blank lines when reading from a file */
@@ -3059,8 +3064,11 @@ do_activate(char **av, int ac, char *arg) {
 	for (pno = 0; pno < z->partno; pno++) {
 	    if (z->partitions[pno].p.bootable) {
 		lpno = index_to_linux(pno, z);
-		if (pno == linux_to_index(lpno, z))
-		    printf("%s\n", partname(dev, lpno, 0));
+		if (pno == linux_to_index(lpno, z)) {
+		    char *pname = partname(dev, lpno, 0);
+		    printf("%s\n", pname);
+		    free(pname);
+        }
 		else
 		    printf("%s#%d\n", dev, pno);
 		if (z->partitions[pno].p.bootable != 0x80)
-- 
1.7.3.4

