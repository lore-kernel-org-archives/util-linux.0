Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50833 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753241AbbDJIRg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 10 Apr 2015 04:17:36 -0400
Date: Fri, 10 Apr 2015 10:17:33 +0200
From: Karel Zak <kzak@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] unshare: allow persisting mount namespaces
Message-ID: <20150410081733.GM3923@ws.net.home>
References: <1428578536-31603-1-git-send-email-kzak@redhat.com>
 <1428578536-31603-2-git-send-email-kzak@redhat.com>
 <87bnix6xj6.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87bnix6xj6.fsf@x220.int.ebiederm.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 09, 2015 at 12:07:09PM -0500, Eric W. Biederman wrote:
> Your do { } while(0); loop below concerns me.  I think continue and
> break are equivalent in that construct.

Ah.. sorry, stupid copy & past from another code; below is updated
version. Thanks for review.

    Karel


>From d7a3cfb3bcd315620aca136a5811d4bbc5cbe77d Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Thu, 9 Apr 2015 11:48:07 +0200
Subject: [PATCH] unshare: allow persisting mount namespaces

We can create a reference (bind mount) to the new namespace after
unshare(2), but it does not make sense to do it within unshared
namespace. (And if I read kernel fs/namespace.c: do_loopback()
correctly than copy mount bind mounts of /proc/<pid>/ns/mnt between
namespaces is unsupported.)

This patch bypass this problem by fork() where parent continue as
usually (call unshare(2), setup another things, etc.), but child
waits for /proc/[ppid]/ns/mnt inode number change (the ino is
changed after parent's unshare(2)) and then it bind mounts the new
namespaces and exit.

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 sys-utils/unshare.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 4 deletions(-)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 65d3e61..460d149 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -27,6 +27,10 @@
 #include <sys/wait.h>
 #include <sys/mount.h>
 
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
 /* we only need some defines missing in sys/mount.h, no libmount linkage */
 #include <libmount.h>
 
@@ -185,6 +189,43 @@ static int bind_ns_files(pid_t pid)
 	return 0;
 }
 
+static ino_t get_mnt_ino(pid_t pid)
+{
+	struct stat st;
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), "/proc/%u/ns/mnt", (unsigned) pid);
+
+	if (stat(path, &st) != 0)
+		err(EXIT_FAILURE, _("cannot stat %s"), path);
+	return st.st_ino;
+}
+
+static void bind_ns_files_from_child(pid_t *child)
+{
+	pid_t ppid = getpid();
+	ino_t ino = get_mnt_ino(ppid);
+
+	*child = fork();
+
+	switch(*child) {
+	case -1:
+		err(EXIT_FAILURE, _("fork failed"));
+	case 0:	/* child */
+		do {
+			/* wait until parent unshare() */
+			ino_t new_ino = get_mnt_ino(ppid);
+			if (ino != new_ino)
+				break;
+		} while (1);
+		bind_ns_files(ppid);
+		exit(EXIT_SUCCESS);
+		break;
+	default: /* parent */
+		break;
+	}
+}
+
 static void usage(int status)
 {
 	FILE *out = status == EXIT_SUCCESS ? stdout : stderr;
@@ -248,6 +289,8 @@ int main(int argc, char *argv[])
 	int unshare_flags = 0;
 	int c, forkit = 0, maproot = 0;
 	const char *procmnt = NULL;
+	pid_t pid = 0;
+	int status;
 	unsigned long propagation = UNSHARE_PROPAGATION_DEFAULT;
 	uid_t real_euid = geteuid();
 	gid_t real_egid = getegid();;
@@ -316,12 +359,35 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (npersists && (unshare_flags & CLONE_NEWNS))
+		bind_ns_files_from_child(&pid);
+
 	if (-1 == unshare(unshare_flags))
 		err(EXIT_FAILURE, _("unshare failed"));
 
+	if (npersists) {
+		if (pid && (unshare_flags & CLONE_NEWNS)) {
+			/* wait for bind_ns_files_from_child() */
+			int rc;
+
+			do {
+				rc = waitpid(pid, &status, 0);
+				if (rc < 0) {
+					if (errno == EINTR)
+						continue;
+					err(EXIT_FAILURE, _("waitpid failed"));
+				}
+				if (WIFEXITED(status) &&
+				    WEXITSTATUS(status) != EXIT_SUCCESS)
+					return WEXITSTATUS(status);
+			} while (rc < 0);
+		} else
+			/* simple way, just bind */
+			bind_ns_files(getpid());
+	}
+
 	if (forkit) {
-		int status;
-		pid_t pid = fork();
+		pid = fork();
 
 		switch(pid) {
 		case -1:
@@ -339,8 +405,6 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (npersists)
-		bind_ns_files(getpid());
 
 	if (maproot) {
 		if (setgrpcmd == SETGROUPS_ALLOW)
-- 
2.1.0

