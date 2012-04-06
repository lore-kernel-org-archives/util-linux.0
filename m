Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50123 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753669Ab2DFOxP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 6 Apr 2012 10:53:15 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 3B45094703
	for <util-linux@vger.kernel.org>; Fri,  6 Apr 2012 16:53:14 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] sfdisk: fix calculation due to type mismatch (ix86)
Date: Fri,  6 Apr 2012 16:53:13 +0200
Message-Id: <1333723993-11424-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Instructing sfdisk to create one partition spanning
across entire disk (",,") on 32bit system, if the disk
is sufficiently large (~2TB) leads to wrong calculation
in compute_start_sect() due to type mismatch.

Can be reproduced as:

--------------------------
linux-3ln5:~ # modprobe scsi_debug virtual_gb=2000
linux-3ln5:~ # sfdisk /dev/sda <<< ',,'
Checking that no-one is using this disk right now ...
OK

Disk /dev/sda: 261083 cylinders, 255 heads, 63 sectors/track

sfdisk: ERROR: sector 0 does not have an msdos signature
sfdisk:  /dev/sda: unrecognized partition table type

Old situation:
sfdisk: No partitions found

no room for partition descriptor
sfdisk: bad input
--------------------------

Addresses: https://bugzilla.novell.com/show_bug.cgi?id=754789
Reported-by: Dan Mares <dan.mares@norcrossgroup.com>
Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisk/sfdisk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index 87929d3..350bf1d 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -1991,7 +1991,7 @@ static int
 compute_start_sect(struct part_desc *p, struct part_desc *ep) {
     unsigned long long base;
     int inc = (DOS && B.sectors) ? B.sectors : 1;
-    int delta;
+    long long delta;
 
     if (ep && p->start + p->size >= ep->start + 1)
 	delta = p->start - ep->start - inc;
@@ -2006,7 +2006,7 @@ compute_start_sect(struct part_desc *p, struct part_desc *ep) {
 	p->size += delta;
 	if (is_extended(p->p.sys_type) && boxes == ONESECTOR)
 	    p->size = inc;
-	else if ((ssize_t) old_size <= (ssize_t) - delta) {
+	else if ((long long) old_size <= -delta) {
 	    my_warn(_("no room for partition descriptor\n"));
 	    return 0;
 	}
-- 
1.7.7

