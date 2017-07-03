Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:49195 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753762AbdGCLxF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 3 Jul 2017 07:53:05 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lp7d2-1dy1L13WXk-00esom for <util-linux@vger.kernel.org>; Mon, 03 Jul 2017
 13:53:03 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 6/6] lsblk: add --sysroot
Date: Mon,  3 Jul 2017 13:53:01 +0200
Message-Id: <1499082781-16968-7-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1499082781-16968-1-git-send-email-sweet_f_a@gmx.de>
References: <1499082781-16968-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 misc-utils/lsblk.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 9d3460b..c7f5b0e 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -57,6 +57,7 @@
 #include "xalloc.h"
 #include "strutils.h"
 #include "sysfs.h"
+#include "path.h"
 #include "closestream.h"
 #include "mangle.h"
 #include "optutils.h"
@@ -640,7 +641,7 @@ static int is_readonly_device(struct blkdev_cxt *cxt)
 		return ro;
 
 	/* fallback if "ro" attribute does not exist */
-	fd = open(cxt->filename, O_RDONLY);
+	fd = path_open(cxt->filename, O_RDONLY);
 	if (fd != -1) {
 		if (ioctl(fd, BLKROGET, &ro) != 0)
 			ro = 0;
@@ -892,7 +893,7 @@ static void set_scols_data(struct blkdev_cxt *cxt, int col, int id, struct libsc
 
 	if (!cxt->st.st_rdev && (id == COL_OWNER || id == COL_GROUP ||
 				 id == COL_MODE))
-		st_rc = stat(cxt->filename, &cxt->st);
+		st_rc = path_stat(cxt->filename, &cxt->st);
 
 	if (lsblk->sort_id == id)
 		sort = 1;
@@ -1437,7 +1438,7 @@ static int iterate_block_devices(void)
 	struct dirent *d;
 	struct blkdev_cxt cxt = { NULL };
 
-	if (!(dir = opendir(_PATH_SYS_BLOCK)))
+	if (!(dir = path_opendir(_PATH_SYS_BLOCK)))
 		return -errno;
 
 	DBG(DEV, ul_debug("iterate on " _PATH_SYS_BLOCK));
@@ -1477,7 +1478,7 @@ static char *devno_to_sysfs_name(dev_t devno, char *devname, char *buf, size_t b
 		return NULL;
 	}
 
-	len = readlink(path, buf, buf_size - 1);
+	len = path_readlink(path, buf, buf_size - 1);
 	if (len < 0) {
 		warn(_("%s: failed to read link"), path);
 		return NULL;
@@ -1495,7 +1496,7 @@ static int process_one_device(char *devname)
 	dev_t disk = 0;
 	int real_part = 0, rc = -EINVAL;
 
-	if (stat(devname, &st) || !S_ISBLK(st.st_mode)) {
+	if (path_stat(devname, &st) || !S_ISBLK(st.st_mode)) {
 		warnx(_("%s: not a block device"), devname);
 		goto leave;
 	}
@@ -1685,6 +1686,10 @@ int main(int argc, char *argv[])
 	size_t i;
 	int force_tree = 0;
 
+	enum {
+		OPT_SYSROOT = CHAR_MAX + 1,
+	};
+
 	static const struct option longopts[] = {
 		{ "all",	no_argument,       NULL, 'a' },
 		{ "bytes",      no_argument,       NULL, 'b' },
@@ -1711,6 +1716,7 @@ int main(int argc, char *argv[])
 		{ "sort",	required_argument, NULL, 'x' },
 		{ "tree",       no_argument,       NULL, 'T' },
 		{ "version",    no_argument,       NULL, 'V' },
+		{ "sysroot",    required_argument, NULL, OPT_SYSROOT },
 		{ NULL, 0, NULL, 0 },
 	};
 
@@ -1848,6 +1854,11 @@ int main(int argc, char *argv[])
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
+		case OPT_SYSROOT:
+			if(path_set_prefix(optarg))
+				err(EXIT_FAILURE, _("invalid argument to %s"), "--sysroot");
+			/* TODO: mod->system = SYSTEM_SNAPSHOT; */
+			break;
 		case 'x':
 			lsblk->flags &= ~LSBLK_TREE; /* disable the default */
 			lsblk->sort_id = column_name_to_id(optarg, strlen(optarg));
-- 
1.8.5.6

