Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56413 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758755Ab2HQSZa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 17 Aug 2012 14:25:30 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7HIPTiP000541
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 17 Aug 2012 14:25:29 -0400
From: Milan Broz <mbroz@redhat.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <mbroz@redhat.com>
Subject: [PATCH] lsblk: add add_random columns
Date: Fri, 17 Aug 2012 20:25:26 +0200
Message-Id: <1345227926-9840-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Allow printing of queue/add_random attribute which describes
if device adds randomness to kernel RNG pool.

Signed-off-by: Milan Broz <mbroz@redhat.com>
---
 misc-utils/lsblk.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 2410de4..3a980db 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -96,6 +96,7 @@ enum {
 	COL_DMAX,
 	COL_DZERO,
 	COL_WWN,
+	COL_RAND,
 };
 
 /* column names */
@@ -123,6 +124,7 @@ static struct colinfo infos[] = {
 	[COL_RO]     = { "RO",      1, TT_FL_RIGHT, N_("read-only device") },
 	[COL_RM]     = { "RM",      1, TT_FL_RIGHT, N_("removable device") },
 	[COL_ROTA]   = { "ROTA",    1, TT_FL_RIGHT, N_("rotational device") },
+	[COL_RAND]   = { "RAND",    1, TT_FL_RIGHT, N_("adds randomness") },
 	[COL_MODEL]  = { "MODEL",   0.1, TT_FL_TRUNC, N_("device identifier") },
 	[COL_SIZE]   = { "SIZE",    5, TT_FL_RIGHT, N_("size of the device") },
 	[COL_STATE]  = { "STATE",   7, TT_FL_TRUNC, N_("state of the device") },
@@ -690,6 +692,11 @@ static void set_tt_data(struct blkdev_cxt *cxt, int col, int id, struct tt_line
 		if (p)
 			tt_line_set_data(ln, col, p);
 		break;
+	case COL_RAND:
+		p = sysfs_strdup(&cxt->sysfs, "queue/add_random");
+		if (p)
+			tt_line_set_data(ln, col, p);
+		break;
 	case COL_MODEL:
 		if (!cxt->partition && cxt->nslaves == 0) {
 			p = sysfs_strdup(&cxt->sysfs, "device/model");
-- 
1.7.10.4

