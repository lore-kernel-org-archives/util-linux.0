Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51293 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754051Ab2JSMKu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 19 Oct 2012 08:10:50 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q9JCAoQZ018153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 19 Oct 2012 08:10:50 -0400
From: Milan Broz <mbroz@redhat.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <mbroz@redhat.com>
Subject: [PATCH 2/3] lsblk: add SCSI H:C:T:L attribute
Date: Fri, 19 Oct 2012 14:10:40 +0200
Message-Id: <1350648641-19388-2-git-send-email-mbroz@redhat.com>
In-Reply-To: <1350648641-19388-1-git-send-email-mbroz@redhat.com>
References: <1350648641-19388-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

For block devices it is sometimes useful to print SCSI device ID"
Host:Channel:Target:LUN.

Patch adds column name HCTL which can be used in lsblk.

Signed-off-by: Milan Broz <mbroz@redhat.com>
---
 misc-utils/lsblk.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 1118e7e..7101eed 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -98,6 +98,7 @@ enum {
 	COL_WWN,
 	COL_RAND,
 	COL_PKNAME,
+	COL_HCTL,
 };
 
 /* column names */
@@ -146,6 +147,7 @@ static struct colinfo infos[] = {
 	[COL_DMAX]   = { "DISC-MAX", 6, TT_FL_RIGHT, N_("discard max bytes") },
 	[COL_DZERO]  = { "DISC-ZERO", 1, TT_FL_RIGHT, N_("discard zeroes data") },
 	[COL_WWN]    = { "WWN",     18, 0, N_("unique storage identifier") },
+	[COL_HCTL]   = { "HCTL", 10, 0, N_("Host:Channel:Target:Lun for SCSI") },
 };
 
 struct lsblk {
@@ -573,6 +575,27 @@ static char *get_type(struct blkdev_cxt *cxt)
 	return res;
 }
 
+/* H:C:T:L - Host:Channel:Target:LUN */
+static int get_hctl(struct blkdev_cxt *cxt, int *h, int *c, int *t, int *l)
+{
+	char buf[PATH_MAX], *hctl;
+	ssize_t len;
+
+	len = sysfs_readlink(&cxt->sysfs, "device", buf, sizeof(buf));
+	if (len < 0)
+		return 0;
+
+	buf[len] = '\0';
+	hctl = strrchr(buf, '/') + 1;
+	if (!hctl)
+		return 0;
+
+	if (sscanf(hctl, "%d:%d:%d:%d", h, c, t, l) != 4)
+		return 0;
+
+	return 1;
+}
+
 #define is_parsable(_l)	(((_l)->tt->flags & TT_FL_RAW) || \
 			 ((_l)->tt->flags & TT_FL_EXPORT))
 
@@ -771,6 +794,15 @@ static void set_tt_data(struct blkdev_cxt *cxt, int col, int id, struct tt_line
 		if (p)
 			tt_line_set_data(ln, col, p);
 		break;
+	case COL_HCTL:
+	{
+		int h, c, t, l;
+		if (get_hctl(cxt, &h, &c, &t, &l)) {
+			snprintf(buf, sizeof(buf), "%d:%d:%d:%d", h, c, t, l);
+			tt_line_set_data(ln, col, xstrdup(buf));
+		}
+		break;
+	}
 	case COL_DALIGN:
 		p = sysfs_strdup(&cxt->sysfs, "discard_alignment");
 		if (cxt->discard && p)
-- 
1.7.10.4

