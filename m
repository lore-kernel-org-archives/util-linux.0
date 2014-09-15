Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f175.google.com ([74.125.82.175]:49768 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743AbaIOQd1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 15 Sep 2014 12:33:27 -0400
Received: by mail-we0-f175.google.com with SMTP id w61so4263704wes.34
        for <util-linux@vger.kernel.org>; Mon, 15 Sep 2014 09:33:23 -0700 (PDT)
From: Boris Egorov <egorov@linux.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: util-linux@vger.kernel.org, Boris Egorov <egorov@linux.com>
Subject: [PATCH] lscpu: fix cppcheck warnings
Date: Mon, 15 Sep 2014 23:33:17 +0700
Message-Id: <1410798797-23769-1-git-send-email-egorov@linux.com>
In-Reply-To: <20140914115745.GA20978@fatal.se>
References: <20140914115745.GA20978@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

CppCheck founds a few wrong arguments in format strings and a NULL
pointer dereference.

Amended version with fixed strcmp() usage.

Signed-off-by: Boris Egorov <egorov@linux.com>
---
 sys-utils/lscpu-dmi.c | 2 +-
 sys-utils/lscpu.c     | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sys-utils/lscpu-dmi.c b/sys-utils/lscpu-dmi.c
index 6c870a1..0e497d1 100644
--- a/sys-utils/lscpu-dmi.c
+++ b/sys-utils/lscpu-dmi.c
@@ -161,7 +161,7 @@ static int hypervisor_from_dmi_table(uint32_t base, uint16_t len,
 	else if (manufacturer && strstr(manufacturer, "HITACHI") &&
 					product && strstr(product, "LPAR"))
 		rc = HYPER_HITACHI;
-	else if (!vendor && strcmp(vendor, "Parallels"))
+	else if (vendor && !strcmp(vendor, "Parallels"))
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

