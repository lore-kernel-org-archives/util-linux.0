Return-Path: util-linux-owner@vger.kernel.org
Received: from g4t3425.houston.hp.com ([15.201.208.53]:27207 "EHLO
	g4t3425.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbaGVXpF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jul 2014 19:45:05 -0400
From: Davidlohr Bueso <davidlohr@hp.com>
To: kzak@redhat.com
Cc: davidlohr@hp.com, aswin@hp.com, util-linux@vger.kernel.org
Subject: [PATCH 02/13] sfdisk: deprecate --linux option
Date: Tue, 22 Jul 2014 16:44:46 -0700
Message-Id: <1406072697-20912-3-git-send-email-davidlohr@hp.com>
In-Reply-To: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
References: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Per sfdisk(8) manpage:
       -L, --Linux
              Do not complain about things irrelevant for Linux.

This doesn't make much sense for a program distributed by the
util-linux package. Mark deprecated, instead of removing, to
allow users to update theirs scripts, otherwise we can easily
break things. Now, using this option has no effect whatsoever
as it is the only behavior anyways.

Previously when sfdisk runs on Linux and the -L option is not
used, we can get some of the warnings from the additional checks:

$ sfdisk -V /dev/sda
sfdisk: Warning: partition 1 does not end at a cylinder boundary
sfdisk: Warning: partition 2 does not start at a cylinder boundary
/dev/sda: OK

With this patch output lines can change, ie:

$ sfdisk -V /dev/sda
/dev/sda: OK

Signed-off-by: Davidlohr Bueso <davidlohr@hp.com>
---
 disk-utils/sfdisk.8 |  2 +-
 disk-utils/sfdisk.c | 77 +++--------------------------------------------------
 2 files changed, 5 insertions(+), 74 deletions(-)

diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index 26065c2..1e84a11 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -301,7 +301,7 @@ Do what I say, even if it is stupid.
 Suppress warning messages.
 .TP
 .BR \-L ", " \-\-Linux
-Do not complain about things irrelevant for Linux.
+Do not complain about things irrelevant for Linux. Deprecated.
 .TP
 .BR \-D ", " \-\-DOS
 For DOS-compatibility: waste a little space.
diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 9fc71b4..6db9dfd 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -532,31 +532,6 @@ is_equal_chs(chs a, chs b) {
     return (a.h == b.h && a.s == b.s && a.c == b.c);
 }
 
-static int
-chs_ok(chs a, char *v, char *w) {
-    longchs aa = chs_to_longchs(a);
-    int ret = 1;
-
-    if (is_equal_chs(a, zero_chs))
-	return 1;
-    if (B.heads && aa.h >= B.heads) {
-	warnx(_("%s of partition %s has impossible value for head: "
-		  "%lu (should be in 0-%lu)"), w, v, aa.h, B.heads - 1);
-	ret = 0;
-    }
-    if (B.sectors && (aa.s == 0 || aa.s > B.sectors)) {
-	warnx(_("%s of partition %s has impossible value for sector: "
-		  "%lu (should be in 1-%lu)"), w, v, aa.s, B.sectors);
-	ret = 0;
-    }
-    if (B.cylinders && aa.c >= B.cylinders) {
-	warnx(_("%s of partition %s has impossible value for cylinders: "
-		  "%lu (should be in 0-%lu)"), w, v, aa.c, B.cylinders - 1);
-	ret = 0;
-    }
-    return ret;
-}
-
 /*
  *  D. About system Ids
  */
@@ -1266,39 +1241,6 @@ partitions_ok(int fd, struct disk_desc *z) {
 	for (p = partitions; p < partitions + 4; p++)
 	    if (p->p.sys_type == EXTENDED_PARTITION)
 		ect++;
-	if (ect > 1 && !Linux) {
-	    warnx(_("Among the primary partitions, at most one can be extended\n"
-		      " (although this is not a problem under Linux)"));
-	    return 0;
-	}
-    }
-
-    /*
-     * Do all partitions start at a cylinder boundary ?
-     * (this is not required for Linux)
-     * The first partition starts after MBR.
-     * Logical partitions start slightly after the containing extended partn.
-     */
-    if (B.cylindersize && !Linux) {
-	for (p = partitions; p < partitions + partno; p++)
-	    if (p->size) {
-		if (p->start % B.cylindersize != 0
-		    && (!p->ep
-			|| p->start / B.cylindersize !=
-			p->ep->start / B.cylindersize)
-		    && (p->p.start_sect >= B.cylindersize)) {
-		    warnx(_("Warning: partition %s does not start "
-			      "at a cylinder boundary"), PNO(p));
-		    if (specified_format == F_CYLINDER)
-			return 0;
-		}
-		if ((p->start + p->size) % B.cylindersize) {
-		    warnx(_("Warning: partition %s does not end "
-			      "at a cylinder boundary"), PNO(p));
-		    if (specified_format == F_CYLINDER)
-			return 0;
-		}
-	    }
     }
 
     /* Usually, one can boot only from primary partitions. */
@@ -1339,8 +1281,7 @@ partitions_ok(int fd, struct disk_desc *z) {
 	    b = p->p.begin_chs;
 	    aa = chs_to_longchs(a);
 	    bb = chs_to_longchs(b);
-	    if (!Linux && !chs_ok(b, PNO(p), _("start")))
-		return 0;
+
 	    if (a.s && !is_equal_chs(a, b))
 		warnx(_("partition %s: start: (c,h,s) expected (%ld,%ld,%ld) found (%ld,%ld,%ld)"),
 			PNO(p), aa.c, aa.h, aa.s, bb.c, bb.h, bb.s);
@@ -1348,8 +1289,7 @@ partitions_ok(int fd, struct disk_desc *z) {
 	    b = p->p.end_chs;
 	    aa = chs_to_longchs(a);
 	    bb = chs_to_longchs(b);
-	    if (!Linux && !chs_ok(b, PNO(p), _("end")))
-		return 0;
+
 	    if (a.s && !is_equal_chs(a, b))
 		warnx(_("partition %s: end: (c,h,s) expected (%ld,%ld,%ld) found (%ld,%ld,%ld)"),
 			PNO(p), aa.c, aa.h, aa.s, bb.c, bb.h, bb.s);
@@ -1383,10 +1323,6 @@ extended_partition(char *dev, int fd, struct part_desc *ep, struct disk_desc *z)
 		      "from %lld to %lld\n"
 		      "(For listing purposes only. "
 		      "Do not change its contents.)"), ep->start, start);
-	} else if (!Linux) {
-	    warnx(_("Warning: extended partition does not start at a "
-		      "cylinder boundary.\n"
-		      "DOS and Linux will interpret the contents differently."));
 	}
     }
 
