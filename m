Return-Path: util-linux-owner@vger.kernel.org
Received: from thot02.seeweb.it ([85.94.213.58]:47796 "EHLO thot02.seeweb.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752601Ab1HRHdl convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 18 Aug 2011 03:33:41 -0400
Received: from i3.golden.dom ([151.58.205.50])
	(authenticated bits=0)
	by thot02.seeweb.it (8.14.3/8.14.3/Debian-5) with ESMTP id p7I7Xcc0019351
	for <util-linux@vger.kernel.org>; Thu, 18 Aug 2011 09:33:38 +0200
From: Giulio <giulioo@gmail.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] sfdisk: make some tests conditional to !Linux
Date: Thu, 18 Aug 2011 09:30:30 +0200
Reply-To: giulioo@pobox.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20110818073019.B70AFF815@i3.golden.dom>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch makes the following tests/actions conditional to "!Linux":

- Force cylinders as format instead of MB, even if user asked for MB.
This solves a bug where if you use "-L -uM", set 1 as starting MB and the
disk is larger than a certain size (about 1GB) the partition would start at
sector 1 instead of 1MB due to cyl rounding.

- Warn about partitions not starting/ending on cyl boundaries.

- Check if CHS is ok.

I used the "!Linux" notation since it was already used elsewhere in the
code.

Sorry, I don't use git, hope this is ok.

Signed-off-by: Giulio Orsero <giulioo@pobox.com>
---
--- a/fdisk/sfdisk.c	2011-08-17 17:17:43.000000000 +0200
+++ b/fdisk/sfdisk.c	2011-08-17 22:48:52.000000000 +0200
@@ -1315,7 +1315,7 @@ partitions_ok(struct disk_desc *z) {
      * The first partition starts after MBR.
      * Logical partitions start slightly after the containing extended partn.
      */
-    if (B.cylindersize) {
+    if (B.cylindersize && !Linux) {
 	for (p = partitions; p < partitions + partno; p++)
 	    if (p->size) {
 		if (p->start % B.cylindersize != 0
@@ -1325,14 +1325,12 @@ partitions_ok(struct disk_desc *z) {
 		    && (p->p.start_sect >= B.cylindersize)) {
 		    my_warn(_("Warning: partition %s does not start "
 			      "at a cylinder boundary\n"), PNO(p));
-		    if (!Linux)
-			return 0;
+		    return 0;
 		}
 		if ((p->start + p->size) % B.cylindersize) {
 		    my_warn(_("Warning: partition %s does not end "
 			      "at a cylinder boundary\n"), PNO(p));
-		    if (!Linux)
-			return 0;
+		    return 0;
 		}
 	    }
     }
@@ -1378,7 +1376,7 @@ partitions_ok(struct disk_desc *z) {
 	    b = p->p.begin_chs;
 	    aa = chs_to_longchs(a);
 	    bb = chs_to_longchs(b);
-	    if (!chs_ok(b, PNO(p), _("start")))
+	    if (!chs_ok(b, PNO(p), _("start")) && !Linux)
 		return 0;
 	    if (a.s && !is_equal_chs(a, b))
 		my_warn(_
@@ -1388,7 +1386,7 @@ partitions_ok(struct disk_desc *z) {
 	    b = p->p.end_chs;
 	    aa = chs_to_longchs(a);
 	    bb = chs_to_longchs(b);
-	    if (!chs_ok(b, PNO(p), _("end")))
+	    if (!chs_ok(b, PNO(p), _("end")) && !Linux)
 		return 0;
 	    if (a.s && !is_equal_chs(a, b))
 		my_warn(_
@@ -2087,7 +2085,7 @@ read_line(int pno, struct part_desc *ep,
 
     /* use specified format, but round to cylinders if F_MEGABYTE specified */
     format = 0;
-    if (B.cylindersize && specified_format == F_MEGABYTE)
+    if (B.cylindersize && specified_format == F_MEGABYTE && !Linux)
 	format = F_CYLINDER;
 
     orig = (one_only ? &(oldp.partitions[pno]) : 0);
