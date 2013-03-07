Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f182.google.com ([209.85.212.182]:63166 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758218Ab3CGX1p (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 7 Mar 2013 18:27:45 -0500
Received: by mail-wi0-f182.google.com with SMTP id hi18so644930wib.9
        for <util-linux@vger.kernel.org>; Thu, 07 Mar 2013 15:27:43 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 6/7] kill, procs: use pid_t for pids
Date: Thu,  7 Mar 2013 23:27:23 +0000
Message-Id: <1362698844-21292-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1362698844-21292-1-git-send-email-kerolasa@iki.fi>
References: <1362698844-21292-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reference: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/threads.h#n30
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/kill.c  |  6 +++---
 misc-utils/kill.h  |  2 +-
 misc-utils/procs.c | 17 ++++++++---------
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index b0145cd..742f349 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -156,7 +156,7 @@ int main(int argc, char **argv)
 	int errors, numsig, pid;
 	char *ep, *arg;
 	int do_pid, do_kill, check_all;
-	int *pids, *ip;
+	pid_t *pids, *ip;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -414,12 +414,12 @@ static int usage(int status)
 	return status;
 }
 
-static int kill_verbose(char *procname, int pid, int sig)
+static int kill_verbose(char *procname, pid_t pid, int sig)
 {
 	int rc;
 
 	if (sig < 0) {
-		printf("%d\n", pid);
+		printf("%ld\n", (long)pid);
 		return 0;
 	}
 #ifdef HAVE_SIGQUEUE
diff --git a/misc-utils/kill.h b/misc-utils/kill.h
index 43c6ed7..fb02994 100644
--- a/misc-utils/kill.h
+++ b/misc-utils/kill.h
@@ -1,7 +1,7 @@
 #ifndef UTIL_LINUX_KILL
 #define UTIL_LINUX_KILL
 
-extern int *get_pids(char *process_name, int get_all);
+extern pid_t *get_pids(char *process_name, int get_all);
 extern char *mybasename(char *);
 
 #endif
diff --git a/misc-utils/procs.c b/misc-utils/procs.c
index 544966e..c4cb06e 100644
--- a/misc-utils/procs.c
+++ b/misc-utils/procs.c
@@ -25,16 +25,16 @@
 
 static char *parse_parens(char *buf);
 
-int *get_pids(char *process_name, int get_all)
+pid_t *get_pids(char *process_name, int get_all)
 {
 	DIR *dir;
 	struct dirent *ent;
 	int status;
-	char *dname, fname[100], *cp, buf[256];
+	char fname[100], *cp, buf[256], *end;
 	struct stat st;
 	uid_t uid;
 	FILE *fp;
-	int pid, *pids, num_pids, pids_size;
+	pid_t pid, *pids, num_pids, pids_size;
 
 	dir = opendir("/proc");
 	if (!dir) {
@@ -46,11 +46,10 @@ int *get_pids(char *process_name, int get_all)
 	num_pids = pids_size = 0;
 
 	while ((ent = readdir(dir)) != NULL) {
-		dname = ent->d_name;
-		if (!isdigit(*dname))
+		pid = strtol(ent->d_name, &end, 10);
+		if (errno || ent->d_name == end || (end && *end))
 			continue;
-		pid = atoi(dname);
-		sprintf(fname, "/proc/%d/cmdline", pid);
+		sprintf(fname, "/proc/%ld/cmdline", (long)pid);
 		/* get the process owner */
 		status = stat(fname, &st);
 		if (status != 0)
@@ -66,7 +65,7 @@ int *get_pids(char *process_name, int get_all)
 		/* an empty command line means the process is swapped out */
 		if (!cp || !*cp) {
 			/* get the process name from the statfile */
-			sprintf(fname, "/proc/%d/stat", pid);
+			sprintf(fname, "/proc/%ld/stat", (long)pid);
 			fp = fopen(fname, "r");
 			if (!fp)
 				continue;
@@ -83,7 +82,7 @@ int *get_pids(char *process_name, int get_all)
 			continue;
 		while (pids_size < num_pids + 2) {
 			pids_size += 5;
-			pids = (int *)xrealloc(pids, sizeof(int) * pids_size);
+			pids = xrealloc(pids, sizeof(pid_t) * pids_size);
 		}
 		if (pids) {
 			pids[num_pids++] = pid;
-- 
1.8.1.5

