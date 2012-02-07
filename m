Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43366 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756924Ab2BGVK4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Feb 2012 16:10:56 -0500
Received: by iacb35 with SMTP id b35so10626649iac.19
        for <util-linux@vger.kernel.org>; Tue, 07 Feb 2012 13:10:56 -0800 (PST)
Subject: [PATCH 3/4] fsck: Add -O option to force-kill fscks that run too
 long.
From: Frank Mayhar <fmayhar@google.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 07 Feb 2012 13:10:53 -0800
Message-ID: <1328649053.11787.30.camel@peace.lax.corp.google.com>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch adds a "-O" option giving a number of seconds to allow each
fsck to run.  Used to prevent very long-running fscks from keeping the
system out of service for too long.

Signed-off-by: Frank Mayhar <fmayhar@google.com>

 fsck/fsck.8 |   14 +++++-
 fsck/fsck.c |  155
++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 fsck/fsck.h |    6 ++-
 3 files changed, 161 insertions(+), 14 deletions(-)

diff --git a/fsck/fsck.8 b/fsck/fsck.8
index 6253de4..d56b0d7 100644
--- a/fsck/fsck.8
+++ b/fsck/fsck.8
@@ -14,6 +14,8 @@ fsck \- check and repair a Linux filesystem
 .IR fstype ]
 .RB [ \-L
 .IR path ]
+.RB [ \-O
+.RI seconds ]
 .RI [ filesys ...]
 .RB [ \-\- ]
 .RI [ fs-specific-options ]
@@ -70,6 +72,9 @@ Usage or syntax error
 .B 32
 Fsck canceled by user request
 .TP
+.B 64
+Fsck canceled due to timeout
+.TP
 .B 128
 Shared-library error
 .PD
@@ -102,7 +107,7 @@ as two lines, each with the device path prepended.
For example:
 .br
 \	/dev/hdc1 status 0 maxrss 92828
 .br
-\	/dev/hdc1 user 2.677592 system 0.861868 elapsed 4
+\	/dev/hdc1 user 2.677592 system 0.861868 elapsed 4.014111
 .TP
 .B \-l
 Lock the whole-disk device by an exclusive
@@ -296,6 +301,13 @@ for mounted filesystems.
 .B \-N
 Don't execute, just show what would be done.
 .TP
+.BI \-O " seconds"
+Allow each fsck to run for a maximum of
+.IR seconds
+seconds, after which time the fsck is considered to have "timed out"
and is
+killed with SIGKILL.  This can be used to prevent long fscks from
keeping the
+system out of service for an inordinately long time.
+.TP
 .B \-P
 When the
 .B \-A
diff --git a/fsck/fsck.c b/fsck/fsck.c
index e004802..28b7016 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -31,6 +31,7 @@
 #include <sys/wait.h>
 #include <sys/stat.h>
 #include <sys/file.h>
+#include <sys/time.h>
 #include <sys/resource.h>
 #include <fcntl.h>
 #include <limits.h>
@@ -134,6 +135,10 @@ struct fsck_instance *instance_list;
 const char fsck_prefix_path[] = FS_SEARCH_PATH;
 char *fsck_path = 0;
 
+int force_timeout = 0;
+int timeout_secs = 0;
+int timeout_active = 0;
+
 int log_output = 0;
 char *log_path = NULL;
 
