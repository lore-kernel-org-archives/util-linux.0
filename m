Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qy0-f181.google.com ([209.85.216.181]:53982 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062Ab1GQSh7 convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Jul 2011 14:37:59 -0400
Received: by qyk9 with SMTP id 9so1499590qyk.19
        for <util-linux@vger.kernel.org>; Sun, 17 Jul 2011 11:37:58 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Sun, 17 Jul 2011 20:37:58 +0200
Message-ID: <CAG27Bk0XXawQERH19+iUguDame2Pts_+bvrt8Of0+ib9KSW3NA@mail.gmail.com>
Subject: [git pull] schedutils
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The following changes since commit 64c9e22aa47ea262f8e01c2aff1d48890d6e4e8b:

  lsblk: add queue request size attribute (2011-07-15 15:41:22 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit schedutils

Sami Kerola (10):
      chrt: data type compiler warning fixed
      chrt: coding style fix
      ionice: add long options
      ionice: coding style fixes
      docs: mention long options in ionice.1
      taskset: include-what-you-use header check
      taskset: coding style fixes
      chrt: change how min/max is expressed
      chrt: add strings to use NLS
      docs: update TODO file

 TODO                 |    2 -
 schedutils/chrt.c    |   55 +++++++++++++++++++++++------------------
 schedutils/ionice.1  |   51 +++++++++++++++++++-------------------
 schedutils/ionice.c  |   66 +++++++++++++++++++++++++++++++------------------
 schedutils/taskset.c |   34 +++++++++++++------------
 5 files changed, 116 insertions(+), 92 deletions(-)

diff --git a/TODO b/TODO
index 6fe25cc..e90c432 100644
--- a/TODO
+++ b/TODO
@@ -192,8 +192,6 @@ misc

  * use TZ=UTC and LANG=en_US.UTF-8 for tests

- * add NLS and err.h stuff to schedutils (chrt.c, taskset.c)
-
  * add mllockall() and SCHED_FIFO to hwclock,
    see http://lkml.org/lkml/2008/10/12/132

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 6c2c6f2..effa302 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -117,7 +117,7 @@ static void show_rt_info(pid_t pid, int isnew)
 		printf("SCHED_FIFO\n");
 		break;
 #ifdef SCHED_RESET_ON_FORK
-	case SCHED_FIFO|SCHED_RESET_ON_FORK:
+	case SCHED_FIFO | SCHED_RESET_ON_FORK:
 		printf("SCHED_FIFO|SCHED_RESET_ON_FORK\n");
 		break;
 #endif
@@ -130,7 +130,7 @@ static void show_rt_info(pid_t pid, int isnew)
 		printf("SCHED_RR\n");
 		break;
 #ifdef SCHED_RESET_ON_FORK
-	case SCHED_RR|SCHED_RESET_ON_FORK:
+	case SCHED_RR | SCHED_RESET_ON_FORK:
 		printf("SCHED_RR|SCHED_RESET_ON_FORK\n");
 		break;
 #endif
@@ -140,7 +140,7 @@ static void show_rt_info(pid_t pid, int isnew)
 		break;
 #endif
 	default:
-		printf(_("unknown\n"));
+		printf(_("unknown scheduling policy\n"));
 	}

 	if (sched_getparam(pid, &sp))
@@ -156,37 +156,45 @@ static void show_rt_info(pid_t pid, int isnew)

 static void show_min_max(void)
 {
-	int i;
-	int policies[] = { SCHED_OTHER, SCHED_FIFO, SCHED_RR,
+	unsigned long i;
+	int policies[] = {
+		SCHED_OTHER,
+		SCHED_FIFO,
+		SCHED_RR,
 #ifdef SCHED_BATCH
-			   SCHED_BATCH,
+		SCHED_BATCH,
 #endif
 #ifdef SCHED_IDLE
-			   SCHED_IDLE,
+		SCHED_IDLE,
 #endif
-			 };
-	const char *names[] = { "OTHER", "FIFO", "RR",
+	};
+	const char *names[] = {
+		"OTHER",
+		"FIFO",
+		"RR",
 #ifdef SCHED_BATCH
-				"BATCH",
+		"BATCH",
 #endif
 #ifdef SCHED_IDLE
-				"IDLE",
+		"IDLE",
 #endif
-			      };
+	};

+	printf(_("policy          : min/max priority\n"
+		 "----------------+-----------------\n"));
 	for (i = 0; i < ARRAY_SIZE(policies); i++) {
 		int max = sched_get_priority_max(policies[i]);
 		int min = sched_get_priority_min(policies[i]);

 		if (max >= 0 && min >= 0)
-			printf(_("SCHED_%s min/max priority\t: %d/%d\n"),
+			printf(_("SCHED_%-10s: %d/%d\n"),
 					names[i], min, max);
 		else
 			printf(_("SCHED_%s not supported?\n"), names[i]);
 	}
 }

-int main(int argc, char *argv[])
+int main(int argc, char **argv)
 {
 	int i, policy = SCHED_RR, priority = 0, verbose = 0, policy_flag = 0,
 	    all_tasks = 0;
@@ -241,7 +249,7 @@ int main(int argc, char *argv[])
 			break;
 		case 'm':
 			show_min_max();
-			return 0;
+			return EXIT_SUCCESS;
 		case 'o':
 			policy = SCHED_OTHER;
 			break;
@@ -257,7 +265,7 @@ int main(int argc, char *argv[])
 			break;
 		case 'V':
 			printf("chrt (%s)\n", PACKAGE_STRING);
-			return 0;
+			return EXIT_SUCCESS;
 		case 'h':
 			ret = EXIT_SUCCESS;
 		default:
@@ -265,7 +273,8 @@ int main(int argc, char *argv[])
 		}
 	}

-	if (((pid > -1) && argc - optind < 1) || ((pid == -1) && argc - optind < 2))
+	if (((pid > -1) && argc - optind < 1) ||
+	    ((pid == -1) && argc - optind < 2))
 		show_usage(EXIT_FAILURE);

 	if ((pid > -1) && (verbose || argc - optind == 1)) {
@@ -274,7 +283,7 @@ int main(int argc, char *argv[])
 			struct proc_tasks *ts = proc_open_tasks(pid);

 			if (!ts)
-				err(EXIT_FAILURE, "cannot obtain the list of tasks");
+				err(EXIT_FAILURE, _("cannot obtain the list of tasks"));
 			while (!proc_next_tid(ts, &tid))
 				show_rt_info(tid, FALSE);
 			proc_close_tasks(ts);
@@ -293,7 +302,7 @@ int main(int argc, char *argv[])
 	if ((policy_flag & SCHED_RESET_ON_FORK) &&
 	    !(policy == SCHED_FIFO || policy == SCHED_RR))
 		errx(EXIT_FAILURE, _("SCHED_RESET_ON_FORK flag is suppoted for "
-				"SCHED_FIFO and SCHED_RR policies only"));
+				     "SCHED_FIFO and SCHED_RR policies only"));
 #endif

 	policy |= policy_flag;
