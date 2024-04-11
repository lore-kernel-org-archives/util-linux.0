Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55291474A8
	for <util-linux@vger.kernel.org>; Thu, 11 Apr 2024 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833389; cv=none; b=Z+yvtYBY8EWILnFSzblDgcL3nnO8aoi/cSvhD4MqPxbF0PwrKPYi6mnhJUNSHVKnwne8SkN9q3wkeiiXk3epwzc2hP5j1mnk0iuikPc6nKDFeZXMxbJ5ybzyDCyUcXbo0jPpX1kfy3ONZFnd6znRgN64n0adNzEplQYBIG5uuUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833389; c=relaxed/simple;
	bh=V6y6khSM6cLiAyBpCV0Mp09leYjE4wbVnrjjmSwP/RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8mcFK2jh9sOh3NXtGB1VJ0sWnZXMsFCv/3q1CdgteFljB7SlRFJL56FsWp6biUvPyrqLRmJ3hdchJLtkRZ8YEbFWhjjkININXfUy2jskV400qw9U1Q3p0xdbxUBXm0+yBd9o9u/WZTfJqwMEPxMETP8vnrgROIdAL2QEuAxwIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raymakers.nl; spf=pass smtp.mailfrom=raymakers.nl; dkim=pass (2048-bit key) header.d=raymakers.nl header.i=@raymakers.nl header.b=F/+Ei1KE; arc=none smtp.client-ip=185.233.34.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raymakers.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raymakers.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raymakers.nl header.i=@raymakers.nl header.b="F/+Ei1KE"
Received: from smtp.soverin.net (c04cst-smtp-sov02.int.sover.in [10.10.4.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4VFcHM0q0DzKP;
	Thu, 11 Apr 2024 11:02:55 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.100]) by soverin.net (Postfix) with ESMTPSA id 4VFcHL4QBLzC8;
	Thu, 11 Apr 2024 11:02:54 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=raymakers.nl header.i=@raymakers.nl header.a=rsa-sha256 header.s=soverin1 header.b=F/+Ei1KE;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raymakers.nl;
	s=soverin1; t=1712833374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwAgsD8DtC2gPeV2CpEEMBT2Mf6UBjkF+iXr5mIob9k=;
	b=F/+Ei1KED1tFLX2436ITdaydZV8WpjvSPIfQ+mRRQf8fUo9JQ4b311C4N/rxbrLNFNNQ2D
	X0b7gbtK+REFBuL6APqSOkCN8OMTmKgfal1OIBdLmPv2HxpaVMT7phkghIiCiYPlq1pdZQ
	f94tEr/r4n/r9EWvspSaDPTmxXJ4Y4WypsgI1t605BkWrVP5ZuQr3107Wc+uk0LbdLNEy9
	hKL7DcLWShl6JwOF4C5bkurKR4nuYM6bqVQ9x7QVRcxC95etk5crmjZ2RnlLae+KqjWo+H
	R/aloMtyevcBcWELX3xw9HaW3l7dyR3LLP6fBpw+KYVC8XOUhd4CCqKLYyyjOw==
From: Thijs Raymakers <thijs@raymakers.nl>
To: pauld@redhat.com
Cc: kzak@redhat.com,
	thomas@t-8ch.de,
	util-linux@vger.kernel.org
Subject: [PATCH v8] coresched: Manage core scheduling cookies for tasks
Date: Thu, 11 Apr 2024 13:02:49 +0200
Message-ID: <20240411110250.292512-1-thijs@raymakers.nl>
In-Reply-To: <20240410221539.GA408244@lorien.usersys.redhat.com>
References: <20240410221539.GA408244@lorien.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Co-authored-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Thijs Raymakers <thijs@raymakers.nl>

---

Hi Phil,

That might have been a bit too drastic from my side. I just wanted to
make sure that I didn't accidentally attribute something to you that you
didn't fully support, since the arguments of this version differ
significantly from what we've previously discussed. I've put you back.

Thijs