@@ -535,6 +540,109 @@ static int progress_active(NOARGS)
 }
 
 /*
+ * Subtract the `struct timeval' value Y from X.
+ * Return 1 if the difference is negative, otherwise 0.
+ */
+static int timeval_diff(struct timeval *result,
+		struct timeval *x, struct timeval *y)
+{
+	/* Perform the carry for the later subtraction by updating y. */
+	if (x->tv_usec < y->tv_usec) {
+		int nsec = (y->tv_usec - x->tv_usec) / 1000000 + 1;
+		y->tv_usec -= 1000000 * nsec;
+		y->tv_sec += nsec;
+	}
+	if (x->tv_usec - y->tv_usec > 1000000) {
+		int nsec = (x->tv_usec - y->tv_usec) / 1000000;
+		y->tv_usec += 1000000 * nsec;
+		y->tv_sec -= nsec;
+	}
+	if (result) {
+		result->tv_sec = x->tv_sec - y->tv_sec;
+		result->tv_usec = x->tv_usec - y->tv_usec;
+	}
+
+	/* Return 1 if result is negative. */
+	return (x->tv_sec < y->tv_sec) ||
+		(x->tv_sec == y->tv_sec && x->tv_usec < y->tv_usec);
+}
+
+/* Forward reference. */
+static void restart_earliest_timeout(NOARGS);
+
+/*
+ * Catch SIGALRM, find any instance(s) that have timed out and SIGKILL
them
+ * to death.  Restarts the timer if necessary.
+ */
+static void catch_timeout(int i)
+{
+	struct timeval now;
+	struct fsck_instance *inst, *prev;
+
+	timeout_active = 0;
+	gettimeofday(&now, NULL);
+	for (prev = 0, inst = instance_list;
+	     inst;
+	     prev = inst, inst = inst->next) {
+		if (inst->end_time.tv_sec >= now.tv_sec) {
+			/* Instance timed out.  Kill it. */
+			inst->flags |= FLAG_TIMEOUT;
+			kill(inst->pid, SIGKILL);
+		}
+	}
+	/* Restart timer if necessary. */
+	restart_earliest_timeout();
+	return;
+}
+
+/*
+ * Set a timer to go off after the passed number of seconds.
+ */
+static void start_timeout(time_t end_time)
+{
+	struct timeval now;
+	static time_t last_end = 0;
+	struct itimerval itv;
+
+	gettimeofday(&now, NULL);
+	/*
+	 * Set the timer only if it's in the future, will expire before
+	 * the one we already set (if any) and no timer is already active.
+	 */
+	if (now.tv_sec < end_time && (end_time < last_end || !timeout_active))
{
+		timeout_active = 1;
+		last_end = end_time;
+		signal(SIGALRM, catch_timeout);
+		itv.it_interval.tv_sec = itv.it_interval.tv_usec = 0;
+		itv.it_value.tv_sec = end_time - now.tv_sec;
+		itv.it_value.tv_usec = 0;
+		setitimer(ITIMER_REAL, &itv, NULL);
+	}
+}
+
+/*
+ * Search the list of instances for the instance with the earliest
unfired
+ * timeout, if any, and set the timer accordingly.
+ */
+static void restart_earliest_timeout(NOARGS)
+{
+	struct timeval now;
+	static time_t min_end = 0x7fffffff;
+	struct fsck_instance *inst, *prev;
+
+	gettimeofday(&now, NULL);
+	for (prev = 0, inst = instance_list;
+	     inst;
+	     prev = inst, inst = inst->next) {
+		if (inst->end_time.tv_sec < min_end &&
+		    inst->end_time.tv_sec > now.tv_sec)
+			min_end = inst->end_time.tv_sec;
+	}
+	if (min_end < 0x7fffffff)
+		start_timeout(min_end);
+}
+
+/*
  * Put together a logfile name from the log path and passed device
string.
  */
 static void setup_logfile(struct fsck_instance *inst, const char
*device)
@@ -583,7 +691,7 @@ static void start_logging(struct fsck_instance
*inst)
 static void report_fsck_stats(struct fsck_instance *inst)
 {
 	FILE *fl = NULL;
-	time_t time_diff;
+	struct timeval time_diff;
 
 	if (!inst || !report_stats || noexecute)
 		return;
@@ -591,16 +699,16 @@ static void report_fsck_stats(struct fsck_instance
*inst)
 		fl = fdopen(inst->log_fd, "a");
 	if (!fl)
 		fl = stdout;
-	time_diff = inst->end_time - inst->start_time;
+	timeval_diff(&time_diff, &inst->end_time, &inst->start_time);
 	fprintf(fl, "%s status %d maxrss %ld\n",
 		inst->fs->device, inst->exit_status, inst->rusage.ru_maxrss);
-	fprintf(fl, "%s user %d.%06d system %d.%06d elapsed %d\n",
+	fprintf(fl, "%s user %d.%06d system %d.%06d elapsed %d.%06d\n",
 		inst->fs->device,
 		(int)inst->rusage.ru_utime.tv_sec,
 		(int)inst->rusage.ru_utime.tv_usec,
 		(int)inst->rusage.ru_stime.tv_sec,
 		(int)inst->rusage.ru_stime.tv_usec,
-		(int)time_diff);
+		(int)time_diff.tv_sec, (int)time_diff.tv_usec);
 	if (fl != stdout)
 		fclose(fl);
 }