@@ -307,15 +316,13 @@ int main(int argc, char *argv[])
 		struct proc_tasks *ts = proc_open_tasks(pid);

 		if (!ts)
-			err(EXIT_FAILURE, "cannot obtain the list of tasks");
+			err(EXIT_FAILURE, _("cannot obtain the list of tasks"));
 		while (!proc_next_tid(ts, &tid))
 			if (sched_setscheduler(tid, policy, &sp) == -1)
 				err(EXIT_FAILURE, _("failed to set tid %d's policy"), tid);
 		proc_close_tasks(ts);
-	}
-	else
-		if (sched_setscheduler(pid, policy, &sp) == -1)
-			err(EXIT_FAILURE, _("failed to set pid %d's policy"), pid);
+	} else if (sched_setscheduler(pid, policy, &sp) == -1)
+		err(EXIT_FAILURE, _("failed to set pid %d's policy"), pid);

 	if (verbose)
 		show_rt_info(pid, TRUE);
diff --git a/schedutils/ionice.1 b/schedutils/ionice.1
index 8e4e964..ed19fae 100644
--- a/schedutils/ionice.1
+++ b/schedutils/ionice.1
@@ -1,28 +1,17 @@
-.TH ionice "1" "August 2005" ionice
+.TH IONICE "1" "July 2011" "util-linux" "User Commands"
 .SH NAME
-ionice \- get/set program io scheduling class and priority
+ionice \- sets or gets process io scheduling class and priority
 .SH SYNOPSIS
 .B ionice
