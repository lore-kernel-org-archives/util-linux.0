Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53133 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367Ab2LTLm1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 20 Dec 2012 06:42:27 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qBKBgR4I026594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Thu, 20 Dec 2012 06:42:27 -0500
From: Milan Broz <mbroz@redhat.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <mbroz@redhat.com>
Subject: [PATCH] lsblk: Add write-same attribute to topology info
Date: Thu, 20 Dec 2012 12:42:23 +0100
Message-Id: <1356003743-8013-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Milan Broz <mbroz@redhat.com>
---
 misc-utils/lsblk.8 |    2 +-
 misc-utils/lsblk.c |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/misc-utils/lsblk.8 b/misc-utils/lsblk.8
index 77e5b74..9152062 100644
--- a/misc-utils/lsblk.8
+++ b/misc-utils/lsblk.8
@@ -74,7 +74,7 @@ Use the raw output format. All potentially unsafe characters are hex-escaped
 Print dependencies in inverse order.
 .IP "\fB\-t, \-\-topology\fP"
 Output info about block device topology.
-This option is equivalent to "-o NAME,ALIGNMENT,MIN-IO,OPT-IO,PHY-SEC,LOG-SEC,ROTA,SCHED,RQ-SIZE".
+This option is equivalent to "-o NAME,ALIGNMENT,MIN-IO,OPT-IO,PHY-SEC,LOG-SEC,ROTA,SCHED,RQ-SIZE,WRITE_SAME".
 .IP "\fB\-S, \-\-scsi\fP"
 Output info about SCSI devices only. All partitions, slaves and holders devices are ignored.
 .IP "\fB\-V, \-\-version\fP"
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 5a63b6b..8c4bfc0 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -95,6 +95,7 @@ enum {
 	COL_DGRAN,
 	COL_DMAX,
 	COL_DZERO,
+	COL_WSAME,
 	COL_WWN,
 	COL_RAND,
 	COL_PKNAME,
@@ -149,6 +150,7 @@ static struct colinfo infos[] = {
 	[COL_DGRAN]  = { "DISC-GRAN", 6, TT_FL_RIGHT, N_("discard granularity") },
 	[COL_DMAX]   = { "DISC-MAX", 6, TT_FL_RIGHT, N_("discard max bytes") },
 	[COL_DZERO]  = { "DISC-ZERO", 1, TT_FL_RIGHT, N_("discard zeroes data") },
+	[COL_WSAME]  = { "WRITE-SAME", 6, TT_FL_RIGHT, N_("write same max bytes") },
 	[COL_WWN]    = { "WWN",     18, 0, N_("unique storage identifier") },
 	[COL_HCTL]   = { "HCTL", 10, 0, N_("Host:Channel:Target:Lun for SCSI") },
 	[COL_TRANSPORT] = { "TRAN", 6, 0, N_("device transport type") },
@@ -900,6 +902,22 @@ static void set_tt_data(struct blkdev_cxt *cxt, int col, int id, struct tt_line
 		else
 			tt_line_set_data(ln, col, "0");
 		break;
+	case COL_WSAME:
+		if (lsblk->bytes)
+			p = sysfs_strdup(&cxt->sysfs, "queue/write_same_max_bytes");
+		else {
+			uint64_t x;
+
+			if (sysfs_read_u64(&cxt->sysfs,
+					   "queue/write_same_max_bytes", &x) == 0)
+				p = size_to_human_string(SIZE_SUFFIX_1LETTER, x);
+		}
+		if (p)
+			tt_line_set_data(ln, col, p);
+		else
+			tt_line_set_data(ln, col, "0");
+
+		break;
 	};
 }
 
@@ -1478,6 +1496,7 @@ int main(int argc, char *argv[])
 			columns[ncolumns++] = COL_SCHED;
 			columns[ncolumns++] = COL_RQ_SIZE;
 			columns[ncolumns++] = COL_RA;
+			columns[ncolumns++] = COL_WSAME;
 			break;
 		case 'S':
 			lsblk->nodeps = 1;
-- 
1.7.10.4

