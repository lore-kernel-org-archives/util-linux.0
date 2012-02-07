Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56464 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756928Ab2BGVK6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Feb 2012 16:10:58 -0500
Received: by mail-yx0-f174.google.com with SMTP id m8so3273055yen.19
        for <util-linux@vger.kernel.org>; Tue, 07 Feb 2012 13:10:58 -0800 (PST)
Subject: [PATCH 4/4] fsck: Add support for "completion" scripts.
From: Frank Mayhar <fmayhar@google.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 07 Feb 2012 13:10:55 -0800
Message-ID: <1328649055.11787.31.camel@peace.lax.corp.google.com>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add support for scripts that are run when each individual fsck
completes.  This allows certain general or file- or device-specific
actions to be taken when each fsck finishes.

Signed-off-by: Frank Mayhar <fmayhar@google.com>

 fsck/fsck.8 |   60
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fsck/fsck.c |   62
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fsck/fsck.h |    4 ++-
 3 files changed, 125 insertions(+), 1 deletions(-)

diff --git a/fsck/fsck.8 b/fsck/fsck.8
index d56b0d7..7e5b55b 100644
--- a/fsck/fsck.8
+++ b/fsck/fsck.8
@@ -413,6 +413,60 @@ and
 do not support the
 .B -y
 option as of this writing.
+.SH COMPLETION SCRIPTS
+.B fsck
+has a mechanism available by which to run a script when each check
completes.
+If when
+.B fsck
+starts the directory
+.IR /etc/fsck.d
+(or see FSCK_COMPLETION_PATH below) exists and is readable,
+.B fsck
+will use it to find such scripts.  Scripts there must be named one of
+.IR /etc/fsck.d/device/name ", " /etc/fsck.d/fstype/name ,
+or
+.IR /etc/fsck.d/completion ,
+where
+.I name
+is either the last component of the device path (e.g.
+.IR /etc/fsck.d/device/hda1 )
+or a file system type (e.g.
+.IR /etc/fsck.d/fstype/ext4 ).
+.PP
+When a file system check completes,
+.B fsck
+looks for a script that corresponds to the device that was checked; if
such
+a script is not found it looks for a script that corresponds to the
+type of that file system.  If neither of those is found it looks for a
+script named
+.IR /etc/fsck.d/completion .
+When
+.B fsck
+finds such a script and if the script is executable (and the
+.B \-N
+option was not specified), it runs the script via the
+.I system(3)
+function, passing the following set of parameters on the command line:
+.br
+\	device\	\-\ Device path of the device checked
+.br
+\	type\	\	\-\ File system type
+.br
+\	status\	\-\ Exit status
+.br
+\	elapsed\	\-\ Elapsed wall-clock time
+.br
+\	utime\	\-\ User CPU time
+.br
+\	stime\	\-\ System CPU time
+.br
+\	maxrss\	\-\ Maximum run-set-size
+.br
+\	logpath\	\-\ Path to logfile if the \-L option was specified
+.PP
+For example:
+.br
+  /etc/fsck.d/device/hdc1 /dev/hdc1 ext4 0 1.60470 0.41193 0.76588 9828
 .SH AUTHOR
 .UR tytso\@mit.edu
 Theodore Ts'o
@@ -429,6 +483,12 @@ The
 .B fsck
 program's behavior is affected by the following environment variables:
 .TP
+.B FSCK_COMPLETION_PATH
+If this environment variable is set,
+.B fsck
+will look for completion scripts in the indicated directory rather than
in
+.IR /etc/fsck.d .
+.TP
 .B FSCK_FORCE_ALL_PARALLEL
 If this environment variable is set,
 .B fsck
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 28b7016..58c7183 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -135,6 +135,8 @@ struct fsck_instance *instance_list;
 const char fsck_prefix_path[] = FS_SEARCH_PATH;
 char *fsck_path = 0;
 
