Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B52E131E3C
	for <util-linux@vger.kernel.org>; Wed, 27 Mar 2024 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553437; cv=none; b=do0mCLbM2vnGm9FgjnBJNFWYWnGDD/2iLQVDaRi3nEPHSkme9x713Ea9C7F/RHdUy394KaGL3yUJ2R1h3GyBHHe1Pt1Hj7u4kuiAAFsQFFYu27aBksc7/HJIBAibj6eu2udq6AEB+3f+kT0q+6p2gLYQDm9pDNfhzuKdA1vZbuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553437; c=relaxed/simple;
	bh=gJMzJE2AHpOBZ7bo/sQ0YgqCZ7BqbfCpOR5BJ7Q0R34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPkgpxe7JRGm+GloILoqF8UTqb4UfUx4/qQLXvC72K28AFn2Fyg+qtGByDnz20C5G9ulPgX7AJ973is7leqRFxfoBoj1mnEUCxjk5G9rbFrFrRsHAgoDM4+JYE1OQ6OJayLvmPPsPp27hMLsTDNVz6pHyWZgJtNBqOyDCZC65dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raymakers.nl; spf=pass smtp.mailfrom=raymakers.nl; dkim=pass (2048-bit key) header.d=raymakers.nl header.i=@raymakers.nl header.b=obSaXYr0; arc=none smtp.client-ip=185.233.34.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raymakers.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raymakers.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raymakers.nl header.i=@raymakers.nl header.b="obSaXYr0"
Received: from smtp.soverin.net (c04cst-smtp-sov01.int.sover.in [10.10.4.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4V4Vx20RPZz79;
	Wed, 27 Mar 2024 15:30:30 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.99]) by soverin.net (Postfix) with ESMTPSA id 4V4Vx12swRz49;
	Wed, 27 Mar 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=raymakers.nl header.i=@raymakers.nl header.a=rsa-sha256 header.s=soverin1 header.b=obSaXYr0;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raymakers.nl;
	s=soverin1; t=1711553429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PudNyzOPPceUVQ4GJd+A42bCM7nu/EXhMbVaokgaUog=;
	b=obSaXYr0Lpw7gN3f2u8AYVGO3kneXvAkebTU8uDsTEWrglDWeyumuWTyVsCtv6l6JF+aWV
	C2uaI3PdtcPEHxbXOP9VvDkxhAAQ154C1uiQTxApoEuTrEtCH34EnS3OeQoTAXU4mMerZv
	naLKlxIeTnM8rbx1aqDA9Uk8faygTtcODgn1W87wBdpL+SldcJfDL4GRycrxMRog3xOEeC
	33VbTROJwPOsQh2OeTAZjHtshMmvZgqijtQw/bShIRIRLDDVZfc6WZ4HZpj1ErBchVLxTT
	tIaU8pRCHladP2ng/md7wr8RIUBHh9j8zDYj+5oTS9snBOxKXdbu8IjQbeV9Vw==
From: Thijs Raymakers <thijs@raymakers.nl>
To: pauld@redhat.com
Cc: kzak@redhat.com,
	util-linux@vger.kernel.org,
	Thijs Raymakers <thijs@raymakers.nl>
Subject: [PATCH v3] coresched: Manage core scheduling cookies for tasks
Date: Wed, 27 Mar 2024 16:30:08 +0100
Message-ID: <20240327153010.59273-1-thijs@raymakers.nl>
In-Reply-To: <20240327141845.GE361020@lorien.usersys.redhat.com>
References: <20240327141845.GE361020@lorien.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Thijs Raymakers <thijs@raymakers.nl>
Thanks: Phil Auld for the valuable feedback
---

Hi Phil,

Thank you for taking a look at it. I've added the missing definitions of
the PR_SCHED* constants so it should now compile on systems that don't
have these definitions available.

Op 27-03-2024 om 15:18 schreef Phil Auld:
>  I think this looks good but I'd do the error line first then the
>  CONFIG_SCHED_CORE message.

I agree that it looks better like that. I switched them around.

> It's a little harder to clear the cookie with coresched than coreset

Clearing the cookie of a task is not something that is explicitly supported
by the kernel. Unless there is an option like PR_SCHED_CORE_CLEAR, this
remains a bit tricky to do. One could do

