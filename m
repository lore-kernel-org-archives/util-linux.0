Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f41.google.com ([74.125.82.41]:49611 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbaI1Twz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:52:55 -0400
Received: by mail-wg0-f41.google.com with SMTP id k14so12133750wgh.12
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:52:54 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 15/23] cfdisk: add missing initializers to struct main_menuitems
Date: Sun, 28 Sep 2014 20:51:48 +0100
Message-Id: <1411933916-30576-16-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

disk-utils/cfdisk.c:149:77: warning: missing field 'userdata' initializer [-Wmissing-field-initializers]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/cfdisk.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index fabc397..0325acb 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -146,15 +146,15 @@ struct cfdisk_menu {
 
 /* main menu */
 static struct cfdisk_menuitem main_menuitems[] = {
-	{ 'b', N_("Bootable"), N_("Toggle bootable flag of the current partition") },
-	{ 'd', N_("Delete"), N_("Delete the current partition") },
-	{ 'n', N_("New"), N_("Create new partition from free space") },
-	{ 'q', N_("Quit"), N_("Quit program without writing partition table") },
-	{ 't', N_("Type"), N_("Change the partition type") },
-	{ 'h', N_("Help"), N_("Print help screen") },
-	{ 's', N_("Sort"), N_("Fix partitions order") },
-	{ 'W', N_("Write"), N_("Write partition table to disk (this might destroy data)") },
-	{ 0, NULL, NULL }
+	{ 'b', N_("Bootable"), N_("Toggle bootable flag of the current partition"), NULL },
+	{ 'd', N_("Delete"), N_("Delete the current partition"), NULL },
+	{ 'n', N_("New"), N_("Create new partition from free space"), NULL },
+	{ 'q', N_("Quit"), N_("Quit program without writing partition table"), NULL },
+	{ 't', N_("Type"), N_("Change the partition type"), NULL },
+	{ 'h', N_("Help"), N_("Print help screen"), NULL },
+	{ 's', N_("Sort"), N_("Fix partitions order"), NULL },
+	{ 'W', N_("Write"), N_("Write partition table to disk (this might destroy data)"), NULL },
+	{ 0, NULL, NULL, NULL }
 };
 
 /* top level control struct */
-- 
2.1.1

