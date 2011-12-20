Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbef.dreamhost.com ([208.97.132.145]:35820 "EHLO
	homiemail-a61.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752141Ab1LTNmI (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 20 Dec 2011 08:42:08 -0500
Subject: [PATCH 2/5] sfdisk: remove do_warn
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 20 Dec 2011 14:42:03 +0100
Message-ID: <1324388523.3316.8.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Replace it with warnx() instead.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/sfdisk.c |   83 ++++++++++++++++++++++++-------------------------------
 1 files changed, 36 insertions(+), 47 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index bd26896..979eadc 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -90,17 +90,6 @@ char *save_sector_file = NULL;
 char *restore_sector_file = NULL;
 
 static void
-do_warn(char *s, ...) {
-    va_list p;
-
-    va_start(p, s);
-    fflush(stdout);
-    vfprintf(stderr, s, p);
-    fflush(stderr);
-    va_end(p);
-}
-
-static void
 my_warn(char *s, ...) {
     va_list p;
 
@@ -428,7 +417,7 @@ get_geometry(char *dev, int fd, int silent) {
     {
 	g.heads = g.sectors = g.cylinders = g.start = 0;
 	if (!silent)
-	    do_warn(_("Disk %s: cannot get geometry\n"), dev);
+	    warnx(_("Disk %s: cannot get geometry\n"), dev);
     }
 
     R.start = g.start;
@@ -445,7 +434,7 @@ get_geometry(char *dev, int fd, int silent) {
 	if (fstat(fd, &s) == 0 && S_ISREG(s.st_mode))
 	    R.total_size = (s.st_size >> 9);
 	else if (!silent)
-	    do_warn(_("Disk %s: cannot get size\n"), dev);
+	    warnx(_("Disk %s: cannot get size\n"), dev);
     } else
 	R.total_size = sectors;
 
@@ -808,7 +797,7 @@ reread_disk_partition(char *dev, int fd) {
     sync();
 
     if (reread_ioctl(fd) && is_blockdev(fd)) {
-	do_warn(_("The command to re-read the partition table failed.\n"
+	warnx(_("The command to re-read the partition table failed.\n"
 		  "Run partprobe(8), kpartx(8) or reboot your system now,\n"
 		  "before using mkfs\n"));
 	return 0;
@@ -816,7 +805,7 @@ reread_disk_partition(char *dev, int fd) {
 
     if (fsync(fd) || close(fd)) {
 	perror(dev);
-	do_warn(_("Error closing %s\n"), dev);
+	warnx(_("Error closing %s\n"), dev);
 	return 0;
     }
     printf("\n");
@@ -880,7 +869,7 @@ static void
 set_format(char c) {
     switch (c) {
     default:
-	do_warn(_("unrecognized format - using sectors\n"));
+	warnx(_("unrecognized format - using sectors\n"));
     case 'S':
 	specified_format = F_SECTOR;
 	break;
@@ -939,7 +928,7 @@ out_partition_header(char *dev, int format, struct geometry G) {
 
     switch (format) {
     default:
-	do_warn(_("unimplemented format - using %s\n"),
+	warnx(_("unimplemented format - using %s\n"),
 		G.cylindersize ? _("cylinders") : _("sectors"));
     case F_CYLINDER:
 	if (G.cylindersize) {
@@ -1121,17 +1110,17 @@ out_partition(char *dev, int format, struct part_desc *p,
 	aa = chs_to_longchs(a);
 	bb = chs_to_longchs(b);
 	if (a.s && !is_equal_chs(a, b))
-	    do_warn(_("\t\tstart: (c,h,s) expected (%ld,%ld,%ld) found (%ld,%ld,%ld)\n"),
+	    warnx(_("\t\tstart: (c,h,s) expected (%ld,%ld,%ld) found (%ld,%ld,%ld)\n"),
 		    aa.c, aa.h, aa.s, bb.c, bb.h, bb.s);
 	a = (size ? ulong_to_chs(end, G) : zero_chs);
 	b = p->p.end_chs;
 	aa = chs_to_longchs(a);
 	bb = chs_to_longchs(b);
 	if (a.s && !is_equal_chs(a, b))
-	    do_warn(_("\t\tend: (c,h,s) expected (%ld,%ld,%ld) found (%ld,%ld,%ld)\n"),
+	    warnx(_("\t\tend: (c,h,s) expected (%ld,%ld,%ld) found (%ld,%ld,%ld)\n"),
 		    aa.c, aa.h, aa.s, bb.c, bb.h, bb.s);
 	if (G.cylinders && G.cylinders < 1024 && bb.c > G.cylinders)
-	    do_warn(_("partition ends on cylinder %ld, beyond the end of the disk\n"),
+	    warnx(_("partition ends on cylinder %ld, beyond the end of the disk\n"),
 		    bb.c);
     }
 }
@@ -1141,10 +1130,10 @@ out_partitions(char *dev, struct disk_desc *z) {
     int pno, format = 0;
 
     if (z->partno == 0)
-	do_warn(_("No partitions found\n"));
+	warnx(_("No partitions found\n"));
     else {
 	if (get_fdisk_geometry(z) && !dump) {
-	    do_warn(_("Warning: The partition table looks like it was made\n"
+	    warnx(_("Warning: The partition table looks like it was made\n"
 		      "  for C/H/S=*/%ld/%ld (instead of %ld/%ld/%ld).\n"
 		      "For this listing I'll assume that geometry.\n"),
 		    F.heads, F.sectors, B.cylinders, B.heads, B.sectors);
@@ -1428,12 +1417,12 @@ extended_partition(char *dev, int fd, struct part_desc *ep, struct disk_desc *z)
 	/* This is BAD */
 	if (DOS_extended) {
 	    here = start -= (start % B.cylindersize);
-	    do_warn(_("Warning: shifted start of the extd partition "
-		      "from %ld to %ld\n"
+	    warnx(_("Warning: shifted start of the extd partition "
+		      "from %lld to %lld\n"
 		      "(For listing purposes only. "
 		      "Do not change its contents.)\n"), ep->start, start);
 	} else {
-	    do_warn(_("Warning: extended partition does not start at a "
+	    warnx(_("Warning: extended partition does not start at a "
 		      "cylinder boundary.\n"
 		      "DOS and Linux will interpret the contents differently.\n"));
 	}
@@ -1451,7 +1440,7 @@ extended_partition(char *dev, int fd, struct part_desc *ep, struct disk_desc *z)
 	cp = s->data + 0x1be;
 
 	if (pno + 4 >= ARRAY_SIZE(z->partitions)) {
-	    do_warn(_("too many partitions - ignoring those past nr (%d)\n"),
+	    warnx(_("too many partitions - ignoring those past nr (%ld)\n"),
 		    pno - 1);
 	    break;
 	}
@@ -1466,7 +1455,7 @@ extended_partition(char *dev, int fd, struct part_desc *ep, struct disk_desc *z)
 	    if (is_extended(p.sys_type)) {
 		partitions[pno].start = start + p.start_sect;
 		if (next)
-		    do_warn(_("tree of partitions?\n"));
+		    warnx(_("tree of partitions?\n"));
 		else
 		    next = partitions[pno].start;	/* follow `upper' branch */
 		moretodo = 1;
@@ -1528,8 +1517,8 @@ bsd_partition(char *dev, int fd, struct part_desc *ep, struct disk_desc *z) {
     bp = bp0 = &l->d_partitions[0];
     while (bp - bp0 < BSD_MAXPARTITIONS && bp - bp0 < l->d_npartitions) {
 	if (pno + 1 >= ARRAY_SIZE(z->partitions)) {
-	    do_warn(_("too many partitions - ignoring those "
-		      "past nr (%d)\n"), pno - 1);
+	    warnx(_("too many partitions - ignoring those "
+		      "past nr (%ld)\n"), pno - 1);
 	    break;
 	}
 	if (bp->p_fstype != BSD_FS_UNUSED) {
@@ -1574,7 +1563,7 @@ msdos_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
 	|| pt.sys_type == EZD_PARTITION
 	|| pt.sys_type == DM6_AUX1PARTITION
 	|| pt.sys_type == DM6_AUX3PARTITION) {
-	do_warn(_("detected Disk Manager - unable to handle that\n"));
+	warnx(_("detected Disk Manager - unable to handle that\n"));
 	return 0;
     }
 
@@ -1582,7 +1571,7 @@ msdos_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
     if (sig <= 0x1ae
 	&& *(unsigned short *)(s->data + sig) == 0x55aa
 	&& (1 & *(unsigned char *)(s->data + sig + 2))) {
-	    do_warn(_("DM6 signature found - giving up\n"));
+	    warnx(_("DM6 signature found - giving up\n"));
 	    return 0;
     }
 
@@ -1601,14 +1590,14 @@ msdos_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
     for (i = 0; i < 4; i++) {
 	if (is_extended(partitions[i].p.sys_type)) {
 	    if (!partitions[i].size) {
-		do_warn(_("strange..., an extended partition of size 0?\n"));
+		warnx(_("strange..., an extended partition of size 0?\n"));
 		continue;
 	    }
 	    extended_partition(dev, fd, &partitions[i], z);
 	}
 	if (!bsd_later && is_bsd(partitions[i].p.sys_type)) {
 	    if (!partitions[i].size) {
-		do_warn(_("strange..., a BSD partition of size 0?\n"));
+		warnx(_("strange..., a BSD partition of size 0?\n"));
 		continue;
 	    }
 	    bsd_partition(dev, fd, &partitions[i], z);
@@ -1619,7 +1608,7 @@ msdos_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
 	for (i = 0; i < 4; i++) {
 	    if (is_bsd(partitions[i].p.sys_type)) {
 		if (!partitions[i].size) {
-		    do_warn(_("strange..., a BSD partition of size 0?\n"));
+		    warnx(_("strange..., a BSD partition of size 0?\n"));
 		    continue;
 		}
 		bsd_partition(dev, fd, &partitions[i], z);
@@ -1662,7 +1651,7 @@ get_partitions(char *dev, int fd, struct disk_desc *z) {
 	&& !osf_partition(dev, fd, 0, z)
 	&& !sun_partition(dev, fd, 0, z)
 	&& !amiga_partition(dev, fd, 0, z)) {
-	do_warn(_(" %s: unrecognized partition table type\n"), dev);
+	warnx(_(" %s: unrecognized partition table type\n"), dev);
 	return;
     }
 }
@@ -1674,7 +1663,7 @@ write_partitions(char *dev, int fd, struct disk_desc *z) {
     int pno = z->partno;
 
     if (no_write) {
-	do_warn(_("-n flag was given: Nothing changed\n"));
+	warnx(_("-n flag was given: Nothing changed\n"));
 	exit(0);
     }
 
@@ -1869,11 +1858,11 @@ get_ul(char *u, unsigned long *up, unsigned long def, int base) {
 	errno = 0;
 	val = strtoul(u, &nu, base);
 	if (errno == ERANGE) {
-	    do_warn(_("number too big\n"));
+	    warnx(_("number too big\n"));
 	    return -1;
 	}
 	if (*nu) {
-	    do_warn(_("trailing junk after number\n"));
+	    warnx(_("trailing junk after number\n"));
 	    return -1;
 	}
 	if (sign == 1)
@@ -1906,11 +1895,11 @@ get_ull(char *u, unsigned long long *up, unsigned long long def, int base) {
 	errno = 0;
 	val = strtoull(u, &nu, base);
 	if (errno == ERANGE) {
-	    do_warn(_("number too big\n"));
+	    warnx(_("number too big\n"));
 	    return -1;
 	}
 	if (*nu) {
-	    do_warn(_("trailing junk after number\n"));
+	    warnx(_("trailing junk after number\n"));
 	    return -1;
 	}
 	if (sign == 1)
@@ -2119,7 +2108,7 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
     if (fno == RD_EOF) {
 	return -1;
     } else if (fno > 10 && *(fields[10]) != 0) {
-	do_warn(_("too many input fields\n"));
+	warnx(_("too many input fields\n"));
 	return 0;
     }
 
@@ -2336,7 +2325,7 @@ read_partition_chain(char *dev, int interactive, struct part_desc *ep,
     while (1) {
 	base = z->partno;
 	if (base + 4 > ARRAY_SIZE(z->partitions)) {
-	    do_warn(_("too many partitions\n"));
+	    warnx(_("too many partitions\n"));
 	    break;
 	}
 	for (i = 0; i < 4; i++)
@@ -3173,7 +3162,7 @@ do_reread(char *dev) {
 
     fd = my_open(dev, 0, 0);
     if (reread_ioctl(fd)) {
-	do_warn(_("This disk is currently in use.\n"));
+	warnx(_("This disk is currently in use.\n"));
 	exit(1);
     }
 
@@ -3197,7 +3186,7 @@ do_fdisk(char *dev) {
 	errx(EXIT_FAILURE, _("Fatal error: cannot find %s"), dev);
     }
     if (!S_ISBLK(statbuf.st_mode)) {
-	do_warn(_("Warning: %s is not a block device\n"), dev);
+	warnx(_("Warning: %s is not a block device\n"), dev);
 	no_reread = 1;
     }
     fd = my_open(dev, !no_write, 0);
@@ -3205,11 +3194,11 @@ do_fdisk(char *dev) {
     if (!no_write && !no_reread) {
 	my_warn(_("Checking that no-one is using this disk right now ...\n"));
 	if (reread_ioctl(fd)) {
-	    do_warn(_("\nThis disk is currently in use - repartitioning is probably a bad idea.\n"
+	    warnx(_("\nThis disk is currently in use - repartitioning is probably a bad idea.\n"
 		      "Umount all file systems, and swapoff all swap partitions on this disk.\n"
 		      "Use the --no-reread flag to suppress this check.\n"));
 	    if (!force) {
-		do_warn(_("Use the --force flag to overrule all checks.\n"));
+		warnx(_("Use the --force flag to overrule all checks.\n"));
 		exit(1);
 	    }
 	} else
@@ -3242,7 +3231,7 @@ do_fdisk(char *dev) {
 		    errx(EXIT_FAILURE, _("I don't like these partitions - nothing changed.\n"
 					 "(If you really want this, use the --force option.)"));
 	    else
-		do_warn(_("I don't like this - probably you should answer No\n"));
+		warnx(_("I don't like this - probably you should answer No\n"));
 	}
  ask:
 	if (interactive) {
-- 
1.7.4.1






