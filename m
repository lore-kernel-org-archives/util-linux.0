Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:40982 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbaI1Tw4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:52:56 -0400
Received: by mail-wg0-f46.google.com with SMTP id k14so1864487wgh.17
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:52:55 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 16/23] findmnt: add missing initializers to struct colinfo
Date: Sun, 28 Sep 2014 20:51:49 +0100
Message-Id: <1411933916-30576-17-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

warning: missing field 'match' initializer [-Wmissing-field-initializers]
warning: missing field 'match_data' initializer [-Wmissing-field-initializers]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/findmnt.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 75099d9..57ee12a 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -118,31 +118,31 @@ struct colinfo {
 
 /* columns descriptions (don't use const, this is writable) */
 static struct colinfo infos[] = {
-	[COL_SOURCE]       = { "SOURCE",       0.25, SCOLS_FL_NOEXTREMES, N_("source device") },
-	[COL_TARGET]       = { "TARGET",       0.30, SCOLS_FL_TREE| SCOLS_FL_NOEXTREMES, N_("mountpoint") },
-	[COL_FSTYPE]       = { "FSTYPE",       0.10, SCOLS_FL_TRUNC, N_("filesystem type") },
-	[COL_OPTIONS]      = { "OPTIONS",      0.10, SCOLS_FL_TRUNC, N_("all mount options") },
-	[COL_VFS_OPTIONS]  = { "VFS-OPTIONS",  0.20, SCOLS_FL_TRUNC, N_("VFS specific mount options") },
-	[COL_FS_OPTIONS]   = { "FS-OPTIONS",   0.10, SCOLS_FL_TRUNC, N_("FS specific mount options") },
-	[COL_LABEL]        = { "LABEL",        0.10, 0, N_("filesystem label") },
-	[COL_UUID]         = { "UUID",           36, 0, N_("filesystem UUID") },
-	[COL_PARTLABEL]    = { "PARTLABEL",    0.10, 0, N_("partition label") },
-	[COL_PARTUUID]     = { "PARTUUID",       36, 0, N_("partition UUID") },
-	[COL_MAJMIN]       = { "MAJ:MIN",         6, 0, N_("major:minor device number") },
-	[COL_ACTION]       = { "ACTION",         10, SCOLS_FL_STRICTWIDTH, N_("action detected by --poll") },
-	[COL_OLD_OPTIONS]  = { "OLD-OPTIONS",  0.10, SCOLS_FL_TRUNC, N_("old mount options saved by --poll") },
-	[COL_OLD_TARGET]   = { "OLD-TARGET",   0.30, 0, N_("old mountpoint saved by --poll") },
-	[COL_SIZE]         = { "SIZE",            5, SCOLS_FL_RIGHT, N_("filesystem size") },
-	[COL_AVAIL]        = { "AVAIL",           5, SCOLS_FL_RIGHT, N_("filesystem size available") },
-	[COL_USED]         = { "USED",            5, SCOLS_FL_RIGHT, N_("filesystem size used") },
-	[COL_USEPERC]      = { "USE%",            3, SCOLS_FL_RIGHT, N_("filesystem use percentage") },
-	[COL_FSROOT]       = { "FSROOT",       0.25, SCOLS_FL_NOEXTREMES, N_("filesystem root") },
-	[COL_TID]          = { "TID",             4, SCOLS_FL_RIGHT, N_("task ID") },
-	[COL_ID]           = { "ID",              2, SCOLS_FL_RIGHT, N_("mount ID") },
-	[COL_OPT_FIELDS]   = { "OPT-FIELDS",   0.10, SCOLS_FL_TRUNC, N_("optional mount fields") },
-	[COL_PROPAGATION]  = { "PROPAGATION",  0.10, 0, N_("VFS propagation flags") },
-	[COL_FREQ]         = { "FREQ",            1, SCOLS_FL_RIGHT, N_("dump(8) period in days [fstab only]") },
-	[COL_PASSNO]       = { "PASSNO",          1, SCOLS_FL_RIGHT, N_("pass number on parallel fsck(8) [fstab only]") }
+	[COL_SOURCE]       = { "SOURCE",       0.25, SCOLS_FL_NOEXTREMES, N_("source device"), NULL, NULL },
+	[COL_TARGET]       = { "TARGET",       0.30, SCOLS_FL_TREE| SCOLS_FL_NOEXTREMES, N_("mountpoint"), NULL, NULL },
+	[COL_FSTYPE]       = { "FSTYPE",       0.10, SCOLS_FL_TRUNC, N_("filesystem type"), NULL, NULL },
+	[COL_OPTIONS]      = { "OPTIONS",      0.10, SCOLS_FL_TRUNC, N_("all mount options"), NULL, NULL },
+	[COL_VFS_OPTIONS]  = { "VFS-OPTIONS",  0.20, SCOLS_FL_TRUNC, N_("VFS specific mount options"), NULL, NULL },
+	[COL_FS_OPTIONS]   = { "FS-OPTIONS",   0.10, SCOLS_FL_TRUNC, N_("FS specific mount options"), NULL, NULL },
+	[COL_LABEL]        = { "LABEL",        0.10, 0, N_("filesystem label"), NULL, NULL },
+	[COL_UUID]         = { "UUID",           36, 0, N_("filesystem UUID"), NULL, NULL },
+	[COL_PARTLABEL]    = { "PARTLABEL",    0.10, 0, N_("partition label"), NULL, NULL },
+	[COL_PARTUUID]     = { "PARTUUID",       36, 0, N_("partition UUID"), NULL, NULL },
+	[COL_MAJMIN]       = { "MAJ:MIN",         6, 0, N_("major:minor device number"), NULL, NULL },
+	[COL_ACTION]       = { "ACTION",         10, SCOLS_FL_STRICTWIDTH, N_("action detected by --poll"), NULL, NULL },
+	[COL_OLD_OPTIONS]  = { "OLD-OPTIONS",  0.10, SCOLS_FL_TRUNC, N_("old mount options saved by --poll"), NULL, NULL },
+	[COL_OLD_TARGET]   = { "OLD-TARGET",   0.30, 0, N_("old mountpoint saved by --poll"), NULL, NULL },
+	[COL_SIZE]         = { "SIZE",            5, SCOLS_FL_RIGHT, N_("filesystem size"), NULL, NULL },
+	[COL_AVAIL]        = { "AVAIL",           5, SCOLS_FL_RIGHT, N_("filesystem size available"), NULL, NULL },
+	[COL_USED]         = { "USED",            5, SCOLS_FL_RIGHT, N_("filesystem size used"), NULL, NULL },
+	[COL_USEPERC]      = { "USE%",            3, SCOLS_FL_RIGHT, N_("filesystem use percentage"), NULL, NULL },
+	[COL_FSROOT]       = { "FSROOT",       0.25, SCOLS_FL_NOEXTREMES, N_("filesystem root"), NULL, NULL },
+	[COL_TID]          = { "TID",             4, SCOLS_FL_RIGHT, N_("task ID"), NULL, NULL },
+	[COL_ID]           = { "ID",              2, SCOLS_FL_RIGHT, N_("mount ID"), NULL, NULL },
+	[COL_OPT_FIELDS]   = { "OPT-FIELDS",   0.10, SCOLS_FL_TRUNC, N_("optional mount fields"), NULL, NULL },
+	[COL_PROPAGATION]  = { "PROPAGATION",  0.10, 0, N_("VFS propagation flags"), NULL, NULL },
+	[COL_FREQ]         = { "FREQ",            1, SCOLS_FL_RIGHT, N_("dump(8) period in days [fstab only]"), NULL, NULL },
+	[COL_PASSNO]       = { "PASSNO",          1, SCOLS_FL_RIGHT, N_("pass number on parallel fsck(8) [fstab only]"), NULL, NULL }
 };
 
 /* columns[] array specifies all currently wanted output column. The columns
-- 
2.1.1

