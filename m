Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6075312E7E
	for <util-linux@vger.kernel.org>; Sun, 24 Mar 2024 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711310896; cv=none; b=LTfxoQgwkCvOlx2CnUJ9jZYYh7KHJxEkkRbb/CtrDmnNLbywkfjxOb+5T632duwFaT78wICNRcoDrmln5VW7xur812EKFm+yyCMVMn54lIprqP+9uS4URfq9u+7ZmBqcv1VlusPzXolc6e1enZI3brZRa1MMO9ff2ZVPxDLeXxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711310896; c=relaxed/simple;
	bh=GyYTNVBI8aVfV7X0fdUFR9fcmKohJpomG5GlACnMNqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9KuVYBELlig4n1r7GZ3eBiUiLOdp5ybB/pyQkOjKP39jX0cJpdv7rZBV3miVoW+yZKj6djCeYGG8jxPiShKoWrG5oKF5eICgPBQ6OhjY5vesgCPUZUhUqtLPqawMbPal6HeJWA21IyjSbB+9xgMdSbR+c4QmL6+mdDNY8nRhnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DeHPrlCa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DeHPrlCa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711310892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V8SbE/5xzr5oA/sn11qWNOSd+mcJ0tspvU7LoISsxfc=;
	b=DeHPrlCaWuksUxDfzGTRXOEWcUktXYnL/eqhvvGjbLwqXtLoLHOFkuphoLtzjrhPGYgbmm
	80M5kHRCFRprj21p1T7nJFLnpML2Dc+dBx5d4ap0JUIVI0xPtnOi0TmmnSeVxT63sSUmCr
	L47Zqmjk/n8E69QK8XI5UldDPQFDwz0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-DTRPzX7POWqp8-ln_stDYg-1; Sun, 24 Mar 2024 16:08:09 -0400
X-MC-Unique: DTRPzX7POWqp8-ln_stDYg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E499811E81;
	Sun, 24 Mar 2024 20:08:09 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.242.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E84F3C20;
	Sun, 24 Mar 2024 20:08:07 +0000 (UTC)
Date: Sun, 24 Mar 2024 21:07:45 +0100
From: Karel Zak <kzak@redhat.com>
To: Thijs Raymakers <thijs@raymakers.nl>, Phil Auld <pauld@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH RFC] coresched: Manage core scheduling cookies for tasks
Message-ID: <20240324200745.yn5krdvi7brdrqga@ws.net.home>
References: <20240316171238.177897-1-thijs@raymakers.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240316171238.177897-1-thijs@raymakers.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Sat, Mar 16, 2024 at 06:10:03PM +0100, Thijs Raymakers wrote:
> I'm looking for any comments on coresched, a program that allows you to
> manage core scheduling cookies for tasks.

 https://github.com/util-linux/util-linux/pull/2839

Guys, you should sync your work and merge it together :-) 

CC: Phil Auld 

    Karel

