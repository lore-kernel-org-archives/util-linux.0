Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:62518 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbcCMWbZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 Mar 2016 18:31:25 -0400
Received: from tenfore.ga-group.nl ([2.247.85.77]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MMYZG-1alIHM2yHW-008GTz for
 <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 23:31:22 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 01/12] misc: fix printf i386 compiler warnings
Date: Sun, 13 Mar 2016 23:31:09 +0100
Message-Id: <1457908280-15588-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
References: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Still a few printf warnings found on i386 Linux:

libfdisk/src/alignment.c: In function 'fdisk_align_lba':
libfdisk/src/alignment.c:115:3: warning: format '%ju' expects argument of type 'uintmax_t', but argument 6 has type 'long unsigned int' [-Wformat]
sys-utils/lsns.c: In function ‘add_namespace’:
sys-utils/lsns.c:346:2: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘ino_t’ [-Wformat]
sys-utils/lsns.c: In function ‘add_process_to_namespace’:
sys-utils/lsns.c:362:2: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 6 has type ‘ino_t’ [-Wformat]
sys-utils/lsns.c: In function ‘add_scols_line’:
sys-utils/lsns.c:440:4: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘ino_t’ [-Wformat]

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libfdisk/src/alignment.c | 2 +-
 sys-utils/lsns.c         | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/libfdisk/src/alignment.c b/libfdisk/src/alignment.c
index 24f1db9..aa082e1 100644
--- a/libfdisk/src/alignment.c
+++ b/libfdisk/src/alignment.c
@@ -112,7 +112,7 @@ fdisk_sector_t fdisk_align_lba(struct fdisk_context *cxt, fdisk_sector_t lba, in
 	}
 
 	if (lba != res)
-		DBG(CXT, ul_debugobj(cxt, "LBA %ju -aligned-%s-> %ju [grain=%jus]",
+		DBG(CXT, ul_debugobj(cxt, "LBA %ju -aligned-%s-> %ju [grain=%lus]",
 				(uintmax_t) lba,
 				direction == FDISK_ALIGN_UP ? "up" :
 				direction == FDISK_ALIGN_DOWN ? "down" : "near",
diff --git a/sys-utils/lsns.c b/sys-utils/lsns.c
index 83b07f5..9621425 100644
--- a/sys-utils/lsns.c
+++ b/sys-utils/lsns.c
@@ -343,7 +343,7 @@ static struct lsns_namespace *add_namespace(struct lsns *ls, int type, ino_t ino
 	if (!ns)
 		return NULL;
 
-	DBG(NS, ul_debugobj(ns, "new %s[%lu]", ns_names[type], ino));
+	DBG(NS, ul_debugobj(ns, "new %s[%ju]", ns_names[type], (uintmax_t)ino));
 
 	INIT_LIST_HEAD(&ns->processes);
 	INIT_LIST_HEAD(&ns->namespaces);
@@ -359,7 +359,8 @@ static int add_process_to_namespace(struct lsns *ls, struct lsns_namespace *ns,
 {
 	struct list_head *p;
 
-	DBG(NS, ul_debugobj(ns, "add process [%p] pid=%d to %s[%lu]", proc, proc->pid, ns_names[ns->type], ns->id));
+	DBG(NS, ul_debugobj(ns, "add process [%p] pid=%d to %s[%ju]",
+		proc, proc->pid, ns_names[ns->type], (uintmax_t)ns->id));
 
 	list_for_each(p, &ls->processes) {
 		struct lsns_process *xproc = list_entry(p, struct lsns_process, processes);
@@ -437,7 +438,7 @@ static void add_scols_line(struct lsns *ls, struct libscols_table *table,
 
 		switch (get_column_id(i)) {
 		case COL_NS:
-			xasprintf(&str, "%lu", ns->id);
+			xasprintf(&str, "%ju", (uintmax_t)ns->id);
 			break;
 		case COL_PID:
 			xasprintf(&str, "%d", (int) proc->pid);
-- 
1.8.4.5