-.RB [[ \-c
-.IR class ]
-.RB [ \-n
-.IR classdata ]
-.RB [ \-t ]]
-.BI \-p \ PID
-.RI [ PID  ]...
+[OPTION] \fB\-p\fR PID [PID...]
 .br
 .B ionice
-.RB [ \-c
-.IR class ]
-.RB [ \-n
-.IR classdata ]
-.RB [ \-t ]
-.IR COMMAND\  [ ARG  ]...
+[OPTION] COMMAND
 .SH DESCRIPTION
 This program sets or gets the io scheduling class and priority for a program.
 If no arguments or just \fB\-p\fR is given, \fBionice\fR will query the current
 io scheduling class and priority for that process.
-
+.PP
 As of this writing, a process can be in one of three scheduling classes:
 .IP "\fBIdle\fP"
 A program running with idle io priority will only get disk time when no other
@@ -36,17 +25,17 @@ a specific io priority.
 This class takes a priority argument from \fI0-7\fR, with lower
 number being higher priority. Programs running at the same best effort
 priority are served in a round-robin fashion.
-
+.PP
 Note that before kernel 2.6.26 a process that has not asked for an io priority
 formally uses "\fBnone\fP" as scheduling class, but the io scheduler will treat
 such processes as if it were in the best effort class. The priority within the
 best effort class will be dynamically derived from the cpu nice level of the
 process: io_priority = (cpu_nice + 20) / 5.
-
+.PP
 For kernels after 2.6.26 with CFQ io scheduler a process that has not asked for
 an io priority inherits CPU scheduling class.  The io priority is derived from
 the cpu nice level of the process (same as before kernel 2.6.26).
-
+.PP
 .IP "\fBReal time\fP"
 The RT scheduling class is given first access to the disk, regardless of
 what else is going on in the system. Thus the RT class needs to be used with
@@ -55,21 +44,31 @@ some care, as it can starve other processes. As
with the best effort class,
 will receive on each scheduling window. This scheduling class is not
 permitted for an ordinary (i.e., non-root) user.
 .SH OPTIONS
-.IP "\fB-c \fIclass\fP"
+.TP
+\fB\-c\fR, \fB\-\-class\fR=\fINUM\fR
 The scheduling class. \fI0\fR for none, \fI1\fR for real time, \fI2\fR for
 best-effort, \fI3\fR for idle.
-.IP "\fB-n \fIclassdata\fP"
-The scheduling class data. This defines the class data, if the class
-accepts an argument. For real time and best-effort, \fI0-7\fR is valid
-data.
-.IP "\fB-p \fIpid\fP"
+.TP
+\fB\-n\fR, \fB\-\-priority\fR=\fINUM\fR
+The scheduling priority. This defines the priority, if the class accepts an
+argument. For real time and best-effort, arguments \fI0-7\fR are valid. 0 is
+the highest priority level, 7 is the lowest.
+.TP
+\fB\-p\fR, \fB\-\-pid\fR=\fIPID\fR
 Pass in process PID(s) to view or change already running processes.
If this argument
 is not given, \fBionice\fP will run the listed program with the given
 parameters.
-.IP "\fB-t\fP"
+.TP
+\fB\-t\fR, \fB\-\-ignore\fR
 Ignore failure to set requested priority. If COMMAND or PID(s) is
specified, run it
 even in case it was not possible to set desired scheduling priority, what
 can happen due to insufficient privileges or old kernel version.
+.TP
+\fB\-V\fR, \fB\-\-version\fR
+Output version information and exit.
+.TP
+\fB\-h\fR, \fB\-\-help\fR
+Display help and exit.
 .SH EXAMPLES
 .LP
 .TP 7
diff --git a/schedutils/ionice.c b/schedutils/ionice.c
index dc18add..17b735a 100644
--- a/schedutils/ionice.c
+++ b/schedutils/ionice.c
@@ -74,35 +74,52 @@ static void ioprio_setpid(pid_t pid, int ioprio,
int ioclass)
 		err(EXIT_FAILURE, _("ioprio_set failed"));
 }

