Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f172.google.com ([74.125.82.172]:55649 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbaI1TxE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:53:04 -0400
Received: by mail-we0-f172.google.com with SMTP id q58so3025428wes.17
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:53:02 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 17/23] lsblk: add missing initializers to struct colinfo
Date: Sun, 28 Sep 2014 20:51:50 +0100
Message-Id: <1411933916-30576-18-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

warning: missing field 'sort_type' initializer [-Wmissing-field-initializers]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/lsblk.c | 58 +++++++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index a87d997..8744cc9 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -134,50 +134,50 @@ struct colinfo {
 
 /* columns descriptions */
 static struct colinfo infos[] = {
-	[COL_NAME]   = { "NAME",    0.25, SCOLS_FL_TREE | SCOLS_FL_NOEXTREMES, N_("device name") },
-	[COL_KNAME]  = { "KNAME",   0.3, 0, N_("internal kernel device name") },
-	[COL_PKNAME] = { "PKNAME",   0.3, 0, N_("internal parent kernel device name") },
+	[COL_NAME]   = { "NAME",    0.25, SCOLS_FL_TREE | SCOLS_FL_NOEXTREMES, N_("device name"), SORT_STRING },
+	[COL_KNAME]  = { "KNAME",   0.3, 0, N_("internal kernel device name"), SORT_STRING },
+	[COL_PKNAME] = { "PKNAME",   0.3, 0, N_("internal parent kernel device name"), SORT_STRING },
 	[COL_MAJMIN] = { "MAJ:MIN", 6, 0, N_("major:minor device number"), SORT_U64 },
-	[COL_FSTYPE] = { "FSTYPE",  0.1, SCOLS_FL_TRUNC, N_("filesystem type") },
-	[COL_TARGET] = { "MOUNTPOINT", 0.10, SCOLS_FL_TRUNC, N_("where the device is mounted") },
-	[COL_LABEL]  = { "LABEL",   0.1, 0, N_("filesystem LABEL") },
-	[COL_UUID]   = { "UUID",    36,  0, N_("filesystem UUID") },
+	[COL_FSTYPE] = { "FSTYPE",  0.1, SCOLS_FL_TRUNC, N_("filesystem type"), SORT_STRING },
+	[COL_TARGET] = { "MOUNTPOINT", 0.10, SCOLS_FL_TRUNC, N_("where the device is mounted"), SORT_STRING },
+	[COL_LABEL]  = { "LABEL",   0.1, 0, N_("filesystem LABEL"), SORT_STRING },
+	[COL_UUID]   = { "UUID",    36,  0, N_("filesystem UUID"), SORT_STRING },
 
-	[COL_PARTTYPE]  = { "PARTTYPE",  36,  0, N_("partition type UUID") },
-	[COL_PARTLABEL] = { "PARTLABEL", 0.1, 0, N_("partition LABEL") },
-	[COL_PARTUUID]  = { "PARTUUID",  36,  0, N_("partition UUID") },
-	[COL_PARTFLAGS] = { "PARTFLAGS",  36,  0, N_("partition flags") },
+	[COL_PARTTYPE]  = { "PARTTYPE",  36,  0, N_("partition type UUID"), SORT_STRING },
+	[COL_PARTLABEL] = { "PARTLABEL", 0.1, 0, N_("partition LABEL"), SORT_STRING },
+	[COL_PARTUUID]  = { "PARTUUID",  36,  0, N_("partition UUID"), SORT_STRING },
+	[COL_PARTFLAGS] = { "PARTFLAGS",  36,  0, N_("partition flags"), SORT_STRING },
 
 	[COL_RA]     = { "RA",      3, SCOLS_FL_RIGHT, N_("read-ahead of the device"), SORT_U64 },
-	[COL_RO]     = { "RO",      1, SCOLS_FL_RIGHT, N_("read-only device") },
-	[COL_RM]     = { "RM",      1, SCOLS_FL_RIGHT, N_("removable device") },
-	[COL_ROTA]   = { "ROTA",    1, SCOLS_FL_RIGHT, N_("rotational device") },
-	[COL_RAND]   = { "RAND",    1, SCOLS_FL_RIGHT, N_("adds randomness") },
-	[COL_MODEL]  = { "MODEL",   0.1, SCOLS_FL_TRUNC, N_("device identifier") },
-	[COL_SERIAL] = { "SERIAL",  0.1, SCOLS_FL_TRUNC, N_("disk serial number") },
+	[COL_RO]     = { "RO",      1, SCOLS_FL_RIGHT, N_("read-only device"), SORT_STRING },
+	[COL_RM]     = { "RM",      1, SCOLS_FL_RIGHT, N_("removable device"), SORT_STRING },
+	[COL_ROTA]   = { "ROTA",    1, SCOLS_FL_RIGHT, N_("rotational device"), SORT_STRING },
+	[COL_RAND]   = { "RAND",    1, SCOLS_FL_RIGHT, N_("adds randomness"), SORT_STRING },
+	[COL_MODEL]  = { "MODEL",   0.1, SCOLS_FL_TRUNC, N_("device identifier"), SORT_STRING },
+	[COL_SERIAL] = { "SERIAL",  0.1, SCOLS_FL_TRUNC, N_("disk serial number"), SORT_STRING },
 	[COL_SIZE]   = { "SIZE",    5, SCOLS_FL_RIGHT, N_("size of the device"), SORT_U64 },
-	[COL_STATE]  = { "STATE",   7, SCOLS_FL_TRUNC, N_("state of the device") },
-	[COL_OWNER]  = { "OWNER",   0.1, SCOLS_FL_TRUNC, N_("user name"), },
-	[COL_GROUP]  = { "GROUP",   0.1, SCOLS_FL_TRUNC, N_("group name") },
-	[COL_MODE]   = { "MODE",    10,   0, N_("device node permissions") },
+	[COL_STATE]  = { "STATE",   7, SCOLS_FL_TRUNC, N_("state of the device"), SORT_STRING },
+	[COL_OWNER]  = { "OWNER",   0.1, SCOLS_FL_TRUNC, N_("user name"), SORT_STRING },
+	[COL_GROUP]  = { "GROUP",   0.1, SCOLS_FL_TRUNC, N_("group name"), SORT_STRING },
+	[COL_MODE]   = { "MODE",    10,   0, N_("device node permissions"), SORT_STRING },
 	[COL_ALIOFF] = { "ALIGNMENT", 6, SCOLS_FL_RIGHT, N_("alignment offset"), SORT_U64 },
 	[COL_MINIO]  = { "MIN-IO",  6, SCOLS_FL_RIGHT, N_("minimum I/O size"), SORT_U64 },
 	[COL_OPTIO]  = { "OPT-IO",  6, SCOLS_FL_RIGHT, N_("optimal I/O size"), SORT_U64 },
 	[COL_PHYSEC] = { "PHY-SEC", 7, SCOLS_FL_RIGHT, N_("physical sector size"), SORT_U64 },
 	[COL_LOGSEC] = { "LOG-SEC", 7, SCOLS_FL_RIGHT, N_("logical sector size"), SORT_U64 },
-	[COL_SCHED]  = { "SCHED",   0.1, 0, N_("I/O scheduler name") },
+	[COL_SCHED]  = { "SCHED",   0.1, 0, N_("I/O scheduler name"), SORT_STRING },
 	[COL_RQ_SIZE]= { "RQ-SIZE", 5, SCOLS_FL_RIGHT, N_("request queue size"), SORT_U64 },
-	[COL_TYPE]   = { "TYPE",    4, 0, N_("device type") },
+	[COL_TYPE]   = { "TYPE",    4, 0, N_("device type"), SORT_STRING },
 	[COL_DALIGN] = { "DISC-ALN", 6, SCOLS_FL_RIGHT, N_("discard alignment offset"), SORT_U64 },
 	[COL_DGRAN]  = { "DISC-GRAN", 6, SCOLS_FL_RIGHT, N_("discard granularity"), SORT_U64 },
 	[COL_DMAX]   = { "DISC-MAX", 6, SCOLS_FL_RIGHT, N_("discard max bytes"), SORT_U64 },
-	[COL_DZERO]  = { "DISC-ZERO", 1, SCOLS_FL_RIGHT, N_("discard zeroes data") },
+	[COL_DZERO]  = { "DISC-ZERO", 1, SCOLS_FL_RIGHT, N_("discard zeroes data"), SORT_STRING },
 	[COL_WSAME]  = { "WSAME",   6, SCOLS_FL_RIGHT, N_("write same max bytes"), SORT_U64 },
-	[COL_WWN]    = { "WWN",     18, 0, N_("unique storage identifier") },
-	[COL_HCTL]   = { "HCTL", 10, 0, N_("Host:Channel:Target:Lun for SCSI") },
-	[COL_TRANSPORT] = { "TRAN", 6, 0, N_("device transport type") },
-	[COL_REV]    = { "REV",   4, SCOLS_FL_RIGHT, N_("device revision") },
-	[COL_VENDOR] = { "VENDOR", 0.1, SCOLS_FL_TRUNC, N_("device vendor") },
+	[COL_WWN]    = { "WWN",     18, 0, N_("unique storage identifier"), SORT_STRING },
+	[COL_HCTL]   = { "HCTL", 10, 0, N_("Host:Channel:Target:Lun for SCSI"), SORT_STRING },
+	[COL_TRANSPORT] = { "TRAN", 6, 0, N_("device transport type"), SORT_STRING },
+	[COL_REV]    = { "REV",   4, SCOLS_FL_RIGHT, N_("device revision"), SORT_STRING },
+	[COL_VENDOR] = { "VENDOR", 0.1, SCOLS_FL_TRUNC, N_("device vendor"), SORT_STRING },
 };
 
 struct lsblk {
-- 
2.1.1

