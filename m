Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:52473 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757206Ab2GLJsI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Jul 2012 05:48:08 -0400
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Cc: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH 1/2] fdisk: don't call update_units() in label probes if not necessary
Date: Thu, 12 Jul 2012 11:47:18 +0200
Message-Id: <1342086439-21462-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

update_units() is called in _probe_labels before the label probes are
started, so we don't need to call it again in probers, unless it messes
around with geometry, which currently only check_sun_label() does (so
keep the call to update_units() in this one).

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisks/fdiskaixlabel.c |    1 -
 fdisks/fdiskmaclabel.c |    1 -
 fdisks/fdisksgilabel.c |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/fdisks/fdiskaixlabel.c b/fdisks/fdiskaixlabel.c
index 474a177..f908abc 100644
--- a/fdisks/fdiskaixlabel.c
+++ b/fdisks/fdiskaixlabel.c
@@ -57,7 +57,6 @@ static int check_aix_label(struct fdisk_context *cxt)
 	return 0;
     }
     other_endian = (aixlabel->magic == AIX_LABEL_MAGIC_SWAPPED);
-    update_units(cxt);
     disklabel = AIX_LABEL;
     partitions= 1016;
     volumes = 15;
diff --git a/fdisks/fdiskmaclabel.c b/fdisks/fdiskmaclabel.c
index 1b82660..cbdf592 100644
--- a/fdisks/fdiskmaclabel.c
+++ b/fdisks/fdiskmaclabel.c
@@ -72,7 +72,6 @@ check_mac_label(struct fdisk_context *cxt)
 
 IS_MAC:
     other_endian = (maclabel->magic == MAC_LABEL_MAGIC_SWAPPED); // =?
-    update_units(cxt);
     disklabel = MAC_LABEL;
     partitions= 1016; // =?
     volumes = 15;	// =?
diff --git a/fdisks/fdisksgilabel.c b/fdisks/fdisksgilabel.c
index 32dae78..c0b346a 100644
--- a/fdisks/fdisksgilabel.c
+++ b/fdisks/fdisksgilabel.c
@@ -151,7 +151,6 @@ check_sgi_label(struct fdisk_context *cxt) {
 		fprintf(stderr,
 			_("Detected sgi disklabel with wrong checksum.\n"));
 	}
-	update_units(cxt);
 	disklabel = SGI_LABEL;
 	partitions= 16;
 	volumes = 15;
-- 
1.7.7

