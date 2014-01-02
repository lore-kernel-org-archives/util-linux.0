Return-Path: util-linux-owner@vger.kernel.org
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:46001 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbaABJou (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 2 Jan 2014 04:44:50 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <maddy@linux.vnet.ibm.com>;
	Thu, 2 Jan 2014 19:44:48 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id B985B3578066
	for <util-linux@vger.kernel.org>; Thu,  2 Jan 2014 20:44:46 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s029iYJm10420694
	for <util-linux@vger.kernel.org>; Thu, 2 Jan 2014 20:44:34 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s029ikMW024011
	for <util-linux@vger.kernel.org>; Thu, 2 Jan 2014 20:44:46 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com, qcai@redhat.com,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 1/1] lscpu: support discontinuous NUMA nodes
Date: Thu,  2 Jan 2014 15:14:37 +0530
Message-Id: <1388655877-18492-1-git-send-email-maddy@linux.vnet.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

lscpu fails to print proper NUMA node values in a system
with discontinuous nodes. This patch adds support by
creating a nodeidx array to map node numbers.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 sys-utils/lscpu.c |   47 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 8f14b3a..6683aff 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -50,6 +50,7 @@
 /* /sys paths */
 #define _PATH_SYS_SYSTEM	"/sys/devices/system"
 #define _PATH_SYS_CPU		_PATH_SYS_SYSTEM "/cpu"
+#define _PATH_SYS_NODE		_PATH_SYS_SYSTEM "/node"
 #define _PATH_PROC_XEN		"/proc/xen"
 #define _PATH_PROC_XENCAP	_PATH_PROC_XEN "/capabilities"
 #define _PATH_PROC_CPUINFO	"/proc/cpuinfo"
@@ -177,6 +178,7 @@ struct lscpu_desc {
 	int		*idx2cpunum;	/* mapping index to CPU num */
 
 	int		nnodes;		/* number of NUMA modes */
+	int		*idx2nodenum;	/* Support for discontinuous nodes */
 	cpu_set_t	**nodemaps;	/* array with NUMA nodes */
 
 	/* books -- based on book_siblings (internal kernel map of cpuX's
@@ -912,25 +914,58 @@ read_cache(struct lscpu_desc *desc, int idx)
 	}
 }
 
+static int
+check_for_dir(const char *path, const char *file_name)
+{
+	char buf[100];
+	struct stat file;
+
+	sprintf(buf, "%s/%s", path, file_name);
+	return stat(buf, &file) == 0 && S_ISDIR(file.st_mode);
+}
+
 static void
 read_nodes(struct lscpu_desc *desc)
 {
-	int i;
+	int i=0;
+	DIR *dir=NULL;
+	struct dirent *curdir=NULL;
 
 	/* number of NUMA node */
-	while (path_exist(_PATH_SYS_SYSTEM "/node/node%d", desc->nnodes))
-		desc->nnodes++;
+	dir=opendir(_PATH_SYS_NODE);
+	if(dir) {
+		while ((curdir = readdir(dir)) != NULL) {
+			if((strncmp(curdir->d_name, "node", 4) == 0) &&
+			    check_for_dir(_PATH_SYS_NODE, curdir->d_name) &&
+			    isdigit_string(curdir->d_name + 4) )
+				desc->nnodes++;
+			}
+		closedir(dir);
+	}
 
 	if (!desc->nnodes)
 		return;
 
 	desc->nodemaps = xcalloc(desc->nnodes, sizeof(cpu_set_t *));
+	desc->idx2nodenum = xmalloc(desc->nnodes * sizeof(int));
+
+	dir=opendir(_PATH_SYS_NODE);
+	if(dir) {
+		while ((curdir = readdir(dir)) != NULL) {
+			if( (strncmp(curdir->d_name, "node", 4) == 0) &&
+			    check_for_dir(_PATH_SYS_NODE, curdir->d_name) &&
+			    isdigit_string(curdir->d_name + 4) )
+				desc->idx2nodenum[i++] = strtol_or_err(((curdir->d_name)+4),
+							_("Failed to extract the node number"));
+			}
+		closedir(dir);
+	}
 
 	/* information about how nodes share different CPUs */
 	for (i = 0; i < desc->nnodes; i++)
 		desc->nodemaps[i] = path_read_cpuset(maxcpus,
 					_PATH_SYS_SYSTEM "/node/node%d/cpumap",
-					i);
+					desc->idx2nodenum[i]);
 }
 
 static char *
@@ -961,7 +996,7 @@ get_cell_data(struct lscpu_desc *desc, int idx, int col,
 	case COL_NODE:
 		if (cpuset_ary_isset(cpu, desc->nodemaps,
 				     desc->nnodes, setsize, &i) == 0)
-			snprintf(buf, bufsz, "%zd", i);
+			snprintf(buf, bufsz, "%d", desc->idx2nodenum[i]);
 		break;
 	case COL_BOOK:
 		if (cpuset_ary_isset(cpu, desc->bookmaps,
@@ -1378,7 +1413,7 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 	}
 
 	for (i = 0; i < desc->nnodes; i++) {
-		snprintf(buf, sizeof(buf), _("NUMA node%d CPU(s):"), i);
+		snprintf(buf, sizeof(buf), _("NUMA node%d CPU(s):"), desc->idx2nodenum[i]);
 		print_cpuset(buf, desc->nodemaps[i], mod->hex);
 	}
 }
-- 
1.7.10.4

