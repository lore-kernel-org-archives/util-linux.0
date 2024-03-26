Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57171F944
	for <util-linux@vger.kernel.org>; Tue, 26 Mar 2024 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475968; cv=none; b=L5jnn1nPmz4vMBA+gzlzmALfoPKRw/QnMNF7seacyYqvs1KLfmlCJ8FBvifB6uPDBZ7HVpz8LuJ2DNUv3Gel3zhOGZJxc0jbAqvZpsRIB0MqT0/pflUpdv5FOp67YWzom32+cKQB7VS0BFpMq6cDRe8nfxw1tbbhyQf8po4F6wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475968; c=relaxed/simple;
	bh=JWu5EzETQTlw8Wbv1u/GxEdUSLjerclQlwSSMjZ9hGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsEpg7D3X69Q6F6zwFkkPhIZkNxWhfEMqMXY6XckIxUoSXcjzBpdgk8EqgCzvYjcfTx+Z0O9JtNeSfj+rZ61aI1v23dKVHnknAs5TKYtBlmCqjqTT90Egx+/5ZXgVSWF3RXzg2ui2BIg4aO/+SOVP7uQxLuZUsjD0EM8kzmLtJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raymakers.nl; spf=pass smtp.mailfrom=raymakers.nl; dkim=pass (2048-bit key) header.d=raymakers.nl header.i=@raymakers.nl header.b=DmVV1t7r; arc=none smtp.client-ip=185.233.34.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raymakers.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raymakers.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raymakers.nl header.i=@raymakers.nl header.b="DmVV1t7r"
Received: from smtp.soverin.net (c04cst-smtp-sov02.int.sover.in [10.10.4.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4V3y3d5tKhz7K;
	Tue, 26 Mar 2024 17:49:17 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.100]) by soverin.net (Postfix) with ESMTPSA id 4V3y3c30qNzHS;
	Tue, 26 Mar 2024 17:49:16 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=raymakers.nl header.i=@raymakers.nl header.a=rsa-sha256 header.s=soverin1 header.b=DmVV1t7r;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raymakers.nl;
	s=soverin1; t=1711475357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l5C9zKwYgmBpJEl3g+deO5AS+yXbPscpvWmGzkvFJRU=;
	b=DmVV1t7r2MrpcqrkoYp6ooD7zrat6g838LAyD07RuteEt4tIrpr2vt7CKanxJKZC/Yv2GB
	dI71WU2U8vkW8qHobyjcOw9yF8oqqXZv9/ttRHRQr1ejddifxjA2cHWgtwU66ispWVzmcc
	5G4MkgEmZieGJaJBgZ8OAHUBJavlO9ea22LSYKeu3iywYpCAJeh3gDvD3Khm/crm+bsZXx
	FhrEIBCY0ID3fla43q0DaMGRppgqEy7PVPsirGASoP/3qJ6tT4Y3wjRd43FZ+Cc7NFqnVr
	HSXy3pmtm4tPrrzKayQf6vyF9bvSUtHY3teQx2NLkiuELo78SHr7pkcmzn5w/A==
From: Thijs Raymakers <thijs@raymakers.nl>
To: pauld@redhat.com
Cc: kzak@redhat.com,
	util-linux@vger.kernel.org,
	Thijs Raymakers <thijs@raymakers.nl>
Subject: [PATCH 1/1] coresched: Manage core scheduling cookies for tasks
Date: Tue, 26 Mar 2024 18:49:08 +0100
Message-ID: <20240326174909.117426-2-thijs@raymakers.nl>
In-Reply-To: <20240326144129.GA315070@lorien.usersys.redhat.com>
References: <20240326144129.GA315070@lorien.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Thijs Raymakers <thijs@raymakers.nl>
---
 .gitignore                  |   1 +
 bash-completion/coresched   |   0
 configure.ac                |  12 +-
 meson.build                 |  16 +-
 meson_options.txt           |   2 +-
 schedutils/Makemodule.am    |   8 +
 schedutils/coresched.1.adoc |  16 ++
 schedutils/coresched.c      | 353 ++++++++++++++++++++++++++++++++++++
 8 files changed, 402 insertions(+), 6 deletions(-)
 create mode 100644 bash-completion/coresched
 create mode 100644 schedutils/coresched.1.adoc
 create mode 100644 schedutils/coresched.c

diff --git a/.gitignore b/.gitignore
index 6ecbfa7fe..316f3cdcc 100644
--- a/.gitignore
+++ b/.gitignore
@@ -94,6 +94,7 @@ ylwrap
 /colcrt
 /colrm
 /column