-static void usage(int rc)
+static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
-	fprintf(stdout, _(
-	"\nionice - sets or gets process io scheduling class and priority.\n"
-	"\nUsage:\n"
-	"  ionice [ options ] -p <pid> [<pid> ...]\n"
-	"  ionice [ options ] <command> [<arg> ...]\n"
-	"\nOptions:\n"
-	"  -n <classdata>      class data (0-7, lower being higher prio)\n"
-	"  -c <class>          scheduling class\n"
-	"                      0: none, 1: realtime, 2: best-effort, 3: idle\n"
-	"  -t                  ignore failures\n"
-	"  -h                  this help\n\n"));
-	exit(rc);
+	fprintf(out,
+	       _("\n"
+		 "%1$s - sets or gets process io scheduling class and priority.\n"
+		 "\n"
+		 "Usage:\n"
+		 "  %1$s [OPTION] -p PID [PID...]\n"
+		 "  %1$s [OPTION] COMMAND\n"
+		 "\n"
+		 "Options:\n"
+		 "  -p, --pid=PID       view or modify already running process\n"
+		 "  -n, --priority=NUM  priority 0 to 7, where 0 is highest priority\n"
+		 "  -c, --class=NUM     scheduling class\n"
+		 "                         0: none, 1: realtime, 2: best-effort, 3: idle\n"
+		 "  -t, --ignore        ignore failures\n"
+		 "  -V, --version       output version information and exit\n"
+		 "  -h, --help          display this help and exit\n\n"),
+		program_invocation_short_name);
+
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }

-int main(int argc, char *argv[])
+int main(int argc, char **argv)
 {
 	int ioprio = 4, set = 0, ioclass = IOPRIO_CLASS_BE, c;
 	pid_t pid = 0;

+	static const struct option longopts[] = {
+		{"pid", required_argument, NULL, 'p'},
+		{"priority", required_argument, NULL, 'n'},
+		{"class", required_argument, NULL, 'c'},
+		{"ignore", no_argument, NULL, 't'},
+		{"version", no_argument, NULL, 'V'},
+		{"help", no_argument, NULL, 'h'},
+		{NULL, 0, NULL, 0}
+	};
+
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);

-	while ((c = getopt(argc, argv, "+n:c:p:th")) != EOF) {
+	while ((c = getopt_long(argc, argv, "+n:c:p:tVh", longopts, NULL)) != EOF)
 		switch (c) {
 		case 'n':
-			ioprio = strtol_or_err(optarg, _("failed to parse class data"));
+			ioprio = strtol_or_err(optarg, _("failed to parse priority"));
 			set |= 1;
 			break;
 		case 'c':
@@ -115,12 +132,15 @@ int main(int argc, char *argv[])
 		case 't':
 			tolerant = 1;
 			break;
+		case 'V':
+			printf(_("%s (%s)\n"),
+				program_invocation_short_name, PACKAGE_STRING);
+			return EXIT_SUCCESS;
 		case 'h':
-			usage(EXIT_SUCCESS);
+			usage(stdout);
 		default:
-			usage(EXIT_FAILURE);
+			usage(stderr);
 		}
-	}

 	switch (ioclass) {
 		case IOPRIO_CLASS_NONE:
@@ -151,13 +171,11 @@ int main(int argc, char *argv[])
 		if (pid) {
 			ioprio_setpid(pid, ioprio, ioclass);

-			for(; argv[optind]; ++optind)
-			{
+			for(; argv[optind]; ++optind) {
 				pid = strtol_or_err(argv[optind], _("failed to parse pid"));
 				ioprio_setpid(pid, ioprio, ioclass);
 			}
-		}
-		else if (argv[optind]) {
+		} else if (argv[optind]) {
 			ioprio_setpid(0, ioprio, ioclass);
 			execvp(argv[optind], &argv[optind]);
 			/* execvp should never return */
@@ -165,5 +183,5 @@ int main(int argc, char *argv[])
 		}
 	}

-	exit(EXIT_SUCCESS);
+	return EXIT_SUCCESS;
 }
diff --git a/schedutils/taskset.c b/schedutils/taskset.c
index 6f0fbc9..a3dcf52 100644
--- a/schedutils/taskset.c
+++ b/schedutils/taskset.c
@@ -24,6 +24,9 @@
 #include <unistd.h>
 #include <getopt.h>
 #include <errno.h>
+#include <sched.h>
+#include <stddef.h>
+#include <string.h>

 #include "cpuset.h"
 #include "nls.h"
