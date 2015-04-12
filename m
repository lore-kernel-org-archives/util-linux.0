Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:48509 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876AbbDLJG7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 12 Apr 2015 05:06:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 39C4C3409C2
	for <util-linux@vger.kernel.org>; Sun, 12 Apr 2015 09:06:59 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/3] fsck: drop hardcoded search path
Date: Sun, 12 Apr 2015 05:06:53 -0400
Message-Id: <1428829613-30423-3-git-send-email-vapier@gentoo.org>
In-Reply-To: <1428829613-30423-1-git-send-email-vapier@gentoo.org>
References: <1428829613-30423-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Rather than maintain a hardcoded search path for looking up tools and
override the user's PATH env setting, respect whatever the user has.
This matches the convention of just about every other tool out there.

It might break on systems that don't have /sbin in their PATH and they
try to run /sbin/fsck directly, or are using the uncommon fs.d subdirs,
but so be it.

We also drop the hardcoded minimal list of filesystem types that we
"really want" to check.  Instead, we blindly execute the fsck.<type>
program whenever it's been requested.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 disk-utils/fsck.8 |  23 +++---------
 disk-utils/fsck.c | 103 ++++++------------------------------------------------
 2 files changed, 14 insertions(+), 112 deletions(-)

diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index c60eef2..4207731 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -80,14 +80,9 @@ In actuality,
 .B fsck
 is simply a front-end for the various filesystem checkers
 (\fBfsck\fR.\fIfstype\fR) available under Linux.  The
-filesystem-specific checker is searched for in
-.I /sbin
-first, then in
-.I /etc/fs
-and
-.IR /etc ,
-and finally in the directories listed in the PATH environment
-variable.  Please see the filesystem-specific checker manual pages for
+filesystem-specific checker is searched for via the PATH
+environment variable only.
+Please see the filesystem-specific checker manual pages for
 further details.
 .SH OPTIONS
 .TP
@@ -416,17 +411,7 @@ be run based on gathering accounting data from the operating system.
 .B PATH
 The
 .B PATH
-environment variable is used to find filesystem checkers.  A set of
-system directories are searched first:
-.BR /sbin ,
-.BR /sbin/fs.d ,
-.BR /sbin/fs ,
-.BR /etc/fs ,
-and
-.BR /etc .
-Then the set of directories found in the
-.B PATH
-environment are searched.
+environment variable is used to find filesystem checkers.
 .TP
 .B FSTAB_FILE
 This environment variable allows the system administrator
diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index 817be97..b1fc187 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -75,16 +75,6 @@ static const char *ignored_types[] = {
 	NULL
 };
 
-static const char *really_wanted[] = {
-	"minix",
-	"ext2",
-	"ext3",
-	"ext4",
-	"ext4dev",
-	"jfs",
-	"reiserfs"
-};
-
 /*
  * Internal structure for mount tabel entries.
  */
@@ -150,9 +140,6 @@ static int kill_sent;
 static char *fstype;
 static struct fsck_instance *instance_list;
 
-static const char fsck_prefix_path[] = FS_SEARCH_PATH;
-static char *fsck_path;
-
 /* parsed fstab and mtab */
 static struct libmnt_table *fstab, *mtab;
 static struct libmnt_cache *mntcache;
@@ -171,19 +158,6 @@ static int string_to_int(const char *s)
 		return (int) l;
 }
 
-/* Do we really really want to check this fs? */
-static int fs_check_required(const char *type)
-{
-	size_t i;
-
-	for(i = 0; i < ARRAY_SIZE(really_wanted); i++) {
-		if (strcmp(type, really_wanted[i]) == 0)
-			return 1;
-	}
-
-	return 0;
-}
-
 static int is_mounted(struct libmnt_fs *fs)
 {
 	int rc;
@@ -535,28 +509,6 @@ static struct libmnt_fs *lookup(char *path)
 	return fs;
 }
 
