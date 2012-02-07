Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56464 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837Ab2BGVKx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Feb 2012 16:10:53 -0500
Received: by yenm8 with SMTP id m8so3273055yen.19
        for <util-linux@vger.kernel.org>; Tue, 07 Feb 2012 13:10:52 -0800 (PST)
Subject: [PATCH 1/4] fsck: Add a -r option to report memory and runtime
 statistics.
From: Frank Mayhar <fmayhar@google.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 07 Feb 2012 13:10:50 -0800
Message-ID: <1328649050.11787.28.camel@peace.lax.corp.google.com>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch adds a "-r" option to report statistics for each fsck run.
It gathers the statistics via wait4() and rusage and reports exit
status, system and user CPU time, elapsed wall-clock time and the max
RSS.

Signed-off-by: Frank Mayhar <fmayhar@google.com>

 fsck/fsck.8 |   12 +++++++++++-
 fsck/fsck.c |   38 +++++++++++++++++++++++++++++++++++++-
 fsck/fsck.h |    2 ++
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/fsck/fsck.8 b/fsck/fsck.8
index d360df1..f77c08e 100644
--- a/fsck/fsck.8
+++ b/fsck/fsck.8
@@ -7,7 +7,7 @@
 fsck \- check and repair a Linux filesystem
 .SH SYNOPSIS
 .B fsck
-.RB [ \-lsAVRTMNP ]
+.RB [ \-lrsAVRTMNP ]
 .RB [ \-C
 .RI [ fd ]]
 .RB [ \-t
@@ -92,6 +92,16 @@ variable.  Please see the filesystem-specific checker
manual pages for
 further details.
 .SH OPTIONS
 .TP
+.B \-r
+Report certain statistics for each fsck when it completes.  These
statistics
+include the exit status, the maximum run set size, the elapsed
wall-clock time
+and the user and system CPU time used by the fsck run.  They are
printed
+as two lines, each with the device path prepended.  For example:
+.br
+\	/dev/hdc1 status 0 maxrss 92828
+.br
+\	/dev/hdc1 user 2.677592 system 0.861868 elapsed 4
+.TP
 .B \-l
 Lock the whole-disk device by an exclusive
 .BR flock (2).
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 7eb5f02..67279f3 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -31,6 +31,7 @@
 #include <sys/wait.h>
 #include <sys/stat.h>
 #include <sys/file.h>
+#include <sys/resource.h>
 #include <fcntl.h>
 #include <limits.h>
 #include <stdio.h>
@@ -133,6 +134,8 @@ struct fsck_instance *instance_list;
 const char fsck_prefix_path[] = FS_SEARCH_PATH;
 char *fsck_path = 0;
 
+int report_stats = 0;
+
 static char *string_copy(const char *s)
 {
 	char	*ret;
@@ -528,6 +531,31 @@ static int progress_active(NOARGS)
 	return 0;
 }
 
+
+/*
+ * Process run statistics for finished fsck instances.
+ *
+ * If report_stats is 0, do nothing, otherwise print a selection of
+ * interesting rusage statistics as well as elapsed wallclock time.
+ */
+static void report_fsck_stats(struct fsck_instance *inst)
+{
+	time_t time_diff;
+
+	if (!inst || !report_stats || noexecute)
+		return;
+	time_diff = inst->end_time - inst->start_time;
+	fprintf(stdout, "%s status %d maxrss %ld\n",
+		inst->fs->device, inst->exit_status, inst->rusage.ru_maxrss);
+	fprintf(stdout, "%s user %d.%06d system %d.%06d elapsed %d\n",
+		inst->fs->device,
+		(int)inst->rusage.ru_utime.tv_sec,
+		(int)inst->rusage.ru_utime.tv_usec,
+		(int)inst->rusage.ru_stime.tv_sec,
+		(int)inst->rusage.ru_stime.tv_usec,
+		(int)time_diff);
+}
+
 /*
  * Execute a particular fsck program, and link it into the list of
  * child processes we are waiting for.
@@ -657,6 +685,7 @@ static struct fsck_instance *wait_one(int flags)
 	int	sig;
 	struct fsck_instance *inst, *inst2, *prev;
 	pid_t	pid;
+	struct rusage rusage;
 
 	if (!instance_list)
 		return NULL;
@@ -681,7 +710,7 @@ static struct fsck_instance *wait_one(int flags)
 	inst = prev = NULL;
 
 	do {
-		pid = waitpid(-1, &status, flags);
+		pid = wait4(-1, &status, flags, &rusage);
 		if (cancel_requested && !kill_sent) {
 			kill_all(SIGTERM);
 			kill_sent++;
@@ -725,6 +754,8 @@ static struct fsck_instance *wait_one(int flags)
 	}
 	inst->exit_status = status;
 	inst->flags |= FLAG_DONE;
+	inst->end_time = time(0);
+	memcpy(&inst->rusage, &rusage, sizeof(struct rusage));
 	if (progress && (inst->flags & FLAG_PROGRESS) &&
 	    !progress_active()) {
 		for (inst2 = instance_list; inst2; inst2 = inst2->next) {
@@ -757,6 +788,7 @@ ret_inst:
 		prev->next = inst->next;
 	else
 		instance_list = inst->next;
+	report_fsck_stats(inst);
 	if (verbose > 1)
 		printf(_("Finished with %s (exit status %d)\n"),
 		       inst->fs->device, inst->exit_status);
@@ -1259,6 +1291,7 @@ static void __attribute__((__noreturn__))
usage(void)
 		"              type is allowed to be comma-separated list\n"
 		" -P         check filesystems in parallel, including root\n"
 		" -s         serialize fsck operations\n"
+		" -r         report statistics for each device fsck\n"
 		" -l         lock the device using flock()\n"
 		" -N         do not execute, just show what would be done\n"
 		" -T         do not show the title on startup\n"
@@ -1401,6 +1434,9 @@ static void PRS(int argc, char *argv[])
 				fstype = string_copy(tmp);
 				compile_fs_type(fstype, &fs_type_compiled);
 				goto next_arg;
+			case 'r':
+				report_stats++;
+				break;
 			case '-':
 				opts_for_fsck++;
 				break;
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 5612b21..c38b41f 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -61,9 +61,11 @@ struct fsck_instance {
 	int	lock;		/* flock()ed whole disk file descriptor or -1 */
 	int	exit_status;
 	time_t	start_time;
+	time_t	end_time;
 	char *	prog;
 	char *	type;
 	struct fs_info *fs;
+	struct rusage rusage;
 	struct fsck_instance *next;
 };
 

-- 
Frank Mayhar
fmayhar@google.com

