Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:26917 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932906Ab2KBR4q (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 2 Nov 2012 13:56:46 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qA2Huk7L017420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 2 Nov 2012 13:56:46 -0400
From: Milan Broz <mbroz@redhat.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <mbroz@redhat.com>
Subject: [PATCH 3/3] lsblk: Add --scsi switch
Date: Fri,  2 Nov 2012 18:56:31 +0100
Message-Id: <1351878991-3472-3-git-send-email-mbroz@redhat.com>
In-Reply-To: <1351878991-3472-1-git-send-email-mbroz@redhat.com>
References: <1351878991-3472-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The --scsi switch prints similar information to lsscsi command.

Signed-off-by: Milan Broz <mbroz@redhat.com>
---
 misc-utils/lsblk.8 |    2 ++
 misc-utils/lsblk.c |   23 ++++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/misc-utils/lsblk.8 b/misc-utils/lsblk.8
index ced0a13..c280ed4 100644
--- a/misc-utils/lsblk.8
+++ b/misc-utils/lsblk.8
@@ -74,6 +74,8 @@ Use the raw output format. All potentially unsafe characters are hex-escaped
 Print dependencies in inverse order.
 .IP "\fB\-t, \-\-topology\fP"
 Output info about block device topology.
+.IP "\fB\-S, \-\-scsi\fP"
+Output info about SCSI devices.
 This option is equivalent to "-o NAME,ALIGNMENT,MIN-IO,OPT-IO,PHY-SEC,LOG-SEC,ROTA,SCHED,RQ-SIZE".
 .IP "\fB\-V, \-\-version\fP"
 Output version information and exit.
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index f8bc6ea..bca4449 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -1,7 +1,7 @@
 /*
  * lsblk(8) - list block devices
  *
- * Copyright (C) 2010,2011 Red Hat, Inc. All rights reserved.
+ * Copyright (C) 2010,2011,2012 Red Hat, Inc. All rights reserved.
  * Written by Milan Broz <mbroz@redhat.com>
  *            Karel Zak <kzak@redhat.com>
  *
@@ -162,6 +162,7 @@ struct lsblk {
 	unsigned int bytes:1;		/* print SIZE in bytes */
 	unsigned int inverse:1;		/* print inverse dependencies */
 	unsigned int nodeps:1;		/* don't print slaves/holders */
+	unsigned int scsi:1;		/* print only device with HCTL (SCSI) */
 };
 
 struct lsblk *lsblk;	/* global handler */
@@ -588,7 +589,7 @@ static char *get_transport(struct blkdev_cxt *cxt)
 	char *attr = NULL;
 	const char *trans = NULL;
 
-	/* SPI - Serial Peripheral Interface */
+	/* SCSI - Serial Peripheral Interface */
 	if (sysfs_scsi_host_is(sysfs, "spi"))
 		trans = "spi";
 
@@ -976,6 +977,10 @@ static int set_cxt(struct blkdev_cxt *cxt,
 	cxt->nholders = sysfs_count_dirents(&cxt->sysfs, "holders");
 	cxt->nslaves = sysfs_count_dirents(&cxt->sysfs, "slaves");
 
+	/* ignore non-SCSI devices */
+	if (lsblk->scsi && sysfs_scsi_get_hctl(&cxt->sysfs, NULL, NULL, NULL, NULL))
+		return -1;
+
 	return 0;
 }
 
@@ -1330,6 +1335,7 @@ static void __attribute__((__noreturn__)) help(FILE *out)
 		" -r, --raw            use raw output format\n"
 		" -s, --inverse        inverse dependencies\n"
 		" -t, --topology       output info about topology\n"
+		" -S, --scsi           output info about SCSI devices\n"
 		" -V, --version        output version information and exit\n"));
 
 	fprintf(out, _("\nAvailable columns (for --output):\n"));
@@ -1374,6 +1380,7 @@ int main(int argc, char *argv[])
 		{ "include",    1, 0, 'I' },
 		{ "topology",   0, 0, 't' },
 		{ "pairs",      0, 0, 'P' },
+		{ "scsi",       0, 0, 'S' },
 		{ "version",    0, 0, 'V' },
 		{ NULL, 0, 0, 0 },
 	};
@@ -1394,7 +1401,7 @@ int main(int argc, char *argv[])
 	memset(lsblk, 0, sizeof(*lsblk));
 
 	while((c = getopt_long(argc, argv,
-			       "abdDe:fhlnmo:PiI:rstV", longopts, NULL)) != -1) {
+			       "abdDe:fhlnmo:PiI:rstVS", longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
 
@@ -1473,6 +1480,16 @@ int main(int argc, char *argv[])
 			columns[ncolumns++] = COL_RQ_SIZE;
 			columns[ncolumns++] = COL_RA;
 			break;
+		case 'S':
+			lsblk->nodeps = 1;
+			lsblk->scsi = 1;
+			columns[ncolumns++] = COL_NAME;
+			columns[ncolumns++] = COL_HCTL;
+			columns[ncolumns++] = COL_TYPE;
+			columns[ncolumns++] = COL_VENDOR;
+			columns[ncolumns++] = COL_MODEL;
+			columns[ncolumns++] = COL_REV;
+			break;
 		case 'V':
 			printf(_("%s from %s\n"), program_invocation_short_name,
 				PACKAGE_STRING);
-- 
1.7.10.4