Interdiff against v7:
  diff --git a/schedutils/coresched.1.adoc b/schedutils/coresched.1.adoc
  index 00f2603e0..aa228b84f 100644
  --- a/schedutils/coresched.1.adoc
  +++ b/schedutils/coresched.1.adoc
  @@ -113,11 +113,12 @@ If a _command_ is being executed, the return value of *{command}* will be the re
   This can be enabled via the *CONFIG_SCHED_CORE* kernel config option.
   
   == AUTHORS
  -mailto:thijs@raymakers.nl[Thijs Raymakers]
  +mailto:thijs@raymakers.nl[Thijs Raymakers],
  +mailto:pauld@redhat.com[Phil Auld]
   
   == COPYRIGHT
   
  -Copyright {copyright} 2024 Thijs Raymakers. This is free software licensed under the EUPL.
  +Copyright {copyright} 2024 Thijs Raymakers and Phil Auld. This is free software licensed under the EUPL.
   
   == SEE ALSO
   *chrt*(1),
  diff --git a/schedutils/coresched.c b/schedutils/coresched.c
  index 7e3cc46d2..bb97cc020 100644
  --- a/schedutils/coresched.c
  +++ b/schedutils/coresched.c
  @@ -3,7 +3,7 @@
    *
    * coresched.c - manage core scheduling cookies for tasks
    *
  - * Copyright (C) 2024 Thijs Raymakers
  + * Copyright (C) 2024 Thijs Raymakers, Phil Auld
    * Licensed under the EUPL v1.2
    */
   

 .gitignore                                    |   1 +
 bash-completion/coresched                     |   0
 configure.ac                                  |  12 +-
 meson.build                                   |  16 +-
 meson_options.txt                             |   2 +-
 schedutils/Makemodule.am                      |   8 +
 schedutils/coresched.1.adoc                   | 139 +++++++
 schedutils/coresched.c                        | 358 ++++++++++++++++++
 tests/commands.sh                             |   1 +
 .../coresched-copy-from-child-to-parent       |   1 +
 ...coresched-copy-from-parent-to-nested-child |   1 +
 .../schedutils/coresched-get-cookie-own-pid   |   1 +
 .../coresched-get-cookie-parent-pid           |   1 +
 .../coresched-new-child-with-new-cookie       |   1 +
 .../coresched-set-cookie-parent-pid.err       |   1 +
 .../expected/schedutils/set-cookie-parent-pid |   1 +
 tests/ts/schedutils/coresched                 |  83 ++++
 17 files changed, 621 insertions(+), 6 deletions(-)
 create mode 100644 bash-completion/coresched
 create mode 100644 schedutils/coresched.1.adoc
 create mode 100644 schedutils/coresched.c
 create mode 100644 tests/expected/schedutils/coresched-copy-from-child-to-parent
 create mode 100644 tests/expected/schedutils/coresched-copy-from-parent-to-nested-child
 create mode 100644 tests/expected/schedutils/coresched-get-cookie-own-pid
 create mode 100644 tests/expected/schedutils/coresched-get-cookie-parent-pid
 create mode 100644 tests/expected/schedutils/coresched-new-child-with-new-cookie
 create mode 100644 tests/expected/schedutils/coresched-set-cookie-parent-pid.err
 create mode 100644 tests/expected/schedutils/set-cookie-parent-pid
 create mode 100755 tests/ts/schedutils/coresched

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
index 9600ce49f..a3a648753 100644
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
+               'schedutils/uclampset.1.adoc',
+               'schedutils/coresched.1.adoc']
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
index 000000000..aa228b84f
--- /dev/null
+++ b/schedutils/coresched.1.adoc
@@ -0,0 +1,139 @@
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
+
+== SYNOPSIS
+
+*{command}* [*get*] [*-s* _pid_]
+
+*{command}* *new* [*-t* _type_] *-d* _pid_
+
+*{command}* *new* [*-t* _type_] \-- _command_ [_argument_...]
+
+*{command}* *copy* [*-s* _pid_] [*-t* _type_] *-d* _pid_
+
+*{command}* *copy* [*-s* _pid_] [*-t* _type_] \-- _command_ [_argument_...]
+
+== DESCRIPTION
+The *{command}* command is used to retrieve or modify the core scheduling cookies of a running process given its _pid_, or to spawn a new _command_ with core scheduling cookies.
+
+Core scheduling allows you to define groups of tasks that are allowed to share a physical core.
+This is done by assigning a cookie to each task.
+Only tasks have the same cookie are allowed to be scheduled on the same physical core.
+
+It is possible to either assign a new random cookie to a task, or copy a cookie from another task. It is not possible to choose the value of the cookie.
+
+== FUNCTIONS
+*get*::
+Retrieve the core scheduling cookie of the PID specified in *-s*.
+If *-s* is omitted, it will get the cookie of the current *{command}* process.
+
+*new*::
+Assign a new cookie to an existing PID specified in *-d*, or execute _command_ with a new cookie.
+
+*copy*::
+Copy the cookie from an existing PID (*-s*) to another PID (*-d*), or execute _command_ with that cookie.
+If *-s* is omitted, it will get the cookie of the current *{command}* process.
+
+If no function is specified, it will run the *get* function.
+
+== OPTIONS
+*-s*, *--source* _PID_::
+Which _PID_ to get the cookie from.
+If this option is omitted, it will get the cookie from the current *{command}* process.
+
+*-d*, *--dest* _PID_::
+Which _PID_ to modify the cookie of.
+
+*-t*, *--dest-type* _TYPE_::
+The type of the PID whose cookie will be modified. This can be one of three values:
+- *pid*, or process ID
+- *tgid*, or thread group ID (default value)
+- *pgid*, or process group ID
+
+*-v*, *--verbose*::
+Show extra information when modifying cookies of tasks.
+
+*-h*, *--help*::
+Display help text and exit.
+
+*-V*, *--version*::
+Print version and exit.
+
+== EXAMPLES
+Get the core scheduling cookie of the {command} task itself, usually inherited from its parent{colon}::
+*{command} get*
+
+Get the core scheduling cookie of a task with PID _123_{colon}::
+*{command} get -s* _123_
+
+Give a task with PID _123_ a new core scheduling cookie{colon}::
+*{command} new -d* _123_
+
+Spawn a new task with a new core scheduling cookie{colon}::
+*{command} new* \-- _command_ [_argument_...]
+
+Copy the cookie from the current {command} process another task with pid _456_{colon}::
+*{command} copy -d* _456_
+
+Copy the cookie from a task with pid _123_ to another task with pid _456_{colon}::
+*{command} copy -s* _123_ *-d* _456_
+
+Copy the cookie from a task with pid _123_ to a new task _command_{colon}::
+*{command} copy -s* _123_ \-- _command_ [_argument_...]
+
+Copy the cookie from a task with pid _123_ to the process group ID _456_{colon}::
+*{command} copy -s* _123_ *-t* _pgid_ *-d* _456_
+
+== PERMISSIONS
+When retrieving or modifying the core scheduling cookie of a process, you need to have *PTRACE_MODE_READ_REALCREDS* ptrace access to that process.
+See the section "Ptrace access mode checking" in *ptrace*(2) for more information.
+
+== RETURN VALUE
+On success, *{command}* returns 0.
+If *{command}* fails, it will print an error and return 1.
+
+If a _command_ is being executed, the return value of *{command}* will be the return value of _command_.
+
+== NOTES
+*{command}* requires core scheduling support in the kernel.
+This can be enabled via the *CONFIG_SCHED_CORE* kernel config option.
+
+== AUTHORS
+mailto:thijs@raymakers.nl[Thijs Raymakers],
+mailto:pauld@redhat.com[Phil Auld]
+
+== COPYRIGHT
+
+Copyright {copyright} 2024 Thijs Raymakers and Phil Auld. This is free software licensed under the EUPL.
+
+== SEE ALSO
+*chrt*(1),
+*nice*(1),
+*renice*(1),
+*taskset*(1),
+*ptrace*(2),
+*sched*(7)
+
+The Linux kernel source files _Documentation/admin-guide/hw-vuln/core-scheduling.rst_
+
+include::man-common/bugreports.adoc[]
+
+include::man-common/footer.adoc[]
+
+ifdef::translation[]
+include::man-common/translation.adoc[]
+endif::[]
diff --git a/schedutils/coresched.c b/schedutils/coresched.c
new file mode 100644
index 000000000..bb97cc020
--- /dev/null
+++ b/schedutils/coresched.c
@@ -0,0 +1,358 @@
+/**
+ * SPDX-License-Identifier: EUPL-1.2
+ *
+ * coresched.c - manage core scheduling cookies for tasks
+ *
+ * Copyright (C) 2024 Thijs Raymakers, Phil Auld
+ * Licensed under the EUPL v1.2
+ */
+
+#include <getopt.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <sys/prctl.h>
+#include <unistd.h>
+
+#include "c.h"
+#include "closestream.h"
+#include "nls.h"
+#include "strutils.h"
+
+// These definitions might not be defined in the header files, even if the
+// prctl interface in the kernel accepts them as valid.
+#ifndef PR_SCHED_CORE
+	#define PR_SCHED_CORE 62
+#endif
+#ifndef PR_SCHED_CORE_GET
+	#define PR_SCHED_CORE_GET 0
+#endif
+#ifndef PR_SCHED_CORE_CREATE
+	#define PR_SCHED_CORE_CREATE 1
+#endif
+#ifndef PR_SCHED_CORE_SHARE_TO
+	#define PR_SCHED_CORE_SHARE_TO 2
+#endif
+#ifndef PR_SCHED_CORE_SHARE_FROM
+	#define PR_SCHED_CORE_SHARE_FROM 3
+#endif
+#ifndef PR_SCHED_CORE_SCOPE_THREAD
+	#define PR_SCHED_CORE_SCOPE_THREAD 0
+#endif
+#ifndef PR_SCHED_CORE_SCOPE_THREAD_GROUP
+	#define PR_SCHED_CORE_SCOPE_THREAD_GROUP 1
+#endif
+#ifndef PR_SCHED_CORE_SCOPE_PROCESS_GROUP
+	#define PR_SCHED_CORE_SCOPE_PROCESS_GROUP 2
+#endif
+
+typedef int sched_core_scope;
+typedef unsigned long sched_core_cookie;
+typedef enum {
+	SCHED_CORE_CMD_GET,
+	SCHED_CORE_CMD_NEW,
+	SCHED_CORE_CMD_COPY,
+} sched_core_cmd;
+
+struct args {
+	pid_t src;
+	pid_t dest;
+	sched_core_scope type;
+	sched_core_cmd cmd;
+	int exec_argv_offset;
+};
+
+static bool sched_core_verbose = false;
+
+static void __attribute__((__noreturn__)) usage(void)
+{
+	fputs(USAGE_HEADER, stdout);
+	fprintf(stdout, _(" %s [get] [--source <PID>]\n"),
+		program_invocation_short_name);
+	fprintf(stdout, _(" %s new [-t <TYPE>] --dest <PID>\n"),
+		program_invocation_short_name);
+	fprintf(stdout, _(" %s new [-t <TYPE>] -- PROGRAM [ARGS...]\n"),
+		program_invocation_short_name);
+	fprintf(stdout,
+		_(" %s copy [--source <PID>] [-t <TYPE>] --dest <PID>\n"),
+		program_invocation_short_name);
+	fprintf(stdout,
+		_(" %s copy [--source <PID>] [-t <TYPE>] -- PROGRAM [ARGS...]\n"),
+		program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, stdout);
+	fputsln(_("Manage core scheduling cookies for tasks."), stdout);
+
+	fputs(USAGE_FUNCTIONS, stdout);
+	fputsln(_(" get                      retrieve the core scheduling cookie of a PID"),
+		stdout);
+	fputsln(_(" new                      assign a new core scheduling cookie to an existing\n"
+		  "                            PID or execute a program with a new cookie"),
+		stdout);
+	fputsln(_(" copy                     copy the core scheduling cookie from an existing PID\n"
+		  "                            to another PID, or execute a program with that\n"
+		  "                            copied cookie"),
+		stdout);
+
+	fputs(USAGE_OPTIONS, stdout);
+	fprintf(stdout,
+		_(" -s, --source <PID>       which PID to get the cookie from\n"
+		  "                            If omitted, it is the PID of %s itself\n"),
+		program_invocation_short_name);
+	fputsln(_(" -d, --dest <PID>         which PID to modify the cookie of\n"),
+		stdout);
+	fputsln(_(" -t, --dest-type <TYPE>   type of the destination PID, or the type of the PID\n"
+		  "                            when a new core scheduling cookie is created.\n"
+		  "                            Can be one of the following: pid, tgid or pgid.\n"
+		  "                            The default is tgid."),
+		stdout);
+	fputs(USAGE_SEPARATOR, stdout);
+	fputsln(_(" -v, --verbose      verbose"), stdout);
+	fprintf(stdout, USAGE_HELP_OPTIONS(20));
+	fprintf(stdout, USAGE_MAN_TAIL("coresched(1)"));
+	exit(EXIT_SUCCESS);
+}
+
+#define bad_usage(FMT...)                 \
+	do {                              \
+		warnx(FMT);               \
+		errtryhelp(EXIT_FAILURE); \
+	} while (0)
+
+static sched_core_cookie core_sched_get_cookie(pid_t pid)
+{
+	sched_core_cookie cookie = 0;
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, pid,
+		  PR_SCHED_CORE_SCOPE_THREAD, &cookie))
+		err(EXIT_FAILURE, _("Failed to get cookie from PID %d"), pid);
+	return cookie;
+}
+
+static void core_sched_create_cookie(pid_t pid, sched_core_scope type)
+{
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pid, type, 0))
+		err(EXIT_FAILURE, _("Failed to create cookie for PID %d"), pid);
+}
+
+static void core_sched_pull_cookie(pid_t from)
+{
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, from,
+		  PR_SCHED_CORE_SCOPE_THREAD, 0))
+		err(EXIT_FAILURE, _("Failed to pull cookie from PID %d"), from);
+}
+
+static void core_sched_push_cookie(pid_t to, sched_core_scope type)
+{
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, to, type, 0))
+		err(EXIT_FAILURE, _("Failed to push cookie to PID %d"), to);
+}
+
+static void core_sched_copy_cookie(pid_t from, pid_t to,
+				   sched_core_scope to_type)
+{
+	core_sched_pull_cookie(from);
+	core_sched_push_cookie(to, to_type);
+
+	if (sched_core_verbose) {
+		sched_core_cookie before = core_sched_get_cookie(from);
+		warnx(_("copied cookie 0x%lx from PID %d to PID %d"), before,
+		      from, to);
+	}
+}
+
+static void core_sched_get_and_print_cookie(pid_t pid)
+{
+	if (sched_core_verbose) {
+		sched_core_cookie after = core_sched_get_cookie(pid);
+		warnx(_("set cookie of PID %d to 0x%lx"), pid, after);
+	}
+}
+
+static void core_sched_exec_with_cookie(struct args *args, char **argv)
+{
+	// Move the argument list to the first argument of the program
+	argv = &argv[args->exec_argv_offset];
+
+	// If a source PID is provided, try to copy the cookie from
+	// that PID. Otherwise, create a brand new cookie with the
+	// provided type.
+	if (args->src) {
+		core_sched_pull_cookie(args->src);
+		core_sched_get_and_print_cookie(args->src);
+	} else {
+		pid_t pid = getpid();
+		core_sched_create_cookie(pid, args->type);
+		core_sched_get_and_print_cookie(pid);
+	}
+
+	if (execvp(argv[0], argv))
+		errexec(argv[0]);
+}
+
+// If PR_SCHED_CORE is not recognized, or not supported on this system,
+// then prctl will set errno to EINVAL. Assuming all other operands of
+// prctl are valid, we can use errno==EINVAL as a check to see whether
+// core scheduling is available on this system.
+static bool is_core_sched_supported(void)
+{
+	sched_core_cookie cookie = 0;
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, getpid(),
+		  PR_SCHED_CORE_SCOPE_THREAD, &cookie))
+		if (errno == EINVAL)
+			return false;
+
+	return true;
+}
+
+static sched_core_scope parse_core_sched_type(char *str)
+{
+	if (!strcmp(str, "pid"))
+		return PR_SCHED_CORE_SCOPE_THREAD;
+	else if (!strcmp(str, "tgid"))
+		return PR_SCHED_CORE_SCOPE_THREAD_GROUP;
+	else if (!strcmp(str, "pgid"))
+		return PR_SCHED_CORE_SCOPE_PROCESS_GROUP;
+
+	bad_usage(_("'%s' is an invalid option. Must be one of pid/tgid/pgid"),
+		  str);
+}
+
+static void parse_and_verify_arguments(int argc, char **argv, struct args *args)
+{
+	int c;
+
+	static const struct option longopts[] = {
+		{ "source", required_argument, NULL, 's' },
+		{ "dest", required_argument, NULL, 'd' },
+		{ "dest-type", required_argument, NULL, 't' },
+		{ "verbose", no_argument, NULL, 'v' },
+		{ "version", no_argument, NULL, 'V' },
+		{ "help", no_argument, NULL, 'h' },
+		{ NULL, 0, NULL, 0 }
+	};
+
+	while ((c = getopt_long(argc, argv, "s:d:t:vVh", longopts, NULL)) != -1)
+		switch (c) {
+		case 's':
+			args->src = strtopid_or_err(
+				optarg,
+				_("Failed to parse PID for -s/--source"));
+			break;
+		case 'd':
+			args->dest = strtopid_or_err(
+				optarg, _("Failed to parse PID for -d/--dest"));
+			break;
+		case 't':
+			args->type = parse_core_sched_type(optarg);
+			break;
+		case 'v':
+			sched_core_verbose = true;
+			break;
+		case 'V':
+			print_version(EXIT_SUCCESS);
+		case 'h':
+			usage();
+		default:
+			errtryhelp(EXIT_FAILURE);
+		}
+
+	if (argc <= optind) {
+		args->cmd = SCHED_CORE_CMD_GET;
+	} else {
+		if (!strcmp(argv[optind], "get"))
+			args->cmd = SCHED_CORE_CMD_GET;
+		else if (!strcmp(argv[optind], "new"))
+			args->cmd = SCHED_CORE_CMD_NEW;
+		else if (!strcmp(argv[optind], "copy"))
+			args->cmd = SCHED_CORE_CMD_COPY;
+		else
+			bad_usage(_("Unknown function"));
+
+		// Since we parsed an extra "option" outside of getopt_long, we have to
+		// increment optind manually.
+		++optind;
+	}
+
+	if (args->cmd == SCHED_CORE_CMD_GET && args->dest)
+		bad_usage(_("get does not accept the --dest option"));
+
+	if (args->cmd == SCHED_CORE_CMD_NEW && args->src)
+		bad_usage(_("new does not accept the --source option"));
+
+	// If the -s/--source option is not specified, it defaults to the PID
+	// of the current coresched process
+	if (args->cmd != SCHED_CORE_CMD_NEW && !args->src)
+		args->src = getpid();
+
+	// More arguments have been passed, which means that the user wants to run
+	// another program with a core scheduling cookie.
+	if (argc > optind) {
+		switch (args->cmd) {
+		case SCHED_CORE_CMD_GET:
+			bad_usage(_("bad usage of the get function"));
+			break;
+		case SCHED_CORE_CMD_NEW:
+			if (args->dest)
+				bad_usage(_(
+					"new requires either a -d/--dest or a command"));
+			else
+				args->exec_argv_offset = optind;
+			break;
+		case SCHED_CORE_CMD_COPY:
+			if (args->dest)
+				bad_usage(_(
+					"copy requires either a -d/--dest or a command"));
+			else
+				args->exec_argv_offset = optind;
+			break;
+		}
+	} else {
+		if (args->cmd == SCHED_CORE_CMD_NEW && !args->dest)
+			bad_usage(_(
+				"new requires either a -d/--dest or a command"));
+		if (args->cmd == SCHED_CORE_CMD_COPY && !args->dest)
+			bad_usage(_(
+				"copy requires either a -d/--dest or a command"));
+	}
+}
+
+int main(int argc, char **argv)
+{
+	struct args args = { .type = PR_SCHED_CORE_SCOPE_THREAD_GROUP };
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	close_stdout_atexit();
+
+	parse_and_verify_arguments(argc, argv, &args);
+
+	if (!is_core_sched_supported())
+		errx(EXIT_FAILURE,
+		     _("No support for core scheduling found. Does your kernel"
+		       "support CONFIG_SCHED_CORE?"));
+
+	sched_core_cookie cookie;
+
+	switch (args.cmd) {
+	case SCHED_CORE_CMD_GET:
+		cookie = core_sched_get_cookie(args.src);
+		printf(_("cookie of pid %d is 0x%lx\n"), args.src, cookie);
+		break;
+	case SCHED_CORE_CMD_NEW:
+		if (args.exec_argv_offset) {
+			core_sched_exec_with_cookie(&args, argv);
+		} else {
+			core_sched_create_cookie(args.dest, args.type);
+			core_sched_get_and_print_cookie(args.dest);
+		}
+		break;
+	case SCHED_CORE_CMD_COPY:
+		if (args.exec_argv_offset)
+			core_sched_exec_with_cookie(&args, argv);
+		else
+			core_sched_copy_cookie(args.src, args.dest, args.type);
+		break;
+	default:
+		usage();
+	}
+}
diff --git a/tests/commands.sh b/tests/commands.sh
index 5674c5ff0..9eef92ccb 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -71,6 +71,7 @@ TS_CMD_COLCRT=${TS_CMD_COLCRT:-"${ts_commandsdir}colcrt"}
 TS_CMD_COLRM=${TS_CMD_COLRM:-"${ts_commandsdir}colrm"}
 TS_CMD_COL=${TS_CMD_COL:-"${ts_commandsdir}col"}
 TS_CMD_COLUMN=${TS_CMD_COLUMN:-"${ts_commandsdir}column"}