+/coresched
 /ctrlaltdel
 /delpart
 /dmesg
diff --git a/bash-completion/coresched b/bash-completion/coresched
new file mode 100644
index 000000000..e69de29bb
diff --git a/configure.ac b/configure.ac
index ab7c98636..3a189a075 100644
--- a/configure.ac
+++ b/configure.ac
@@ -2500,9 +2500,9 @@ UL_REQUIRES_HAVE([setterm], [ncursesw, ncurses], [ncursesw or ncurses library])
 AM_CONDITIONAL([BUILD_SETTERM], [test "x$build_setterm" = xyes])
 
 # build_schedutils= is just configure-only variable to control
-# ionice, taskset and chrt
+# ionice, taskset, coresched and chrt
 AC_ARG_ENABLE([schedutils],
-  AS_HELP_STRING([--disable-schedutils], [do not build chrt, ionice, taskset]),
+  AS_HELP_STRING([--disable-schedutils], [do not build chrt, ionice, taskset, coresched]),
   [], [UL_DEFAULT_ENABLE([schedutils], [check])]
 )
 
@@ -2545,6 +2545,14 @@ UL_REQUIRES_SYSCALL_CHECK([taskset],
 AM_CONDITIONAL([BUILD_TASKSET], [test "x$build_taskset" = xyes])
 
 
+UL_ENABLE_ALIAS([coresched], [schedutils])
+UL_BUILD_INIT([coresched])
+UL_REQUIRES_SYSCALL_CHECK([coresched],
+	[UL_CHECK_SYSCALL([prctl])],
+	[prctl])
+AM_CONDITIONAL([BUILD_CORESCHED], [test "x$build_coresched" = xyes])
+
+
 have_schedsetter=no
 AS_IF([test "x$ac_cv_func_sched_setscheduler" = xyes], [have_schedsetter=yes],
       [test "x$ac_cv_func_sched_setattr" = xyes], [have_schedsetter=yes])
diff --git a/meson.build b/meson.build
index 9600ce49f..9a2c04e8f 100644
--- a/meson.build
+++ b/meson.build
@@ -3111,13 +3111,23 @@ exe4 = executable(
   install : opt,
   build_by_default : opt)
 
+exe5 = executable(
+  'coresched',
+  'schedutils/coresched.c',
+  include_directories : includes,
+  link_with : lib_common,
+  install_dir : usrbin_exec_dir,
+  install : opt,
+  build_by_default : opt)
+
 if opt and not is_disabler(exe)
-  exes += [exe, exe2, exe3, exe4]
+  exes += [exe, exe2, exe3, exe4, exe5]
   manadocs += ['schedutils/chrt.1.adoc',
                'schedutils/ionice.1.adoc',
                'schedutils/taskset.1.adoc',
-	       'schedutils/uclampset.1.adoc']
-  bashcompletions += ['chrt', 'ionice', 'taskset', 'uclampset']
+	       'schedutils/uclampset.1.adoc',
+         'schedutils/coresched.1.adoc']
+  bashcompletions += ['chrt', 'ionice', 'taskset', 'uclampset', 'coresched']
 endif
 
 ############################################################
