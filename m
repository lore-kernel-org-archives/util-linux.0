Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:9068 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932945Ab2KBR4p (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 2 Nov 2012 13:56:45 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qA2Hujb0032412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 2 Nov 2012 13:56:45 -0400
From: Milan Broz <mbroz@redhat.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <mbroz@redhat.com>
Subject: [PATCH 2/3] lsblk: Add vendor column
Date: Fri,  2 Nov 2012 18:56:30 +0100
Message-Id: <1351878991-3472-2-git-send-email-mbroz@redhat.com>
In-Reply-To: <1351878991-3472-1-git-send-email-mbroz@redhat.com>
References: <1351878991-3472-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Milan Broz <mbroz@redhat.com>
---
 misc-utils/lsblk.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 671d912..f8bc6ea 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -101,6 +101,7 @@ enum {
 	COL_HCTL,
 	COL_TRANSPORT,
 	COL_REV,
+	COL_VENDOR,
 };
 
 /* column names */
@@ -152,6 +153,7 @@ static struct colinfo infos[] = {
 	[COL_HCTL]   = { "HCTL", 10, 0, N_("Host:Channel:Target:Lun for SCSI") },
 	[COL_TRANSPORT] = { "TRAN", 6, 0, N_("device transport type") },
 	[COL_REV]    = { "REV",   4, TT_FL_RIGHT, N_("device revision") },
+	[COL_VENDOR] = { "VENDOR", 0.1, TT_FL_TRUNC, N_("device vendor") },
 };
 
 struct lsblk {
@@ -775,6 +777,13 @@ static void set_tt_data(struct blkdev_cxt *cxt, int col, int id, struct tt_line
 				tt_line_set_data(ln, col, p);
 		}
 		break;
+	case COL_VENDOR:
+		if (!cxt->partition && cxt->nslaves == 0) {
+			p = sysfs_strdup(&cxt->sysfs, "device/vendor");
+			if (p)
+				tt_line_set_data(ln, col, p);
+		}
+		break;
 	case COL_SIZE:
 		if (cxt->size) {
 			if (lsblk->bytes) {
-- 
1.7.10.4

