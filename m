Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:63837 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab3FPSy3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Jun 2013 14:54:29 -0400
Received: by mail-wi0-f178.google.com with SMTP id k10so1574795wiv.11
        for <util-linux@vger.kernel.org>; Sun, 16 Jun 2013 11:54:28 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/15] sfdisk: replace my_warn() with warnx()
Date: Sun, 16 Jun 2013 19:53:48 +0100
Message-Id: <1371408836-16663-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This change adds program name in front of error messages.  Often that
helps user to know which command sent message, when the command is
executed as part of script.

Unfortunately the prefixing can break scripts, as someone might have
wrote automation which expects output in the format it has always been.
In programmer terms, the change has an ABI change, which some may find
annoying.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisks/sfdisk.c | 223 ++++++++++++++++++++++++++------------------------------
 1 file changed, 104 insertions(+), 119 deletions(-)

diff --git a/fdisks/sfdisk.c b/fdisks/sfdisk.c
index ae17e8d..dce56d5 100644
--- a/fdisks/sfdisk.c
+++ b/fdisks/sfdisk.c
@@ -93,19 +93,6 @@ int opt_list = 0;
 char *save_sector_file = NULL;
 char *restore_sector_file = NULL;
 
-static void
-my_warn(char *s, ...) {
-    va_list p;
-
-    va_start(p, s);
-    if (!quiet) {
-	fflush(stdout);
-	vfprintf(stderr, s, p);
-	fflush(stderr);
-    }
-    va_end(p);
-}
-
 /*
  *  A. About seeking
  */
