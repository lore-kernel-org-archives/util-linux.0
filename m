Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:52173 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbcCRLtX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 18 Mar 2016 07:49:23 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0Lbd9v-1ZvgCJ1AAV-00lCMR for
 <util-linux@vger.kernel.org>; Fri, 18 Mar 2016 12:49:20 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] ipcs: make sure to parse whole lines for shm_data
Date: Fri, 18 Mar 2016 12:49:17 +0100
Message-Id: <1458301758-21853-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1458301758-21853-1-git-send-email-sweet_f_a@gmx.de>
References: <1458301758-21853-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

We want to parse 16 columns _per_row_ without mixing them up. The
existing code is unsafe for more or less columns and could even
run into endless loops. This patch assures that we parse row-wise
and really skip lines with columns != 16.

Probably somehow we could have also done this with fscanf() only.
Using fgets() additionally makes the code more easy to read and
to improve later.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/ipcutils.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sys-utils/ipcutils.c b/sys-utils/ipcutils.c
index 400f00c..c763cde 100644
--- a/sys-utils/ipcutils.c
+++ b/sys-utils/ipcutils.c
@@ -99,6 +99,7 @@ int ipc_shm_get_info(int id, struct shm_data **shmds)
 {
 	FILE *f;
 	int i = 0, maxid;
+	char buf[BUFSIZ];
 	struct shm_data *p;
 	struct shmid_ds dummy;
 
@@ -111,8 +112,8 @@ int ipc_shm_get_info(int id, struct shm_data **shmds)
 
 	while (fgetc(f) != '\n');		/* skip header */
 
-	while (feof(f) == 0) {
-		if (fscanf(f,
+	while (fgets(buf, sizeof(buf), f) != NULL) {
+		if (sscanf(buf,
 			  "%d %d  %o %"SCNu64 " %u %u  "
 			  "%"SCNu64 " %u %u %u %u %"SCNi64 " %"SCNi64 " %"SCNi64
 			  " %"SCNu64 " %"SCNu64 "\n",
@@ -132,7 +133,7 @@ int ipc_shm_get_info(int id, struct shm_data **shmds)
 			   &p->shm_ctim,
 			   &p->shm_rss,
 			   &p->shm_swp) != 16)
-			continue;
+			continue; /* ivalid line, skipped */
 
 		if (id > -1) {
 			/* ID specified */
-- 
1.8.4.5

