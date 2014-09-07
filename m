Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:44653 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbaIGMne (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Sep 2014 08:43:34 -0400
Received: by mail-wi0-f180.google.com with SMTP id ex7so1374087wid.13
        for <util-linux@vger.kernel.org>; Sun, 07 Sep 2014 05:43:33 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/17] mountpoint: add struct mountpoint_control
Date: Sun,  7 Sep 2014 13:42:57 +0100
Message-Id: <1410093785-17537-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This unifies variable names in different functions, and removes redundant
stat() calls.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/mountpoint.c | 86 ++++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 45 deletions(-)

diff --git a/sys-utils/mountpoint.c b/sys-utils/mountpoint.c
index 3919ab7..3392cdd 100644
--- a/sys-utils/mountpoint.c
+++ b/sys-utils/mountpoint.c
@@ -40,9 +40,17 @@
 #include "closestream.h"
 #include "pathnames.h"
 
-static int quiet;
+struct mountpoint_control {
+	char *devname;
+	dev_t dev;
+	struct stat st;
+	uint8_t
+		dev_devno:1,
+		fs_devno:1,
+		quiet:1;
+};
 
-static int dir_to_device(const char *spec, dev_t *dev)
+static int dir_to_device(struct mountpoint_control *ctl)
 {
 	struct libmnt_table *tb = mnt_new_table_from_file(_PATH_PROC_MOUNTINFO);
 	struct libmnt_fs *fs;
@@ -54,16 +62,13 @@ static int dir_to_device(const char *spec, dev_t *dev)
 		 * Fallback. Traditional way to detect mountpoints. This way
 		 * is independent on /proc, but not able to detect bind mounts.
 		 */
-		struct stat pst, st;
+		struct stat pst;
 		char buf[PATH_MAX], *cn;
 		int len;
 
-		if (stat(spec, &st) != 0)
-			return -1;
-
-		cn = mnt_resolve_path(spec, NULL);	/* canonicalize */
+		cn = mnt_resolve_path(ctl->devname, NULL);	/* canonicalize */
 
-		len = snprintf(buf, sizeof(buf), "%s/..", cn ? cn : spec);
+		len = snprintf(buf, sizeof(buf), "%s/..", cn ? cn : ctl->devname);
 		free(cn);
 
 		if (len < 0 || (size_t) len + 1 > sizeof(buf))
@@ -71,9 +76,9 @@ static int dir_to_device(const char *spec, dev_t *dev)
 		if (stat(buf, &pst) !=0)
 			return -1;
 
-		if ((st.st_dev != pst.st_dev) ||
-		    (st.st_dev == pst.st_dev && st.st_ino == pst.st_ino)) {
-			*dev = st.st_dev;
+		if ((ctl->st.st_dev != pst.st_dev) ||
+		    (ctl->st.st_dev == pst.st_dev && ctl->st.st_ino == pst.st_ino)) {
+			ctl->dev = ctl->st.st_dev;
 			return 0;
 		}
 
@@ -85,9 +90,9 @@ static int dir_to_device(const char *spec, dev_t *dev)
 	mnt_table_set_cache(tb, cache);
 	mnt_unref_cache(cache);
 
-	fs = mnt_table_find_target(tb, spec, MNT_ITER_BACKWARD);
+	fs = mnt_table_find_target(tb, ctl->devname, MNT_ITER_BACKWARD);
 	if (fs && mnt_fs_get_target(fs)) {
-		*dev = mnt_fs_get_devno(fs);
+		ctl->dev = mnt_fs_get_devno(fs);
 		rc = 0;
 	}
 
@@ -95,20 +100,14 @@ static int dir_to_device(const char *spec, dev_t *dev)
 	return rc;
 }
 
-static int print_devno(const char *devname, struct stat *st)
+static int print_devno(const struct mountpoint_control *ctl)
 {
-	struct stat stbuf;
-
-	if (!st && stat(devname, &stbuf) == 0)
-		st = &stbuf;
-	if (!st)
-		return -1;
-	if (!S_ISBLK(st->st_mode)) {
-		if (!quiet)
-			warnx(_("%s: not a block device"), devname);
+	if (!S_ISBLK(ctl->st.st_mode)) {
+		if (!ctl->quiet)
+			warnx(_("%s: not a block device"), ctl->devname);
 		return -1;
 	}
-	printf("%u:%u\n", major(st->st_rdev), minor(st->st_rdev));
+	printf("%u:%u\n", major(ctl->st.st_rdev), minor(ctl->st.st_rdev));
 	return 0;
 }
 
@@ -133,9 +132,8 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 
 int main(int argc, char **argv)
 {
-	int c, fs_devno = 0, dev_devno = 0, rc = 0;
-	char *spec;
-	struct stat st;
+	int c, rc = 0;
+	struct mountpoint_control ctl = { 0 };
 
 	static const struct option longopts[] = {
 		{ "quiet", 0, 0, 'q' },
@@ -157,13 +155,13 @@ int main(int argc, char **argv)
 
 		switch(c) {
 		case 'q':
-			quiet = 1;
+			ctl.quiet = 1;
 			break;
 		case 'd':
-			fs_devno = 1;
+			ctl.fs_devno = 1;
 			break;
 		case 'x':
-			dev_devno = 1;
+			ctl.dev_devno = 1;
 			break;
 		case 'h':
 			usage(stdout);
@@ -180,27 +178,25 @@ int main(int argc, char **argv)
 	if (optind + 1 != argc)
 		usage(stderr);
 
-	spec = argv[optind++];
+	ctl.devname = argv[optind];
 
-	if (stat(spec, &st)) {
-		if (!quiet)
-			err(EXIT_FAILURE, "%s", spec);
+	if (stat(ctl.devname, &ctl.st)) {
+		if (!ctl.quiet)
+			err(EXIT_FAILURE, "%s", ctl.devname);
 		return EXIT_FAILURE;
 	}
-	if (dev_devno)
-		rc = print_devno(spec, &st);
+	if (ctl.dev_devno)
+		rc = print_devno(&ctl);
 	else {
-		dev_t src;
-
-		if ( dir_to_device(spec, &src)) {
-			if (!quiet)
-				printf(_("%s is not a mountpoint\n"), spec);
+		if (dir_to_device(&ctl)) {
+			if (!ctl.quiet)
+				printf(_("%s is not a mountpoint\n"), ctl.devname);
 			return EXIT_FAILURE;
 		}
-		if (fs_devno)
-			printf("%u:%u\n", major(src), minor(src));
-		else if (!quiet)
-			printf(_("%s is a mountpoint\n"), spec);
+		if (ctl.fs_devno)
+			printf("%u:%u\n", major(ctl.dev), minor(ctl.dev));
+		else if (!ctl.quiet)
+			printf(_("%s is a mountpoint\n"), ctl.devname);
 	}
 
 	return rc ? EXIT_FAILURE : EXIT_SUCCESS;
-- 
2.1.0