+TS_CMD_CORESCHED=${TS_CMD_CORESCHED:-"${ts_commandsdir}coresched"}
 TS_CMD_ENOSYS=${TS_CMD_ENOSYS-"${ts_commandsdir}enosys"}
 TS_CMD_EJECT=${TS_CMD_EJECT-"${ts_commandsdir}eject"}
 TS_CMD_EXCH=${TS_CMD_EXCH-"${ts_commandsdir}exch"}
diff --git a/tests/expected/schedutils/coresched-copy-from-child-to-parent b/tests/expected/schedutils/coresched-copy-from-child-to-parent
new file mode 100644
index 000000000..5b9c40052
--- /dev/null
+++ b/tests/expected/schedutils/coresched-copy-from-child-to-parent
@@ -0,0 +1 @@
+DIFFERENT_COOKIE
diff --git a/tests/expected/schedutils/coresched-copy-from-parent-to-nested-child b/tests/expected/schedutils/coresched-copy-from-parent-to-nested-child
new file mode 100644
index 000000000..ecfc41142
--- /dev/null
+++ b/tests/expected/schedutils/coresched-copy-from-parent-to-nested-child
@@ -0,0 +1 @@
+SAME_COOKIE
diff --git a/tests/expected/schedutils/coresched-get-cookie-own-pid b/tests/expected/schedutils/coresched-get-cookie-own-pid
new file mode 100644
index 000000000..84f182cbe
--- /dev/null
+++ b/tests/expected/schedutils/coresched-get-cookie-own-pid
@@ -0,0 +1 @@
+cookie of pid OWN_PID is PARENT_COOKIE
diff --git a/tests/expected/schedutils/coresched-get-cookie-parent-pid b/tests/expected/schedutils/coresched-get-cookie-parent-pid
new file mode 100644
index 000000000..e183e0402
--- /dev/null
+++ b/tests/expected/schedutils/coresched-get-cookie-parent-pid
@@ -0,0 +1 @@
+cookie of pid PARENT_PID is PARENT_COOKIE
diff --git a/tests/expected/schedutils/coresched-new-child-with-new-cookie b/tests/expected/schedutils/coresched-new-child-with-new-cookie
new file mode 100644
index 000000000..5b9c40052
--- /dev/null
+++ b/tests/expected/schedutils/coresched-new-child-with-new-cookie
@@ -0,0 +1 @@
+DIFFERENT_COOKIE
diff --git a/tests/expected/schedutils/coresched-set-cookie-parent-pid.err b/tests/expected/schedutils/coresched-set-cookie-parent-pid.err
new file mode 100644
index 000000000..e7318ffc2
--- /dev/null
+++ b/tests/expected/schedutils/coresched-set-cookie-parent-pid.err
@@ -0,0 +1 @@
+coresched: set cookie of PID PARENT_PID to PARENT_COOKIE
diff --git a/tests/expected/schedutils/set-cookie-parent-pid b/tests/expected/schedutils/set-cookie-parent-pid
new file mode 100644
index 000000000..e7318ffc2
--- /dev/null
+++ b/tests/expected/schedutils/set-cookie-parent-pid
@@ -0,0 +1 @@
+coresched: set cookie of PID PARENT_PID to PARENT_COOKIE
diff --git a/tests/ts/schedutils/coresched b/tests/ts/schedutils/coresched
new file mode 100755
index 000000000..e34fa319f
--- /dev/null
+++ b/tests/ts/schedutils/coresched
@@ -0,0 +1,83 @@
+#!/bin/bash
+# SPDX-License-Identifier: EUPL-1.2
+#
+# This file is part of util-linux
+#
+# Copyright (C) 2024 Thijs Raymakers
+# Licensed under the EUPL v1.2
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="coresched"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_CORESCHED"
+ts_check_prog "tee"
+ts_check_prog "sed"
+
+# If there is no kernel support, skip the test suite
+CORESCHED_TEST_KERNEL_SUPPORT_CMD=$($TS_CMD_CORESCHED 2>&1)
+if [[ $CORESCHED_TEST_KERNEL_SUPPORT_CMD == *"CONFIG_SCHED_CORE"* ]]; then
+  ts_skip "Kernel has no CONFIG_SCHED_CORE support"
+fi
+
+# The output of coresched contains PIDs and core scheduling cookies, both of which should be
+# assumed to be random values as we have no control over them. The tests replace these values
+# with sed before writing them to the output file, so it can match the expected output file.
+# - The PID of this bash script is replaced with the placeholder `OWN_PID`
+# - The core scheduling cookie of this bash script is replaced by `COOKIE`
+# - Any other cookie is replaced by `DIFFERENT_COOKIE`
+# The behavior of coresched does not depend on the exact values of these cookies, so using
+# placeholder values does not change the behavior tests.
+ts_init_subtest "set-cookie-parent-pid"
+CORESCHED_OUTPUT=$( ($TS_CMD_CORESCHED -v new -d $$ \
+  | tee -a "$TS_OUTPUT") 3>&1 1>&2 2>&3 \
+  | sed "s/$$/PARENT_PID/g")
+CORESCHED_PARENT_COOKIE=$(echo "$CORESCHED_OUTPUT" | sed 's/^.*\(0x.*$\)/\1/g')
+if [ -z "$CORESCHED_PARENT_COOKIE" ]; then
+  ts_failed "empty value for CORESCHED_PARENT_COOKIE"
+fi
+CORESCHED_OUTPUT=$(echo "$CORESCHED_OUTPUT" \
+  | sed "s/$CORESCHED_PARENT_COOKIE/PARENT_COOKIE/g")
+echo "$CORESCHED_OUTPUT" >> "$TS_ERRLOG"
+ts_finalize_subtest
+
+ts_init_subtest "get-cookie-parent-pid"
+$TS_CMD_CORESCHED get -s $$ 2>> "$TS_ERRLOG" \
+  | sed -e "s/$$/PARENT_PID/g" \
+        -e "s/$CORESCHED_PARENT_COOKIE/PARENT_COOKIE/g" >> "$TS_OUTPUT"
+ts_finalize_subtest
+
+ts_init_subtest "get-cookie-own-pid"
+$TS_CMD_CORESCHED get 2>> "$TS_ERRLOG" \
+  | sed -e "s/pid [0-9]\+/pid OWN_PID/g" \
+        -e "s/$CORESCHED_PARENT_COOKIE/PARENT_COOKIE/g" >> "$TS_OUTPUT"
+ts_finalize_subtest
+
+ts_init_subtest "new-child-with-new-cookie"
+$TS_CMD_CORESCHED new -- "$TS_CMD_CORESCHED" get 2>> "$TS_ERRLOG" \
+  | sed -e 's/^.*\(0x.*$\)/\1/g' \
+        -e "s/$CORESCHED_PARENT_COOKIE/SAME_COOKIE/g" \
+        -e "s/0x.*$/DIFFERENT_COOKIE/g" >> "$TS_OUTPUT"
+ts_finalize_subtest
+
+ts_init_subtest "copy-from-parent-to-nested-child"
+$TS_CMD_CORESCHED new -- /bin/bash -c \
+  "$TS_CMD_CORESCHED copy -s $$ -- $TS_CMD_CORESCHED get" \
+2>> "$TS_ERRLOG" \
+  | sed -e 's/^.*\(0x.*$\)/\1/g' \
+        -e "s/$CORESCHED_PARENT_COOKIE/SAME_COOKIE/g" \
+        -e "s/0x.*$/DIFFERENT_COOKIE/g" >> "$TS_OUTPUT"
+ts_finalize_subtest
+
+ts_init_subtest "copy-from-child-to-parent"
+$TS_CMD_CORESCHED new -- /bin/bash -c \
+  "$TS_CMD_CORESCHED copy -s \$\$ -d $$"
+$TS_CMD_CORESCHED get 2>> "$TS_ERRLOG" \
+  | sed -e 's/^.*\(0x.*$\)/\1/g' \
+        -e "s/$CORESCHED_PARENT_COOKIE/SAME_COOKIE/g" \
+        -e "s/0x.*$/DIFFERENT_COOKIE/g" >> "$TS_OUTPUT"
+ts_finalize_subtest
+
+ts_finalize
-- 
2.44.0

