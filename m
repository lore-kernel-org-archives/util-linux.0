Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41695 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757522Ab2CETjk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Mar 2012 14:39:40 -0500
Received: by mail-ee0-f46.google.com with SMTP id c41so1625459eek.19
        for <util-linux@vger.kernel.org>; Mon, 05 Mar 2012 11:39:40 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 16/17] xalloc: use xasprintf in all files
Date: Mon,  5 Mar 2012 20:38:53 +0100
Message-Id: <1330976334-10751-17-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
References: <20120305123847.GD486@x2.net.home>
 <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fsck.cramfs.c |    2 +-
 lib/fileutils.c          |    5 +++--
 misc-utils/findmnt.c     |    7 ++++---
 misc-utils/lsblk.c       |    2 +-
 misc-utils/namei.c       |    2 +-
 partx/partx.c            |   14 +++++++-------
 sys-utils/lscpu.c        |    2 +-
 sys-utils/mount.c        |    2 +-
 sys-utils/prlimit.c      |   12 ++++++------
 9 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index eab44f3..465e115 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -530,7 +530,7 @@ static void do_symlink(char *path, struct cramfs_inode *i)
 	if (opt_verbose) {
 		char *str;
 
-		asprintf(&str, "%s -> %s", path, outbuffer);
+		xasprintf(&str, "%s -> %s", path, outbuffer);
 		print_node('l', i, str);
 		if (opt_verbose > 1)
 			printf(_("  uncompressing block at %ld to %ld (%ld)\n"),
diff --git a/lib/fileutils.c b/lib/fileutils.c
index b3b7438..b13db61 100644
--- a/lib/fileutils.c
+++ b/lib/fileutils.c
@@ -9,6 +9,7 @@
 
 #include "c.h"
 #include "pathnames.h"
+#include "xalloc.h"
 
 /* Create open temporary file in safe way.  Please notice that the
  * file permissions are -rw------- by default. */
@@ -22,10 +23,10 @@ FILE *xmkstemp(char **tmpname)
 
 	tmpenv = getenv("TMPDIR");
 	if (tmpenv)
-		asprintf(&localtmp, "%s/%s.XXXXXX", tmpenv,
+		xasprintf(&localtmp, "%s/%s.XXXXXX", tmpenv,
 			 program_invocation_short_name);
 	else
-		asprintf(&localtmp, "%s/%s.XXXXXX", _PATH_TMP,
+		xasprintf(&localtmp, "%s/%s.XXXXXX", _PATH_TMP,
 			 program_invocation_short_name);
 	old_mode = umask(077);
 	fd = mkstemp(localtmp);
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 77897d3..2df79a4 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -38,6 +38,7 @@
 #include "c.h"
 #include "tt.h"
 #include "strutils.h"
+#include "xalloc.h"
 
 /* flags */
 enum {
@@ -305,7 +306,7 @@ static const char *get_data(struct libmnt_fs *fs, int num)
 		if (root && str && !(flags & FL_NOFSROOT) && strcmp(root, "/")) {
 			char *tmp;
 
-			if (asprintf(&tmp, "%s[%s]", str, root) > 0)
+			if (xasprintf(&tmp, "%s[%s]", str, root) > 0)
 				str = tmp;
 		}
 		break;
@@ -338,10 +339,10 @@ static const char *get_data(struct libmnt_fs *fs, int num)
 			char *tmp;
 			int rc = 0;
 			if ((tt_flags & TT_FL_RAW) || (tt_flags & TT_FL_EXPORT))
-				rc = asprintf(&tmp, "%u:%u",
+				rc = xasprintf(&tmp, "%u:%u",
 					      major(devno), minor(devno));
 			else
-				rc = asprintf(&tmp, "%3u:%-3u",
+				rc = xasprintf(&tmp, "%3u:%-3u",
 					      major(devno), minor(devno));
 			if (rc)
 				str = tmp;
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index f33696a..58b0084 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -566,7 +566,7 @@ static void set_tt_data(struct blkdev_cxt *cxt, int col, int id, struct tt_line
 	case COL_SIZE:
 		if (cxt->size) {
 			if (lsblk->bytes) {
-				if (asprintf(&p, "%jd", cxt->size) < 0)
+				if (xasprintf(&p, "%jd", cxt->size) < 0)
 					p = NULL;
 			} else
 				p = size_to_human_string(SIZE_SUFFIX_1LETTER, cxt->size);
diff --git a/misc-utils/namei.c b/misc-utils/namei.c
index 3c2e7fc..e53b4c9 100644
--- a/misc-utils/namei.c
+++ b/misc-utils/namei.c
@@ -123,7 +123,7 @@ add_id(struct idcache **ic, char *name, unsigned long int id, int *width)
 	/* note, we ignore names with non-printable widechars */
 	if (w > 0)
 		nc->name = xstrdup(name);
-	else if (asprintf(&nc->name, "%lu", id) == -1)
+	else if (xasprintf(&nc->name, "%lu", id) == -1)
 		nc->name = NULL;
 
 	for (x = *ic; x && x->next; x = x->next);
diff --git a/partx/partx.c b/partx/partx.c
index e5f4319..ddce6fe 100644
--- a/partx/partx.c
+++ b/partx/partx.c
@@ -445,25 +445,25 @@ static void add_tt_line(struct tt *tt, blkid_partition par)
 
 		switch (get_column_id(i)) {
 		case COL_PARTNO:
-			rc = asprintf(&str, "%d",
+			rc = xasprintf(&str, "%d",
 					blkid_partition_get_partno(par));
 			break;
 		case COL_START:
-			rc = asprintf(&str, "%ju",
+			rc = xasprintf(&str, "%ju",
 					blkid_partition_get_start(par));
 			break;
 		case COL_END:
-			rc = asprintf(&str, "%ju",
+			rc = xasprintf(&str, "%ju",
 					blkid_partition_get_start(par) +
 					blkid_partition_get_size(par) - 1);
 			break;
 		case COL_SECTORS:
-			rc = asprintf(&str, "%ju",
+			rc = xasprintf(&str, "%ju",
 					blkid_partition_get_size(par));
 			break;
 		case COL_SIZE:
 			if (partx_flags & FL_BYTES)
-				rc = asprintf(&str, "%ju", (uintmax_t)
+				rc = xasprintf(&str, "%ju", (uintmax_t)
 					blkid_partition_get_size(par) << 9);
 			else
 				str = size_to_human_string(SIZE_SUFFIX_1LETTER,
@@ -484,11 +484,11 @@ static void add_tt_line(struct tt *tt, blkid_partition par)
 			if (str)
 				str = xstrdup(str);
 			else
-				rc = asprintf(&str, "0x%x",
+				rc = xasprintf(&str, "0x%x",
 					blkid_partition_get_type(par));
 			break;
 		case COL_FLAGS:
-			rc = asprintf(&str, "0x%llx", blkid_partition_get_flags(par));
+			rc = xasprintf(&str, "0x%llx", blkid_partition_get_flags(par));
 			break;
 		case COL_SCHEME:
 		{
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 3cdd767..6e17b2e 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -543,7 +543,7 @@ read_hypervisor(struct lscpu_desc *desc)
 			str = strchr(buf, ':');
 			if (!str)
 				continue;
-			if (asprintf(&str, "%s", str + 1) == -1)
+			if (xasprintf(&str, "%s", str + 1) == -1)
 				errx(EXIT_FAILURE, _("failed to allocate memory"));
 			/* remove leading, trailing and repeating whitespace */
 			while (*str == ' ')
diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index 69f536b..b1a0390 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -769,7 +769,7 @@ int main(int argc, char **argv)
 		case 'U':
 			if (source)
 				errx(MOUNT_EX_USAGE, _("only one <source> may be specified"));
-			if (asprintf(&srcbuf, "%s=\"%s\"",
+			if (xasprintf(&srcbuf, "%s=\"%s\"",
 				     c == 'L' ? "LABEL" : "UUID", optarg) <= 0)
 				err(MOUNT_EX_SYSERR, _("failed to allocate source buffer"));
 			source = srcbuf;
diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index a446187..c45b85e 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -228,20 +228,20 @@ static void add_tt_line(struct tt *tt, struct prlimit *l)
 
 		switch (get_column_id(i)) {
 		case COL_RES:
-			rc = asprintf(&str, "%s", l->desc->name);
+			rc = xasprintf(&str, "%s", l->desc->name);
 			break;
 		case COL_HELP:
-			rc = asprintf(&str, "%s", l->desc->help);
+			rc = xasprintf(&str, "%s", l->desc->help);
 			break;
 		case COL_SOFT:
 			rc = l->rlim.rlim_cur == RLIM_INFINITY ?
-				asprintf(&str, "%s", "unlimited") :
-				asprintf(&str, "%llu", (unsigned long long) l->rlim.rlim_cur);
+				xasprintf(&str, "%s", "unlimited") :
+				xasprintf(&str, "%llu", (unsigned long long) l->rlim.rlim_cur);
 			break;
 		case COL_HARD:
 			rc = l->rlim.rlim_max == RLIM_INFINITY ?
-				asprintf(&str, "%s", "unlimited") :
-				asprintf(&str, "%llu", (unsigned long long) l->rlim.rlim_max);
+				xasprintf(&str, "%s", "unlimited") :
+				xasprintf(&str, "%llu", (unsigned long long) l->rlim.rlim_max);
 			break;
 		case COL_UNITS:
 			str = l->desc->unit ? xstrdup(_(l->desc->unit)) : NULL;
-- 
1.7.9.2

