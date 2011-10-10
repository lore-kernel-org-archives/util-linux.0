Return-Path: util-linux-owner@vger.kernel.org
Received: from mtagate3.uk.ibm.com ([194.196.100.163]:40356 "EHLO
	mtagate3.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991Ab1JJJAj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Oct 2011 05:00:39 -0400
Received: from d06nrmr1707.portsmouth.uk.ibm.com (d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p9A90cWa030468
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 09:00:38 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p9A90br52449412
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 10:00:37 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p9A90QFP012663
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 03:00:26 -0600
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 3/6] lscpu: change column names back to mixed case
Date: Mon, 10 Oct 2011 10:59:41 +0200
Message-Id: <1318237184-6616-4-git-send-email-heiko.carstens@de.ibm.com>
In-Reply-To: <1318237184-6616-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1318237184-6616-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Commit b9d18bc3 "lscpu: add column names to --help" changed all column names
to upper case only and printed the column names for the parsable output in
lower case.
However current behaviour was that for the parsable output the column names
were printed in mixed case. The change might break existing other tools and
breaks also the util-linux internal lscpu tests.
So revert part of the above commit and restore the old behaviour.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c |   31 ++++++++++++++-----------------
 1 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 7c8cb13..63facc3 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -224,15 +224,15 @@ enum {
 static const char *colnames[] =
 {
 	[COL_CPU] = "CPU",
-	[COL_CORE] = "CORE",
-	[COL_SOCKET] = "SOCKET",
-	[COL_NODE] = "NODE",
-	[COL_BOOK] = "BOOK",
-	[COL_CACHE] = "CACHE",
-	[COL_POLARIZATION] = "POLARIZATION",
-	[COL_ADDRESS] = "ADDRESS",
-	[COL_CONFIGURED] = "CONFIGURED",
-	[COL_ONLINE] = "ONLINE",
+	[COL_CORE] = "Core",
+	[COL_SOCKET] = "Socket",
+	[COL_NODE] = "Node",
+	[COL_BOOK] = "Book",
+	[COL_CACHE] = "Cache",
+	[COL_POLARIZATION] = "Polarization",
+	[COL_ADDRESS] = "Address",
+	[COL_CONFIGURED] = "Configured",
+	[COL_ONLINE] = "Online",
 };
 
 
@@ -937,8 +937,6 @@ print_parsable(struct lscpu_desc *desc, int cols[], int ncols,
 
 	fputs("# ", stdout);
 	for (i = 0; i < ncols; i++) {
-		char *p;
-
 		if (cols[i] == COL_CACHE) {
 			if (mod->compat && !desc->ncaches)
 				continue;
@@ -948,11 +946,7 @@ print_parsable(struct lscpu_desc *desc, int cols[], int ncols,
 		if (i > 0)
 			putchar(',');
 
-		p = data = get_cell_header(desc, cols[i],
-					   mod, buf, sizeof(buf));
-		while (p && *p != '\0')
-			*p++ = tolower((unsigned int) *p);
-
+		data = get_cell_header(desc, cols[i], mod, buf, sizeof(buf));
 		fputs(data && *data ? data : "", stdout);
 	}
 	putchar('\n');
@@ -1000,7 +994,10 @@ print_readable(struct lscpu_desc *desc, int cols[], int ncols,
 		 err(EXIT_FAILURE, _("failed to initialize output table"));
 
 	for (i = 0; i < ncols; i++) {
-		data = get_cell_header(desc, cols[i], mod, buf, sizeof(buf));
+		char *p = data = get_cell_header(desc, cols[i],
+						 mod, buf, sizeof(buf));
+		while (p && *p != '\0')
+			*p++ = toupper((unsigned int) *p);
 		tt_define_column(tt, xstrdup(data), 0, 0);
 	}
 
-- 
1.7.6.3

