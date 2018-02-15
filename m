Return-Path: util-linux-owner@vger.kernel.org
Received: from imap.thunk.org ([74.207.234.97]:48820 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162607AbeBOUFS (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 15 Feb 2018 15:05:18 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: util-linux@vger.kernel.org
Cc: Hornseth_Brenan@bah.com, Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] fsck: use xasprintf to avoid buffer overruns with an insane fs type
Date: Thu, 15 Feb 2018 15:05:08 -0500
Message-Id: <20180215200508.1466-1-tytso@mit.edu>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This prevents a crash when running the command:

fsck -t AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA /dev/sda

Reported-by: Hornseth_Brenan@bah.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 disk-utils/fsck.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index 58fd8ac59..8a07bc272 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -544,20 +544,20 @@ static char *find_fsck(const char *type)
 {
 	char *s;
 	const char *tpl;
-	static char prog[256];
+	static char *prog = NULL;
 	char *p = xstrdup(fsck_path);
 
 	/* Are we looking for a program or just a type? */
 	tpl = (strncmp(type, "fsck.", 5) ? "%s/fsck.%s" : "%s/%s");
 
 	for(s = strtok(p, ":"); s; s = strtok(NULL, ":")) {
-		sprintf(prog, tpl, s, type);
+		xasprintf(&prog, tpl, s, type);
 		if (access(prog, X_OK) == 0)
 			break;
+		free(prog); prog = NULL;
 	}
 	free(p);
-
-	return(s ? prog : NULL);
+	return(prog);
 }
 
 static int progress_active(void)
@@ -885,7 +885,7 @@ static int wait_many(int flags)
  */
 static int fsck_device(struct libmnt_fs *fs, int interactive)
 {
-	char progname[80], *progpath;
+	char *progname, *progpath;
 	const char *type;
 	int retval;
 
@@ -902,9 +902,10 @@ static int fsck_device(struct libmnt_fs *fs, int interactive)
 	else
 		type = DEFAULT_FSTYPE;
 
-	sprintf(progname, "fsck.%s", type);
+	xasprintf(&progname, "fsck.%s", type);
 	progpath = find_fsck(progname);
 	if (progpath == NULL) {
+		free(progname);
 		if (fs_check_required(type)) {
 			retval = ENOENT;
 			goto err;
@@ -914,6 +915,8 @@ static int fsck_device(struct libmnt_fs *fs, int interactive)
 
 	num_running++;
 	retval = execute(progname, progpath, type, fs, interactive);
+	free(progname);
+	free(progpath);
 	if (retval) {
 		num_running--;
 		goto err;
-- 
2.16.1.72.g5be1f00a9a