@@ -34,13 +37,10 @@

 struct taskset {
 	pid_t		pid;		/* task PID */
-
 	cpu_set_t	*set;		/* task CPU mask */
 	size_t		setsize;
-
 	char		*buf;		/* buffer for conversion from mask to string */
 	size_t		buflen;
-
 	int		use_list:1,	/* use list rather than masks */
 			get_only:1;	/* print the mask, but not modify */
 };
@@ -104,7 +104,7 @@ static void do_taskset(struct taskset *ts, size_t
setsize, cpu_set_t *set)
 	if (ts->pid) {
 		if (sched_getaffinity(ts->pid, ts->setsize, ts->set) < 0)
 			err(EXIT_FAILURE, _("failed to get pid %d's affinity"),
-					ts->pid);
+			    ts->pid);
 		print_affinity(ts, FALSE);
 	}

@@ -113,33 +113,34 @@ static void do_taskset(struct taskset *ts,
size_t setsize, cpu_set_t *set)

 	/* set new mask */
 	if (sched_setaffinity(ts->pid, setsize, set) < 0)
-		err(EXIT_FAILURE, _("failed to set pid %d's affinity"), ts->pid);
+		err(EXIT_FAILURE, _("failed to set pid %d's affinity"),
+		    ts->pid);

 	/* re-read the current mask */
 	if (ts->pid) {
 		if (sched_getaffinity(ts->pid, ts->setsize, ts->set) < 0)
 			err(EXIT_FAILURE, _("failed to get pid %d's affinity"),
-					ts->pid);
+			    ts->pid);
 		print_affinity(ts, TRUE);
 	}
 }

-int main(int argc, char *argv[])
+int main(int argc, char **argv)
 {
 	cpu_set_t *new_set;
 	pid_t pid = 0;
 	int c, all_tasks = 0;
-        unsigned int ncpus;
+	unsigned int ncpus;
 	size_t new_setsize, nbits;
 	struct taskset ts;

 	static const struct option longopts[] = {
-		{ "all-tasks",   0, NULL, 'a' },
+		{ "all-tasks",	0, NULL, 'a' },
 		{ "pid",	0, NULL, 'p' },
 		{ "cpu-list",	0, NULL, 'c' },
 		{ "help",	0, NULL, 'h' },
 		{ "version",	0, NULL, 'V' },
-		{ NULL,		0, NULL, 0 }
+		{ NULL,		0, NULL,  0  }
 	};

 	setlocale(LC_ALL, "");
@@ -154,7 +155,8 @@ int main(int argc, char *argv[])
 			all_tasks = 1;
 			break;
 		case 'p':
-			pid = strtol_or_err(argv[argc - 1], _("failed to parse pid"));
+			pid = strtol_or_err(argv[argc - 1],
+					    _("failed to parse pid"));
 			break;
 		case 'c':
 			ts.use_list = 1;
@@ -172,7 +174,7 @@ int main(int argc, char *argv[])
 	}

 	if ((!pid && argc - optind < 2)
-			|| (pid && (argc - optind < 1 || argc - optind > 2)))
+	    || (pid && (argc - optind < 1 || argc - optind > 2)))
 		usage(stderr);

 	ncpus = get_max_number_of_cpus();
@@ -207,18 +209,18 @@ int main(int argc, char *argv[])
 	else if (ts.use_list) {
 		if (cpulist_parse(argv[optind], new_set, new_setsize))
 			errx(EXIT_FAILURE, _("failed to parse CPU list: %s"),
-					argv[optind]);
+			     argv[optind]);
 	} else if (cpumask_parse(argv[optind], new_set, new_setsize)) {
 		errx(EXIT_FAILURE, _("failed to parse CPU mask: %s"),
-				argv[optind]);
+		     argv[optind]);
 	}

 	if (all_tasks) {
 		struct proc_tasks *tasks = proc_open_tasks(pid);
-                while (!proc_next_tid(tasks, &ts.pid))
+		while (!proc_next_tid(tasks, &ts.pid))
 			do_taskset(&ts, new_setsize, new_set);
 		proc_close_tasks(tasks);
-        } else {
+	} else {
 		ts.pid = pid;
 		do_taskset(&ts, new_setsize, new_set);
 	}

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
