Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58259 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932906Ab2KBR4o (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 2 Nov 2012 13:56:44 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qA2Huith031900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 2 Nov 2012 13:56:44 -0400
From: Milan Broz <mbroz@redhat.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <mbroz@redhat.com>
Subject: [PATCH 1/3] lsblk: Add revision column
Date: Fri,  2 Nov 2012 18:56:29 +0100
Message-Id: <1351878991-3472-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Milan Broz <mbroz@redhat.com>
---
 misc-utils/lsblk.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index c57e78f..671d912 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -100,6 +100,7 @@ enum {
 	COL_PKNAME,
 	COL_HCTL,
 	COL_TRANSPORT,
+	COL_REV,
 };
 
 /* column names */
@@ -150,6 +151,7 @@ static struct colinfo infos[] = {
 	[COL_WWN]    = { "WWN",     18, 0, N_("unique storage identifier") },
 	[COL_HCTL]   = { "HCTL", 10, 0, N_("Host:Channel:Target:Lun for SCSI") },
 	[COL_TRANSPORT] = { "TRAN", 6, 0, N_("device transport type") },
+	[COL_REV]    = { "REV",   4, TT_FL_RIGHT, N_("device revision") },
 };
 
 struct lsblk {
@@ -766,6 +768,13 @@ static void set_tt_data(struct blkdev_cxt *cxt, int col, int id, struct tt_line
 				tt_line_set_data(ln, col, p);
 		}
 		break;
+	case COL_REV:
+		if (!cxt->partition && cxt->nslaves == 0) {
+			p = sysfs_strdup(&cxt->sysfs, "device/rev");
+			if (p)
+				tt_line_set_data(ln, col, p);
+		}
+		break;
 	case COL_SIZE:
 		if (cxt->size) {
 			if (lsblk->bytes) {
-- 
1.7.10.4

