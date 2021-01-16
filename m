Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DF2C433DB
	for <util-linux@archiver.kernel.org>; Sat, 16 Jan 2021 19:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067C323106
	for <util-linux@archiver.kernel.org>; Sat, 16 Jan 2021 19:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbhAPTMP (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 16 Jan 2021 14:12:15 -0500
Received: from foss.arm.com ([217.140.110.172]:58704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbhAPTMO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 16 Jan 2021 14:12:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6002D106F;
        Sat, 16 Jan 2021 11:11:28 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60F0E3F70D;
        Sat, 16 Jan 2021 11:11:27 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     util-linux@vger.kernel.org
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH 2/5] Add uclampset schedutil
Date:   Sat, 16 Jan 2021 19:09:37 +0000
Message-Id: <20210116190940.2320819-3-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210116190940.2320819-1-qais.yousef@arm.com>
References: <20210116190940.2320819-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Utilization clamping is a new kernel feature that got merged in 5.3. It
allows controlling the performance of a process by manipulating the
utilization such that the task appears bigger or smaller than what it
really is.

There's a system-wide control to to restrict what maximum values the
process are allowed to use.

Man page added in a later patch attempts to explain the usage in more
detail.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 .gitignore             |   1 +
 include/sched_attr.h   |  30 ++++
 schedutils/uclampset.c | 378 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 409 insertions(+)
 create mode 100644 schedutils/uclampset.c

diff --git a/.gitignore b/.gitignore
index a6f379146..c01d2f644 100644
--- a/.gitignore
+++ b/.gitignore
@@ -180,3 +180,4 @@ ylwrap
 /wipefs
 /write
 /zramctl
+/uclampset
diff --git a/include/sched_attr.h b/include/sched_attr.h
index b39d37b5d..e8f8173ec 100644
--- a/include/sched_attr.h
+++ b/include/sched_attr.h
@@ -13,6 +13,8 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  *
  * Copyright (C) 2004 Robert Love
+ * Copyright (C) 2020 Qais Yousef
+ * Copyright (C) 2020 Arm Ltd
  */
 #ifndef UTIL_LINUX_SCHED_ATTR_H
 #define UTIL_LINUX_SCHED_ATTR_H
@@ -42,6 +44,30 @@
 # define SCHED_FLAG_RESET_ON_FORK 0x01
 #endif
 
+#if defined(__linux__) && !defined(SCHED_FLAG_RECLAIM)
+# define SCHED_FLAG_RECLAIM 0x02
+#endif
+
+#if defined(__linux__) && !defined(SCHED_FLAG_DL_OVERRUN)
+# define SCHED_FLAG_DL_OVERRUN 0x04
+#endif
+
+#if defined(__linux__) && !defined(SCHED_FLAG_KEEP_POLICY)
+# define SCHED_FLAG_KEEP_POLICY 0x08
+#endif
+
+#if defined(__linux__) && !defined(SCHED_FLAG_KEEP_PARAMS)
+# define SCHED_FLAG_KEEP_PARAMS 0x10
+#endif
+
+#if defined(__linux__) && !defined(SCHED_FLAG_UTIL_CLAMP_MIN)
+# define SCHED_FLAG_UTIL_CLAMP_MIN 0x20
+#endif
+
+#if defined(__linux__) && !defined(SCHED_FLAG_UTIL_CLAMP_MAX)
+# define SCHED_FLAG_UTIL_CLAMP_MAX 0x40
+#endif
+
 #if defined (__linux__)
 # include <sys/syscall.h>
 #endif
@@ -73,6 +99,10 @@ struct sched_attr {
 	uint64_t sched_runtime;
 	uint64_t sched_deadline;
 	uint64_t sched_period;
+
+	/* UTILIZATION CLAMPING */
+	uint32_t sched_util_min;
+	uint32_t sched_util_max;
 };
 
 static int sched_setattr(pid_t pid, const struct sched_attr *attr, unsigned int flags)
diff --git a/schedutils/uclampset.c b/schedutils/uclampset.c
new file mode 100644
index 000000000..d7d5619ad
--- /dev/null
+++ b/schedutils/uclampset.c
@@ -0,0 +1,378 @@
+/*
+ * uclampset.c - change utilization clamping attributes of a task or the system
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ * Copyright (C) 2020 Qais Yousef
+ * Copyright (C) 2020 Arm Ltd
+ */
+
+#include <errno.h>
+#include <getopt.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "closestream.h"
+#include "procutils.h"
+#include "sched_attr.h"
+#include "strutils.h"
+
+#define PROCFS(file)	"/proc/sys/kernel/" #file
+
+#define PROCFS_UCLAMP_MIN	PROCFS(sched_util_clamp_min)
+#define PROCFS_UCLAMP_MAX	PROCFS(sched_util_clamp_max)
+
+#define MAX_OPT		1000
+#define COMM_LEN	64
+#define NOT_SET		-1U
+
+struct uclampset {
+	unsigned int util_min;
+	unsigned int util_max;
+
+	pid_t pid;
+	unsigned int all_tasks;			/* all threads of the PID */
+
+	unsigned int system;
+
+	unsigned int verbose;
+};
+
+static void __attribute__((__noreturn__)) usage(void)
+{
+	FILE *out = stdout;
+
+	fputs(_("Show or change the utilization clamping attributes of a process or the system.\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_("Set util clamp for a process:\n"
+	" uclampset [options] [-m <util_min>] [-M <util_max>] [cmd <arg>...]\n"
+	" uclampset [options] [-m <util_min>] [-M <util_max>] --pid <pid>\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_("Get util clamp for a process:\n"
+	" uclampset [options] -p <pid>\n"), out);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_("Set util clamp for the sytem:\n"
+	" uclampset [options] --system [-m <util_min>] [-M <util_max>]\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_("Get util clamp for the system:\n"
+	" uclampset [options] -s\n"), out);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_("Other options:\n"), out);
+	fputs(_(" -m                   util_min value to set\n"), out);
+	fputs(_(" -M                   util_max value to set\n"), out);
+	fputs(_(" -a, --all-tasks      operate on all the tasks (threads) for a given pid\n"), out);
+	fputs(_(" -p, --pid            operate on existing given pid\n"), out);
+	fputs(_(" -s, --system         operate on system\n"), out);
+	fputs(_(" --max                show min and max valid uclamp values\n"), out);
+	fputs(_(" -v, --verbose        display status information\n"), out);
+
+	fputs(USAGE_SEPARATOR, out);
+	printf(USAGE_HELP_OPTIONS(22));
+
+	printf(USAGE_MAN_TAIL("uclampset(1)"));
+	exit(EXIT_SUCCESS);
+}
+
+static void proc_pid_name(pid_t pid, char *name, int len)
+{
+	char *proc_comm_fmt = "/proc/%d/comm";
+	char proc_comm[COMM_LEN];
+	FILE *fp;
+	int size;
+
+	size = snprintf(proc_comm, COMM_LEN, proc_comm_fmt, pid);
+	if (size >= COMM_LEN || size < 0)
+		goto error;
+
+	fp = fopen(proc_comm, "r");
+	if (!fp)
+		goto error;
+
+	size = fread(name, 1, len, fp);
+	name[size-1] = '\0';
+
+	fclose(fp);
+
+	if (ferror(fp))
+		goto error;
+
+	return;
+error:
+	strncpy(name, "unknown", len);
+}
+
+static void show_uclamp_pid_info(pid_t pid)
+{
+#ifdef HAVE_SCHED_SETATTR
+	struct sched_attr sa;
+	char comm[COMM_LEN];
+
+	/* don't display "pid 0" as that is confusing */
+	if (!pid)
+		pid = getpid();
+
+
+	proc_pid_name(pid, comm, COMM_LEN);
+
+	if (sched_getattr(pid, &sa, sizeof(sa), 0) != 0)
+		err(EXIT_FAILURE, _("failed to get pid %d's uclamp values"), pid);
+
+	printf(_("%s-%d\n\tutil_min: %d\n\tutil_max: %d\n"),
+		  comm, pid, sa.sched_util_min, sa.sched_util_max);
+#else
+	err(EXIT_FAILURE, _("uclamp is not supported on this system"));
+#endif
+}
+
+static unsigned int read_uclamp_sysfs(char *dir)
+{
+	unsigned int size;
+	char buf[16];
+	FILE *fp;
+
+	fp = fopen(dir, "r");
+	if (!fp)
+		err(EXIT_FAILURE, _("cannot open %s"), dir);
+
+	size = fread(buf, 1, sizeof(buf), fp);
+	buf[size-1] = '\0';
+
+	if (ferror(fp)) {
+		fclose(fp);
+		err(EXIT_FAILURE, _("error writing %s"), dir);
+	}
+
+	fclose(fp);
+
+	return strtou32_or_err(buf, _("invalid util clamp value"));
+}
+
+static void write_uclamp_sysfs(char *dir, unsigned int val)
+{
+	unsigned int size;
+	char buf[16];
+	FILE *fp;
+
+	fp = fopen(dir, "w");
+	if (!fp)
+		err(EXIT_FAILURE, _("cannot open %s"), dir);
+
+	size = snprintf(buf, sizeof(buf), "%d", val);
+	buf[size] = '\n';
+	buf[size+1] = '\0';
+	fwrite(buf, 1, sizeof(buf), fp);
+
+	if (ferror(fp)) {
+		fclose(fp);
+		err(EXIT_FAILURE, _("error writing %s"), dir);
+	}
+
+	fclose(fp);
+}
+
+static void show_uclamp_system_info(void)
+{
+	unsigned int min, max;
+
+	min = read_uclamp_sysfs(PROCFS_UCLAMP_MIN);
+	max = read_uclamp_sysfs(PROCFS_UCLAMP_MAX);
+
+	printf(_("System\n\tutil_min: %u\n\tutil_max: %u\n"), min, max);
+}
+
+static void show_uclamp_info(struct uclampset *ctl)
+{
+	if (ctl->system) {
+		show_uclamp_system_info();
+	} else if (ctl->all_tasks) {
+		pid_t tid;
+		struct proc_tasks *ts = proc_open_tasks(ctl->pid);
+
+		if (!ts)
+			err(EXIT_FAILURE, _("cannot obtain the list of tasks"));
+
+		while (!proc_next_tid(ts, &tid))
+			show_uclamp_pid_info(tid);
+
+		proc_close_tasks(ts);
+	} else {
+		show_uclamp_pid_info(ctl->pid);
+	}
+}
+
+static void show_min_max(void)
+{
+	printf(_("util_min and util_max must be in the range of [0:1024] inclusive\n"));
+}
+
+#ifndef HAVE_SCHED_SETATTR
+static int set_uclamp_one(struct uclampset *ctl, pid_t pid)
+{
+	err(EXIT_FAILURE, _("uclamp is not supported on this system"));
+}
+
+#else /* !HAVE_SCHED_SETATTR */
+static int set_uclamp_one(struct uclampset *ctl, pid_t pid)
+{
+	struct sched_attr sa;
+
+	if (sched_getattr(pid, &sa, sizeof(sa), 0) != 0)
+		err(EXIT_FAILURE, _("failed to get pid %d's uclamp values"), pid);
+
+	if (ctl->util_min != NOT_SET)
+		sa.sched_util_min = ctl->util_min;
+	if (ctl->util_max != NOT_SET)
+		sa.sched_util_max = ctl->util_max;
+
+	sa.sched_flags = SCHED_FLAG_KEEP_POLICY |
+			 SCHED_FLAG_KEEP_PARAMS |
+			 SCHED_FLAG_UTIL_CLAMP_MIN |
+			 SCHED_FLAG_UTIL_CLAMP_MAX;
+
+	return sched_setattr(pid, &sa, 0);
+}
+#endif /* HAVE_SCHED_SETATTR */
+
+static void set_uclamp_pid(struct uclampset *ctl)
+{
+	if (ctl->all_tasks) {
+		pid_t tid;
+		struct proc_tasks *ts = proc_open_tasks(ctl->pid);
+
+		if (!ts)
+			err(EXIT_FAILURE, _("cannot obtain the list of tasks"));
+
+		while (!proc_next_tid(ts, &tid))
+			if (set_uclamp_one(ctl, tid) == -1)
+				err(EXIT_FAILURE, _("failed to set tid %d's uclamp values"), tid);
+
+		proc_close_tasks(ts);
+
+	} else if (set_uclamp_one(ctl, ctl->pid) == -1) {
+		err(EXIT_FAILURE, _("failed to set pid %d's uclamp values"), ctl->pid);
+	}
+}
+
+static void set_uclamp_system(struct uclampset *ctl)
+{
+	if (ctl->util_min == NOT_SET)
+		ctl->util_min = read_uclamp_sysfs(PROCFS_UCLAMP_MIN);
+
+	if (ctl->util_max == NOT_SET)
+		ctl->util_max = read_uclamp_sysfs(PROCFS_UCLAMP_MAX);
+
+	if (ctl->util_min > ctl->util_max) {
+		errno = EINVAL;
+		err(EXIT_FAILURE, _("util_min must be <= util_max"));
+	}
+
+	write_uclamp_sysfs(PROCFS_UCLAMP_MIN, ctl->util_min);
+	write_uclamp_sysfs(PROCFS_UCLAMP_MAX, ctl->util_max);
+}
+
+int main(int argc, char **argv)
+{
+	struct uclampset _ctl = {
+		.pid = -1,
+		.util_min = NOT_SET,
+		.util_max = NOT_SET
+	};
+	struct uclampset *ctl = &_ctl;
+	bool no_input;
+	int c;
+
+	static const struct option longopts[] = {
+		{ "all-tasks",  no_argument, NULL, 'a' },
+		{ "pid",	no_argument, NULL, 'p' },
+		{ "system",	no_argument, NULL, 's' },
+		{ "help",	no_argument, NULL, 'h' },
+		{ "max",        no_argument, NULL, MAX_OPT },
+		{ "verbose",	no_argument, NULL, 'v' },
+		{ "version",	no_argument, NULL, 'V' },
+		{ NULL,		no_argument, NULL, 0 }
+	};
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	close_stdout_atexit();
+
+	while((c = getopt_long(argc, argv, "+asphmMvV", longopts, NULL)) != -1)
+	{
+		switch (c) {
+		case 'a':
+			ctl->all_tasks = 1;
+			break;
+		case MAX_OPT:
+			show_min_max();
+			return EXIT_SUCCESS;
+		case 'p':
+			errno = 0;
+			ctl->pid = strtos32_or_err(argv[optind], _("invalid PID argument"));
+			optind++;
+			break;
+		case 's':
+			ctl->system = 1;
+			break;
+		case 'v':
+			ctl->verbose = 1;
+			break;
+		case 'm':
+			ctl->util_min = strtos32_or_err(argv[optind], _("invalid util_min argument"));
+			optind++;
+			break;
+		case 'M':
+			ctl->util_max = strtos32_or_err(argv[optind], _("invalid util_max argument"));
+			optind++;
+			break;
+		case 'V':
+			print_version(EXIT_SUCCESS);
+			/* fallthrough */
+		case 'h':
+			usage();
+		default:
+			errtryhelp(EXIT_FAILURE);
+		}
+	}
+
+	no_input = ctl->util_min == NOT_SET && ctl->util_max == NOT_SET;
+
+	if (no_input) {
+		show_uclamp_info(ctl);
+		return EXIT_SUCCESS;
+	}
+
+	if (ctl->pid == -1)
+		ctl->pid = 0;
+
+	if (ctl->system)
+		set_uclamp_system(ctl);
+	else
+		set_uclamp_pid(ctl);
+
+	if (ctl->verbose)
+		show_uclamp_info(ctl);
+
+	if (!ctl->pid && !ctl->system) {
+		argv += optind;
+		execvp(argv[0], argv);
+		errexec(argv[0]);
+	}
+
+	return EXIT_SUCCESS;
+}
-- 
2.25.1