diff --git a/meson_options.txt b/meson_options.txt
index 7b8cf3f35..3405c1b73 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -162,7 +162,7 @@ option('build-pipesz', type : 'feature',
 option('build-setterm', type : 'feature',
        description : 'build setterm')
 option('build-schedutils', type : 'feature',
-       description : 'build chrt, ionice, taskset')
+       description : 'build chrt, ionice, taskset, coresched')
 option('build-wall', type : 'feature',
        description : 'build wall')
 option('build-write', type : 'feature',
diff --git a/schedutils/Makemodule.am b/schedutils/Makemodule.am
index 1040da85f..0cb655401 100644
--- a/schedutils/Makemodule.am
+++ b/schedutils/Makemodule.am
@@ -29,3 +29,11 @@ dist_noinst_DATA += schedutils/uclampset.1.adoc
 uclampset_SOURCES = schedutils/uclampset.c schedutils/sched_attr.h
 uclampset_LDADD = $(LDADD) libcommon.la
 endif
+
+if BUILD_CORESCHED
+usrbin_exec_PROGRAMS += coresched
+MANPAGES += schedutils/coresched.1
+dist_noinst_DATA += schedutils/coresched.1.adoc
+coresched_SOURCES = schedutils/coresched.c
+coresched_LDADD = $(LDADD) libcommon.la
+endif
diff --git a/schedutils/coresched.1.adoc b/schedutils/coresched.1.adoc
new file mode 100644
index 000000000..60a21cd01
--- /dev/null
+++ b/schedutils/coresched.1.adoc
@@ -0,0 +1,16 @@
+//po4a: entry man manual
+////
+coresched(1) manpage
+////
+= coresched(1)
+:doctype: manpage
+:man manual: User Commands
+:man source: util-linux {release-version}
+:page-layout: base
+:command: coresched
+:colon: :
+:copyright: ©
+
+== NAME
+
+coresched - manage core scheduling cookies for tasks
diff --git a/schedutils/coresched.c b/schedutils/coresched.c
new file mode 100644
index 000000000..17d775f2d
--- /dev/null
+++ b/schedutils/coresched.c
@@ -0,0 +1,353 @@
+/**
+ * SPDX-License-Identifier: EUPL-1.2
+ *
+ * coresched.c - manage core scheduling cookies for tasks
+ *
+ * Copyright (C) 2024 Thijs Raymakers
+ * Licensed under the EUPL v1.2
+ */
+
+#include <getopt.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+
+#include "c.h"
+#include "closestream.h"
+#include "nls.h"
+#include "strutils.h"
+
+// These definitions might not be defined, even if the
+// prctl interface accepts them.
+#ifndef PR_SCHED_CORE_SCOPE_THREAD
+#define PR_SCHED_CORE_SCOPE_THREAD 0
+#endif
+#ifndef PR_SCHED_CORE_SCOPE_THREAD_GROUP
+#define PR_SCHED_CORE_SCOPE_THREAD_GROUP 1
+#endif
+#ifndef PR_SCHED_CORE_SCOPE_PROCESS_GROUP
+#define PR_SCHED_CORE_SCOPE_PROCESS_GROUP 2
+#endif
+
+typedef int core_sched_type_t;
+typedef enum {
+	SCHED_CORE_CMD_EXEC = 0,
+	SCHED_CORE_CMD_GET = 1,
+	SCHED_CORE_CMD_CREATE = 2,
+	SCHED_CORE_CMD_COPY = 4,
+} core_sched_cmd_t;
+
+struct args {
+	pid_t from_pid;
+	pid_t to_pid;
+	core_sched_type_t type;
+	core_sched_cmd_t cmd;
+	int exec_argv_offset;
+};
+
+unsigned long core_sched_get_cookie(struct args *args);
+void core_sched_create_cookie(struct args *args);
+void core_sched_pull_cookie(pid_t from);
+void core_sched_push_cookie(pid_t to, core_sched_type_t type);
+void core_sched_copy_cookie(struct args *args);
+void core_sched_exec_with_cookie(struct args *args, char **argv);
+
+core_sched_type_t parse_core_sched_type(char *str);
+bool verify_arguments(struct args *args);
+void parse_arguments(int argc, char **argv, struct args *args);
+void set_pid_or_err(pid_t *dest, pid_t src, const char *err_msg);
+static void __attribute__((__noreturn__)) usage(void);
+
+unsigned long core_sched_get_cookie(struct args *args)
+{
+	unsigned long cookie = 0;
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, args->from_pid,
+		  PR_SCHED_CORE_SCOPE_THREAD, &cookie)) {
+		err(errno, "Failed to get cookie from PID %d", args->from_pid);
+	}
+	return cookie;
+}
+
+void core_sched_create_cookie(struct args *args)
+{
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, args->to_pid, args->type,
+		  0)) {
+		err(errno, "Failed to create cookie for PID %d",
+		    args->from_pid);
+	}
+}
+
+void core_sched_pull_cookie(pid_t from)
+{
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, from,
+		  PR_SCHED_CORE_SCOPE_THREAD, 0)) {
+		err(errno, "Failed to pull cookie from PID %d", from);
+	}
+}
+
+void core_sched_push_cookie(pid_t to, core_sched_type_t type)
+{
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, to, type, 0)) {
+		err(errno, "Failed to push cookie to PID %d", to);
+	}
+}
+
+void core_sched_copy_cookie(struct args *args)
+{
+	core_sched_pull_cookie(args->from_pid);
+	core_sched_push_cookie(args->to_pid, args->type);
+}
+
+void core_sched_exec_with_cookie(struct args *args, char **argv)
+{
+	if (!args->exec_argv_offset) {
+		usage();
+	}
+
+	// Move the argument list to the first argument of the program
+	argv = &argv[args->exec_argv_offset];
+
+	// If a source PID is provided, try to copy the cookie from
+	// that PID. Otherwise, create a brand new cookie with the
+	// provided type.
+	if (args->from_pid) {
+		core_sched_pull_cookie(args->from_pid);
+	} else {
+		args->to_pid = getpid();
+		core_sched_create_cookie(args);
+	}
+
+	if (execvp(argv[0], argv)) {
+		errexec(argv[0]);
+	}
+}
+
+core_sched_type_t parse_core_sched_type(char *str)
+{
+	if (!strncmp(str, "pid\0", 4)) {
+		return PR_SCHED_CORE_SCOPE_THREAD;
+	} else if (!strncmp(str, "tgid\0", 5)) {
+		return PR_SCHED_CORE_SCOPE_THREAD_GROUP;
+	} else if (!strncmp(str, "pgid\0", 5)) {
+		return PR_SCHED_CORE_SCOPE_PROCESS_GROUP;
+	}
+
+	errx(EINVAL, "'%s' is an invalid option. Must be one of pid/tgid/pgid",
+	     str);
+	__builtin_unreachable();
+}
+
+static void __attribute__((__noreturn__)) usage(void)
+{
+	fputs(USAGE_HEADER, stdout);
+	fprintf(stdout, _(" %s --get <PID>\n"), program_invocation_short_name);
+	fprintf(stdout, _(" %s --new <PID> [-t <TYPE>]\n"),
+		program_invocation_short_name);
+	fprintf(stdout, _(" %s --copy -s <PID> -d <PID> [-t <TYPE>]\n"),
+		program_invocation_short_name);
+	fprintf(stdout, _(" %s [-s <PID>] -- PROGRAM ARGS... \n"),
+		program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, stdout);
+	fputsln(_("Manage core scheduling cookies for tasks."), stdout);
+
+	fputs(USAGE_FUNCTIONS, stdout);
+	fputsln(_(" -g, --get <PID>         get the core scheduling cookie of a PID"),
+		stdout);
+	fputsln(_(" -n, --new <PID>         assign a new core scheduling cookie to PID"),
+		stdout);
+	fputsln(_(" -c, --copy              copy the core scheduling cookie from PID to\n"
+		  "                           another PID, requires the --source and --dest option"),
+		stdout);
+
+	fputs(USAGE_OPTIONS, stdout);
+	fputsln(_(" -s, --source <PID>      where to copy the core scheduling cookie from."),
+		stdout);
+	fputsln(_(" -d, --dest <PID>        where to copy the core scheduling cookie to."),
+		stdout);
+	fputsln(_(" -t, --type              type of the destination PID, or the type of\n"
+		  "                           the PID when a new core scheduling cookie\n"
+		  "                           is created. Can be one of the following:\n"
+		  "                           pid, tgid or pgid. Defaults to tgid."),
+		stdout);
+	fputs(USAGE_SEPARATOR, stdout);
+	fprintf(stdout,
+		USAGE_HELP_OPTIONS(
+			25)); /* char offset to align option descriptions */
+	fprintf(stdout, USAGE_MAN_TAIL("coresched(1)"));
+	exit(EXIT_SUCCESS);
+}
+
+bool verify_arguments(struct args *args)
+{
+	// Check if the value of args->cmd is a power of 2
+	// In that case, only a single function option was set.
+	if (args->cmd & (args->cmd - 1)) {
+		errx(EINVAL,
+		     "Cannot do more than one function at a time. See %s --help",
+		     program_invocation_short_name);
+	}
+
+	switch (args->cmd) {
+	case SCHED_CORE_CMD_GET:
+		if (args->to_pid) {
+			errx(EINVAL,
+			     "Cannot use -d/--dest with this -g/--get. See %s --help",
+			     program_invocation_short_name);
+		}
+		break;
+	case SCHED_CORE_CMD_CREATE:
+		if (args->from_pid) {
+			errx(EINVAL,
+			     "Cannot use -s/--source with this -n/--new. See %s --help",
+			     program_invocation_short_name);
+		}
+		break;
+	case SCHED_CORE_CMD_COPY:
+		if (!args->from_pid) {
+			errx(EINVAL,
+			     "-s/--source PID is required when copying");
+		}
+		if (!args->to_pid) {
+			errx(EINVAL, "-d/--dest PID is required when copying");
+		}
+		break;
+	case SCHED_CORE_CMD_EXEC:
+		if (args->to_pid) {
+			errx(EINVAL,
+			     "Cannot use -d/--dest when spawning a program. See %s --help",
+			     program_invocation_short_name);
+		}
+		break;
+	}
+	return true;
+}
+
+void set_pid_or_err(pid_t *dest, pid_t src, const char *err_msg)
+{
+	if (*dest) {
+		errx(EINVAL, "Ambigious usage: %s", err_msg);
+	} else {
+		*dest = src;
+	}
+}
+
+static const char *ERR_MSG_MULTIPLE_SOURCE_PIDS =
+	"Multiple source PIDs defined";
+void parse_arguments(int argc, char **argv, struct args *args)
+{
+	int c;
+	pid_t tmp;
+
+	static const struct option longopts[] = {
+		{ "get", required_argument, NULL, 'g' },
+		{ "new", required_argument, NULL, 'n' },
+		{ "copy", no_argument, NULL, 'c' },
+		{ "source", required_argument, NULL, 's' },
+		{ "destination", required_argument, NULL, 'd' },
+		{ "type", required_argument, NULL, 't' },
+		{ "version", no_argument, NULL, 'V' },
+		{ "help", no_argument, NULL, 'h' },
+		{ NULL, 0, NULL, 0 }
+	};
+
+	while ((c = getopt_long(argc, argv, "g:n:cs:d:t:Vh", longopts, NULL)) !=
+	       -1)
+		switch (c) {
+		case 'g':
+			args->cmd |= SCHED_CORE_CMD_GET;
+			tmp = strtopid_or_err(
+				optarg, "Failed to parse PID for -g/--get");
+			set_pid_or_err(&args->from_pid, tmp,
+				       ERR_MSG_MULTIPLE_SOURCE_PIDS);
+			break;
+		case 'n':
+			args->cmd |= SCHED_CORE_CMD_CREATE;
+			tmp = strtopid_or_err(
+				optarg, "Failed to parse PID for -n/--new");
+			set_pid_or_err(&args->to_pid, tmp,
+				       ERR_MSG_MULTIPLE_SOURCE_PIDS);
+			break;
+		case 'c':
+			args->cmd |= SCHED_CORE_CMD_COPY;
+			break;
+		case 's':
+			tmp = strtopid_or_err(
+				optarg, "Failed to parse PID for -s/--source");
+			set_pid_or_err(&args->from_pid, tmp,
+				       ERR_MSG_MULTIPLE_SOURCE_PIDS);
+			break;
+		case 'd':
+			tmp = strtopid_or_err(
+				optarg, "Failed to parse PID for -d/--dest");
+			set_pid_or_err(&args->to_pid, tmp,
+				       "Multiple destination PIDs defined");
+			break;
+		case 't':
+			args->type = parse_core_sched_type(optarg);
+			break;
+		case 'V':
+			print_version(EXIT_SUCCESS);
+		case 'h':
+			usage();
+		default:
+			errtryhelp(EXIT_FAILURE);
+		}
+
+	if (argc > optind) {
+		if (args->cmd == SCHED_CORE_CMD_EXEC) {
+			args->exec_argv_offset = optind;
+		} else {
+			// -g, -n or -c AND a program to run is provided
+			errx(EINVAL, "bad usage, see %s --help",
+			     program_invocation_short_name);
+		}
+	} else if (argc == optind && args->from_pid) {
+		// Neither a function (-g, -n, or -c), nor a program to
+		// run is given
+		args->cmd = SCHED_CORE_CMD_GET;
+	}
+
+	verify_arguments(args);
+}
+
+int main(int argc, char **argv)
+{
+	struct args arguments = { 0 };
+	arguments.type = PR_SCHED_CORE_SCOPE_THREAD_GROUP;
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	close_stdout_atexit();
+
+	parse_arguments(argc, argv, &arguments);
+
+	unsigned long cookie = 0;
+	switch (arguments.cmd) {
+	case SCHED_CORE_CMD_GET:
+		cookie = core_sched_get_cookie(&arguments);
+		if (cookie) {
+			printf("core scheduling cookie of pid %d is 0x%lx\n",
+			       arguments.from_pid, cookie);
+		} else {
+			printf("pid %d doesn't have a core scheduling cookie\n",
+			       arguments.from_pid);
+			exit(1);
+		}
+		break;
+	case SCHED_CORE_CMD_CREATE:
+		core_sched_create_cookie(&arguments);
+		break;
+	case SCHED_CORE_CMD_COPY:
+		core_sched_copy_cookie(&arguments);
+		break;
+	case SCHED_CORE_CMD_EXEC:
+		core_sched_exec_with_cookie(&arguments, argv);
+		break;
+	default:
+		usage();
+		exit(1);
+	}
+}
-- 
2.44.0

