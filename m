Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f169.google.com ([74.125.82.169]:35751 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249Ab3CPXkl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Mar 2013 19:40:41 -0400
Received: by mail-we0-f169.google.com with SMTP id t11so4036401wey.0
        for <util-linux@vger.kernel.org>; Sat, 16 Mar 2013 16:40:39 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 7/7] whereis: remove duplicates from search results
Date: Sat, 16 Mar 2013 23:40:19 +0000
Message-Id: <1363477219-29245-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1363477219-29245-1-git-send-email-kerolasa@iki.fi>
References: <1363477219-29245-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Now when the whereis will not have search directory duplicates, and it
finds real path for symlinked files in paths it is time to remove search
result duplicates.

Addresses: https://bugzilla.redhat.com/show_bug.cgi?id=835211
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/whereis.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index 5136eff..0e333e1 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -173,6 +173,28 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
+static int is_same_file(char *file, struct is_here *filelist)
+{
+	struct stat statbuf;
+	struct is_here *prev = NULL;
+
+	if (stat(file, &statbuf))
+		return 1;
+	while (filelist) {
+		if (filelist->st_ino == statbuf.st_ino &&
+		    filelist->st_dev == statbuf.st_dev)
+			return 1;
+		prev = filelist;
+		filelist = filelist->next;
+	}
+	assert(prev);
+	filelist = xcalloc(1, sizeof(struct is_here));
+	filelist->st_ino = statbuf.st_ino;
+	filelist->st_dev = statbuf.st_dev;
+	prev->next = filelist;
+	return 0;
+}
+
 static int itsit(char *cp, char *dp)
 {
 	int i = strlen(dp);
@@ -201,7 +223,7 @@ static int itsit(char *cp, char *dp)
 	return 0;
 }
 
-static void findin(char *dir, char *cp, int *nr_found, char **wait)
+static void findin(char *dir, char *cp, int *nr_found, char **wait, struct is_here *filelist)
 {
 	DIR *dirp;
 	struct dirent *dp;
@@ -213,6 +235,8 @@ static void findin(char *dir, char *cp, int *nr_found, char **wait)
 	while ((dp = readdir(dirp)) != NULL)
 		if (itsit(cp, dp->d_name)) {
 			xasprintf(&full_path, "%s/%s", dir, dp->d_name);
+			if (is_same_file(full_path, filelist))
+				continue;
 			rl = canonicalize_path(full_path);
 			free(full_path);
 			if (*(nr_found) == 0)
@@ -376,16 +400,19 @@ static void lookup(char *argv, struct is_here *dirlist, int flags)
 {
 	int nr_found;
 	char *wait = NULL;
+	struct is_here *filelist;
 
 	nr_found = uflag == 1 ? 0 : 1;
+	filelist = xcalloc(1, sizeof(struct is_here));
 
 	for (; dirlist; dirlist = dirlist->next) {
 		if (check_type(dirlist->type, flags))
 			continue;
 		if (dirlist->path != NULL)
-			findin(dirlist->path, argv, &nr_found, &wait);
+			findin(dirlist->path, argv, &nr_found, &wait, filelist);
 	}
 	free(wait);
+	free_dirs(filelist, ALL_DIRS);
 	if (1 < nr_found)
 		putchar('\n');
 	return;
-- 
1.8.2

