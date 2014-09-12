Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f169.google.com ([209.85.217.169]:56543 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbaILSMP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 12 Sep 2014 14:12:15 -0400
Received: by mail-lb0-f169.google.com with SMTP id p9so1408327lbv.28
        for <util-linux@vger.kernel.org>; Fri, 12 Sep 2014 11:12:13 -0700 (PDT)
From: Boris Egorov <egorov@linux.com>
To: util-linux@vger.kernel.org
Cc: Boris Egorov <egorov@linux.com>
Subject: [PATCH] lscpu: fix cppcheck warnings
Date: Sat, 13 Sep 2014 01:11:35 +0700
Message-Id: <1410545495-13427-1-git-send-email-egorov@linux.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

CppCheck founds a few wrong arguments in format strings and a NULL
pointer dereference.

Signed-off-by: Boris Egorov <egorov@linux.com>
---
 sys-utils/lscpu-dmi.c | 2 +-
 sys-utils/lscpu.c     | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sys-utils/lscpu-dmi.c b/sys-utils/lscpu-dmi.c
index 6c870a1..d6fe1a5 100644
--- a/sys-utils/lscpu-dmi.c
+++ b/sys-utils/lscpu-dmi.c
@@ -161,7 +161,7 @@ static int hypervisor_from_dmi_table(uint32_t base, uint16_t len,
 	else if (manufacturer && strstr(manufacturer, "HITACHI") &&
 					product && strstr(product, "LPAR"))
 		rc = HYPER_HITACHI;
-	else if (!vendor && strcmp(vendor, "Parallels"))
+	else if (vendor && strcmp(vendor, "Parallels"))
 		rc = HYPER_PARALLELS;
 done:
 	free(buf);
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 9965eeb..8827424 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1182,12 +1182,12 @@ get_cell_data(struct lscpu_desc *desc, int idx, int col,
 	case COL_CORE:
 		if (cpuset_ary_isset(cpu, desc->coremaps,
 				     desc->ncores, setsize, &i) == 0)
-			snprintf(buf, bufsz, "%zd", i);
+			snprintf(buf, bufsz, "%zu", i);
 		break;
 	case COL_SOCKET:
 		if (cpuset_ary_isset(cpu, desc->socketmaps,
 				     desc->nsockets, setsize, &i) == 0)
-			snprintf(buf, bufsz, "%zd", i);
+			snprintf(buf, bufsz, "%zu", i);
 		break;
 	case COL_NODE:
 		if (cpuset_ary_isset(cpu, desc->nodemaps,
@@ -1197,7 +1197,7 @@ get_cell_data(struct lscpu_desc *desc, int idx, int col,
 	case COL_BOOK:
 		if (cpuset_ary_isset(cpu, desc->bookmaps,
 				     desc->nbooks, setsize, &i) == 0)
-			snprintf(buf, bufsz, "%zd", i);
+			snprintf(buf, bufsz, "%zu", i);
 		break;
 	case COL_CACHE:
 	{
@@ -1210,7 +1210,7 @@ get_cell_data(struct lscpu_desc *desc, int idx, int col,
 
 			if (cpuset_ary_isset(cpu, ca->sharedmaps,
 					     ca->nsharedmaps, setsize, &i) == 0) {
-				int x = snprintf(p, sz, "%zd", i);
+				int x = snprintf(p, sz, "%zu", i);
 				if (x <= 0 || (size_t) x + 2 >= sz)
 					return NULL;
 				p += x;
-- 
2.1.0

