Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:56124 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751997AbdF1QlG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 28 Jun 2017 12:41:06 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lp8h6-1dvzrz146O-00esrk for <util-linux@vger.kernel.org>; Wed, 28 Jun 2017
 18:40:59 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/8] lscpu: make clang analyzer happy
Date: Wed, 28 Jun 2017 18:40:53 +0200
Message-Id: <1498668057-8256-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498668057-8256-1-git-send-email-sweet_f_a@gmx.de>
References: <1498668057-8256-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Let read_nodes() work on uninitialized structs to silence these two
warnings:

  CC       sys-utils/lscpu-lscpu.o
warning: Path diagnostic report is not generated. Current output format does not support diagnostics that cross file boundaries. Refer to --analyzer-output for valid output formats
In file included from sys-utils/lscpu.c:63:
./include/xalloc.h:32:21: warning: Call to 'malloc' has an allocation size of 0 bytes
        void *ret = malloc(size);
                    ^~~~~~~~~~~~
sys-utils/lscpu.c:1468:23: warning: Function call argument is an uninitialized value
                desc->nodemaps[i] = path_read_cpuset(maxcpus,
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
2 warnings generated.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/lscpu.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 83f3a7d..852711e 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1432,35 +1432,34 @@ read_nodes(struct lscpu_desc *desc)
 	struct dirent *d;
 	const char *path;
 
+	desc->nnodes = 0;
+
 	/* number of NUMA node */
 	if (!(path = path_get(_PATH_SYS_NODE)))
 		return;
-	dir = opendir(path);
-
-	while (dir && (d = readdir(dir))) {
+	if (!(dir = opendir(path)))
+		return;
+	while ((d = readdir(dir))) {
 		if (is_node_dirent(d))
 			desc->nnodes++;
 	}
 
 	if (!desc->nnodes) {
-		if (dir)
-			closedir(dir);
+		closedir(dir);
 		return;
 	}
 
 	desc->nodemaps = xcalloc(desc->nnodes, sizeof(cpu_set_t *));
 	desc->idx2nodenum = xmalloc(desc->nnodes * sizeof(int));
 
-	if (dir) {
-		rewinddir(dir);
-		while ((d = readdir(dir)) && i < desc->nnodes) {
-			if (is_node_dirent(d))
-				desc->idx2nodenum[i++] = strtol_or_err(((d->d_name) + 4),
-							_("Failed to extract the node number"));
-		}
-		closedir(dir);
-		qsort(desc->idx2nodenum, desc->nnodes, sizeof(int), nodecmp);
+	rewinddir(dir);
+	while ((d = readdir(dir)) && i < desc->nnodes) {
+		if (is_node_dirent(d))
+			desc->idx2nodenum[i++] = strtol_or_err(((d->d_name) + 4),
+						_("Failed to extract the node number"));
 	}
+	closedir(dir);
+	qsort(desc->idx2nodenum, desc->nnodes, sizeof(int), nodecmp);
 
 	/* information about how nodes share different CPUs */
 	for (i = 0; i < desc->nnodes; i++)
-- 
1.8.5.6