@@ -2054,7 +1990,7 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
     int fno, pct = pno % 4;
     struct part_desc p, *orig;
     unsigned long long ff, ff1, ul, ml, ml1, def;
-    int format, lpno, is_extd;
+    int format = 0, lpno, is_extd;
 
     if (eof || eob)
 	return -1;
@@ -2083,11 +2019,6 @@ read_line(int pno, struct part_desc *ep, char *dev, int interactive,
 	return -1;
     }
 
-    /* use specified format, but round to cylinders if F_MEGABYTE specified */
-    format = 0;
-    if (B.cylindersize && specified_format == F_MEGABYTE && !Linux)
-	format = F_CYLINDER;
-
     orig = (one_only ? &(oldp.partitions[pno]) : 0);
 
     p = zero_part_desc;
@@ -2375,7 +2306,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(_(" -f, --force               disable all consistency checking\n"
 		"     --no-reread           do not check whether the partition is in use\n"
 		" -q, --quiet               suppress warning messages\n"
-		" -L, --Linux               do not complain about things irrelevant for Linux\n"), out);
+		" -L, --Linux               do not complain about things irrelevant for Linux [deprecated]\n"), out);
 	fputs(_(" -g, --show-geometry       print the kernel's idea of the geometry\n"
 		" -G, --show-pt-geometry    print geometry guessed from the partition table\n"), out);
 	fputs(_(" -A, --activate[=<device>] activate the bootable flag\n"
-- 
1.8.1.4

