Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:58726 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422Ab2KGSCb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 7 Nov 2012 13:02:31 -0500
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Lukas Jirkovsky <l.jirkovsky@gmail.com>,
        Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] umount: add -R, --recursive option
Date: Wed,  7 Nov 2012 13:02:28 -0500
Message-Id: <1352311348-2947-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This allows unmounting of an entire tree of filesystems, which might be
of particular interest for a shutdown initramfs.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 sys-utils/umount.8 |  4 +++
 sys-utils/umount.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index bdd10a5..b8d4358 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -109,6 +109,10 @@ Each option can be prefixed with
 .B no
 to specify options for which no action should be taken.
 .TP
+\fB\-R\fR, \fB\-\-recursive\fR
+Recursively unmount each directory specified. Recursion for each directory will
+stop if any unmount operation in the chain fails for any reason.
+.TP
 \fB\-r\fR, \fB\-\-read\-only\fR
 In case unmounting fails, try to remount read-only.
 .TP
diff --git a/sys-utils/umount.c b/sys-utils/umount.c
index 38a2fc8..d107a49 100644
--- a/sys-utils/umount.c
+++ b/sys-utils/umount.c
@@ -88,6 +88,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	" -l, --lazy              detach the filesystem now, and cleanup all later\n"));
 	fprintf(out, _(
 	" -O, --test-opts <list>  limit the set of filesystems (use with -a)\n"
+	" -R, --recursive         recursively unmount a target with all its children\n"
 	" -r, --read-only         In case unmounting fails, try to remount read-only\n"
 	" -t, --types <list>      limit the set of filesystem types\n"
 	" -v, --verbose           say what is being done\n"));
@@ -300,9 +301,71 @@ static int umount_one(struct libmnt_context *cxt, const char *spec)
 	return rc;
 }
 
+static int umount_do_recurse(struct libmnt_context *cxt,
+		struct libmnt_table *mountinfo, struct libmnt_fs *parent)
+{
+	int rc;
+	struct libmnt_fs *child;
+	const char *target = mnt_fs_get_target(parent);
+	struct libmnt_iter *itr = mnt_new_iter(MNT_ITER_BACKWARD);
+
+	if (itr == NULL)
+		err(MOUNT_EX_SYSERR, _("libmount iterator allocation failed"));
+
+	for (;;) {
+		rc = mnt_table_next_child_fs(mountinfo, itr, parent, &child);
+		if (rc == -1)
+			warn(_("failed to get child fs of %s"), target);
+
+		if (rc != 0)
+			break;
+
+		rc = umount_do_recurse(cxt, mountinfo, child);
+		if (rc != 0)
+			break;
+	}
+
+	/* stop on any hard failure */
+	if (rc != -1 && rc != 32)
+		rc = umount_one(cxt, target);
+
+	mnt_free_iter(itr);
+
+	return rc;
+}
+
+static int umount_recursive(struct libmnt_context *cxt, const char *spec)
+{
+	struct libmnt_table *mountinfo;
+	struct libmnt_fs *fs;
+	int rc = 32; /* ENOENT */
+
+	mountinfo = mnt_new_table();
+	if (mountinfo == NULL)
+		err(MOUNT_EX_SYSERR, _("libmount table allocation failed"));
+
+	if (mnt_table_parse_mtab(mountinfo, "/proc/self/mountifo") < 0) {
+		warn("failed to parse /proc/self/mountifo");
+		goto finish;
+	}
+
+	fs = mnt_table_find_target(mountinfo, spec, MNT_ITER_BACKWARD);
+	if (fs)
+		rc = umount_do_recurse(cxt, mountinfo, fs);
+	else
+		warnx(access(spec, F_OK) == 0 ?
+				_("%s: not mounted") :
+				_("%s: not found"), spec);
+
+finish:
+	mnt_free_table(mountinfo);
+
+	return rc;
+}
+
 int main(int argc, char **argv)
 {
-	int c, rc = 0, all = 0;
+	int c, rc = 0, all = 0, recursive = 0;
 	struct libmnt_context *cxt;
 	char *types = NULL;
 
@@ -321,6 +384,7 @@ int main(int argc, char **argv)
 		{ "no-canonicalize", 0, 0, 'c' },
 		{ "no-mtab", 0, 0, 'n' },
 		{ "read-only", 0, 0, 'r' },
+		{ "recursive", 0, 0, 'R' },
 		{ "test-opts", 1, 0, 'O' },
 		{ "types", 1, 0, 't' },
 		{ "verbose", 0, 0, 'v' },
@@ -341,7 +405,7 @@ int main(int argc, char **argv)
 
 	mnt_context_set_tables_errcb(cxt, table_parser_errcb);
 
-	while ((c = getopt_long(argc, argv, "acdfhilnrO:t:vV",
+	while ((c = getopt_long(argc, argv, "acdfhilnRrO:t:vV",
 					longopts, NULL)) != -1) {
 
 
@@ -380,6 +444,9 @@ int main(int argc, char **argv)
 		case 'r':
 			mnt_context_enable_rdonly_umount(cxt, TRUE);
 			break;
+		case 'R':
+			recursive = TRUE;
+			break;
 		case 'O':
 			if (mnt_context_set_options_pattern(cxt, optarg))
 				err(MOUNT_EX_SYSERR, _("failed to set options pattern"));
@@ -412,8 +479,14 @@ int main(int argc, char **argv)
 	} else if (argc < 1) {
 		usage(stderr);
 
-	} else while (argc--)
-		rc += umount_one(cxt, *argv++);
+	} else if (recursive) {
+		while (argc--)
+			rc += umount_recursive(cxt, *argv++);
+
+	} else {
+		while (argc--)
+			rc += umount_one(cxt, *argv++);
+	}
 
 	mnt_free_context(cxt);
 	return rc;
-- 
1.8.0