@@ -696,7 +804,12 @@ static int execute(const char *type, struct fs_info
*fs, int interactive)
 	inst->pid = pid;
 	inst->prog = string_copy(prog);
 	inst->type = string_copy(type);
-	inst->start_time = time(0);
+	gettimeofday(&inst->start_time, NULL);
+	if (force_timeout) {
+		inst->end_time.tv_sec = inst->start_time.tv_sec + timeout_secs;
+		inst->end_time.tv_usec = inst->start_time.tv_usec;
+		start_timeout(inst->end_time.tv_sec);
+	}
 	inst->next = NULL;
 
 	/*
@@ -796,10 +909,17 @@ static struct fsck_instance *wait_one(int flags)
 		if (sig == SIGINT) {
 			status = EXIT_UNCORRECTED;
 		} else {
-			warnx(_("Warning... %s for device %s exited "
-			       "with signal %d."),
-			       inst->prog, inst->fs->device, sig);
-			status = EXIT_ERROR;
+			if (sig == SIGKILL && (inst->flags & FLAG_TIMEOUT)) {
+				warnx(_("Warning... %s for device %s killed "
+				       "due to timeout.\n"),
+				       inst->prog, inst->fs->device);
+				status = EXIT_TIMEOUT;
+			} else {
+				warnx(_("Warning... %s for device %s exited "
+				       "with signal %d."),
+				       inst->prog, inst->fs->device, sig);
+				status = EXIT_ERROR;
+			}
 		}
 	} else {
 		warnx(_("%s %s: status is %x, should never happen."),
@@ -808,7 +928,7 @@ static struct fsck_instance *wait_one(int flags)
 	}
 	inst->exit_status = status;
 	inst->flags |= FLAG_DONE;
-	inst->end_time = time(0);
+	gettimeofday(&inst->end_time, NULL);
 	memcpy(&inst->rusage, &rusage, sizeof(struct rusage));
 	if (progress && (inst->flags & FLAG_PROGRESS) &&
 	    !progress_active()) {
@@ -825,7 +945,7 @@ static struct fsck_instance *wait_one(int flags)
 			 * bit before sending the kill, to give it
 			 * time to set up the signal handler
 			 */
-			if (inst2->start_time < time(0)+2) {
+			if (inst2->start_time.tv_sec < time(0)+2) {
 				if (fork() == 0) {
 					sleep(1);
 					kill(inst2->pid, SIGUSR1);
@@ -1351,6 +1471,7 @@ static void __attribute__((__noreturn__))
usage(void)
 		" -l         lock the device using flock()\n"
 		" -L <path>  log fsck output for each device to file in <path>\n"
 		" -N         do not execute, just show what would be done\n"
+		" -O <secs>  do not run any fsck for longer than <secs> seconds\n"
 		" -T         do not show the title on startup\n"
 		" -C <fd>    display progress bar; file descriptor is for GUIs\n"
 		" -V         explain what is being done\n"
@@ -1504,6 +1625,18 @@ static void PRS(int argc, char *argv[])
 					usage();
 				log_path = string_copy(tmp);
 				goto next_arg;
+			case 'O':
+				if (force_timeout)
+					usage();
+				force_timeout++;
+				if (arg[j+1])
+					tmp = arg + j + 1;
+				else if ((i+1) < argc)
+					tmp = argv[++i];
+				else
+					usage();
+				timeout_secs = string_to_int(tmp);
+				goto next_arg;
 			case 'r':
 				report_stats++;
 				break;
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 6dfb107..6e41f40 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -30,6 +30,7 @@
 #define EXIT_UNCORRECTED 4
 #define EXIT_ERROR       8
 #define EXIT_USAGE       16
+#define EXIT_TIMEOUT     64
 #define EXIT_LIBRARY     128
 
 /*
@@ -51,6 +52,7 @@ struct fs_info {
 
 #define FLAG_DONE 1
 #define FLAG_PROGRESS 2
+#define FLAG_TIMEOUT 4
 
 /*
  * Structure to allow exit codes to be stored
@@ -60,8 +62,8 @@ struct fsck_instance {
 	int	flags;
 	int	lock;		/* flock()ed whole disk file descriptor or -1 */
 	int	exit_status;
-	time_t	start_time;
-	time_t	end_time;
+	struct timeval	start_time;
+	struct timeval	end_time;
 	char *	prog;
 	char *	type;
 	struct fs_info *fs;

-- 
Frank Mayhar
fmayhar@google.com

