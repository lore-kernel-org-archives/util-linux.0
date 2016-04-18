Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43007 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189AbcDRKWl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Apr 2016 06:22:41 -0400
Date: Mon, 18 Apr 2016 12:22:38 +0200
From: Karel Zak <kzak@redhat.com>
To: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: fsck -l: fix racing between unlock/unlink and open
Message-ID: <20160418102238.54gvnoxnsq7z76uv@ws.net.home>
References: <m3bn5lqdvi.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m3bn5lqdvi.fsf@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Apr 08, 2016 at 12:59:29AM +0300, Yuriy M. Kaminskiy wrote:
> Probably, there are better solutions, but I prefer KISS.

> From fcb97ddcbc336bc8860828c47cdaf21c7b1ca655 Mon Sep 17 00:00:00 2001
> From: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
> Date: Fri, 8 Apr 2016 00:38:56 +0300
> Subject: [PATCH] fsck: fix racing between unlock/unlink and open
> 
> Process A	Process B	Process C
> open()
> [creates file]
> lock()
> [succeed]
> 		open()
> 		[open existing]
> 		lock()...
> running()
> close()
> 		[...succeed]
> unlink()
> 		running()
> 				open()
> 				[creates file] {BAD!}
> 				lock()
> 				[succeed] {BAD!}
> 				running() {BAD!}
> 		close()
> 

It would be better to check if the file still exist on the filesystem
with the same inode number, if not then re-open. It means that on race
you will create a new lock file. (You have to unlock after unlink.)
See http://stackoverflow.com/questions/17708885/flock-removing-locked-file-without-race-condition

Simple example:

#include <stdio.h>
#include <sys/file.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>

int main(int argc, char **argv)
{
	const char *lockpath = "test.lock";
	int fd;
	struct stat st_lock, st_file;

	while (1) {
		fd = open(lockpath, O_RDONLY|O_CREAT|O_CLOEXEC,
				    S_IWUSR|S_IRUSR|S_IRGRP|S_IROTH);
		fstat(fd, &st_lock);
		flock(fd, LOCK_EX);

		errno = 0;
		if (stat(lockpath, &st_file) == 0 && st_file.st_ino == st_lock.st_ino)
			break;
		if (errno)
			fprintf(stderr, "%d: stat failed: %m\n", getpid());
		else
			fprintf(stderr, "%d: ignore %lu (fs has:%lu)\n", getpid(), st_lock.st_ino, st_file.st_ino);
		close(fd);
	}

	fprintf(stderr, "%d: -->locked ino: %lu\n", getpid(), st_lock.st_ino);
	sleep(10);
	unlink(lockpath);
	close(fd);
	return 0;
}


See untested fsck patch below. Comments?

    Karel


diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index 05cfbc4..0a7dbc8 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -370,23 +370,38 @@ static void lock_disk(struct fsck_instance *inst)
 	if (verbose)
 		printf(_("Locking disk by %s ... "), inst->lockpath);
 
-	inst->lock = open(inst->lockpath, O_RDONLY|O_CREAT|O_CLOEXEC,
-				    S_IWUSR|S_IRUSR|S_IRGRP|S_IROTH);
-	if (inst->lock >= 0) {
-		int rc = -1;
-
-		/* inform users that we're waiting on the lock */
-		if (verbose &&
-		    (rc = flock(inst->lock, LOCK_EX | LOCK_NB)) != 0 &&
-		    errno == EWOULDBLOCK)
-			printf(_("(waiting) "));
-
-		if (rc != 0 && flock(inst->lock, LOCK_EX) != 0) {
-			close(inst->lock);			/* failed */
-			inst->lock = -1;
+	while (1) {
+		struct stat st_lock, st_file;
+
+		inst->lock = open(inst->lockpath, O_RDONLY|O_CREAT|O_CLOEXEC,
+					    S_IWUSR|S_IRUSR|S_IRGRP|S_IROTH);
+		if (inst->lock >= 0) {
+			int rc = -1;
+
+			/* inform users that we're waiting on the lock */
+			if (verbose &&
+			    (rc = flock(inst->lock, LOCK_EX | LOCK_NB)) != 0 &&
+			    errno == EWOULDBLOCK)
+				printf(_("(waiting) "));
+
+			if (rc != 0 && flock(inst->lock, LOCK_EX) != 0) {
+				close(inst->lock);			/* failed */
+				inst->lock = -1;
+			}
 		}
+
+		/*
+		 * Make sure the locked lockfile really exist on the filesystem
+		 * to avoid race between lock and unlink (see unlock_disk())
+		 */
+		fstat(inst->lock, &st_lock);
+		if (stat(inst->lockpath, &st_file) == 0
+		    && st_file.st_ino == st_lock.st_ino)
+			break;				/* success */
+		close(inst->lock);
 	}
 
+
 	if (verbose)
 		/* TRANSLATORS: These are followups to "Locking disk...". */
 		printf("%s.\n", inst->lock >= 0 ? _("succeeded") : _("failed"));
@@ -409,8 +424,8 @@ static void unlock_disk(struct fsck_instance *inst)
 	if (verbose)
 		printf(_("Unlocking %s.\n"), inst->lockpath);
 
-	close(inst->lock);			/* unlock */
 	unlink(inst->lockpath);
+	close(inst->lock);			/* unlock */
 
 	free(inst->lockpath);
 
 
