Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44670 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837Ab2BGVK4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Feb 2012 16:10:56 -0500
Received: by yhoo21 with SMTP id o21so3295089yho.19
        for <util-linux@vger.kernel.org>; Tue, 07 Feb 2012 13:10:55 -0800 (PST)
Subject: [PATCH 2/4] fsck: Add -L option to capture fsck output and save it.
From: Frank Mayhar <fmayhar@google.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 07 Feb 2012 13:10:52 -0800
Message-ID: <1328649052.11787.29.camel@peace.lax.corp.google.com>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch adds a "-L" option to provide a directory where fsck output
will be captured and saved on a per-device basis.

Signed-off-by: Frank Mayhar <fmayhar@google.com>

 fsck/fsck.8 |   15 ++++++++++++
 fsck/fsck.c |   74
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fsck/fsck.h |    2 +
 3 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/fsck/fsck.8 b/fsck/fsck.8
index f77c08e..6253de4 100644
--- a/fsck/fsck.8
+++ b/fsck/fsck.8
@@ -12,6 +12,8 @@ fsck \- check and repair a Linux filesystem
 .RI [ fd ]]
 .RB [ \-t
 .IR fstype ]
+.RB [ \-L
+.IR path ]
 .RI [ filesys ...]
 .RB [ \-\- ]
 .RI [ fs-specific-options ]
@@ -274,6 +276,19 @@ a progress bar at a time.  GUI front-ends may
specify a file descriptor
 .IR fd ,
 in which case the progress bar information will be sent to that file
descriptor.
 .TP
+.BI \-L " path"
+Log fsck output for each checked device to a file in the directory
indicated by
+.IR path .
+The file will be named for the last component of the associated device
+path, with "fsck-" prepended.  E.g. if the device is
+.IR /dev/hdc1
+and
+.IR path
+is
+.IR /var/log/fsck ,
+fsck output for that device (and only that device) will be logged to
the file
+.IR /var/log/fsck/fsck-hdc1 .
+.TP
 .B \-M
 Do not check mounted filesystems and return an exit code of 0
 for mounted filesystems.
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 67279f3..e004802 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -134,6 +134,9 @@ struct fsck_instance *instance_list;
 const char fsck_prefix_path[] = FS_SEARCH_PATH;
 char *fsck_path = 0;
 
+int log_output = 0;
+char *log_path = NULL;
+
 int report_stats = 0;
 
 static char *string_copy(const char *s)
@@ -531,6 +534,45 @@ static int progress_active(NOARGS)
 	return 0;
 }
 
+/*
+ * Put together a logfile name from the log path and passed device
string.
+ */
+static void setup_logfile(struct fsck_instance *inst, const char
*device)
+{
+	char *cp, *cp2;
+	int fd;
+
+	if (!device || (cp = malloc(strlen(log_path)+strlen(device)+8)) ==
NULL)
+		return;
+	strcpy(cp, log_path);
+	if (log_path[strlen(log_path)] != '/')
+		strcat(cp, "/");
+	strcat(cp, "fsck-");
+	if ((cp2 = strrchr(device, '/')) == NULL)
+		cp2 = (char *)device;
+	else
+		cp2++;
+	strcat(cp, cp2);
+	if ((fd = open(cp, O_CREAT|O_WRONLY|O_TRUNC, 00600)) < 0)
+		return;
+	inst->log_file = cp;
+	inst->log_fd = fd;
+	return;
+}
+
+/*
+ * Redirect stdout and stderr to the log file; called after forking a
new
+ * fsck instance.
+ */
+static void start_logging(struct fsck_instance *inst)
+{
+	if (!log_output || !log_path || !inst->log_file || !inst->log_fd)
+		return;
+	close(1);
+	close(2);
+	dup2(inst->log_fd, 1);
+	dup2(inst->log_fd, 2);
+}
 
 /*
  * Process run statistics for finished fsck instances.
@@ -540,20 +582,27 @@ static int progress_active(NOARGS)
  */
 static void report_fsck_stats(struct fsck_instance *inst)
 {
+	FILE *fl = NULL;
 	time_t time_diff;
 
 	if (!inst || !report_stats || noexecute)
 		return;
+	if (log_output && inst->log_fd)
+		fl = fdopen(inst->log_fd, "a");
+	if (!fl)
+		fl = stdout;
 	time_diff = inst->end_time - inst->start_time;
-	fprintf(stdout, "%s status %d maxrss %ld\n",
+	fprintf(fl, "%s status %d maxrss %ld\n",
 		inst->fs->device, inst->exit_status, inst->rusage.ru_maxrss);
-	fprintf(stdout, "%s user %d.%06d system %d.%06d elapsed %d\n",
+	fprintf(fl, "%s user %d.%06d system %d.%06d elapsed %d\n",
 		inst->fs->device,
 		(int)inst->rusage.ru_utime.tv_sec,
 		(int)inst->rusage.ru_utime.tv_usec,
 		(int)inst->rusage.ru_stime.tv_sec,
 		(int)inst->rusage.ru_stime.tv_usec,
 		(int)time_diff);
+	if (fl != stdout)
+		fclose(fl);
 }
 
 /*
@@ -613,6 +662,10 @@ static int execute(const char *type, struct fs_info
*fs, int interactive)
 		printf("\n");
 	}
 
+	/* Fill this in before the fork. */
+	if (log_output)
+		setup_logfile(inst, fs->device);
+
 
 	inst->fs = fs;
 	inst->lock = -1;
@@ -630,6 +683,7 @@ static int execute(const char *type, struct fs_info
*fs, int interactive)
 	} else if (pid == 0) {
 		if (!interactive)
 			close(0);
+		start_logging(inst);
 		(void) execv(s, argv);
 		perror(argv[0]);
 		free(inst);
@@ -789,6 +843,8 @@ ret_inst:
 	else
 		instance_list = inst->next;
 	report_fsck_stats(inst);
+	if (inst->log_fd)
+		close(inst->log_fd);
 	if (verbose > 1)
 		printf(_("Finished with %s (exit status %d)\n"),
 		       inst->fs->device, inst->exit_status);
@@ -1293,6 +1349,7 @@ static void __attribute__((__noreturn__))
usage(void)
 		" -s         serialize fsck operations\n"
 		" -r         report statistics for each device fsck\n"
 		" -l         lock the device using flock()\n"
+		" -L <path>  log fsck output for each device to file in <path>\n"
 		" -N         do not execute, just show what would be done\n"
 		" -T         do not show the title on startup\n"
 		" -C <fd>    display progress bar; file descriptor is for GUIs\n"
@@ -1434,6 +1491,19 @@ static void PRS(int argc, char *argv[])
 				fstype = string_copy(tmp);
 				compile_fs_type(fstype, &fs_type_compiled);
 				goto next_arg;
+			case 'L':
+				tmp = NULL;
+				if (log_output)
+					usage();
+				log_output++;
+				if (arg[j+1])
+					tmp = arg + j + 1;
+				else if ((i+1) < argc)
+					tmp = argv[++i];
+				else
+					usage();
+				log_path = string_copy(tmp);
+				goto next_arg;
 			case 'r':
 				report_stats++;
 				break;
diff --git a/fsck/fsck.h b/fsck/fsck.h
index c38b41f..6dfb107 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -65,6 +65,8 @@ struct fsck_instance {
 	char *	prog;
 	char *	type;
 	struct fs_info *fs;
+	char *	log_file;
+	int	log_fd;
 	struct rusage rusage;
 	struct fsck_instance *next;
 };

-- 
Frank Mayhar
fmayhar@google.com