+char *completion_path = COMPLETION_PATH;
+
 int force_timeout = 0;
 int timeout_secs = 0;
 int timeout_active = 0;
@@ -567,6 +569,59 @@ static int timeval_diff(struct timeval *result,
 		(x->tv_sec == y->tv_sec && x->tv_usec < y->tv_usec);
 }
 
+/*
+ * Choose and run a completion script for the completed fsck instance
+ * Prefer device match, then file system type, then generic script.
+ */
+static void run_completion(struct fsck_instance *inst)
+{
+	char *cmd, *cp, *devc;
+	struct timeval time_diff;
+
+	/*
+	 * If we're not actually doing fsck or we don't have a completion
+	 * path, don't run completions.
+	 */
+	if (noexecute || !completion_path)
+		return;
+	if ((devc = strrchr(inst->fs->device, '/')) == NULL)
+		devc = inst->fs->device;
+	else
+		devc++;
+	if ((cmd = malloc(1024)) == NULL)
+		return;
+	cp = cmd;
+	cp += sprintf(cmd, "%s/device/%s", completion_path, devc);
+	if (access(cmd, R_OK|X_OK) < 0) {
+		cp = cmd;
+		cp += sprintf(cmd, "%s/fstype/%s", completion_path, inst->fs->type);
+		if (access(cmd, R_OK|X_OK) < 0) {
+			cp = cmd;
+			cp += sprintf(cmd, "%s/completion", completion_path);
+			if (access(cmd, R_OK|X_OK) < 0) {
+				free(cmd);
+				return;
+			}
+		}
+	}
+	cp += sprintf(cp, " %s", inst->fs->device);
+	cp += sprintf(cp, " %s", inst->fs->type);
+	cp += sprintf(cp, " %d", inst->exit_status);
+	timeval_diff(&time_diff, &inst->end_time, &inst->start_time);
+	cp += sprintf(cp, " %d.%06d", (int)time_diff.tv_sec,
+			(int)time_diff.tv_usec);
+	cp += sprintf(cp, " %d.%06d", (int)inst->rusage.ru_utime.tv_sec,
+			(int)inst->rusage.ru_utime.tv_usec);
+	cp += sprintf(cp, " %d.%06d", (int)inst->rusage.ru_stime.tv_sec,
+			(int)inst->rusage.ru_stime.tv_usec);
+	cp += sprintf(cp, " %ld", inst->rusage.ru_maxrss);
+	if (log_output)
+		cp += sprintf(cp, " %s", inst->log_file);
+	if (system(cmd) < 0)
+		perror(cmd);
+	free(cmd);
+}
+
 /* Forward reference. */
 static void restart_earliest_timeout(NOARGS);
 
@@ -962,6 +1017,7 @@ ret_inst:
 		prev->next = inst->next;
 	else
 		instance_list = inst->next;
+	run_completion(inst);
 	report_fsck_stats(inst);
 	if (inst->log_fd)
 		close(inst->log_fd);
@@ -1694,6 +1750,12 @@ int main(int argc, char *argv[])
 		fstab = _PATH_MNTTAB;
 	load_fs_info(fstab);
 
+	completion_path = getenv("FSCK_COMPLETION_PATH");
+	if (!completion_path)
+		completion_path = COMPLETION_PATH;
+	if (access(completion_path, R_OK|X_OK) < 0)
+		completion_path = NULL;
+
 	/* Update our search path to include uncommon directories. */
 	if (oldpath) {
 		fsck_path = xmalloc (strlen (fsck_prefix_path) + 1 +
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 6e41f40..93356bc 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -33,8 +33,10 @@
 #define EXIT_TIMEOUT     64
 #define EXIT_LIBRARY     128
 
+#define COMPLETION_PATH	"/etc/fsck.d/"
+
 /*
- * Internal structure for mount tabel entries.
+ * Internal structure for mount table entries.
  */
 
 struct fs_info {

-- 
Frank Mayhar
fmayhar@google.com