@@ -393,7 +380,7 @@ get_geometry(char *dev, int fd, int silent) {
     {
 	g.heads = g.sectors = g.cylinders = g.start = 0;
 	if (!silent)
-	    warnx(_("Disk %s: cannot get geometry\n"), dev);
+	    warnx(_("Disk %s: cannot get geometry"), dev);
     }
 
     R.start = g.start;
@@ -410,7 +397,7 @@ get_geometry(char *dev, int fd, int silent) {
 	if (fstat(fd, &s) == 0 && S_ISREG(s.st_mode))
 	    R.total_size = (s.st_size >> 9);
 	else if (!silent)
-	    warnx(_("Disk %s: cannot get size\n"), dev);
+	    warnx(_("Disk %s: cannot get size"), dev);
     } else
 	R.total_size = sectors;
 
@@ -442,28 +429,28 @@ get_cylindersize(char *dev, int fd, int silent) {
 	B.cylinders = B.total_size / B.cylindersize;
 
     if (R.start && !force) {
-	my_warn(_("Warning: start=%lu - this looks like a partition rather than\n"
+	warnx(_("Warning: start=%lu - this looks like a partition rather than\n"
 		  "the entire disk. Using fdisk on it is probably meaningless.\n"
-		  "[Use the --force option if you really want this]\n"),
+		  "[Use the --force option if you really want this]"),
 		R.start);
 	exit(EXIT_FAILURE);
     }
 #if 0
     if (R.heads && B.heads != R.heads)
-	my_warn(_("Warning: HDIO_GETGEO says that there are %lu heads\n"),
+	warnx(_("Warning: HDIO_GETGEO says that there are %lu heads"),
 		R.heads);
     if (R.sectors && B.sectors != R.sectors)
-	my_warn(_("Warning: HDIO_GETGEO says that there are %lu sectors\n"),
+	warnx(_("Warning: HDIO_GETGEO says that there are %lu sectors"),
 		R.sectors);
     if (R.cylinders && B.cylinders != R.cylinders
 	&& B.cylinders < 65536 && R.cylinders < 65536)
-	my_warn(_("Warning: BLKGETSIZE/HDIO_GETGEO says that there are %lu cylinders\n"),
+	warnx(_("Warning: BLKGETSIZE/HDIO_GETGEO says that there are %lu cylinders"),
 		R.cylinders);
 #endif
 
     if (B.sectors > 63)
-	my_warn(_("Warning: unlikely number of sectors (%lu) - usually at most 63\n"
-		  "This will give problems with all software that uses C/H/S addressing.\n"),
+	warnx(_("Warning: unlikely number of sectors (%lu) - usually at most 63\n"
+		  "This will give problems with all software that uses C/H/S addressing."),
 		B.sectors);
     if (!silent)
 	printf(_("\nDisk %s: %lu cylinders, %lu heads, %lu sectors/track\n"),
@@ -552,18 +539,18 @@ chs_ok(chs a, char *v, char *w) {
     if (is_equal_chs(a, zero_chs))
 	return 1;
     if (B.heads && aa.h >= B.heads) {
-	my_warn(_("%s of partition %s has impossible value for head: "
-		  "%lu (should be in 0-%lu)\n"), w, v, aa.h, B.heads - 1);
+	warnx(_("%s of partition %s has impossible value for head: "
+		  "%lu (should be in 0-%lu)"), w, v, aa.h, B.heads - 1);
 	ret = 0;
     }
     if (B.sectors && (aa.s == 0 || aa.s > B.sectors)) {
-	my_warn(_("%s of partition %s has impossible value for sector: "
-		  "%lu (should be in 1-%lu)\n"), w, v, aa.s, B.sectors);
+	warnx(_("%s of partition %s has impossible value for sector: "
+		  "%lu (should be in 1-%lu)"), w, v, aa.s, B.sectors);
 	ret = 0;
     }
     if (B.cylinders && aa.c >= B.cylinders) {
-	my_warn(_("%s of partition %s has impossible value for cylinders: "
-		  "%lu (should be in 0-%lu)\n"), w, v, aa.c, B.cylinders - 1);
+	warnx(_("%s of partition %s has impossible value for cylinders: "
+		  "%lu (should be in 0-%lu)"), w, v, aa.c, B.cylinders - 1);
 	ret = 0;
     }
     return ret;
@@ -769,13 +756,13 @@ reread_disk_partition(char *dev, int fd) {
 	if (reread_ioctl(fd) ) {
 	   warnx(_("The command to re-read the partition table failed.\n"
 		"Run partprobe(8), kpartx(8) or reboot your system now,\n"
-		"before using mkfs\n"));
+		"before using mkfs"));
 	   return 0;
 	}
     }
 
     if (close_fd(fd) != 0) {
-	warn(_("Error closing %s\n"), dev);
+	warn(_("Error closing %s"), dev);
 	return 0;
     }
     printf("\n");
@@ -839,7 +826,7 @@ static void
 set_format(char c) {
     switch (c) {
     default:
-	warnx(_("unrecognized format - using sectors\n"));
+	warnx(_("unrecognized format - using sectors"));
 	/* fallthrough */
     case 'S':
 	specified_format = F_SECTOR;
@@ -900,7 +887,7 @@ out_partition_header(char *dev, int format, struct geometry G) {
 
     switch (format) {
     default:
-	warnx(_("unimplemented format - using %s\n"),
+	warnx(_("unimplemented format - using %s"),
 		G.cylindersize ? _("cylinders") : _("sectors"));
 	/* fallthrough */
     case F_CYLINDER:
@@ -1083,17 +1070,17 @@ out_partition(char *dev, int format, struct part_desc *p,
 	aa = chs_to_longchs(a);
 	bb = chs_to_longchs(b);
 	if (a.s && !is_equal_chs(a, b))
-	    warnx(_("\t\tstart: (c,h,s) expected (%ld,%ld,%ld) found (%ld,%ld,%ld)\n"),
+	    printf(_("\t\tstart: (c,h,s) expected (%ld,%ld,%ld) found (%ld,%ld,%ld)\n"),
 		    aa.c, aa.h, aa.s, bb.c, bb.h, bb.s);
 	a = (size ? ulong_to_chs(end, G) : zero_chs);
 	b = p->p.end_chs;
 	aa = chs_to_longchs(a);
 	bb = chs_to_longchs(b);
 	if (a.s && !is_equal_chs(a, b))
-	    warnx(_("\t\tend: (c,h,s) expected (%ld,%ld,%ld) found (%ld,%ld,%ld)\n"),
+	    printf(_("\t\tend: (c,h,s) expected (%ld,%ld,%ld) found (%ld,%ld,%ld)\n"),
 		    aa.c, aa.h, aa.s, bb.c, bb.h, bb.s);
 	if (G.cylinders && G.cylinders < 1024 && bb.c > G.cylinders)
-	    warnx(_("partition ends on cylinder %ld, beyond the end of the disk\n"),
+	    printf(_("partition ends on cylinder %ld, beyond the end of the disk\n"),
 		    bb.c);
     }
 }
@@ -1104,12 +1091,12 @@ out_partitions(char *dev, struct disk_desc *z) {
 
     if (z->partno == 0) {
 	if (!opt_list)
-	    warnx(_("No partitions found\n"));
+	    warnx(_("No partitions found"));
     } else {
 	if (get_fdisk_geometry(z) && !dump) {
 	    warnx(_("Warning: The partition table looks like it was made\n"
 		      "  for C/H/S=*/%ld/%ld (instead of %ld/%ld/%ld).\n"
-		      "For this listing I'll assume that geometry.\n"),
+		      "For this listing I'll assume that geometry."),
 		    F.heads, F.sectors, B.cylinders, B.heads, B.sectors);
 	}
 
@@ -1167,13 +1154,13 @@ partitions_ok(int fd, struct disk_desc *z) {
     for (p = partitions; p - partitions < partno; p++)
 	if (p->size == 0) {
 	    if (p->p.sys_type != EMPTY_PARTITION)
-		my_warn(_("Warning: partition %s has size 0 but is not marked Empty\n"),
+		warnx(_("Warning: partition %s has size 0 but is not marked Empty"),
 			PNO(p));
 	    else if (p->p.bootable != 0)
-		my_warn(_("Warning: partition %s has size 0 and is bootable\n"),
+		warnx(_("Warning: partition %s has size 0 and is bootable"),
 			PNO(p));
 	    else if (p->p.start_sect != 0)
-		my_warn(_("Warning: partition %s has size 0 and nonzero start\n"),
+		warnx(_("Warning: partition %s has size 0 and nonzero start"),
 			PNO(p));
 	    /* all this is probably harmless, no error return */
 	}
@@ -1185,8 +1172,8 @@ partitions_ok(int fd, struct disk_desc *z) {
 		q = p->ep;
 		if (p->start < q->start
 		    || p->start + p->size > q->start + q->size) {
-		    my_warn(_("Warning: partition %s is not contained in "
-			      "partition %s\n"), PNO(p), PNO(q));
+		    warnx(_("Warning: partition %s is not contained in "
+			      "partition %s"), PNO(p), PNO(q));
 		    return 0;
 		}
 	    }
@@ -1197,7 +1184,7 @@ partitions_ok(int fd, struct disk_desc *z) {
 	    for (q = p + 1; q < partitions + partno; q++)
 		if (q->size && !is_extended(q->p.sys_type))
 		    if (!((p->start > q->start) ? disj(q, p) : disj(p, q))) {
-			my_warn(_("Warning: partitions %s and %s overlap\n"),
+			warnx(_("Warning: partitions %s and %s overlap"),
 				PNO(p), PNO(q));
 			return 0;
 		    }
@@ -1209,9 +1196,9 @@ partitions_ok(int fd, struct disk_desc *z) {
 	    for (q = partitions; q < partitions + partno; q++)
 		if (is_extended(q->p.sys_type))
 		    if (p->start <= q->start && p->start + p->size > q->start) {
-			my_warn(_("Warning: partition %s contains part of "
+			warnx(_("Warning: partition %s contains part of "
 				  "the partition table (sector %llu),\n"
-				  "and will destroy it when filled\n"),
+				  "and will destroy it when filled"),
 				PNO(p), q->start);
 			return 0;
 		    }
@@ -1222,12 +1209,12 @@ partitions_ok(int fd, struct disk_desc *z) {
 	for (p = partitions; p < partitions + partno; p++)
 	    if (p->size) {
 		if (p->start == 0) {
-		    my_warn(_("Warning: partition %s starts at sector 0\n"),
+		    warnx(_("Warning: partition %s starts at sector 0"),
 			    PNO(p));
 		    return 0;
 		}
 		if (p->size && p->start + p->size > ds) {
-		    my_warn(_("Warning: partition %s extends past end of disk\n"),
+		    warnx(_("Warning: partition %s extends past end of disk"),
 			    PNO(p));
 		    return 0;
 		}
@@ -1243,9 +1230,9 @@ partitions_ok(int fd, struct disk_desc *z) {
 	    unsigned long long bytes = p->size * sector_size;
 	    int giga = bytes / 1000000000;
 	    int hectogiga = (giga + 50) / 100;
-	    my_warn(_("Warning: partition %s has size %d.%d TB (%llu bytes),\n"
+	    warnx(_("Warning: partition %s has size %d.%d TB (%llu bytes),\n"
 		      "which is larger than the %llu bytes limit imposed\n"
-		      "by the DOS partition table for %d-byte sectors\n"),
+		      "by the DOS partition table for %d-byte sectors"),
 		    PNO(p), hectogiga / 10, hectogiga % 10,
 		    bytes,
 		    (unsigned long long) UINT_MAX * sector_size,
@@ -1259,8 +1246,8 @@ partitions_ok(int fd, struct disk_desc *z) {
 	    unsigned long long bytes = p->start * sector_size;
 	    int giga = bytes / 1000000000;
 	    int hectogiga = (giga + 50) / 100;
-	    my_warn(_("Warning: partition %s starts at sector %llu (%d.%d TB for %d-byte sectors),\n"
-		      "which exceeds the DOS partition table limit of %llu sectors\n"),
+	    warnx(_("Warning: partition %s starts at sector %llu (%d.%d TB for %d-byte sectors),\n"
+		      "which exceeds the DOS partition table limit of %llu sectors"),
 		    PNO(p),
 		    p->start,
 		    hectogiga / 10,
@@ -1279,8 +1266,8 @@ partitions_ok(int fd, struct disk_desc *z) {
 	    if (p->p.sys_type == EXTENDED_PARTITION)
 		ect++;
 	if (ect > 1 && !Linux) {
-	    my_warn(_("Among the primary partitions, at most one can be extended\n"
-		      " (although this is not a problem under Linux)\n"));
+	    warnx(_("Among the primary partitions, at most one can be extended\n"
+		      " (although this is not a problem under Linux)"));
 	    return 0;
 	}
     }
@@ -1299,14 +1286,14 @@ partitions_ok(int fd, struct disk_desc *z) {
 			|| p->start / B.cylindersize !=
 			p->ep->start / B.cylindersize)
 		    && (p->p.start_sect >= B.cylindersize)) {
-		    my_warn(_("Warning: partition %s does not start "
-			      "at a cylinder boundary\n"), PNO(p));
+		    warnx(_("Warning: partition %s does not start "
+			      "at a cylinder boundary"), PNO(p));
 		    if (specified_format == F_CYLINDER)
 			return 0;
 		}
 		if ((p->start + p->size) % B.cylindersize) {
-		    my_warn(_("Warning: partition %s does not end "
-			      "at a cylinder boundary\n"), PNO(p));
+		    warnx(_("Warning: partition %s does not end "
+			      "at a cylinder boundary"), PNO(p));
 		    if (specified_format == F_CYLINDER)
 			return 0;
 		}
@@ -1324,22 +1311,22 @@ partitions_ok(int fd, struct disk_desc *z) {
 		if (pno == -1)
 		    pno = p - partitions;
 		else if (p - partitions < 4) {
-		    my_warn(_("Warning: more than one primary partition is marked "
+		    warnx(_("Warning: more than one primary partition is marked "
 			      "bootable (active)\n"
 			      "This does not matter for LILO, but the DOS MBR will "
-			      "not boot this disk.\n"));
+			      "not boot this disk."));
 		    break;
 		}
 		if (p - partitions >= 4) {
-		    my_warn(_("Warning: usually one can boot from primary partitions "
-			      "only\nLILO disregards the `bootable' flag.\n"));
+		    warnx(_("Warning: usually one can boot from primary partitions "
+			      "only\nLILO disregards the `bootable' flag."));
 		    break;
 		}
 	    }
 	if (pno == -1 || pno >= 4)
-	    my_warn(_("Warning: no primary partition is marked bootable (active)\n"
+	    warnx(_("Warning: no primary partition is marked bootable (active)\n"
 		      "This does not matter for LILO, but the DOS MBR will "
-		      "not boot this disk.\n"));
+		      "not boot this disk."));
     }
 
     /* Is chs as we expect? */
@@ -1354,7 +1341,7 @@ partitions_ok(int fd, struct disk_desc *z) {
 	    if (!Linux && !chs_ok(b, PNO(p), _("start")))
 		return 0;
 	    if (a.s && !is_equal_chs(a, b))
-		my_warn(_("partition %s: start: (c,h,s) expected (%ld,%ld,%ld) found (%ld,%ld,%ld)\n"),
+		warnx(_("partition %s: start: (c,h,s) expected (%ld,%ld,%ld) found (%ld,%ld,%ld)"),
 			PNO(p), aa.c, aa.h, aa.s, bb.c, bb.h, bb.s);
 	    a = p->size ? ulong_to_chs(p->start + p->size - 1, B) : zero_chs;
 	    b = p->p.end_chs;
@@ -1363,10 +1350,10 @@ partitions_ok(int fd, struct disk_desc *z) {
 	    if (!Linux && !chs_ok(b, PNO(p), _("end")))
 		return 0;
 	    if (a.s && !is_equal_chs(a, b))
-		my_warn(_("partition %s: end: (c,h,s) expected (%ld,%ld,%ld) found (%ld,%ld,%ld)\n"),
+		warnx(_("partition %s: end: (c,h,s) expected (%ld,%ld,%ld) found (%ld,%ld,%ld)"),
 			PNO(p), aa.c, aa.h, aa.s, bb.c, bb.h, bb.s);
 	    if (B.cylinders && B.cylinders < 1024 && bb.c > B.cylinders)
-		my_warn(_("partition %s ends on cylinder %ld, beyond the end of the disk\n"),
+		warnx(_("partition %s ends on cylinder %ld, beyond the end of the disk"),
 			PNO(p), bb.c);
 	}
 
@@ -1394,11 +1381,11 @@ extended_partition(char *dev, int fd, struct part_desc *ep, struct disk_desc *z)
 	    warnx(_("Warning: shifted start of the extd partition "
 		      "from %lld to %lld\n"
 		      "(For listing purposes only. "
-		      "Do not change its contents.)\n"), ep->start, start);
+		      "Do not change its contents.)"), ep->start, start);
 	} else {
 	    warnx(_("Warning: extended partition does not start at a "
 		      "cylinder boundary.\n"
-		      "DOS and Linux will interpret the contents differently.\n"));
+		      "DOS and Linux will interpret the contents differently."));
 	}
     }
 
@@ -1416,7 +1403,7 @@ extended_partition(char *dev, int fd, struct part_desc *ep, struct disk_desc *z)
 	cp = s->data + 0x1be;
 
 	if (pno + 4 >= ARRAY_SIZE(z->partitions)) {
-	    warnx(_("too many partitions - ignoring those past nr (%zu)\n"),
+	    warnx(_("too many partitions - ignoring those past nr (%zu)"),
 		    pno - 1);
 	    break;
 	}
@@ -1431,7 +1418,7 @@ extended_partition(char *dev, int fd, struct part_desc *ep, struct disk_desc *z)
 	    if (is_extended(p.sys_type)) {
 		partitions[pno].start = start + p.start_sect;
 		if (next)
-		    warnx(_("tree of partitions?\n"));
+		    warnx(_("tree of partitions?"));
 		else
 		    next = partitions[pno].start;	/* follow `upper' branch */
 		moretodo = 1;
@@ -1494,7 +1481,7 @@ bsd_partition(char *dev, int fd, struct part_desc *ep, struct disk_desc *z) {
     while (bp - bp0 < BSD_MAXPARTITIONS && bp - bp0 < l->d_npartitions) {
 	if (pno + 1 >= ARRAY_SIZE(z->partitions)) {
 	    warnx(_("too many partitions - ignoring those "
-		      "past nr (%zu)\n"), pno - 1);
+		      "past nr (%zu)"), pno - 1);
 	    break;
 	}
 	if (bp->p_fstype != BSD_FS_UNUSED) {
@@ -1540,7 +1527,7 @@ msdos_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
 	|| pt.sys_type == EZD_PARTITION
 	|| pt.sys_type == DM6_AUX1PARTITION
 	|| pt.sys_type == DM6_AUX3PARTITION) {
-	warnx(_("detected Disk Manager - unable to handle that\n"));
+	warnx(_("detected Disk Manager - unable to handle that"));
 	return 0;
     }
 
@@ -1548,7 +1535,7 @@ msdos_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
     if (sig <= 0x1ae) {
 	memcpy(&magic, s->data + sig, sizeof(magic));
 	if (magic == 0x55aa && (1 & *(unsigned char *)(s->data + sig + 2))) {
-	    warnx(_("DM6 signature found - giving up\n"));
+	    warnx(_("DM6 signature found - giving up"));
 	    return 0;
 	}
     }
@@ -1568,14 +1555,14 @@ msdos_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
     for (i = 0; i < 4; i++) {
 	if (is_extended(partitions[i].p.sys_type)) {
 	    if (!partitions[i].size) {
-		warnx(_("strange..., an extended partition of size 0?\n"));
+		warnx(_("strange..., an extended partition of size 0?"));
 		continue;
 	    }
 	    extended_partition(dev, fd, &partitions[i], z);
 	}
 	if (!bsd_later && is_bsd(partitions[i].p.sys_type)) {
 	    if (!partitions[i].size) {
-		warnx(_("strange..., a BSD partition of size 0?\n"));
+		warnx(_("strange..., a BSD partition of size 0?"));
 		continue;
 	    }
 	    bsd_partition(dev, fd, &partitions[i], z);
@@ -1586,7 +1573,7 @@ msdos_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
 	for (i = 0; i < 4; i++) {
 	    if (is_bsd(partitions[i].p.sys_type)) {
 		if (!partitions[i].size) {
-		    warnx(_("strange..., a BSD partition of size 0?\n"));
+		    warnx(_("strange..., a BSD partition of size 0?"));
 		    continue;
 		}
 		bsd_partition(dev, fd, &partitions[i], z);
@@ -1630,7 +1617,7 @@ get_partitions(char *dev, int fd, struct disk_desc *z) {
 	&& !sun_partition(dev, fd, 0, z)
 	&& !amiga_partition(dev, fd, 0, z)) {
 	if (!opt_list)
-	    warnx(_(" %s: unrecognized partition table type\n"), dev);
+	    warnx(_(" %s: unrecognized partition table type"), dev);
 	return;
     }
 }
@@ -1642,7 +1629,7 @@ write_partitions(char *dev, int fd, struct disk_desc *z) {
     int pno = z->partno;
 
     if (no_write) {
-	warnx(_("-n flag was given: Nothing changed\n"));
+	warnx(_("-n flag was given: Nothing changed"));
 	exit(EXIT_SUCCESS);
     }
 
@@ -1836,11 +1823,11 @@ get_ul(char *u, unsigned long *up, unsigned long def, int base) {
 	errno = 0;
 	val = strtoul(u, &nu, base);
 	if (errno == ERANGE) {
-	    warnx(_("number too big\n"));
+	    warnx(_("number too big"));
 	    return -1;
 	}
 	if (*nu) {
-	    warnx(_("trailing junk after number\n"));
+	    warnx(_("trailing junk after number"));
 	    return -1;
 	}
 	if (sign == 1)
@@ -1873,11 +1860,11 @@ get_ull(char *u, unsigned long long *up, unsigned long long def, int base) {
 	errno = 0;
 	val = strtoull(u, &nu, base);
 	if (errno == ERANGE) {
-	    warnx(_("number too big\n"));
+	    warnx(_("number too big"));
 	    return -1;
 	}
 	if (*nu) {
-	    warnx(_("trailing junk after number\n"));
+	    warnx(_("trailing junk after number"));
 	    return -1;
 	}
 	if (sign == 1)
@@ -2002,7 +1989,7 @@ compute_start_sect(struct part_desc *p, struct part_desc *ep) {
 	if (is_extended(p->p.sys_type) && boxes == ONESECTOR)
 	    p->size = inc;
 	else if ((long long) old_size <= -delta) {
-	    my_warn(_("no room for partition descriptor\n"));
+	    warnx(_("no room for partition descriptor"));
 	    return 0;
 	}
     }
@@ -2035,7 +2022,7 @@ build_surrounding_extended(struct part_desc *p, struct part_desc *ep,
 	ep->start = first_free(ep - p0, 1, eep, format, p->start, z);
 	ep->size = max_length(ep - p0, 1, eep, format, ep->start, z);
 	if (ep->start > p->start || ep->start + ep->size < p->start + p->size) {
-	    my_warn(_("cannot build surrounding extended partition\n"));
+	    warnx(_("cannot build surrounding extended partition"));
 	    return 0;
 	}
     } else {
@@ -2075,8 +2062,8 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
 
     if (interactive) {
 	if (pct == 0 && (show_extended || pno == 0))
-	    my_warn("\n");
-	my_warn("%s:", partname(dev, lpno, 10));
+	    putchar('\n');
+	warnx("%s:", partname(dev, lpno, 10));
     }
 
     /* read input line - skip blank lines when reading from a file */
@@ -2086,7 +2073,7 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
     if (fno == RD_EOF) {
 	return -1;
     } else if (fno > 10 && *(fields[10]) != 0) {
-	warnx(_("too many input fields\n"));
+	warnx(_("too many input fields"));
 	return 0;
     }
 
@@ -2120,7 +2107,7 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
 	}
 	if (ml == 0 && pno >= 4) {
 	    /* no free blocks left - don't read any further */
-	    my_warn(_("No room for more\n"));
+	    warnx(_("No room for more"));
 	    return -1;
 	}
     }
@@ -2139,7 +2126,7 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
     else if (get_ull(fields[2], &ul, LINUX_NATIVE, 16))
 	return 0;
     if (ul > 255) {
-	my_warn(_("Illegal type\n"));
+	warnx(_("Illegal type"));
 	return 0;
     }
     p.p.sys_type = ul;
@@ -2173,13 +2160,13 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
 	p.size -= (p.size % unitsize(format));
     }
     if (p.size > ml1) {
-	my_warn(_("Warning: given size (%lu) exceeds max allowable size (%lu)\n"),
+	warnx(_("Warning: given size (%llu) exceeds max allowable size (%llu)"),
 		(p.size + unitsize(0) - 1) / unitsize(0), ml1 / unitsize(0));
 	if (!force)
 	    return 0;
     }
     if (p.size == 0 && pno >= 4 && (fno < 2 || !*(fields[1]))) {
-	my_warn(_("Warning: empty partition\n"));
+	warnx(_("Warning: empty partition"));
 	if (!force)
 	    return 0;
     }
@@ -2193,7 +2180,7 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
     }
 
     if (p.start < ff1 && p.size > 0) {
-	my_warn(_("Warning: bad partition start (earliest %lu)\n"),
+	warnx(_("Warning: bad partition start (earliest %llu)"),
 		(ff1 + unitsize(0) - 1) / unitsize(0));
 	if (!force)
 	    return 0;
@@ -2206,7 +2193,7 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
     else if (!strcmp(fields[3], "*") || !strcmp(fields[3], "+"))
 	ul = 0x80;
     else {
-	my_warn(_("unrecognized bootable flag - choose - or *\n"));
+	warnx(_("unrecognized bootable flag - choose - or *"));
 	return 0;
     }
     p.p.bootable = ul;
@@ -2223,7 +2210,7 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
 	if (fno < 5) {
 	    bb = aa;
 	} else if (fno < 7) {
-	    my_warn(_("partial c,h,s specification?\n"));
+	    warnx(_("partial c,h,s specification?"));
 	    return 0;
 	} else if (get_ul(fields[4], &bb.c, aa.c, 0) ||
 		   get_ul(fields[5], &bb.h, aa.h, 0) ||
@@ -2237,7 +2224,7 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
 	if (fno < 8) {
 	    bb = aa;
 	} else if (fno < 10) {
-	    my_warn(_("partial c,h,s specification?\n"));
+	    warnx(_("partial c,h,s specification?"));
 	    return 0;
 	} else if (get_ul(fields[7], &bb.c, aa.c, 0) ||
 		   get_ul(fields[8], &bb.h, aa.h, 0) ||
@@ -2248,7 +2235,7 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
 
     if (pno > 3 && p.size && show_extended && p.p.sys_type != EMPTY_PARTITION
 	&& (is_extended(p.p.sys_type) != (pct == 1))) {
-	my_warn(_("Extended partition not where expected\n"));
+	warnx(_("Extended partition not where expected"));
 	if (!force)
 	    return 0;
     }
@@ -2303,7 +2290,7 @@ read_partition_chain(char *dev, int interactive, struct part_desc *ep,
     while (1) {
 	base = z->partno;
 	if (base + 4 > ARRAY_SIZE(z->partitions)) {
-	    warnx(_("too many partitions\n"));
+	    warnx(_("too many partitions"));
 	    break;
 	}
 	for (i = 0; i < 4; i++)
@@ -2336,9 +2323,9 @@ read_input(char *dev, int interactive, struct disk_desc *z) {
     z->partno = 0;
 
     if (interactive)
-	my_warn(_("Input in the following format; absent fields get a default value.\n"
+	warnx(_("Input in the following format; absent fields get a default value.\n"
 		  "<start> <size> <type [E,S,L,X,hex]> <bootable [-,*]> <c,h,s> <c,h,s>\n"
-		  "Usually you only need to specify <start> and <size> (and perhaps <type>).\n"));
+		  "Usually you only need to specify <start> and <size> (and perhaps <type>)."));
     eof = 0;
 
     for (i = 0; i < 4; i++)
@@ -2798,7 +2785,7 @@ do_list(char *dev, int silent) {
 
     if (verify) {
 	if (partitions_ok(fd, z))
-	    my_warn(_("%s: OK\n"), dev);
+	    printf(_("%s: OK"), dev);
 	else
 	    exit_status = 1;
     }
@@ -2947,7 +2934,7 @@ do_activate(char **av, int ac, char *arg) {
 		else
 		    printf("%s#%d\n", dev, pno);
 		if (z->partitions[pno].p.bootable != 0x80)
-		    my_warn(_("bad active byte: 0x%x instead of 0x80\n"),
+		    warnx(_("bad active byte: 0x%x instead of 0x80"),
 			    z->partitions[pno].p.bootable);
 	    }
 	}
@@ -2966,7 +2953,7 @@ do_activate(char **av, int ac, char *arg) {
 
 	/* then write to disk */
 	if (write_partitions(dev, fd, z))
-	    my_warn(_("Done\n\n"));
+	    warnx(_("Done"));
 	else
 	    exit_status = 1;
     }
@@ -2975,12 +2962,12 @@ do_activate(char **av, int ac, char *arg) {
 	if (z->partitions[pno].p.bootable)
 	    i++;
     if (i != 1)
-	my_warn(_("You have %d active primary partitions. This does not matter for LILO,\n"
-		 "but the DOS MBR will only boot a disk with 1 active partition.\n"),
+	warnx(_("You have %d active primary partitions. This does not matter for LILO,\n"
+		 "but the DOS MBR will only boot a disk with 1 active partition."),
 		i);
 
     if (close_fd(fd) != 0) {
-	my_warn(_("write failed"));
+	warnx(_("write failed"));
 	exit_status = 1;
     }
 }
@@ -3011,13 +2998,13 @@ do_change_id(char *dev, char *pnam, char *id) {
     z->partitions[pno].p.sys_type = i;
 
     if (write_partitions(dev, fd, z))
-	my_warn(_("Done\n\n"));
+	warnx(_("Done"));
     else
 	exit_status = 1;
 
 done:
     if (close_fd(fd) != 0) {
-	my_warn(_("write failed"));
+	warnx(_("write failed"));
 	exit_status = 1;
     }
 }
@@ -3028,7 +3015,7 @@ do_reread(char *dev) {
 
     fd = my_open(dev, 0, 0);
     if (reread_ioctl(fd)) {
-	warnx(_("This disk is currently in use.\n"));
+	warnx(_("This disk is currently in use."));
 	exit(EXIT_FAILURE);
     }
 
@@ -3050,23 +3037,21 @@ do_fdisk(char *dev) {
     if (stat(dev, &statbuf) < 0)
 	err(EXIT_FAILURE, _("Fatal error: cannot find %s"), dev);
     if (!S_ISBLK(statbuf.st_mode)) {
-	warnx(_("Warning: %s is not a block device\n"), dev);
+	warnx(_("Warning: %s is not a block device"), dev);
 	no_reread = 1;
     }
     fd = my_open(dev, !no_write, 0);
 
     if (!no_write && !no_reread) {
-	my_warn(_("Checking that no-one is using this disk right now ...\n"));
+	warnx(_("Checking that no-one is using this disk right now ..."));
 	if (reread_ioctl(fd)) {
 	    warnx(_("\nThis disk is currently in use - repartitioning is probably a bad idea.\n"
 		      "Umount all file systems, and swapoff all swap partitions on this disk.\n"
-		      "Use the --no-reread flag to suppress this check.\n"));
-	    if (!force) {
-		warnx(_("Use the --force flag to overrule all checks.\n"));
-		exit(EXIT_FAILURE);
-	    }
+		      "Use the --no-reread flag to suppress this check."));
+	    if (!force)
+		errx(EXIT_FAILURE, _("Use the --force flag to overrule all checks."));
 	} else
-	    my_warn(_("OK\n"));
+	    warnx(_("OK"));
     }
 
     z = &oldp;
@@ -3095,7 +3080,7 @@ do_fdisk(char *dev) {
 		errx(EXIT_FAILURE, _("I don't like these partitions - nothing changed.\n"
 					 "(If you really want this, use the --force option.)"));
 	    else
-		warnx(_("I don't like this - probably you should answer No\n"));
+		warnx(_("I don't like this - probably you should answer No"));
 	}
 	if (interactive) {
  ask:
@@ -3129,9 +3114,9 @@ do_fdisk(char *dev) {
 	close(fd);
 	exit_status = 1;
     }
-    my_warn(_("If you created or changed a DOS partition, /dev/foo7, say, then use dd(1)\n"
+    warnx(_("If you created or changed a DOS partition, /dev/foo7, say, then use dd(1)\n"
 	      "to zero the first 512 bytes:  dd if=/dev/zero of=/dev/foo7 bs=512 count=1\n"
-	      "(See fdisk(8).)\n"));
+	      "(See fdisk(8).)"));
 
     sync();			/* superstition */
 }
-- 
1.8.3.1

