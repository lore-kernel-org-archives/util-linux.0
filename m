Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39606 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754978Ab2GXOer (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jul 2012 10:34:47 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q6OEYlZq021028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 24 Jul 2012 10:34:47 -0400
From: Milan Broz <mbroz@redhat.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <mbroz@redhat.com>
Subject: [PATCH] lsblk: add read-ahead column.
Date: Tue, 24 Jul 2012 16:34:33 +0200
Message-Id: <1343140473-15035-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Milan Broz <mbroz@redhat.com>
---
 misc-utils/lsblk.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index b459728..cb2b768 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -73,6 +73,7 @@ enum {
 	COL_UUID,
 	COL_PARTLABEL,
 	COL_PARTUUID,
+	COL_RA,
 	COL_RO,
 	COL_RM,
 	COL_MODEL,
@@ -117,6 +118,7 @@ static struct colinfo infos[] = {
 	[COL_PARTLABEL] = { "PARTLABEL", 0.1, 0, N_("partition LABEL") },
 	[COL_PARTUUID]  = { "PARTUUID",  36,  0, N_("partition UUID") },
 
+	[COL_RA]     = { "RA",      4, TT_FL_RIGHT, N_("read-ahead of the device") },
 	[COL_RO]     = { "RO",      1, TT_FL_RIGHT, N_("read-only device") },
 	[COL_RM]     = { "RM",      1, TT_FL_RIGHT, N_("removable device") },
 	[COL_ROTA]   = { "ROTA",    1, TT_FL_RIGHT, N_("rotational device") },
@@ -643,6 +645,11 @@ static void set_tt_data(struct blkdev_cxt *cxt, int col, int id, struct tt_line
 		if (cxt->uuid)
 			tt_line_set_data(ln, col, xstrdup(cxt->partuuid));
 		break;
+	case COL_RA:
+		p = sysfs_strdup(&cxt->sysfs, "queue/read_ahead_kb");
+		if (p)
+			tt_line_set_data(ln, col, p);
+		break;
 	case COL_RO:
 		tt_line_set_data(ln, col, is_readonly_device(cxt) ?
 					xstrdup("1") : xstrdup("0"));
@@ -1333,6 +1340,7 @@ int main(int argc, char *argv[])
 			columns[ncolumns++] = COL_ROTA;
 			columns[ncolumns++] = COL_SCHED;
 			columns[ncolumns++] = COL_RQ_SIZE;
+			columns[ncolumns++] = COL_RA;
 			break;
 		case 'V':
 			printf(_("%s from %s\n"), program_invocation_short_name,
-- 
1.7.10.4

