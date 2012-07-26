Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcagg.dreamhost.com ([208.97.132.66]:52340 "EHLO
	homiemail-a61.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751418Ab2GZORC (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 10:17:02 -0400
Subject: [PATCH] fdisk: fix menu
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Jul 2012 16:16:57 +0200
Message-ID: <1343312217.2609.11.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Commit 79c8a145ddff98d9c5bc70e67c5a861f67c50484 changed the numerical values of
fdisk_labeltype and broke the menu functionality, mixing main and expert menus.
Revert this change along with the label comment regarding it matching labeltype.

This is no longer valid since the original patch that lead to this modification
assumed that __probe_labels() would use these indices when creating a default
DOS/SUN disklabel, see http://www.spinics.net/lists/util-linux-ng/msg06509.html

Reported-by: Petr Uzel <petr.uzel@suse.cz>
Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/fdisk.h |   12 ++++++------
 fdisks/utils.c |    2 --
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fdisks/fdisk.h b/fdisks/fdisk.h
index 29b57fe..260445a 100644
--- a/fdisks/fdisk.h
+++ b/fdisks/fdisk.h
@@ -226,13 +226,13 @@ extern sector_t get_nr_sects(struct partition *p);
  * Supported partition table types (labels)
  */
 enum fdisk_labeltype {
-	ANY_LABEL = -1,
 	DOS_LABEL = 1,
-	SUN_LABEL,
-	SGI_LABEL,
-	AIX_LABEL,
-	OSF_LABEL,
-	MAC_LABEL,
+	SUN_LABEL = 2,
+	SGI_LABEL = 4,
+	AIX_LABEL = 8,
+	OSF_LABEL = 16,
+	MAC_LABEL = 32,
+	ANY_LABEL = -1
 };
 
 extern enum fdisk_labeltype disklabel;
diff --git a/fdisks/utils.c b/fdisks/utils.c
index c4ffe04..dbb422d 100644
--- a/fdisks/utils.c
+++ b/fdisks/utils.c
@@ -36,8 +36,6 @@ int fdisk_debug_mask;
 
 /*
  * Label probing functions.
- * Must have the same order as fdisk_labeltype as the index
- * depends on it.
  */
 static const struct fdisk_label *labels[] =
 {
-- 
1.7.4.1



