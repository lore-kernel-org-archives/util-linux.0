Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5306 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753345Ab2JSMKt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 19 Oct 2012 08:10:49 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q9JCAnlA017305
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 19 Oct 2012 08:10:49 -0400
From: Milan Broz <mbroz@redhat.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <mbroz@redhat.com>
Subject: [PATCH 1/3] lsblk: add parent kernel name column
Date: Fri, 19 Oct 2012 14:10:39 +0200
Message-Id: <1350648641-19388-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

For raw output used in scripts it is sometimes necessary
to reconstruct tree of devices.

Parent kernel name (PKNAME) provides needed information
to do that easily.

Signed-off-by: Milan Broz <mbroz@redhat.com>
---
 misc-utils/lsblk.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 26dfaf9..1118e7e 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -97,6 +97,7 @@ enum {
 	COL_DZERO,
 	COL_WWN,
 	COL_RAND,
+	COL_PKNAME,
 };
 
 /* column names */
@@ -111,6 +112,7 @@ struct colinfo {
 static struct colinfo infos[] = {
 	[COL_NAME]   = { "NAME",    0.25, TT_FL_TREE | TT_FL_NOEXTREMES, N_("device name") },
 	[COL_KNAME]  = { "KNAME",   0.3, 0, N_("internal kernel device name") },
+	[COL_PKNAME] = { "PKNAME",   0.3, 0, N_("internal parent kernel device name") },
 	[COL_MAJMIN] = { "MAJ:MIN", 6, 0, N_("major:minor device number") },
 	[COL_FSTYPE] = { "FSTYPE",  0.1, TT_FL_TRUNC, N_("filesystem type") },
 	[COL_TARGET] = { "MOUNTPOINT", 0.10, TT_FL_TRUNC, N_("where the device is mounted") },
@@ -144,7 +146,6 @@ static struct colinfo infos[] = {
 	[COL_DMAX]   = { "DISC-MAX", 6, TT_FL_RIGHT, N_("discard max bytes") },
 	[COL_DZERO]  = { "DISC-ZERO", 1, TT_FL_RIGHT, N_("discard zeroes data") },
 	[COL_WWN]    = { "WWN",     18, 0, N_("unique storage identifier") },
-
 };
 
 struct lsblk {
@@ -600,6 +601,10 @@ static void set_tt_data(struct blkdev_cxt *cxt, int col, int id, struct tt_line
 	case COL_KNAME:
 		tt_line_set_data(ln, col, xstrdup(cxt->name));
 		break;
+	case COL_PKNAME:
+		if (cxt->parent)
+			tt_line_set_data(ln, col, xstrdup(cxt->parent->name));
+		break;
 	case COL_OWNER:
 	{
 		struct passwd *pw = st_rc ? NULL : getpwuid(cxt->st.st_uid);
-- 
1.7.10.4

