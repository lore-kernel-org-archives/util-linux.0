Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:48507 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbbDLJHE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 12 Apr 2015 05:07:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 7C2DA340992
	for <util-linux@vger.kernel.org>; Sun, 12 Apr 2015 09:06:58 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/3] mkfs: drop hardcoded search path
Date: Sun, 12 Apr 2015 05:06:51 -0400
Message-Id: <1428829613-30423-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Rather than maintain a hardcoded search path for looking up tools and
override the user's PATH env setting, respect whatever the user has.
This matches the convention of just about every other tool out there.

It might break on systems that don't have /sbin in their PATH and they
try to run /sbin/mkfs directly, but so be it.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 disk-utils/mkfs.8 | 16 ++--------------
 disk-utils/mkfs.c | 17 +----------------
 2 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/disk-utils/mkfs.8 b/disk-utils/mkfs.8
index 9a5cdc0..0279260 100644
--- a/disk-utils/mkfs.8
+++ b/disk-utils/mkfs.8
@@ -29,20 +29,8 @@ In actuality,
 is simply a front-end for the various filesystem builders
 (\fBmkfs.\fIfstype\fR)
 available under Linux.
-The filesystem-specific builder is searched for in a number
-of directories, like perhaps
-.IR /sbin ,
-.IR /sbin/fs ,
-.IR /sbin/fs.d ,
-.IR /etc/fs ,
-.I /etc
-(the precise list is defined at compile time but at least
-contains
-.I /sbin
-and
-.IR /sbin/fs ),
-and finally in the directories
-listed in the PATH environment variable.
+The filesystem-specific builder is searched for via your PATH
+environment setting only.
 Please see the filesystem-specific builder manual pages for
 further details.
 .SH OPTIONS
diff --git a/disk-utils/mkfs.c b/disk-utils/mkfs.c
index 08c4ef0..cf1a312 100644
--- a/disk-utils/mkfs.c
+++ b/disk-utils/mkfs.c
@@ -38,10 +38,6 @@
 #define DEFAULT_FSTYPE	"ext2"
 #endif
 
-#define SEARCH_PATH	"PATH=" FS_SEARCH_PATH
-#define PROGNAME	"mkfs.%s"
-
-
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
@@ -78,7 +74,6 @@ int main(int argc, char **argv)
 	char *progname;		/* name of executable to be called */
 	char *fstype = NULL;
 	int i, more = 0, verbose = 0;
-	char *oldpath, *newpath;
 
 	enum { VERSION_OPTION = CHAR_MAX + 1 };
 
@@ -126,17 +121,7 @@ int main(int argc, char **argv)
 	if (fstype == NULL)
 		fstype = DEFAULT_FSTYPE;
 
-	/* Set PATH and program name */
-	oldpath = getenv("PATH");
-	if (!oldpath)
-		oldpath = "/bin";
-
-	newpath = xmalloc(strlen(oldpath) + sizeof(SEARCH_PATH) + 3);
-	sprintf(newpath, "%s:%s\n", SEARCH_PATH, oldpath);
-	putenv(newpath);
-
-	progname = xmalloc(sizeof(PROGNAME) + strlen(fstype) + 1);
-	sprintf(progname, PROGNAME, fstype);
+	xasprintf(&progname, "mkfs.%s", fstype);
 	argv[--optind] = progname;
 
 	if (verbose) {
-- 
2.3.5

