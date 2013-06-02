Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:54642 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970Ab3FBRwD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Jun 2013 13:52:03 -0400
Received: by mail-wi0-f177.google.com with SMTP id hr14so2011032wib.16
        for <util-linux@vger.kernel.org>; Sun, 02 Jun 2013 10:52:01 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/19] sfdisk: replace my_warn() with warnx()
Date: Sun,  2 Jun 2013 18:51:15 +0100
Message-Id: <1370195485-27907-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
References: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This change adds program name in front of error messages.  Often that
helps user to know which command sent message, when the command is
executed as part of script.

Unfortunately the prefixing may break scripts, as there is no knowledge
whether some scripts are expecting not command name prefixed error
messages from this utility.  Same in programmer terms; the change
contains ABI change.

Karel: could you sign-off abi change, if not please drop this patch.
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisks/sfdisk.c | 219 ++++++++++++++++++++++++++------------------------------
 1 file changed, 103 insertions(+), 116 deletions(-)

diff --git a/fdisks/sfdisk.c b/fdisks/sfdisk.c
index 2d430de..c25616d 100644
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
@@ -405,7 +392,7 @@ get_geometry(char *dev, int fd, int silent) {
     {
 	g.heads = g.sectors = g.cylinders = g.start = 0;
 	if (!silent)
-	    warnx(_("Disk %s: cannot get geometry\n"), dev);
+	    warnx(_("Disk %s: cannot get geometry"), dev);
     }
 
     R.start = g.start;
@@ -422,7 +409,7 @@ get_geometry(char *dev, int fd, int silent) {
 	if (fstat(fd, &s) == 0 && S_ISREG(s.st_mode))
 	    R.total_size = (s.st_size >> 9);
 	else if (!silent)
-	    warnx(_("Disk %s: cannot get size\n"), dev);
+	    warnx(_("Disk %s: cannot get size"), dev);
     } else
 	R.total_size = sectors;
 
@@ -454,28 +441,28 @@ get_cylindersize(char *dev, int fd, int silent) {
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
@@ -564,18 +551,18 @@ chs_ok(chs a, char *v, char *w) {
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
@@ -781,14 +768,14 @@ reread_disk_partition(char *dev, int fd) {
 	if (reread_ioctl(fd) ) {
 	   warnx(_("The command to re-read the partition table failed.\n"
 		"Run partprobe(8), kpartx(8) or reboot your system now,\n"
-		"before using mkfs\n"));
+		"before using mkfs"));
 	   return 0;
 	}
     }
 
     if (close_fd(fd) != 0) {
 	perror(dev);
-	warnx(_("Error closing %s\n"), dev);
+	warnx(_("Error closing %s"), dev);
 	return 0;
     }
     printf("\n");
@@ -852,7 +839,7 @@ static void
 set_format(char c) {
     switch (c) {
     default:
-	warnx(_("unrecognized format - using sectors\n"));
+	warnx(_("unrecognized format - using sectors"));
 	/* fallthrough */
     case 'S':
 	specified_format = F_SECTOR;
@@ -913,7 +900,7 @@ out_partition_header(char *dev, int format, struct geometry G) {
 
     switch (format) {
     default:
-	warnx(_("unimplemented format - using %s\n"),
+	warnx(_("unimplemented format - using %s"),
 		G.cylindersize ? _("cylinders") : _("sectors"));
 	/* fallthrough */
     case F_CYLINDER:
@@ -1096,17 +1083,17 @@ out_partition(char *dev, int format, struct part_desc *p,
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
@@ -1117,12 +1104,12 @@ out_partitions(char *dev, struct disk_desc *z) {
 
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
 
@@ -1180,13 +1167,13 @@ partitions_ok(int fd, struct disk_desc *z) {
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
@@ -1198,8 +1185,8 @@ partitions_ok(int fd, struct disk_desc *z) {
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
@@ -1210,7 +1197,7 @@ partitions_ok(int fd, struct disk_desc *z) {
 	    for (q = p + 1; q < partitions + partno; q++)
 		if (q->size && !is_extended(q->p.sys_type))
 		    if (!((p->start > q->start) ? disj(q, p) : disj(p, q))) {
-			my_warn(_("Warning: partitions %s and %s overlap\n"),
+			warnx(_("Warning: partitions %s and %s overlap"),
 				PNO(p), PNO(q));
 			return 0;
 		    }
@@ -1222,9 +1209,9 @@ partitions_ok(int fd, struct disk_desc *z) {
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
@@ -1235,12 +1222,12 @@ partitions_ok(int fd, struct disk_desc *z) {
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
@@ -1256,9 +1243,9 @@ partitions_ok(int fd, struct disk_desc *z) {
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
@@ -1272,8 +1259,8 @@ partitions_ok(int fd, struct disk_desc *z) {
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
@@ -1292,8 +1279,8 @@ partitions_ok(int fd, struct disk_desc *z) {
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
@@ -1312,14 +1299,14 @@ partitions_ok(int fd, struct disk_desc *z) {
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
@@ -1337,22 +1324,22 @@ partitions_ok(int fd, struct disk_desc *z) {
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
@@ -1367,7 +1354,7 @@ partitions_ok(int fd, struct disk_desc *z) {
 	    if (!Linux && !chs_ok(b, PNO(p), _("start")))
 		return 0;
 	    if (a.s && !is_equal_chs(a, b))
-		my_warn(_("partition %s: start: (c,h,s) expected (%ld,%ld,%ld) found (%ld,%ld,%ld)\n"),
+		warnx(_("partition %s: start: (c,h,s) expected (%ld,%ld,%ld) found (%ld,%ld,%ld)"),
 			PNO(p), aa.c, aa.h, aa.s, bb.c, bb.h, bb.s);
 	    a = p->size ? ulong_to_chs(p->start + p->size - 1, B) : zero_chs;
 	    b = p->p.end_chs;
@@ -1376,10 +1363,10 @@ partitions_ok(int fd, struct disk_desc *z) {
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
 
@@ -1407,11 +1394,11 @@ extended_partition(char *dev, int fd, struct part_desc *ep, struct disk_desc *z)
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
 
@@ -1429,7 +1416,7 @@ extended_partition(char *dev, int fd, struct part_desc *ep, struct disk_desc *z)
 	cp = s->data + 0x1be;
 
 	if (pno + 4 >= ARRAY_SIZE(z->partitions)) {
-	    warnx(_("too many partitions - ignoring those past nr (%zu)\n"),
+	    warnx(_("too many partitions - ignoring those past nr (%zu)"),
 		    pno - 1);
 	    break;
 	}
@@ -1444,7 +1431,7 @@ extended_partition(char *dev, int fd, struct part_desc *ep, struct disk_desc *z)
 	    if (is_extended(p.sys_type)) {
 		partitions[pno].start = start + p.start_sect;
 		if (next)
-		    warnx(_("tree of partitions?\n"));
+		    warnx(_("tree of partitions?"));
 		else
 		    next = partitions[pno].start;	/* follow `upper' branch */
 		moretodo = 1;
@@ -1507,7 +1494,7 @@ bsd_partition(char *dev, int fd, struct part_desc *ep, struct disk_desc *z) {
     while (bp - bp0 < BSD_MAXPARTITIONS && bp - bp0 < l->d_npartitions) {
 	if (pno + 1 >= ARRAY_SIZE(z->partitions)) {
 	    warnx(_("too many partitions - ignoring those "
-		      "past nr (%zu)\n"), pno - 1);
+		      "past nr (%zu)"), pno - 1);
 	    break;
 	}
 	if (bp->p_fstype != BSD_FS_UNUSED) {
@@ -1553,7 +1540,7 @@ msdos_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
 	|| pt.sys_type == EZD_PARTITION
 	|| pt.sys_type == DM6_AUX1PARTITION
 	|| pt.sys_type == DM6_AUX3PARTITION) {
-	warnx(_("detected Disk Manager - unable to handle that\n"));
+	warnx(_("detected Disk Manager - unable to handle that"));
 	return 0;
     }
 
@@ -1561,7 +1548,7 @@ msdos_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
     if (sig <= 0x1ae) {
 	memcpy(&magic, s->data + sig, sizeof(magic));
 	if (magic == 0x55aa && (1 & *(unsigned char *)(s->data + sig + 2))) {
-	    warnx(_("DM6 signature found - giving up\n"));
+	    warnx(_("DM6 signature found - giving up"));
 	    return 0;
 	}
     }
@@ -1581,14 +1568,14 @@ msdos_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
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
@@ -1599,7 +1586,7 @@ msdos_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
 	for (i = 0; i < 4; i++) {
 	    if (is_bsd(partitions[i].p.sys_type)) {
 		if (!partitions[i].size) {
-		    warnx(_("strange..., a BSD partition of size 0?\n"));
+		    warnx(_("strange..., a BSD partition of size 0?"));
 		    continue;
 		}
 		bsd_partition(dev, fd, &partitions[i], z);
@@ -1643,7 +1630,7 @@ get_partitions(char *dev, int fd, struct disk_desc *z) {
 	&& !sun_partition(dev, fd, 0, z)
 	&& !amiga_partition(dev, fd, 0, z)) {
 	if (!opt_list)
-	    warnx(_(" %s: unrecognized partition table type\n"), dev);
+	    warnx(_(" %s: unrecognized partition table type"), dev);
 	return;
     }
 }
@@ -1655,7 +1642,7 @@ write_partitions(char *dev, int fd, struct disk_desc *z) {
     int pno = z->partno;
 
     if (no_write) {
-	warnx(_("-n flag was given: Nothing changed\n"));
+	warnx(_("-n flag was given: Nothing changed"));
 	exit(EXIT_SUCCESS);
     }
 
@@ -1850,11 +1837,11 @@ get_ul(char *u, unsigned long *up, unsigned long def, int base) {
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
@@ -1887,11 +1874,11 @@ get_ull(char *u, unsigned long long *up, unsigned long long def, int base) {
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
@@ -2016,7 +2003,7 @@ compute_start_sect(struct part_desc *p, struct part_desc *ep) {
 	if (is_extended(p->p.sys_type) && boxes == ONESECTOR)
 	    p->size = inc;
 	else if ((long long) old_size <= -delta) {
-	    my_warn(_("no room for partition descriptor\n"));
+	    warnx(_("no room for partition descriptor"));
 	    return 0;
 	}
     }
@@ -2049,7 +2036,7 @@ build_surrounding_extended(struct part_desc *p, struct part_desc *ep,
 	ep->start = first_free(ep - p0, 1, eep, format, p->start, z);
 	ep->size = max_length(ep - p0, 1, eep, format, ep->start, z);
 	if (ep->start > p->start || ep->start + ep->size < p->start + p->size) {
-	    my_warn(_("cannot build surrounding extended partition\n"));
+	    warnx(_("cannot build surrounding extended partition"));
 	    return 0;
 	}
     } else {
@@ -2089,8 +2076,8 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
 
     if (interactive) {
 	if (pct == 0 && (show_extended || pno == 0))
-	    my_warn("\n");
-	my_warn("%s:", partname(dev, lpno, 10));
+	    putchar('\n');
+	warnx("%s:", partname(dev, lpno, 10));
     }
 
     /* read input line - skip blank lines when reading from a file */
@@ -2100,7 +2087,7 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
     if (fno == RD_EOF) {
 	return -1;
     } else if (fno > 10 && *(fields[10]) != 0) {
-	warnx(_("too many input fields\n"));
+	warnx(_("too many input fields"));
 	return 0;
     }
 
@@ -2134,7 +2121,7 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
 	}
 	if (ml == 0 && pno >= 4) {
 	    /* no free blocks left - don't read any further */
-	    my_warn(_("No room for more\n"));
+	    warnx(_("No room for more"));
 	    return -1;
 	}
     }
@@ -2153,7 +2140,7 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
     else if (get_ull(fields[2], &ul, LINUX_NATIVE, 16))
 	return 0;
     if (ul > 255) {
-	my_warn(_("Illegal type\n"));
+	warnx(_("Illegal type"));
 	return 0;
     }
     p.p.sys_type = ul;
@@ -2187,13 +2174,13 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
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
@@ -2207,7 +2194,7 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
     }
 
     if (p.start < ff1 && p.size > 0) {
-	my_warn(_("Warning: bad partition start (earliest %lu)\n"),
+	warnx(_("Warning: bad partition start (earliest %llu)"),
 		(ff1 + unitsize(0) - 1) / unitsize(0));
 	if (!force)
 	    return 0;
@@ -2220,7 +2207,7 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
     else if (!strcmp(fields[3], "*") || !strcmp(fields[3], "+"))
 	ul = 0x80;
     else {
-	my_warn(_("unrecognized bootable flag - choose - or *\n"));
+	warnx(_("unrecognized bootable flag - choose - or *"));
 	return 0;
     }
     p.p.bootable = ul;
@@ -2237,7 +2224,7 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
 	if (fno < 5) {
 	    bb = aa;
 	} else if (fno < 7) {
-	    my_warn(_("partial c,h,s specification?\n"));
+	    warnx(_("partial c,h,s specification?"));
 	    return 0;
 	} else if (get_ul(fields[4], &bb.c, aa.c, 0) ||
 		   get_ul(fields[5], &bb.h, aa.h, 0) ||
@@ -2251,7 +2238,7 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
 	if (fno < 8) {
 	    bb = aa;
 	} else if (fno < 10) {
-	    my_warn(_("partial c,h,s specification?\n"));
+	    warnx(_("partial c,h,s specification?"));
 	    return 0;
 	} else if (get_ul(fields[7], &bb.c, aa.c, 0) ||
 		   get_ul(fields[8], &bb.h, aa.h, 0) ||
@@ -2262,7 +2249,7 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
 
     if (pno > 3 && p.size && show_extended && p.p.sys_type != EMPTY_PARTITION
 	&& (is_extended(p.p.sys_type) != (pct == 1))) {
-	my_warn(_("Extended partition not where expected\n"));
+	warnx(_("Extended partition not where expected"));
 	if (!force)
 	    return 0;
     }
@@ -2317,7 +2304,7 @@ read_partition_chain(char *dev, int interactive, struct part_desc *ep,
     while (1) {
 	base = z->partno;
 	if (base + 4 > ARRAY_SIZE(z->partitions)) {
-	    warnx(_("too many partitions\n"));
+	    warnx(_("too many partitions"));
 	    break;
 	}
 	for (i = 0; i < 4; i++)
@@ -2350,9 +2337,9 @@ read_input(char *dev, int interactive, struct disk_desc *z) {
     z->partno = 0;
 
     if (interactive)
-	my_warn(_("Input in the following format; absent fields get a default value.\n"
+	warnx(_("Input in the following format; absent fields get a default value.\n"
 		  "<start> <size> <type [E,S,L,X,hex]> <bootable [-,*]> <c,h,s> <c,h,s>\n"
-		  "Usually you only need to specify <start> and <size> (and perhaps <type>).\n"));
+		  "Usually you only need to specify <start> and <size> (and perhaps <type>)."));
     eof = 0;
 
     for (i = 0; i < 4; i++)
@@ -2813,7 +2800,7 @@ do_list(char *dev, int silent) {
 
     if (verify) {
 	if (partitions_ok(fd, z))
-	    my_warn(_("%s: OK\n"), dev);
+	    printf(_("%s: OK"), dev);
 	else
 	    exit_status = 1;
     }
@@ -2964,7 +2951,7 @@ do_activate(char **av, int ac, char *arg) {
 		else
 		    printf("%s#%d\n", dev, pno);
 		if (z->partitions[pno].p.bootable != 0x80)
-		    my_warn(_("bad active byte: 0x%x instead of 0x80\n"),
+		    warnx(_("bad active byte: 0x%x instead of 0x80"),
 			    z->partitions[pno].p.bootable);
 	    }
 	}
@@ -2983,7 +2970,7 @@ do_activate(char **av, int ac, char *arg) {
 
 	/* then write to disk */
 	if (write_partitions(dev, fd, z))
-	    my_warn(_("Done\n\n"));
+	    warnx(_("Done"));
 	else
 	    exit_status = 1;
     }
@@ -2992,12 +2979,12 @@ do_activate(char **av, int ac, char *arg) {
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
@@ -3028,13 +3015,13 @@ do_change_id(char *dev, char *pnam, char *id) {
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
@@ -3045,7 +3032,7 @@ do_reread(char *dev) {
 
     fd = my_open(dev, 0, 0);
     if (reread_ioctl(fd)) {
-	warnx(_("This disk is currently in use.\n"));
+	warnx(_("This disk is currently in use."));
 	exit(EXIT_FAILURE);
     }
 
@@ -3069,23 +3056,23 @@ do_fdisk(char *dev) {
 	errx(EXIT_FAILURE, _("Fatal error: cannot find %s"), dev);
     }
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
+		      "Use the --no-reread flag to suppress this check."));
 	    if (!force) {
-		warnx(_("Use the --force flag to overrule all checks.\n"));
+		warnx(_("Use the --force flag to overrule all checks."));
 		exit(EXIT_FAILURE);
 	    }
 	} else
-	    my_warn(_("OK\n"));
+	    warnx(_("OK"));
     }
 
     z = &oldp;
@@ -3114,7 +3101,7 @@ do_fdisk(char *dev) {
 		errx(EXIT_FAILURE, _("I don't like these partitions - nothing changed.\n"
 					 "(If you really want this, use the --force option.)"));
 	    else
-		warnx(_("I don't like this - probably you should answer No\n"));
+		warnx(_("I don't like this - probably you should answer No"));
 	}
 	if (interactive) {
  ask:
@@ -3148,9 +3135,9 @@ do_fdisk(char *dev) {
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
1.8.3

