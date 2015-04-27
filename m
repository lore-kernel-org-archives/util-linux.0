Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58196 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932196AbbD0JDJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Apr 2015 05:03:09 -0400
Date: Mon, 27 Apr 2015 11:03:06 +0200
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] fsck: drop hardcoded search path
Message-ID: <20150427090306.GN27969@ws.net.home>
References: <1428829613-30423-1-git-send-email-vapier@gentoo.org>
 <1428829613-30423-3-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428829613-30423-3-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 12, 2015 at 05:06:53AM -0400, Mike Frysinger wrote:
>  disk-utils/fsck.8 |  23 +++---------
>  disk-utils/fsck.c | 103 ++++++------------------------------------------------
>  2 files changed, 14 insertions(+), 112 deletions(-)

 I have applied a little bit less invasive patch to keep the current
 semantic with required/optional checkers.

    Karel

>From a03bdbcd2029ed1b002d45a028f6e706845fa566 Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Mon, 27 Apr 2015 10:51:33 +0200
Subject: [PATCH] fsck: use PATH or fallback to /sbin

It's overkill to support all the obscure paths like /sbin/fs.d. We
have PATH for customization, that's enough.

It still seems like a good idea to keep fsck robust, because it's used
by boot scripts/systemd. For this reason fsck fallbacks to "/sbin" if
PATH is undefined or empty.

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 disk-utils/fsck.8 | 25 ++++++-------------------
 disk-utils/fsck.c | 16 ++++------------
 2 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index c60eef2..c2bb7bf 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -80,14 +80,11 @@ In actuality,
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
+filesystem-specific checker is searched for in the
+PATH environment variable. If the PATH is undefined then
+fallback to "/sbin".
+.PP
+Please see the filesystem-specific checker manual pages for
 further details.
 .SH OPTIONS
 .TP
@@ -416,17 +413,7 @@ be run based on gathering accounting data from the operating system.
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
index 817be97..299a775 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -150,9 +150,10 @@ static int kill_sent;
 static char *fstype;
 static struct fsck_instance *instance_list;
 
-static const char fsck_prefix_path[] = FS_SEARCH_PATH;
+#define FSCK_DEFAULT_PATH "/sbin"
 static char *fsck_path;
 
+
 /* parsed fstab and mtab */
 static struct libmnt_table *fstab, *mtab;
 static struct libmnt_cache *mntcache;
@@ -1551,8 +1552,8 @@ int main(int argc, char *argv[])
 {
 	int i, status = 0;
 	int interactive = 0;
-	char *oldpath = getenv("PATH");
 	struct libmnt_fs *fs;
+	const char *path = getenv("PATH");
 
 	setvbuf(stdout, NULL, _IONBF, BUFSIZ);
 	setvbuf(stderr, NULL, _IONBF, BUFSIZ);
@@ -1573,16 +1574,7 @@ int main(int argc, char *argv[])
 
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
+	fsck_path = xstrdup(path && *path ? path : FSCK_DEFAULT_PATH);
 
 	if ((num_devices == 1) || (serialize))
 		interactive = 1;
-- 
2.1.0