> 
> === What is Core Scheduling ===
> Core Scheduling can be used to ensure that certain tasks will never be
> scheduled on the same physical core. This can be a useful, alternative,
> mitigation to hardware vulnerabilities like L1tf or MDS.
> The full software mitigation for these vulnerabilities would be to disable
> SMT/Hyper-Threading. However, this can be prohibitively expensive and
> therefore often not done in practice.
> With Core Scheduling you can mitigate in these issues in some scenarios,
> while keeping SMT enabled.
> 
> Core Scheduling works by adding a random "cookie" to a process. Only
> processes with the same core scheduling cookie are allowed to run on
> sibling cores. Tasks that trust each other can be given the same
> cookie and untrusted tasks are given a different cookie.
> This is important when running VMs that don't trust each other, as
> it prevents a guest VM to leak data from another guest VM with L1tf or MDS.
> 
> === Motivation ===
> The kernel exposes a prctl uapi to manage core scheduling cookies (see
> https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/core-scheduling.html)
> Last week, I wanted to use core scheduling on some programs. Adding the
> prctl calls and recompiling felt a bit inconvenient, so I looked for a
> program like taskset that could do the job without having to modify the
> target program. I couldn't find any, and so I wrote a small program that
> does this. Hopefully it saves the next person some time :)
> 
> === RFC ===
> I'm looking forward to any comments that you might have on the patch!
> Please note that I haven't written the manpage and the bash completion
> script yet. I first wanted to get some feedback on the program before I
> start documenting it in more detail.
> 
> I'm particularly curious about your thoughts on the following things:
> 
> - General comments about interacting with the program: Do the options
>   make sense? Are there any necessary functions missing? Are the error
>   messages helpful? Is the output too verbose/not verbose enough?
> - How should the program behave if the prctl core scheduling API is not
>   available? It has been in Linus' tree since november 2021
>   (commit a41b74451b35f7a6529689760eb8c05241feecbc) but it can be
>   disabled with CONFIG_SCHED_CORE=n
> - Most of the options require the user to have the CAP_SYS_PTRACE
>   capability. Should the program notify the user that the capability
>   is missing when the prctl call returns -EPREM, or does a mention in the
>   man page suffice?
> - I've currently licensed it under the EUPL v1.2, which is easier to
>   enforce in my jurisdiction than the GPL. It is GPL compatible so it
>   shouldn't be an issue, but if anybody has any remarks on this, please
>   let me know.
> 
> Thanks for taking the time!
> 
> Best regards,
> Thijs Raymakers
> 
> 
> Signed-off-by: Thijs Raymakers <thijs@raymakers.nl>
> 
> ---
>  .gitignore                  |   1 +
>  bash-completion/coresched   |   0
>  configure.ac                |  12 +-
>  meson.build                 |  16 +-
>  meson_options.txt           |   2 +-
>  schedutils/Makemodule.am    |   8 +
>  schedutils/coresched.1.adoc |  16 ++
>  schedutils/coresched.c      | 340 ++++++++++++++++++++++++++++++++++++
>  8 files changed, 389 insertions(+), 6 deletions(-)
>  create mode 100644 bash-completion/coresched
>  create mode 100644 schedutils/coresched.1.adoc
>  create mode 100644 schedutils/coresched.c
> 
> diff --git a/.gitignore b/.gitignore
> index 6ecbfa7fe..316f3cdcc 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -94,6 +94,7 @@ ylwrap
>  /colcrt
>  /colrm
>  /column
> +/coresched
>  /ctrlaltdel
>  /delpart
>  /dmesg
> diff --git a/bash-completion/coresched b/bash-completion/coresched
> new file mode 100644
> index 000000000..e69de29bb
> diff --git a/configure.ac b/configure.ac
> index ab7c98636..3a189a075 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -2500,9 +2500,9 @@ UL_REQUIRES_HAVE([setterm], [ncursesw, ncurses], [ncursesw or ncurses library])
>  AM_CONDITIONAL([BUILD_SETTERM], [test "x$build_setterm" = xyes])
>  
>  # build_schedutils= is just configure-only variable to control
> -# ionice, taskset and chrt
> +# ionice, taskset, coresched and chrt
>  AC_ARG_ENABLE([schedutils],
> -  AS_HELP_STRING([--disable-schedutils], [do not build chrt, ionice, taskset]),
> +  AS_HELP_STRING([--disable-schedutils], [do not build chrt, ionice, taskset, coresched]),
>    [], [UL_DEFAULT_ENABLE([schedutils], [check])]
>  )
>  
> @@ -2545,6 +2545,14 @@ UL_REQUIRES_SYSCALL_CHECK([taskset],
>  AM_CONDITIONAL([BUILD_TASKSET], [test "x$build_taskset" = xyes])
>  
>  
> +UL_ENABLE_ALIAS([coresched], [schedutils])
> +UL_BUILD_INIT([coresched])
> +UL_REQUIRES_SYSCALL_CHECK([coresched],
> +	[UL_CHECK_SYSCALL([prctl])],
> +	[prctl])
> +AM_CONDITIONAL([BUILD_CORESCHED], [test "x$build_coresched" = xyes])
> +
> +
>  have_schedsetter=no
>  AS_IF([test "x$ac_cv_func_sched_setscheduler" = xyes], [have_schedsetter=yes],
>        [test "x$ac_cv_func_sched_setattr" = xyes], [have_schedsetter=yes])
> diff --git a/meson.build b/meson.build
> index f7baab7a2..8244c43a9 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3107,13 +3107,23 @@ exe4 = executable(
>    install : opt,
>    build_by_default : opt)
>  
> +exe5 = executable(
> +  'coresched',
> +  'schedutils/coresched.c',
> +  include_directories : includes,
> +  link_with : lib_common,
> +  install_dir : usrbin_exec_dir,
> +  install : opt,
> +  build_by_default : opt)
> +
>  if opt and not is_disabler(exe)
> -  exes += [exe, exe2, exe3, exe4]
> +  exes += [exe, exe2, exe3, exe4, exe5]
>    manadocs += ['schedutils/chrt.1.adoc',
>                 'schedutils/ionice.1.adoc',
>                 'schedutils/taskset.1.adoc',
> -	       'schedutils/uclampset.1.adoc']
> -  bashcompletions += ['chrt', 'ionice', 'taskset', 'uclampset']
> +	       'schedutils/uclampset.1.adoc',
> +         'schedutils/coresched.1.adoc']
> +  bashcompletions += ['chrt', 'ionice', 'taskset', 'uclampset', 'coresched']
>  endif
>  
>  ############################################################
> diff --git a/meson_options.txt b/meson_options.txt
> index 7b8cf3f35..3405c1b73 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -162,7 +162,7 @@ option('build-pipesz', type : 'feature',
>  option('build-setterm', type : 'feature',
>         description : 'build setterm')
>  option('build-schedutils', type : 'feature',
> -       description : 'build chrt, ionice, taskset')
> +       description : 'build chrt, ionice, taskset, coresched')
>  option('build-wall', type : 'feature',
>         description : 'build wall')
>  option('build-write', type : 'feature',
> diff --git a/schedutils/Makemodule.am b/schedutils/Makemodule.am
> index 1040da85f..0cb655401 100644
> --- a/schedutils/Makemodule.am
> +++ b/schedutils/Makemodule.am
> @@ -29,3 +29,11 @@ dist_noinst_DATA += schedutils/uclampset.1.adoc
>  uclampset_SOURCES = schedutils/uclampset.c schedutils/sched_attr.h
>  uclampset_LDADD = $(LDADD) libcommon.la
>  endif
> +
> +if BUILD_CORESCHED
> +usrbin_exec_PROGRAMS += coresched
> +MANPAGES += schedutils/coresched.1
> +dist_noinst_DATA += schedutils/coresched.1.adoc
> +coresched_SOURCES = schedutils/coresched.c
> +coresched_LDADD = $(LDADD) libcommon.la
> +endif
> diff --git a/schedutils/coresched.1.adoc b/schedutils/coresched.1.adoc
> new file mode 100644
> index 000000000..60a21cd01
> --- /dev/null
> +++ b/schedutils/coresched.1.adoc
> @@ -0,0 +1,16 @@
> +//po4a: entry man manual
> +////
> +coresched(1) manpage
> +////
> += coresched(1)
> +:doctype: manpage
> +:man manual: User Commands
> +:man source: util-linux {release-version}
> +:page-layout: base
> +:command: coresched
> +:colon: :
> +:copyright: ©
> +
> +== NAME
> +
> +coresched - manage core scheduling cookies for tasks
> diff --git a/schedutils/coresched.c b/schedutils/coresched.c
> new file mode 100644
> index 000000000..4be8f9fda
> --- /dev/null
> +++ b/schedutils/coresched.c
> @@ -0,0 +1,340 @@
> +/**
> + * SPDX-License-Identifier: EUPL-1.2
> + *
> + * coresched.c - manage core scheduling cookies for tasks
> + *
> + * Copyright (C) 2024 Thijs Raymakers
> + * Licensed under the EUPL v1.2
> + */
> +
> +#include <getopt.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <sys/prctl.h>
> +#include <sys/wait.h>
> +
> +#include "c.h"
> +#include "closestream.h"
> +#include "nls.h"
> +#include "strutils.h"
> +
> +typedef enum {
> +	SCHED_CORE_SCOPE_PID = PR_SCHED_CORE_SCOPE_THREAD,
> +	SCHED_CORE_SCOPE_TGID = PR_SCHED_CORE_SCOPE_THREAD_GROUP,
> +	SCHED_CORE_SCOPE_PGID = PR_SCHED_CORE_SCOPE_PROCESS_GROUP,
> +} core_sched_type_t;
> +
> +typedef enum {
> +	SCHED_CORE_CMD_NONE = 0,
> +	SCHED_CORE_CMD_GET = 1,
> +	SCHED_CORE_CMD_CREATE = 2,
> +	SCHED_CORE_CMD_COPY = 4,
> +	SCHED_CORE_CMD_EXEC = 8,
> +} core_sched_cmd_t;
> +
> +struct args {
> +	pid_t from_pid;
> +	pid_t to_pid;
> +	core_sched_type_t type;
> +	core_sched_cmd_t cmd;
> +	int exec_argv_offset;
> +};
> +
> +unsigned long core_sched_get_cookie(struct args *args);
> +void core_sched_create_cookie(struct args *args);
> +void core_sched_pull_cookie(pid_t from);
> +void core_sched_push_cookie(pid_t to, core_sched_type_t type);
> +void core_sched_copy_cookie(struct args *args);
> +void core_sched_exec_with_cookie(struct args *args, char **argv);
> +
> +core_sched_type_t parse_core_sched_type(char *str);
> +bool verify_arguments(struct args *args);
> +void parse_arguments(int argc, char **argv, struct args *args);
> +
> +unsigned long core_sched_get_cookie(struct args *args)
> +{
> +	unsigned long cookie = 0;
> +	int prctl_errno = prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET,
> +				args->from_pid, SCHED_CORE_SCOPE_PID, &cookie);
> +	if (prctl_errno) {
> +		errx(-prctl_errno, "Failed to get cookie from PID %d",
> +		     args->from_pid);
> +	}
> +	return cookie;
> +}
> +
> +void core_sched_create_cookie(struct args *args)
> +{
> +	int prctl_errno = prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE,
> +				args->from_pid, args->type, 0);
> +	if (prctl_errno) {
> +		errx(-prctl_errno, "Failed to create cookie for PID %d",
> +		     args->from_pid);
> +	}
> +}
> +
> +void core_sched_pull_cookie(pid_t from)
> +{
> +	int prctl_errno = prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, from,
> +				SCHED_CORE_SCOPE_PID, 0);
> +	if (prctl_errno) {
> +		errx(-prctl_errno, "Failed to pull cookie from PID %d", from);
> +	}
> +}
> +
> +void core_sched_push_cookie(pid_t to, core_sched_type_t type)
> +{
> +	int prctl_errno =
> +		prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, to, type, 0);
> +	if (prctl_errno) {
> +		errx(-prctl_errno, "Failed to push cookie to PID %d", to);
> +	}
> +}
> +
> +void core_sched_copy_cookie(struct args *args)
> +{
> +	core_sched_pull_cookie(args->from_pid);
> +	core_sched_push_cookie(args->to_pid, args->type);
> +}
> +
> +void core_sched_exec_with_cookie(struct args *args, char **argv)
> +{
> +	if (!args->exec_argv_offset) {
> +		errx(EINVAL, "when --exec is provided, a program name "
> +			     "has to be given.");
> +	}
> +
> +	// Move the argument list to the first argument of the program
> +	argv = &argv[args->exec_argv_offset];
> +
> +	pid_t pid = fork();
> +	if (pid == -1) {
> +		errx(errno, "Failed to spawn new process");
> +	}
> +
> +	if (!pid) {
> +		// If a source PID is provided, try to copy the cookie from
> +		// that PID. Otherwise, create a brand new cookie with the
> +		// provided type.
> +		if (args->from_pid) {
> +			core_sched_pull_cookie(args->from_pid);
> +		} else {
> +			args->from_pid = getpid();
> +			core_sched_create_cookie(args);
> +		}
> +		if (execvp(argv[0], argv)) {
> +			errexec(argv[0]);
> +		}
> +	} else {
> +		int status = 0;
> +		waitpid(pid, &status, 0);
> +		exit(status);
> +	}
> +}
> +
> +core_sched_type_t parse_core_sched_type(char *str)
> +{
> +	if (!strncmp(str, "pid\0", 4)) {
> +		return SCHED_CORE_SCOPE_PID;
> +	} else if (!strncmp(str, "tgid\0", 5)) {
> +		return SCHED_CORE_SCOPE_TGID;
> +	} else if (!strncmp(str, "pgid\0", 5)) {
> +		return SCHED_CORE_SCOPE_PGID;
> +	}
> +
> +	errx(EINVAL, "'%s' is an invalid option. Must be one of pid/tgid/pgid",
> +	     str);
> +	__builtin_unreachable();
> +}
> +
> +static void __attribute__((__noreturn__)) usage(void)
> +{
> +	fputs(USAGE_HEADER, stdout);
> +	fprintf(stdout, _(" %s --get <PID>\n"), program_invocation_short_name);
> +	fprintf(stdout, _(" %s --new <PID> [-t <TYPE>]\n"),
> +		program_invocation_short_name);
> +	fprintf(stdout, _(" %s --copy -s <PID> -d <PID> [-t <TYPE>]\n"),
> +		program_invocation_short_name);
> +	fprintf(stdout, _(" %s --exec [-s <PID>] -- PROGRAM ARGS... \n"),
> +		program_invocation_short_name);
> +
> +	fputs(USAGE_SEPARATOR, stdout);
> +	fputsln(_("Manage core scheduling cookies for tasks."), stdout);
> +
> +	fputs(USAGE_FUNCTIONS, stdout);
> +	fputsln(_(" -g, --get <PID>         get the core scheduling cookie of a PID"),
> +		stdout);
> +	fputsln(_(" -n, --new <PID>         assign a new core scheduling cookie to PID"),
> +		stdout);
> +	fputsln(_(" -c, --copy              copy the core scheduling cookie from PID to\n"
> +		  "                           another PID, requires the --source and --dest option"),
> +		stdout);
> +	fputsln(_(" -e, --exec              execute a program with a new core scheduling\n"
> +		  "                           cookie."),
> +		stdout);
> +
> +	fputs(USAGE_OPTIONS, stdout);
> +	fputsln(_(" -s, --source <PID>      where to copy the core scheduling cookie from."),
> +		stdout);
> +	fputsln(_(" -d, --dest <PID>        where to copy the core scheduling cookie to."),
> +		stdout);
> +	fputsln(_(" -t, --type              type of the destination PID, or the type of\n"
> +		  "                           the PID when a new core scheduling cookie\n"
> +		  "                           is created. Can be one of the following:\n"
> +		  "                           pid, tgid or pgid. Defaults to tgid."),
> +		stdout);
> +	fputs(USAGE_SEPARATOR, stdout);
> +	fprintf(stdout,
> +		USAGE_HELP_OPTIONS(
> +			25)); /* char offset to align option descriptions */
> +	fprintf(stdout, USAGE_MAN_TAIL("coresched(1)"));
> +	exit(EXIT_SUCCESS);
> +}
> +
> +bool verify_arguments(struct args *args)
> +{
> +	if (args->cmd == SCHED_CORE_CMD_NONE) {
> +		usage();
> +	}
> +
> +	// Check if the value of args->cmd is a power of 2
> +	// In that case, only a single function option was set.
> +	if (!(args->cmd && !(args->cmd & (args->cmd - 1)))) {
> +		errx(EINVAL, "Cannot do more than one function at a time.");
> +	}
> +
> +	if (args->from_pid < 0) {
> +		errx(EINVAL, "source PID cannot be negative");
> +	}
> +
> +	if (args->to_pid < 0) {
> +		errx(EINVAL, "destination PID cannot be negative");
> +	}
> +
> +	if (args->from_pid == 0 && args->cmd == SCHED_CORE_CMD_COPY) {
> +		errx(EINVAL, "valid argument to --source is required");
> +	}
> +
> +	if (args->to_pid == 0 && args->cmd == SCHED_CORE_CMD_COPY) {
> +		errx(EINVAL, "valid argument to --dest is required");
> +	}
> +
> +	if (args->from_pid == 0 && args->cmd != SCHED_CORE_CMD_EXEC) {
> +		errx(EINVAL, "PID cannot be zero");
> +	}
> +
> +	return true;
> +}
> +
> +void parse_arguments(int argc, char **argv, struct args *args)
> +{
> +	int c;
> +
> +	enum {
> +		OPT_GET = 'g',
> +		OPT_NEW = 'n',
> +		OPT_COPY = 'c',
> +		OPT_EXEC = 'e',
> +		OPT_SRC = 's',
> +		OPT_DEST = 'd',
> +		OPT_TYPE = 't',
> +		OPT_VERSION = 'V',
> +		OPT_HELP = 'h'
> +	};
> +
> +	static const struct option longopts[] = {
> +		{ "get", required_argument, NULL, OPT_GET },
> +		{ "new", required_argument, NULL, OPT_NEW },
> +		{ "copy", no_argument, NULL, OPT_COPY },
> +		{ "exec", no_argument, NULL, OPT_EXEC },
> +		{ "source", required_argument, NULL, OPT_SRC },
> +		{ "destination", required_argument, NULL, OPT_DEST },
> +		{ "type", required_argument, NULL, OPT_TYPE },
> +		{ "version", no_argument, NULL, OPT_VERSION },
> +		{ "help", no_argument, NULL, OPT_HELP },
> +		{ NULL, 0, NULL, 0 }
> +	};
> +
> +	while ((c = getopt_long(argc, argv, "g:n:ces:d:t:Vh", longopts,
> +				NULL)) != -1)
> +		switch (c) {
> +		case OPT_GET:
> +			args->cmd |= SCHED_CORE_CMD_GET;
> +			args->from_pid = strtos32_or_err(
> +				optarg, "Failed to parse PID for --get");
> +			break;
> +		case OPT_NEW:
> +			args->cmd |= SCHED_CORE_CMD_CREATE;
> +			args->from_pid = strtos32_or_err(
> +				optarg, "Failed to parse PID for --new");
> +			break;
> +		case OPT_COPY:
> +			args->cmd |= SCHED_CORE_CMD_COPY;
> +			break;
> +		case OPT_EXEC:
> +			args->cmd |= SCHED_CORE_CMD_EXEC;
> +			break;
> +		case OPT_SRC:
> +			args->from_pid = strtos32_or_err(
> +				optarg, "Failed to parse PID for --source");
> +			break;
> +		case OPT_DEST:
> +			args->to_pid = strtos32_or_err(
> +				optarg, "Failed to parse PID for --dest");
> +			break;
> +		case OPT_TYPE:
> +			args->type = parse_core_sched_type(optarg);
> +			break;
> +		case OPT_VERSION:
> +			print_version(EXIT_SUCCESS);
> +		case OPT_HELP:
> +			usage();
> +		default:
> +			errtryhelp(EXIT_FAILURE);
> +		}
> +
> +	if (argc > optind) {
> +		args->exec_argv_offset = optind;
> +	}
> +	verify_arguments(args);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	struct args arguments = { 0 };
> +	arguments.type = SCHED_CORE_SCOPE_TGID;
> +
> +	setlocale(LC_ALL, "");
> +	bindtextdomain(PACKAGE, LOCALEDIR);
> +	textdomain(PACKAGE);
> +	close_stdout_atexit();
> +
> +	parse_arguments(argc, argv, &arguments);
> +
> +	unsigned long cookie = 0;
> +	switch (arguments.cmd) {
> +	case SCHED_CORE_CMD_GET:
> +		cookie = core_sched_get_cookie(&arguments);
> +		if (cookie) {
> +			printf("core scheduling cookie of pid %d is 0x%lx\n",
> +			       arguments.from_pid, cookie);
> +		} else {
> +			printf("pid %d doesn't have a core scheduling cookie\n",
> +			       arguments.from_pid);
> +			exit(1);
> +		}
> +		break;
> +	case SCHED_CORE_CMD_CREATE:
> +		core_sched_create_cookie(&arguments);
> +		break;
> +	case SCHED_CORE_CMD_COPY:
> +		core_sched_copy_cookie(&arguments);
> +		break;
> +	case SCHED_CORE_CMD_EXEC:
> +		core_sched_exec_with_cookie(&arguments, argv);
> +		break;
> +	default:
> +		usage();
> +		exit(1);
> +	}
> +}
> -- 
> 2.44.0
> 
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