$ coresched --copy -p $$ -d <PID>

to copy the cookie of current shell to a destination PID, but that
would only clear the cookie if the current shell has no cookie to begin
with. Properly clearing the cookie of a task without relying on the
existance of a cookieless task seems to require some changes to the kernel.

> but otherwise I think this version is really good. It's covering all
> my use cases and seems to fit my expectations pretty well.

That is great to hear! My main use case of copying cookies around is
also covered. Unless you or anybody else have any remaining remarks,
I think this patch is ready.

The next steps would be to write the man page and add some tests as
well. I don't know exactly what the policy surrounding this is. Do those
have to be included in the same patch, or can they come a bit later?

Thijs


Interdiff against v2:
  diff --git a/schedutils/coresched.c b/schedutils/coresched.c
  index 537281fdb..756e0a1a6 100644
  --- a/schedutils/coresched.c
  +++ b/schedutils/coresched.c
  @@ -20,15 +20,29 @@
   #include "optutils.h"
   #include "strutils.h"
   
  -// These definitions might not be defined, even if the
  -// prctl interface accepts them.
  +// These definitions might not be defined in the header files, even if the
  +// prctl interface in the kernel accepts them as valid.
  +#ifndef PR_SCHED_CORE
  +#define PR_SCHED_CORE 62
  +#endif
  +#ifndef PR_SCHED_CORE_GET
  +#define PR_SCHED_CORE_GET 0
  +#endif
  +#ifndef PR_SCHED_CORE_CREATE
  +#define PR_SCHED_CORE_CREATE 1
  +#endif
  +#ifndef PR_SCHED_CORE_SHARE_TO
  +#define PR_SCHED_CORE_SHARE_TO 2
  +#endif
  +#ifndef PR_SCHED_CORE_SHARE_FROM
  +#define PR_SCHED_CORE_SHARE_FROM 3
  +#endif
   #ifndef PR_SCHED_CORE_SCOPE_THREAD
   #define PR_SCHED_CORE_SCOPE_THREAD 0
   #endif
   #ifndef PR_SCHED_CORE_SCOPE_THREAD_GROUP
   #define PR_SCHED_CORE_SCOPE_THREAD_GROUP 1
   #endif
  -
   #ifndef PR_SCHED_CORE_SCOPE_PROCESS_GROUP
   #define PR_SCHED_CORE_SCOPE_PROCESS_GROUP 2
   #endif
  @@ -67,9 +81,12 @@ static void __attribute__((__noreturn__)) usage(void);
   	warnx(FMT);       \
   	errtryhelp(EINVAL);
   
  -#define check_coresched_in_kernel(errno)                              \
  -	if (errno == EINVAL) {                                        \
  -		warnx("Does your kernel support CONFIG_SCHED_CORE?"); \
  +#define check_prctl(FMT...)                                                 \
  +	if (errno == EINVAL) {                                              \
  +		warn(FMT);                                                  \
  +		errx(errno, "Does your kernel support CONFIG_SCHED_CORE?"); \
  +	} else {                                                            \
  +		err(errno, FMT);                                            \
   	}
   
   cookie_t core_sched_get_cookie(pid_t pid)
  @@ -77,8 +94,7 @@ cookie_t core_sched_get_cookie(pid_t pid)
   	cookie_t cookie = 0;
   	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, pid,
   		  PR_SCHED_CORE_SCOPE_THREAD, &cookie)) {
  -		check_coresched_in_kernel(errno);
  -		err(errno, "Failed to get cookie from PID %d", pid);
  +		check_prctl("Failed to get cookie from PID %d", pid);
   	}
   	return cookie;
   }
  @@ -86,8 +102,7 @@ cookie_t core_sched_get_cookie(pid_t pid)
   void core_sched_create_cookie(pid_t pid, core_sched_type_t type)
   {
   	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pid, type, 0)) {
  -		check_coresched_in_kernel(errno);
  -		err(errno, "Failed to create cookie for PID %d", pid);
  +		check_prctl("Failed to create cookie for PID %d", pid);
   	}
   }
   
  @@ -95,16 +110,14 @@ void core_sched_pull_cookie(pid_t from)
   {
   	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, from,
   		  PR_SCHED_CORE_SCOPE_THREAD, 0)) {
  -		check_coresched_in_kernel(errno);
  -		err(errno, "Failed to pull cookie from PID %d", from);
  +		check_prctl("Failed to pull cookie from PID %d", from);
   	}
   }
   
   void core_sched_push_cookie(pid_t to, core_sched_type_t type)
   {
   	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, to, type, 0)) {
  -		check_coresched_in_kernel(errno);
  -		err(errno, "Failed to push cookie to PID %d", to);
  +		check_prctl("Failed to push cookie to PID %d", to);
   	}
   }
   

 .gitignore                  |   1 +
 bash-completion/coresched   |   0
 configure.ac                |  12 +-
 meson.build                 |  16 +-
 meson_options.txt           |   2 +-
 schedutils/Makemodule.am    |   8 +
 schedutils/coresched.1.adoc |  16 ++
 schedutils/coresched.c      | 376 ++++++++++++++++++++++++++++++++++++
 8 files changed, 425 insertions(+), 6 deletions(-)
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
index 000000000..756e0a1a6
--- /dev/null
+++ b/schedutils/coresched.c
@@ -0,0 +1,376 @@
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
+#include <unistd.h>
+
+#include "c.h"
+#include "closestream.h"
+#include "nls.h"
+#include "optutils.h"
+#include "strutils.h"
+
+// These definitions might not be defined in the header files, even if the
+// prctl interface in the kernel accepts them as valid.
+#ifndef PR_SCHED_CORE
+#define PR_SCHED_CORE 62
+#endif
+#ifndef PR_SCHED_CORE_GET
+#define PR_SCHED_CORE_GET 0
+#endif
+#ifndef PR_SCHED_CORE_CREATE
+#define PR_SCHED_CORE_CREATE 1
+#endif
+#ifndef PR_SCHED_CORE_SHARE_TO
+#define PR_SCHED_CORE_SHARE_TO 2
+#endif
+#ifndef PR_SCHED_CORE_SHARE_FROM
+#define PR_SCHED_CORE_SHARE_FROM 3
+#endif
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
+typedef unsigned long cookie_t;
+typedef enum {
+	SCHED_CORE_CMD_GET,
+	SCHED_CORE_CMD_NEW,
+	SCHED_CORE_CMD_COPY,
+} core_sched_cmd_t;
+
+struct args {
+	pid_t pid;
+	pid_t dest;
+	core_sched_type_t type;
+	core_sched_cmd_t cmd;
+	int exec_argv_offset;
+};
+
+cookie_t core_sched_get_cookie(pid_t pid);
+void core_sched_create_cookie(pid_t pid, core_sched_type_t type);
+void core_sched_pull_cookie(pid_t from);
+void core_sched_push_cookie(pid_t to, core_sched_type_t type);
+void core_sched_copy_cookie(pid_t from, pid_t to, core_sched_type_t to_type);
+void core_sched_exec_with_cookie(struct args *args, char **argv);
+void core_sched_get_and_print_cookie(pid_t pid);
+
+core_sched_type_t parse_core_sched_type(char *str);
+bool verify_arguments(struct args *args);
+void parse_arguments(int argc, char **argv, struct args *args);
+void set_pid_or_err(pid_t *dest, pid_t src, const char *err_msg);
+static void __attribute__((__noreturn__)) usage(void);
+
+#define bad_usage(FMT...) \
+	warnx(FMT);       \
+	errtryhelp(EINVAL);
+
+#define check_prctl(FMT...)                                                 \
+	if (errno == EINVAL) {                                              \
+		warn(FMT);                                                  \
+		errx(errno, "Does your kernel support CONFIG_SCHED_CORE?"); \
+	} else {                                                            \
+		err(errno, FMT);                                            \
+	}
+
+cookie_t core_sched_get_cookie(pid_t pid)
+{
+	cookie_t cookie = 0;
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, pid,
+		  PR_SCHED_CORE_SCOPE_THREAD, &cookie)) {
+		check_prctl("Failed to get cookie from PID %d", pid);
+	}
+	return cookie;
+}
+
+void core_sched_create_cookie(pid_t pid, core_sched_type_t type)
+{
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pid, type, 0)) {
+		check_prctl("Failed to create cookie for PID %d", pid);
+	}
+}
+
+void core_sched_pull_cookie(pid_t from)
+{
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, from,
+		  PR_SCHED_CORE_SCOPE_THREAD, 0)) {
+		check_prctl("Failed to pull cookie from PID %d", from);
+	}
+}
+
+void core_sched_push_cookie(pid_t to, core_sched_type_t type)
+{
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, to, type, 0)) {
+		check_prctl("Failed to push cookie to PID %d", to);
+	}
+}
+
+void core_sched_copy_cookie(pid_t from, pid_t to, core_sched_type_t to_type)
+{
+	core_sched_pull_cookie(from);
+	cookie_t before = core_sched_get_cookie(from);
+	core_sched_push_cookie(to, to_type);
+	printf("%s: copied cookie 0x%lx from PID %d to PID %d\n",
+	       program_invocation_short_name, before, from, to);
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
+	if (args->pid) {
+		core_sched_pull_cookie(args->pid);
+		core_sched_get_and_print_cookie(args->pid);
+	} else {
+		pid_t pid = getpid();
+		core_sched_create_cookie(pid, args->type);
+		cookie_t after = core_sched_get_cookie(pid);
+		printf("%s: set cookie of PID %d to 0x%lx\n",
+		       program_invocation_short_name, pid, after);
+	}
+
+	if (execvp(argv[0], argv)) {
+		errexec(argv[0]);
+	}
+}
+
+void core_sched_get_and_print_cookie(pid_t pid)
+{
+	cookie_t after = core_sched_get_cookie(pid);
+	printf("%s: set cookie of PID %d to 0x%lx\n",
+	       program_invocation_short_name, pid, after);
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
+	bad_usage("'%s' is an invalid option. Must be one of pid/tgid/pgid",
+		  str);
+	__builtin_unreachable();
+}
+
+static void __attribute__((__noreturn__)) usage(void)
+{
+	fputs(USAGE_HEADER, stdout);
+	fprintf(stdout, _(" %s [-p PID]\n"), program_invocation_short_name);
+	fprintf(stdout, _(" %s --new [-t <TYPE>] -p <PID>\n"),
+		program_invocation_short_name);
+	fprintf(stdout, _(" %s --new [-t <TYPE>] -- PROGRAM [ARGS...]\n"),
+		program_invocation_short_name);
+	fprintf(stdout, _(" %s --copy -p <PID> [-t <TYPE>] -d <PID>\n"),
+		program_invocation_short_name);
+	fprintf(stdout,
+		_(" %s --copy -p <PID> [-t <TYPE>] -- PROGRAM [ARGS...]\n"),
+		program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, stdout);
+	fputsln(_("Manage core scheduling cookies for tasks."), stdout);
+
+	fputs(USAGE_FUNCTIONS, stdout);
+	fputsln(_(" -n, --new          assign a new core scheduling cookie to an existing PID or\n"
+		  "                      execute a program with a new cookie."),
+		stdout);
+	fputsln(_(" -c, --copy         copy the core scheduling cookie from an existing PID to\n"
+		  "                      either another PID, or copy it to a new program"),
+		stdout);
+	fputsln(_("\n If no function is provided, it will retrieve and print the cookie from\n"
+		  "   the PID provided via --pid.\n"),
+		stdout);
+
+	fputs(USAGE_OPTIONS, stdout);
+	fputsln(_(" -p, --pid <PID>    operate on an existing PID"), stdout);
+	fputsln(_(" -d, --dest <PID>   when copying a cookie from an existing PID, --dest is\n"
+		  "                      the destination PID where to copy the cookie to."),
+		stdout);
+	fputsln(_(" -t, --type <TYPE>  type of the destination PID, or the type of the PID\n"
+		  "                      when a new core scheduling cookie is created.\n"
+		  "                      Can be one of the following: pid, tgid or pgid.\n"
+		  "                      The default is tgid."),
+		stdout);
+	fputs(USAGE_SEPARATOR, stdout);
+	fprintf(stdout,
+		USAGE_HELP_OPTIONS(
+			20)); /* char offset to align option descriptions */
+	fprintf(stdout, USAGE_MAN_TAIL("coresched(1)"));
+	exit(EXIT_SUCCESS);
+}
+
+void parse_arguments(int argc, char **argv, struct args *args)
+{
+	int c;
+
+	static const struct option longopts[] = {
+		{ "new", no_argument, NULL, 'n' },
+		{ "copy", no_argument, NULL, 'c' },
+		{ "pid", required_argument, NULL, 'p' },
+		{ "dest", required_argument, NULL, 'd' },
+		{ "type", required_argument, NULL, 't' },
+		{ "version", no_argument, NULL, 'V' },
+		{ "help", no_argument, NULL, 'h' },
+		{ NULL, 0, NULL, 0 }
+	};
+	static const ul_excl_t excl[] = {
+		{ 'c', 'n' }, // Cannot do both --new and --copy
+		{ 'd', 'n' }, // Cannot have both --new and --dest
+		{ 0 }
+	};
+
+	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
+
+	while ((c = getopt_long(argc, argv, "ncp:d:t:Vh", longopts, NULL)) !=
+	       -1) {
+		err_exclusive_options(c, longopts, excl, excl_st);
+		switch (c) {
+		case 'n':
+			args->cmd = SCHED_CORE_CMD_NEW;
+			break;
+		case 'c':
+			args->cmd = SCHED_CORE_CMD_COPY;
+			break;
+		case 'p':
+			args->pid = strtopid_or_err(
+				optarg, "Failed to parse PID for -p/--pid");
+			break;
+		case 'd':
+			args->dest = strtopid_or_err(
+				optarg, "Failed to parse PID for -d/--dest");
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
+	}
+
+	if (args->cmd == SCHED_CORE_CMD_COPY && !args->pid) {
+		bad_usage("--copy: requires a -p/--pid");
+	}
+
+	// More arguments have been passed, which means that the user wants to run
+	// another program with a core scheduling cookie.
+	if (argc > optind) {
+		switch (args->cmd) {
+		case SCHED_CORE_CMD_GET:
+			bad_usage("Unknown command");
+			break;
+		case SCHED_CORE_CMD_NEW:
+			if (args->pid) {
+				bad_usage(
+					"--new: cannot accept both a -p/--pid and a command");
+			} else {
+				args->exec_argv_offset = optind;
+			}
+			break;
+		case SCHED_CORE_CMD_COPY:
+			if (args->dest) {
+				bad_usage(
+					"--copy: cannot accept both a destination PID "
+					"-d/--dest and a command")
+			} else {
+				args->exec_argv_offset = optind;
+			}
+			break;
+		}
+	}
+
+	if (argc <= optind) {
+		if (args->cmd == SCHED_CORE_CMD_NEW && !args->pid) {
+			bad_usage(
+				"--new: requires either a -p/--pid or a command");
+		}
+		if (args->cmd == SCHED_CORE_CMD_COPY && !args->dest) {
+			bad_usage(
+				"--copy: requires either a -d/--dest or a command");
+		}
+	}
+}
+
+int main(int argc, char **argv)
+{
+	struct args args = { 0 };
+	args.cmd = SCHED_CORE_CMD_GET;
+	args.type = PR_SCHED_CORE_SCOPE_THREAD_GROUP;
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	close_stdout_atexit();
+
+	parse_arguments(argc, argv, &args);
+
+	cookie_t cookie = 0;
+
+	switch (args.cmd) {
+	case SCHED_CORE_CMD_GET:
+		if (args.pid) {
+			cookie = core_sched_get_cookie(args.pid);
+			if (cookie) {
+				printf("%s: cookie of pid %d is 0x%lx\n",
+				       program_invocation_short_name, args.pid,
+				       cookie);
+			} else {
+				errx(ENODATA,
+				     "pid %d doesn't have a core scheduling cookie",
+				     args.pid);
+			}
+		} else {
+			usage();
+			exit(0);
+		}
+		break;
+	case SCHED_CORE_CMD_NEW:
+		if (args.pid) {
+			core_sched_create_cookie(args.pid, args.type);
+			core_sched_get_and_print_cookie(args.pid);
+		} else {
+			core_sched_exec_with_cookie(&args, argv);
+		}
+		break;
+	case SCHED_CORE_CMD_COPY:
+		if (args.dest) {
+			core_sched_copy_cookie(args.pid, args.dest, args.type);
+		} else {
+			core_sched_exec_with_cookie(&args, argv);
+		}
+		break;
+	default:
+		usage();
+		exit(1);
+	}
+}
-- 
2.44.0