-/* Find fsck program for a given fs type. */
-static char *find_fsck(const char *type)
-{
-	char *s;
-	const char *tpl;
-	static char prog[256];
-	char *p = xstrdup(fsck_path);
-	struct stat st;
-
-	/* Are we looking for a program or just a type? */
-	tpl = (strncmp(type, "fsck.", 5) ? "%s/fsck.%s" : "%s/%s");
-
-	for(s = strtok(p, ":"); s; s = strtok(NULL, ":")) {
-		sprintf(prog, tpl, s, type);
-		if (stat(prog, &st) == 0)
-			break;
-	}
-	free(p);
-
-	return(s ? prog : NULL);
-}
-
 static int progress_active(void)
 {
 	struct fsck_instance *inst;
@@ -601,8 +553,7 @@ static void print_stats(struct fsck_instance *inst)
  * Execute a particular fsck program, and link it into the list of
  * child processes we are waiting for.
  */
-static int execute(const char *progname, const char *progpath,
-		   const char *type, struct libmnt_fs *fs, int interactive)
+static int execute(const char *type, struct libmnt_fs *fs, int interactive)
 {
 	char *argv[80];
 	int  argc, i;
@@ -611,7 +562,7 @@ static int execute(const char *progname, const char *progpath,
 
 	inst = xcalloc(1, sizeof(*inst));
 
-	argv[0] = xstrdup(progname);
+	xasprintf(&argv[0], "fsck.%s", type);
 	argc = 1;
 
 	for (i=0; i <num_args; i++)
@@ -643,7 +594,7 @@ static int execute(const char *progname, const char *progpath,
 
 		if (!tgt)
 			tgt = fs_get_device(fs);
-		printf("[%s (%d) -- %s] ", progpath, num_running, tgt);
+		printf("[%s (%d) -- %s] ", argv[0], num_running, tgt);
 		for (i=0; i < argc; i++)
 			printf("%s ", argv[i]);
 		printf("\n");
@@ -666,19 +617,19 @@ static int execute(const char *progname, const char *progpath,
 	} else if (pid == 0) {
 		if (!interactive)
 			close(0);
-		execv(progpath, argv);
-		err(FSCK_EX_ERROR, _("%s: execute failed"), progpath);
+		execvp(argv[0], argv);
+		err(FSCK_EX_ERROR, _("%s: execute failed"), argv[0]);
 	}
 
-	for (i=0; i < argc; i++)
-		free(argv[i]);
-
 	inst->pid = pid;
-	inst->prog = xstrdup(progname);
+	inst->prog = xstrdup(argv[0]);
 	inst->type = xstrdup(type);
 	gettime_monotonic(&inst->start_time);
 	inst->next = NULL;
 
+	for (i = 0; i < argc; i++)
+		free(argv[i]);
+
 	/*
 	 * Find the end of the list, so we add the instance on at the end.
 	 */
@@ -871,7 +822,6 @@ static int wait_many(int flags)
  */
 static int fsck_device(struct libmnt_fs *fs, int interactive)
 {
-	char progname[80], *progpath;
 	const char *type;
 	int retval;
 
@@ -888,18 +838,8 @@ static int fsck_device(struct libmnt_fs *fs, int interactive)
 	else
 		type = DEFAULT_FSTYPE;
 
-	sprintf(progname, "fsck.%s", type);
-	progpath = find_fsck(progname);
-	if (progpath == NULL) {
-		if (fs_check_required(type)) {
-			retval = ENOENT;
-			goto err;
-		}
-		return 0;
-	}
-
 	num_running++;
-	retval = execute(progname, progpath, type, fs, interactive);
+	retval = execute(type, fs, interactive);
 	if (retval) {
 		num_running--;
 		goto err;
@@ -1131,16 +1071,6 @@ static int ignore(struct libmnt_fs *fs)
 	if (fs_ignored_type(fs))
 		return 1;
 
-
-
-	/* See if the <fsck.fs> program is available. */
-	if (find_fsck(type) == NULL) {
-		if (fs_check_required(type))
-			warnx(_("cannot check %s: fsck.%s not found"),
-				fs_get_device(fs), type);
-		return 1;
-	}
-
 	/* We can and want to check this file system type. */
 	return 0;
 }
@@ -1551,7 +1481,6 @@ int main(int argc, char *argv[])
 {
 	int i, status = 0;
 	int interactive = 0;
-	char *oldpath = getenv("PATH");
 	struct libmnt_fs *fs;
 
 	setvbuf(stdout, NULL, _IONBF, BUFSIZ);
@@ -1573,17 +1502,6 @@ int main(int argc, char *argv[])
 
 	load_fs_info();
 
-	/* Update our search path to include uncommon directories. */
-	if (oldpath) {
-		fsck_path = xmalloc (strlen (fsck_prefix_path) + 1 +
-				    strlen (oldpath) + 1);
-		strcpy (fsck_path, fsck_prefix_path);
-		strcat (fsck_path, ":");
-		strcat (fsck_path, oldpath);
-	} else {
-		fsck_path = xstrdup(fsck_prefix_path);
-	}
-
 	if ((num_devices == 1) || (serialize))
 		interactive = 1;
 
@@ -1632,7 +1550,6 @@ int main(int argc, char *argv[])
 		}
 	}
 	status |= wait_many(FLAG_WAIT_ALL);
-	free(fsck_path);
 	mnt_unref_cache(mntcache);
 	mnt_unref_table(fstab);
 	mnt_unref_table(mtab);
-- 
2.3.5

