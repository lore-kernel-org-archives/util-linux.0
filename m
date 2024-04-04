Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771CB12D1EF
	for <util-linux@vger.kernel.org>; Thu,  4 Apr 2024 22:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712268570; cv=none; b=NIicaJxQaGlcnuPExMbR4ioytHNzpx4Gc7nnwcWCOPZlNX8sWwKhUJ96hWc5HEymY8uWozciSf3HDMw9LsbixmwAHQNmiuF0b2QxAXLHmp+E0tR+XKt70ykjJ6F4GSWguCj3rTwQ72ZS2lqTns7wUvV/NBVS0suUTSu99fGD8zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712268570; c=relaxed/simple;
	bh=AUg2nu6U3TVBmALvtHzZi3y3AvckQSJU7Kf4ArbPZx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sb14CdYiq8Z6Ja6GU2PEXbbwkIUjEixZ+Aoi/0l7aM9LhBkSNHtwVrplbGRfarqJqaEhQlNlck/LTrrwsrrTWX+6mD/W/76/JPzav6uRfMFoJPq4KuYA3aMgeTGIvA09ENQ7EVnTK4EILw0aRoVmYjsa2m45TBgdhasQ59+DnLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raymakers.nl; spf=pass smtp.mailfrom=raymakers.nl; dkim=pass (2048-bit key) header.d=raymakers.nl header.i=@raymakers.nl header.b=aDFIycct; arc=none smtp.client-ip=185.233.34.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raymakers.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raymakers.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raymakers.nl header.i=@raymakers.nl header.b="aDFIycct"
Received: from smtp.soverin.net (c04cst-smtp-sov02.int.sover.in [10.10.4.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4V9bHc5drfz5W;
	Thu,  4 Apr 2024 22:04:12 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.100]) by soverin.net (Postfix) with ESMTPSA id 4V9bHc0zXgzNw;
	Thu,  4 Apr 2024 22:04:12 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=raymakers.nl header.i=@raymakers.nl header.a=rsa-sha256 header.s=soverin1 header.b=aDFIycct;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raymakers.nl;
	s=soverin1; t=1712268252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PZ0olOxGHWCCeSoFGHSBdo8Uv0hCET2PHeWNenqr/M=;
	b=aDFIycct0dA/ibYNw33kAWTpE1+edRKUJhb06NvHVFq6QeWnD5UvMuQPsD6oUdePi8RjWB
	b8iBBjmyshJprxKx3XxztjIXsLtJiHIN+Dm4Nfg83w7QJYeyB/OmIOCIiuaTrF7YG755Pw
	arjx+D1wxkR6B/3SjzmoKQXNcsQM00xIlEEhlvRthcjq+K+MGpD0qPMBsDa6FbHTHLCu1U
	HO4hK1elA2kZigHdNkHro8HiIWzb+lS2AwO2JlnisVWZj+CqJ3JfWek/pidYshQkzGh34H
	C9uo8UQhBXKWMakuAV0kYGflH+usqluaLgk10dYcau4qqo2GLsrY4U/EOuHYuA==
From: Thijs Raymakers <thijs@raymakers.nl>
To: thomas@t-8ch.de
Cc: pauld@redhat.com,
	kzak@redhat.com,
	util-linux@vger.kernel.org,
	Thijs Raymakers <thijs@raymakers.nl>
Subject: [PATCH v4] coresched: Manage core scheduling cookies for tasks
Date: Fri,  5 Apr 2024 00:03:57 +0200
Message-ID: <20240404220358.104595-1-thijs@raymakers.nl>
In-Reply-To: <cf9125a9-281f-4940-9c32-1085680d03de@t-8ch.de>
References: <cf9125a9-281f-4940-9c32-1085680d03de@t-8ch.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Co-authored-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Thijs Raymakers <thijs@raymakers.nl>
Signed-off-by: Phil Auld <pauld@redhat.com>
---

Hi Thomas,

Thanks for your comments. This patch addresses most of your remarks. It
also adds Phil Auld as a Co-author since we went back and forth on the
design quite a lot. His feedback has been valuable and his ideas have
been integrated in the util to accomodate for both our usecases.

Op 01-04-2024 om 7:18 p.m. schreef Thomas Weißschuh:
> I guess you are aware, but the manpage is empty.

I've added the manpage in this version of the patch.

> Technically all types ending in _t are reserved for libc.
> And a conflict for cookie_t doesn't even sound that improbable.
> How about sched_core_scope, sched_core_cookie and enum sched_core_cmd?

Good suggestion, the names of these types have been changed.

> Would a single call to core_sched_get_cookie() not be a reliable check
> that can be done and reported once?
> ...
> To make clear that this works like err{,x}() maybe call it err_prctl().
> It's unfortunate that this has to be a macro.
> There are verrx() and verr() which could make this an inline function.
> We would need fallback implementations for it in include/c.h though,
> which doesn't look so hard.

I Initially wrote it like this to avoid doing more prctl calls than
necessary. All the PR_SCHED_CORE* prctl calls indicate whether or not
the kernel supports core scheduling whenever they return with errno
EINVAL.

However, if support is explicitly checked beforehand, then the error
handling becomes a bit simpler and doesn't rely on macros anymore.
Therefore, I've changed to code to explicitly check for kernel support
beforehand. This change also removes the need for the `check_prctl`
macro.

> It would be nicer if these helpers are closer named to the prctl
> operations.
> sched_core_share_from_thread() for example.

I've followed the terminology of the kernel documentation of core
scheduling (Documentation/admin-guide/hw-vuln/core-scheduling.rst) here.
There, `PR_SCHED_CORE_SHARE_TO` is described as "push core_sched cookie
to pid." and `PR_SCHED_CORE_SHARE_FROM` is described as "pull core_sched
cookie from pid"

I prefer that terminology because I find it a little less ambiguous than
SHARE_TO and SHARE_FROM.

Op 01-04-2024 om 7:18 p.m. schreef Thomas Weißschuh:
> On 2024-03-27 16:30:08+0100, Thijs Raymakers wrote:
>> +	printf("%s: copied cookie 0x%lx from PID %d to PID %d\n",
>> +	       program_invocation_short_name, before, from, to);
> stderr and only with --verbose?

This has been changed now. All operations, except getting a cookie,
will no longer print this type of information unless --verbose is passed.

> Also, please some tests.

This version adds 5 tests for coresched:
- getting the cookie of itself when no cookie is set
- setting the cookie of itself
- getting the cookie of itself when the cookie is set (must be equal to
  the cookie that was set)
- spawn a child process with a new cookie (must be different than the
  cookie of the parent process)
- spawn a child process with a new cookie and push that cookie to the
  parent process (afterwards, the cookie of the parent must be different)

An interdiff between the previous version and this version is listed
below. It also address your other remarks not mentioned in this email.

Only the bash completion script is missing, but I think that is better
suited for a follow-up patch.

Thijs

Interdiff against v3:
  diff --git a/meson.build b/meson.build
  index 9a2c04e8f..a3a648753 100644
  --- a/meson.build
  +++ b/meson.build
  @@ -3125,8 +3125,8 @@ if opt and not is_disabler(exe)
     manadocs += ['schedutils/chrt.1.adoc',
                  'schedutils/ionice.1.adoc',
                  'schedutils/taskset.1.adoc',
  -	       'schedutils/uclampset.1.adoc',
  -         'schedutils/coresched.1.adoc']
  +               'schedutils/uclampset.1.adoc',
  +               'schedutils/coresched.1.adoc']
     bashcompletions += ['chrt', 'ionice', 'taskset', 'uclampset', 'coresched']
   endif
   
  diff --git a/schedutils/coresched.1.adoc b/schedutils/coresched.1.adoc
  index 60a21cd01..34bc352a8 100644
  --- a/schedutils/coresched.1.adoc
  +++ b/schedutils/coresched.1.adoc
  @@ -14,3 +14,103 @@ coresched(1) manpage
   == NAME
   
   coresched - manage core scheduling cookies for tasks
  +
  +== SYNOPSIS
  +
  +*{command}* [options] *-p* _pid_
  +
  +*{command}* [options] \-- _command_ [_argument_...]
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
  +*-n*, *--new*::
  +Assign a new cookie to an existing PID or to execute _command_ with a new cookie.
  +
  +*-c*, *--copy*::
  +Copy the cookie from an existing PID to another PID, or execute _command_ with that copied cookie.
  +
  +If no function is specified, it will retrieve and print the cookie of a task.
  +
  +== OPTIONS
  +*-p*, *--pid* _PID_::
  +Operate on an existing PID and do not launch a new task.
  +
  +*-d*, *--dest* _PID_::
  +When using *--copy*, specify a destination PID where you want to copy the cookie to.
  +
  +*-t*, *--type* _TYPE_::
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
  +Get the core scheduling cookie of a task with PID _123_{colon}::
  +*{command} -p* _123_
  +
  +Give a task with PID _123_ a new core scheduling cookie{colon}::
  +*{command} --new -p* _123_
  +
  +Spawn a new task with a new core scheduling cookie{colon}::
  +*{command} --new* \-- _command_ [_argument_...]
  +
  +Copy the cookie from a task with pid _123_ to another task with pid _456_{colon}::
  +*{command} --copy -p* _123_ *-d* _456_
  +
  +Copy the cookie from a task with pid _123_ to a new task _command_{colon}::
  +*{command} --copy -p* _123_ \-- _command_ [_argument_...]
  +
  +Copy the cookie from a task with pid _123_ to the process group ID _456_{colon}::
  +*{command} --copy -p* _123_ *-t* pgid *-d* _456_
  +
  +== PERMISSIONS
  +When retrieving or modifying the core scheduling cookie of a process, you need to have *PTRACE_MODE_READ_REALCREDS* ptrace access to that process.
  +See the section "Ptrace access mode checking" in *ptrace*(2) for more information.
  +
  +== RETURN VALUE
  +On success, *{command}* returns 0.
  +If *{command}* fails, it will print an error and return 1.
  +If core scheduling is not supported with your kernel (e.g. because *CONFIG_SCHED_CORE*=n), then it will return 95 (*ENOTSUP*).
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
  index 756e0a1a6..3d9392b1a 100644
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
   
  @@ -47,94 +47,134 @@
   #define PR_SCHED_CORE_SCOPE_PROCESS_GROUP 2
   #endif
   
  -typedef int core_sched_type_t;
  -typedef unsigned long cookie_t;
  +typedef int sched_core_scope;
  +typedef unsigned long sched_core_cookie;
   typedef enum {
   	SCHED_CORE_CMD_GET,
   	SCHED_CORE_CMD_NEW,
   	SCHED_CORE_CMD_COPY,
  -} core_sched_cmd_t;
  +} sched_core_cmd;
   
   struct args {
   	pid_t pid;
   	pid_t dest;
  -	core_sched_type_t type;
  -	core_sched_cmd_t cmd;
  +	sched_core_scope type;
  +	sched_core_cmd cmd;
   	int exec_argv_offset;
   };
   
  -cookie_t core_sched_get_cookie(pid_t pid);
  -void core_sched_create_cookie(pid_t pid, core_sched_type_t type);
  -void core_sched_pull_cookie(pid_t from);
  -void core_sched_push_cookie(pid_t to, core_sched_type_t type);
  -void core_sched_copy_cookie(pid_t from, pid_t to, core_sched_type_t to_type);
  -void core_sched_exec_with_cookie(struct args *args, char **argv);
  -void core_sched_get_and_print_cookie(pid_t pid);
  +static bool sched_core_verbose = false;
   
  -core_sched_type_t parse_core_sched_type(char *str);
  -bool verify_arguments(struct args *args);
  -void parse_arguments(int argc, char **argv, struct args *args);
  -void set_pid_or_err(pid_t *dest, pid_t src, const char *err_msg);
  -static void __attribute__((__noreturn__)) usage(void);
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
  +	fputsln(_(" -v, --verbose      verbose"), stdout);
  +	fprintf(stdout,
  +		USAGE_HELP_OPTIONS(
  +			20)); /* char offset to align option descriptions */
  +	fprintf(stdout, USAGE_MAN_TAIL("coresched(1)"));
  +	exit(EXIT_SUCCESS);
  +}
   
   #define bad_usage(FMT...) \
   	warnx(FMT);       \
  -	errtryhelp(EINVAL);
  -
  -#define check_prctl(FMT...)                                                 \
  -	if (errno == EINVAL) {                                              \
  -		warn(FMT);                                                  \
  -		errx(errno, "Does your kernel support CONFIG_SCHED_CORE?"); \
  -	} else {                                                            \
  -		err(errno, FMT);                                            \
  -	}
  +	errtryhelp(EXIT_FAILURE);
   
  -cookie_t core_sched_get_cookie(pid_t pid)
  +static sched_core_cookie core_sched_get_cookie(pid_t pid)
   {
  -	cookie_t cookie = 0;
  +	sched_core_cookie cookie = 0;
   	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, pid,
   		  PR_SCHED_CORE_SCOPE_THREAD, &cookie)) {
  -		check_prctl("Failed to get cookie from PID %d", pid);
  +		err(EXIT_FAILURE, _("Failed to get cookie from PID %d"), pid);
   	}
   	return cookie;
   }
   
  -void core_sched_create_cookie(pid_t pid, core_sched_type_t type)
  +static void core_sched_create_cookie(pid_t pid, sched_core_scope type)
   {
   	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pid, type, 0)) {
  -		check_prctl("Failed to create cookie for PID %d", pid);
  +		err(EXIT_FAILURE, _("Failed to create cookie for PID %d"), pid);
   	}
   }
   
  -void core_sched_pull_cookie(pid_t from)
  +static void core_sched_pull_cookie(pid_t from)
   {
   	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, from,
   		  PR_SCHED_CORE_SCOPE_THREAD, 0)) {
  -		check_prctl("Failed to pull cookie from PID %d", from);
  +		err(EXIT_FAILURE, _("Failed to pull cookie from PID %d"), from);
   	}
   }
   
  -void core_sched_push_cookie(pid_t to, core_sched_type_t type)
  +static void core_sched_push_cookie(pid_t to, sched_core_scope type)
   {
   	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, to, type, 0)) {
  -		check_prctl("Failed to push cookie to PID %d", to);
  +		err(EXIT_FAILURE, _("Failed to push cookie to PID %d"), to);
   	}
   }
   
  -void core_sched_copy_cookie(pid_t from, pid_t to, core_sched_type_t to_type)
  +static void core_sched_copy_cookie(pid_t from, pid_t to,
  +				   sched_core_scope to_type)
   {
   	core_sched_pull_cookie(from);
  -	cookie_t before = core_sched_get_cookie(from);
   	core_sched_push_cookie(to, to_type);
  -	printf("%s: copied cookie 0x%lx from PID %d to PID %d\n",
  -	       program_invocation_short_name, before, from, to);
  +
  +	if (sched_core_verbose) {
  +		sched_core_cookie before = core_sched_get_cookie(from);
  +		fprintf(stderr,
  +			_("%s: copied cookie 0x%lx from PID %d to PID %d\n"),
  +			program_invocation_short_name, before, from, to);
  +	}
   }
   
  -void core_sched_exec_with_cookie(struct args *args, char **argv)
  +static void core_sched_get_and_print_cookie(pid_t pid)
   {
  -	if (!args->exec_argv_offset) {
  -		usage();
  +	if (sched_core_verbose) {
  +		sched_core_cookie after = core_sched_get_cookie(pid);
  +		fprintf(stderr, _("%s: set cookie of PID %d to 0x%lx\n"),
  +			program_invocation_short_name, pid, after);
   	}
  +}
  +
  +static void core_sched_exec_with_cookie(struct args *args, char **argv)
  +{
  +	if (!args->exec_argv_offset)
  +		usage();
   
   	// Move the argument list to the first argument of the program
   	argv = &argv[args->exec_argv_offset];
  @@ -148,9 +188,7 @@ void core_sched_exec_with_cookie(struct args *args, char **argv)
   	} else {
   		pid_t pid = getpid();
   		core_sched_create_cookie(pid, args->type);
  -		cookie_t after = core_sched_get_cookie(pid);
  -		printf("%s: set cookie of PID %d to 0x%lx\n",
  -		       program_invocation_short_name, pid, after);
  +		core_sched_get_and_print_cookie(pid);
   	}
   
   	if (execvp(argv[0], argv)) {
  @@ -158,75 +196,36 @@ void core_sched_exec_with_cookie(struct args *args, char **argv)
   	}
   }
   
  -void core_sched_get_and_print_cookie(pid_t pid)
  +// If PR_SCHED_CORE is not recognized, or not supported on this system,
  +// then prctl will set errno to EINVAL. Assuming all other operands of
  +// prctl are valid, we can use errno==EINVAL as a check to see whether
  +// core scheduling is available on this system.
  +static bool is_core_sched_supported(void)
   {
  -	cookie_t after = core_sched_get_cookie(pid);
  -	printf("%s: set cookie of PID %d to 0x%lx\n",
  -	       program_invocation_short_name, pid, after);
  +	sched_core_cookie cookie = 0;
  +	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, getpid(),
  +		  PR_SCHED_CORE_SCOPE_THREAD, &cookie)) {
  +		if (errno == EINVAL) {
  +			return false;
  +		}
  +	}
  +	return true;
   }
   
  -core_sched_type_t parse_core_sched_type(char *str)
  +static sched_core_scope parse_core_sched_type(char *str)
   {
  -	if (!strncmp(str, "pid\0", 4)) {
  +	if (!strncmp(str, "pid", 4))
   		return PR_SCHED_CORE_SCOPE_THREAD;
  -	} else if (!strncmp(str, "tgid\0", 5)) {
  +	else if (!strncmp(str, "tgid", 5))
   		return PR_SCHED_CORE_SCOPE_THREAD_GROUP;
  -	} else if (!strncmp(str, "pgid\0", 5)) {
  +	else if (!strncmp(str, "pgid", 5))
   		return PR_SCHED_CORE_SCOPE_PROCESS_GROUP;
  -	}
   
  -	bad_usage("'%s' is an invalid option. Must be one of pid/tgid/pgid",
  +	bad_usage(_("'%s' is an invalid option. Must be one of pid/tgid/pgid"),
   		  str);
  -	__builtin_unreachable();
  -}
  -
  -static void __attribute__((__noreturn__)) usage(void)
  -{
  -	fputs(USAGE_HEADER, stdout);
  -	fprintf(stdout, _(" %s [-p PID]\n"), program_invocation_short_name);
  -	fprintf(stdout, _(" %s --new [-t <TYPE>] -p <PID>\n"),
  -		program_invocation_short_name);
  -	fprintf(stdout, _(" %s --new [-t <TYPE>] -- PROGRAM [ARGS...]\n"),
  -		program_invocation_short_name);
  -	fprintf(stdout, _(" %s --copy -p <PID> [-t <TYPE>] -d <PID>\n"),
  -		program_invocation_short_name);
  -	fprintf(stdout,
  -		_(" %s --copy -p <PID> [-t <TYPE>] -- PROGRAM [ARGS...]\n"),
  -		program_invocation_short_name);
  -
  -	fputs(USAGE_SEPARATOR, stdout);
  -	fputsln(_("Manage core scheduling cookies for tasks."), stdout);
  -
  -	fputs(USAGE_FUNCTIONS, stdout);
  -	fputsln(_(" -n, --new          assign a new core scheduling cookie to an existing PID or\n"
  -		  "                      execute a program with a new cookie."),
  -		stdout);
  -	fputsln(_(" -c, --copy         copy the core scheduling cookie from an existing PID to\n"
  -		  "                      either another PID, or copy it to a new program"),
  -		stdout);
  -	fputsln(_("\n If no function is provided, it will retrieve and print the cookie from\n"
  -		  "   the PID provided via --pid.\n"),
  -		stdout);
  -
  -	fputs(USAGE_OPTIONS, stdout);
  -	fputsln(_(" -p, --pid <PID>    operate on an existing PID"), stdout);
  -	fputsln(_(" -d, --dest <PID>   when copying a cookie from an existing PID, --dest is\n"
  -		  "                      the destination PID where to copy the cookie to."),
  -		stdout);
  -	fputsln(_(" -t, --type <TYPE>  type of the destination PID, or the type of the PID\n"
  -		  "                      when a new core scheduling cookie is created.\n"
  -		  "                      Can be one of the following: pid, tgid or pgid.\n"
  -		  "                      The default is tgid."),
  -		stdout);
  -	fputs(USAGE_SEPARATOR, stdout);
  -	fprintf(stdout,
  -		USAGE_HELP_OPTIONS(
  -			20)); /* char offset to align option descriptions */
  -	fprintf(stdout, USAGE_MAN_TAIL("coresched(1)"));
  -	exit(EXIT_SUCCESS);
   }
   
  -void parse_arguments(int argc, char **argv, struct args *args)
  +static void parse_arguments(int argc, char **argv, struct args *args)
   {
   	int c;
   
  @@ -236,6 +235,7 @@ void parse_arguments(int argc, char **argv, struct args *args)
   		{ "pid", required_argument, NULL, 'p' },
   		{ "dest", required_argument, NULL, 'd' },
   		{ "type", required_argument, NULL, 't' },
  +		{ "verbose", no_argument, NULL, 'v' },
   		{ "version", no_argument, NULL, 'V' },
   		{ "help", no_argument, NULL, 'h' },
   		{ NULL, 0, NULL, 0 }
  @@ -248,7 +248,7 @@ void parse_arguments(int argc, char **argv, struct args *args)
   
   	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
   
  -	while ((c = getopt_long(argc, argv, "ncp:d:t:Vh", longopts, NULL)) !=
  +	while ((c = getopt_long(argc, argv, "ncp:d:t:vVh", longopts, NULL)) !=
   	       -1) {
   		err_exclusive_options(c, longopts, excl, excl_st);
   		switch (c) {
  @@ -260,15 +260,18 @@ void parse_arguments(int argc, char **argv, struct args *args)
   			break;
   		case 'p':
   			args->pid = strtopid_or_err(
  -				optarg, "Failed to parse PID for -p/--pid");
  +				optarg, _("Failed to parse PID for -p/--pid"));
   			break;
   		case 'd':
   			args->dest = strtopid_or_err(
  -				optarg, "Failed to parse PID for -d/--dest");
  +				optarg, _("Failed to parse PID for -d/--dest"));
   			break;
   		case 't':
   			args->type = parse_core_sched_type(optarg);
   			break;
  +		case 'v':
  +			sched_core_verbose = true;
  +			break;
   		case 'V':
   			print_version(EXIT_SUCCESS);
   		case 'h':
  @@ -279,7 +282,7 @@ void parse_arguments(int argc, char **argv, struct args *args)
   	}
   
   	if (args->cmd == SCHED_CORE_CMD_COPY && !args->pid) {
  -		bad_usage("--copy: requires a -p/--pid");
  +		bad_usage(_("--copy: requires a -p/--pid"));
   	}
   
   	// More arguments have been passed, which means that the user wants to run
  @@ -287,21 +290,21 @@ void parse_arguments(int argc, char **argv, struct args *args)
   	if (argc > optind) {
   		switch (args->cmd) {
   		case SCHED_CORE_CMD_GET:
  -			bad_usage("Unknown command");
  +			bad_usage(_("Unknown command"));
   			break;
   		case SCHED_CORE_CMD_NEW:
   			if (args->pid) {
  -				bad_usage(
  -					"--new: cannot accept both a -p/--pid and a command");
  +				bad_usage(_(
  +					"--new: cannot accept both a -p/--pid and a command"));
   			} else {
   				args->exec_argv_offset = optind;
   			}
   			break;
   		case SCHED_CORE_CMD_COPY:
   			if (args->dest) {
  -				bad_usage(
  +				bad_usage(_(
   					"--copy: cannot accept both a destination PID "
  -					"-d/--dest and a command")
  +					"-d/--dest and a command"))
   			} else {
   				args->exec_argv_offset = optind;
   			}
  @@ -311,12 +314,12 @@ void parse_arguments(int argc, char **argv, struct args *args)
   
   	if (argc <= optind) {
   		if (args->cmd == SCHED_CORE_CMD_NEW && !args->pid) {
  -			bad_usage(
  -				"--new: requires either a -p/--pid or a command");
  +			bad_usage(_(
  +				"--new: requires either a -p/--pid or a command"));
   		}
   		if (args->cmd == SCHED_CORE_CMD_COPY && !args->dest) {
  -			bad_usage(
  -				"--copy: requires either a -d/--dest or a command");
  +			bad_usage(_(
  +				"--copy: requires either a -d/--dest or a command"));
   		}
   	}
   }
  @@ -334,24 +337,27 @@ int main(int argc, char **argv)
   
   	parse_arguments(argc, argv, &args);
   
  -	cookie_t cookie = 0;
  +	if (!is_core_sched_supported()) {
  +		errx(ENOTSUP, _("Does your kernel support CONFIG_SCHED_CORE?"));
  +	}
  +
  +	sched_core_cookie cookie;
   
   	switch (args.cmd) {
   	case SCHED_CORE_CMD_GET:
   		if (args.pid) {
   			cookie = core_sched_get_cookie(args.pid);
   			if (cookie) {
  -				printf("%s: cookie of pid %d is 0x%lx\n",
  +				printf(_("%s: cookie of pid %d is 0x%lx\n"),
   				       program_invocation_short_name, args.pid,
   				       cookie);
   			} else {
   				errx(ENODATA,
  -				     "pid %d doesn't have a core scheduling cookie",
  +				     _("pid %d doesn't have a core scheduling cookie"),
   				     args.pid);
   			}
   		} else {
   			usage();
  -			exit(0);
   		}
   		break;
   	case SCHED_CORE_CMD_NEW:
  @@ -363,14 +369,12 @@ int main(int argc, char **argv)
   		}
   		break;
   	case SCHED_CORE_CMD_COPY:
  -		if (args.dest) {
  +		if (args.dest)
   			core_sched_copy_cookie(args.pid, args.dest, args.type);
  -		} else {
  +		else
   			core_sched_exec_with_cookie(&args, argv);
  -		}
   		break;
   	default:
   		usage();
  -		exit(1);
   	}
   }
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
  diff --git a/tests/expected/schedutils/coresched-change-cookie-of-parent b/tests/expected/schedutils/coresched-change-cookie-of-parent
  new file mode 100644
  index 000000000..97ab7ea23
  --- /dev/null
  +++ b/tests/expected/schedutils/coresched-change-cookie-of-parent
  @@ -0,0 +1 @@
  +coresched: cookie of pid OWN_PID is DIFFERENT_COOKIE
  diff --git a/tests/expected/schedutils/coresched-get-own-pid-no-cookie b/tests/expected/schedutils/coresched-get-own-pid-no-cookie
  new file mode 100644
  index 000000000..7f64a98b3
  --- /dev/null
  +++ b/tests/expected/schedutils/coresched-get-own-pid-no-cookie
  @@ -0,0 +1 @@
  +coresched: pid OWN_PID doesn't have a core scheduling cookie
  diff --git a/tests/expected/schedutils/coresched-get-own-pid-with-cookie b/tests/expected/schedutils/coresched-get-own-pid-with-cookie
  new file mode 100644
  index 000000000..556e31a65
  --- /dev/null
  +++ b/tests/expected/schedutils/coresched-get-own-pid-with-cookie
  @@ -0,0 +1 @@
  +coresched: cookie of pid OWN_PID is COOKIE
  diff --git a/tests/expected/schedutils/coresched-set-cookie-own-pid b/tests/expected/schedutils/coresched-set-cookie-own-pid
  new file mode 100644
  index 000000000..1816a4fbd
  --- /dev/null
  +++ b/tests/expected/schedutils/coresched-set-cookie-own-pid
  @@ -0,0 +1 @@
  +coresched: set cookie of PID OWN_PID to COOKIE
  diff --git a/tests/expected/schedutils/coresched-spawn-child-with-new-cookie b/tests/expected/schedutils/coresched-spawn-child-with-new-cookie
  new file mode 100644
  index 000000000..5b9c40052
  --- /dev/null
  +++ b/tests/expected/schedutils/coresched-spawn-child-with-new-cookie
  @@ -0,0 +1 @@
  +DIFFERENT_COOKIE
  diff --git a/tests/ts/schedutils/coresched b/tests/ts/schedutils/coresched
  new file mode 100755
  index 000000000..5381a56f2
  --- /dev/null
  +++ b/tests/ts/schedutils/coresched
  @@ -0,0 +1,55 @@
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
  +
  +# The output of coresched contains PIDs and core scheduling cookies, both of which should be
  +# assumed to be random values as we have no control over them. The tests replace these values
  +# with sed before writing them to the output file, so it can match the expected output file.
  +# - The PID of this bash script is replaced with the placeholder `OWN_PID`
  +# - The core scheduling cookie of this bash script is replaced by `COOKIE`
  +# - Any other cookie is replaced by `DIFFERENT_COOKIE`
  +# The behavior of coresched does not depend on the exact values of these cookies, so using
  +# placeholder values does not change the behavior tests.
  +ts_init_subtest "get-own-pid-no-cookie"
  +$TS_CMD_CORESCHED -p $$ 3>&2 2>&1 1>&3 | sed "s/$$/OWN_PID/g" >> "$TS_OUTPUT"
  +ts_finalize_subtest
  +
  +ts_init_subtest "set-cookie-own-pid"
  +CORESCHED_OUTPUT=$($TS_CMD_CORESCHED -v -n -p $$ 3>&2 2>&1 1>&3 | sed "s/$$/OWN_PID/g")
  +CORESCHED_COOKIE=$(echo "$CORESCHED_OUTPUT" | sed 's/^.*\(0x.*$\)/\1/g')
  +CORESCHED_OUTPUT=$(echo "$CORESCHED_OUTPUT" | sed "s/$CORESCHED_COOKIE/COOKIE/g")
  +echo "$CORESCHED_OUTPUT" >> "$TS_OUTPUT"
  +ts_finalize_subtest
  +
  +ts_init_subtest "get-own-pid-with-cookie"
  +$TS_CMD_CORESCHED -p $$ | sed "s/$$/OWN_PID/g" | sed "s/$CORESCHED_COOKIE/COOKIE/g" >> "$TS_OUTPUT"
  +ts_finalize_subtest
  +
  +ts_init_subtest "spawn-child-with-new-cookie"
  +$TS_CMD_CORESCHED -n -- /bin/bash -c "$TS_CMD_CORESCHED -p \$\$" \
  +  | sed 's/^.*\(0x.*$\)/\1/g' \
  +  | sed "s/$CORESCHED_COOKIE/SAME_COOKIE/g" \
  +  | sed "s/0x.*$/DIFFERENT_COOKIE/g" >> "$TS_OUTPUT"
  +ts_finalize_subtest
  +
  +ts_init_subtest "change-cookie-of-parent"
  +$TS_CMD_CORESCHED -n -- /bin/bash -c "$TS_CMD_CORESCHED -c -p \$\$ -d $$"
  +$TS_CMD_CORESCHED -p $$ \
  +  | sed "s/$$/OWN_PID/g" \
  +  | sed "s/$CORESCHED_COOKIE/COOKIE/g" \
  +  | sed "s/0x.*$/DIFFERENT_COOKIE/g" >> "$TS_OUTPUT"
  +ts_finalize_subtest
  +
  +ts_finalize

 .gitignore                                    |   1 +
 bash-completion/coresched                     |   0
 configure.ac                                  |  12 +-
 meson.build                                   |  16 +-
 meson_options.txt                             |   2 +-
 schedutils/Makemodule.am                      |   8 +
 schedutils/coresched.1.adoc                   | 116 ++++++
 schedutils/coresched.c                        | 380 ++++++++++++++++++
 tests/commands.sh                             |   1 +
 .../coresched-change-cookie-of-parent         |   1 +
 .../coresched-get-own-pid-no-cookie           |   1 +
 .../coresched-get-own-pid-with-cookie         |   1 +
 .../schedutils/coresched-set-cookie-own-pid   |   1 +
 .../coresched-spawn-child-with-new-cookie     |   1 +
 tests/ts/schedutils/coresched                 |  55 +++
 15 files changed, 590 insertions(+), 6 deletions(-)
 create mode 100644 bash-completion/coresched
 create mode 100644 schedutils/coresched.1.adoc
 create mode 100644 schedutils/coresched.c
 create mode 100644 tests/expected/schedutils/coresched-change-cookie-of-parent
 create mode 100644 tests/expected/schedutils/coresched-get-own-pid-no-cookie
 create mode 100644 tests/expected/schedutils/coresched-get-own-pid-with-cookie
 create mode 100644 tests/expected/schedutils/coresched-set-cookie-own-pid
 create mode 100644 tests/expected/schedutils/coresched-spawn-child-with-new-cookie
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
index 000000000..34bc352a8
--- /dev/null
+++ b/schedutils/coresched.1.adoc
@@ -0,0 +1,116 @@
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
+*{command}* [options] *-p* _pid_
+
+*{command}* [options] \-- _command_ [_argument_...]
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
+*-n*, *--new*::
+Assign a new cookie to an existing PID or to execute _command_ with a new cookie.
+
+*-c*, *--copy*::
+Copy the cookie from an existing PID to another PID, or execute _command_ with that copied cookie.
+
+If no function is specified, it will retrieve and print the cookie of a task.
+
+== OPTIONS
+*-p*, *--pid* _PID_::
+Operate on an existing PID and do not launch a new task.
+
+*-d*, *--dest* _PID_::
+When using *--copy*, specify a destination PID where you want to copy the cookie to.
+
+*-t*, *--type* _TYPE_::
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
+Get the core scheduling cookie of a task with PID _123_{colon}::
+*{command} -p* _123_
+
+Give a task with PID _123_ a new core scheduling cookie{colon}::
+*{command} --new -p* _123_
+
+Spawn a new task with a new core scheduling cookie{colon}::
+*{command} --new* \-- _command_ [_argument_...]
+
+Copy the cookie from a task with pid _123_ to another task with pid _456_{colon}::
+*{command} --copy -p* _123_ *-d* _456_
+
+Copy the cookie from a task with pid _123_ to a new task _command_{colon}::
+*{command} --copy -p* _123_ \-- _command_ [_argument_...]
+
+Copy the cookie from a task with pid _123_ to the process group ID _456_{colon}::
+*{command} --copy -p* _123_ *-t* pgid *-d* _456_
+
+== PERMISSIONS
+When retrieving or modifying the core scheduling cookie of a process, you need to have *PTRACE_MODE_READ_REALCREDS* ptrace access to that process.
+See the section "Ptrace access mode checking" in *ptrace*(2) for more information.
+
+== RETURN VALUE
+On success, *{command}* returns 0.
+If *{command}* fails, it will print an error and return 1.
+If core scheduling is not supported with your kernel (e.g. because *CONFIG_SCHED_CORE*=n), then it will return 95 (*ENOTSUP*).
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
index 000000000..3d9392b1a
--- /dev/null
+++ b/schedutils/coresched.c
@@ -0,0 +1,380 @@
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
+typedef int sched_core_scope;
+typedef unsigned long sched_core_cookie;
+typedef enum {
+	SCHED_CORE_CMD_GET,
+	SCHED_CORE_CMD_NEW,
+	SCHED_CORE_CMD_COPY,
+} sched_core_cmd;
+
+struct args {
+	pid_t pid;
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
+	fputsln(_(" -v, --verbose      verbose"), stdout);
+	fprintf(stdout,
+		USAGE_HELP_OPTIONS(
+			20)); /* char offset to align option descriptions */
+	fprintf(stdout, USAGE_MAN_TAIL("coresched(1)"));
+	exit(EXIT_SUCCESS);
+}
+
+#define bad_usage(FMT...) \
+	warnx(FMT);       \
+	errtryhelp(EXIT_FAILURE);
+
+static sched_core_cookie core_sched_get_cookie(pid_t pid)
+{
+	sched_core_cookie cookie = 0;
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, pid,
+		  PR_SCHED_CORE_SCOPE_THREAD, &cookie)) {
+		err(EXIT_FAILURE, _("Failed to get cookie from PID %d"), pid);
+	}
+	return cookie;
+}
+
+static void core_sched_create_cookie(pid_t pid, sched_core_scope type)
+{
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pid, type, 0)) {
+		err(EXIT_FAILURE, _("Failed to create cookie for PID %d"), pid);
+	}
+}
+
+static void core_sched_pull_cookie(pid_t from)
+{
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, from,
+		  PR_SCHED_CORE_SCOPE_THREAD, 0)) {
+		err(EXIT_FAILURE, _("Failed to pull cookie from PID %d"), from);
+	}
+}
+
+static void core_sched_push_cookie(pid_t to, sched_core_scope type)
+{
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, to, type, 0)) {
+		err(EXIT_FAILURE, _("Failed to push cookie to PID %d"), to);
+	}
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
+		fprintf(stderr,
+			_("%s: copied cookie 0x%lx from PID %d to PID %d\n"),
+			program_invocation_short_name, before, from, to);
+	}
+}
+
+static void core_sched_get_and_print_cookie(pid_t pid)
+{
+	if (sched_core_verbose) {
+		sched_core_cookie after = core_sched_get_cookie(pid);
+		fprintf(stderr, _("%s: set cookie of PID %d to 0x%lx\n"),
+			program_invocation_short_name, pid, after);
+	}
+}
+
+static void core_sched_exec_with_cookie(struct args *args, char **argv)
+{
+	if (!args->exec_argv_offset)
+		usage();
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
+		core_sched_get_and_print_cookie(pid);
+	}
+
+	if (execvp(argv[0], argv)) {
+		errexec(argv[0]);
+	}
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
+		  PR_SCHED_CORE_SCOPE_THREAD, &cookie)) {
+		if (errno == EINVAL) {
+			return false;
+		}
+	}
+	return true;
+}
+
+static sched_core_scope parse_core_sched_type(char *str)
+{
+	if (!strncmp(str, "pid", 4))
+		return PR_SCHED_CORE_SCOPE_THREAD;
+	else if (!strncmp(str, "tgid", 5))
+		return PR_SCHED_CORE_SCOPE_THREAD_GROUP;
+	else if (!strncmp(str, "pgid", 5))
+		return PR_SCHED_CORE_SCOPE_PROCESS_GROUP;
+
+	bad_usage(_("'%s' is an invalid option. Must be one of pid/tgid/pgid"),
+		  str);
+}
+
+static void parse_arguments(int argc, char **argv, struct args *args)
+{
+	int c;
+
+	static const struct option longopts[] = {
+		{ "new", no_argument, NULL, 'n' },
+		{ "copy", no_argument, NULL, 'c' },
+		{ "pid", required_argument, NULL, 'p' },
+		{ "dest", required_argument, NULL, 'd' },
+		{ "type", required_argument, NULL, 't' },
+		{ "verbose", no_argument, NULL, 'v' },
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
+	while ((c = getopt_long(argc, argv, "ncp:d:t:vVh", longopts, NULL)) !=
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
+				optarg, _("Failed to parse PID for -p/--pid"));
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
+	}
+
+	if (args->cmd == SCHED_CORE_CMD_COPY && !args->pid) {
+		bad_usage(_("--copy: requires a -p/--pid"));
+	}
+
+	// More arguments have been passed, which means that the user wants to run
+	// another program with a core scheduling cookie.
+	if (argc > optind) {
+		switch (args->cmd) {
+		case SCHED_CORE_CMD_GET:
+			bad_usage(_("Unknown command"));
+			break;
+		case SCHED_CORE_CMD_NEW:
+			if (args->pid) {
+				bad_usage(_(
+					"--new: cannot accept both a -p/--pid and a command"));
+			} else {
+				args->exec_argv_offset = optind;
+			}
+			break;
+		case SCHED_CORE_CMD_COPY:
+			if (args->dest) {
+				bad_usage(_(
+					"--copy: cannot accept both a destination PID "
+					"-d/--dest and a command"))
+			} else {
+				args->exec_argv_offset = optind;
+			}
+			break;
+		}
+	}
+
+	if (argc <= optind) {
+		if (args->cmd == SCHED_CORE_CMD_NEW && !args->pid) {
+			bad_usage(_(
+				"--new: requires either a -p/--pid or a command"));
+		}
+		if (args->cmd == SCHED_CORE_CMD_COPY && !args->dest) {
+			bad_usage(_(
+				"--copy: requires either a -d/--dest or a command"));
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
+	if (!is_core_sched_supported()) {
+		errx(ENOTSUP, _("Does your kernel support CONFIG_SCHED_CORE?"));
+	}
+
+	sched_core_cookie cookie;
+
+	switch (args.cmd) {
+	case SCHED_CORE_CMD_GET:
+		if (args.pid) {
+			cookie = core_sched_get_cookie(args.pid);
+			if (cookie) {
+				printf(_("%s: cookie of pid %d is 0x%lx\n"),
+				       program_invocation_short_name, args.pid,
+				       cookie);
+			} else {
+				errx(ENODATA,
+				     _("pid %d doesn't have a core scheduling cookie"),
+				     args.pid);
+			}
+		} else {
+			usage();
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
+		if (args.dest)
+			core_sched_copy_cookie(args.pid, args.dest, args.type);
+		else
+			core_sched_exec_with_cookie(&args, argv);
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
diff --git a/tests/expected/schedutils/coresched-change-cookie-of-parent b/tests/expected/schedutils/coresched-change-cookie-of-parent
new file mode 100644
index 000000000..97ab7ea23
--- /dev/null
+++ b/tests/expected/schedutils/coresched-change-cookie-of-parent
@@ -0,0 +1 @@
+coresched: cookie of pid OWN_PID is DIFFERENT_COOKIE
diff --git a/tests/expected/schedutils/coresched-get-own-pid-no-cookie b/tests/expected/schedutils/coresched-get-own-pid-no-cookie
new file mode 100644
index 000000000..7f64a98b3
--- /dev/null
+++ b/tests/expected/schedutils/coresched-get-own-pid-no-cookie
@@ -0,0 +1 @@
+coresched: pid OWN_PID doesn't have a core scheduling cookie
diff --git a/tests/expected/schedutils/coresched-get-own-pid-with-cookie b/tests/expected/schedutils/coresched-get-own-pid-with-cookie
new file mode 100644
index 000000000..556e31a65
--- /dev/null
+++ b/tests/expected/schedutils/coresched-get-own-pid-with-cookie
@@ -0,0 +1 @@
+coresched: cookie of pid OWN_PID is COOKIE
diff --git a/tests/expected/schedutils/coresched-set-cookie-own-pid b/tests/expected/schedutils/coresched-set-cookie-own-pid
new file mode 100644
index 000000000..1816a4fbd
--- /dev/null
+++ b/tests/expected/schedutils/coresched-set-cookie-own-pid
@@ -0,0 +1 @@
+coresched: set cookie of PID OWN_PID to COOKIE
diff --git a/tests/expected/schedutils/coresched-spawn-child-with-new-cookie b/tests/expected/schedutils/coresched-spawn-child-with-new-cookie
new file mode 100644
index 000000000..5b9c40052
--- /dev/null
+++ b/tests/expected/schedutils/coresched-spawn-child-with-new-cookie
@@ -0,0 +1 @@
+DIFFERENT_COOKIE
diff --git a/tests/ts/schedutils/coresched b/tests/ts/schedutils/coresched
new file mode 100755
index 000000000..5381a56f2
--- /dev/null
+++ b/tests/ts/schedutils/coresched
@@ -0,0 +1,55 @@
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
+
+# The output of coresched contains PIDs and core scheduling cookies, both of which should be
+# assumed to be random values as we have no control over them. The tests replace these values
+# with sed before writing them to the output file, so it can match the expected output file.
+# - The PID of this bash script is replaced with the placeholder `OWN_PID`
+# - The core scheduling cookie of this bash script is replaced by `COOKIE`
+# - Any other cookie is replaced by `DIFFERENT_COOKIE`
+# The behavior of coresched does not depend on the exact values of these cookies, so using
+# placeholder values does not change the behavior tests.
+ts_init_subtest "get-own-pid-no-cookie"
+$TS_CMD_CORESCHED -p $$ 3>&2 2>&1 1>&3 | sed "s/$$/OWN_PID/g" >> "$TS_OUTPUT"
+ts_finalize_subtest
+
+ts_init_subtest "set-cookie-own-pid"
+CORESCHED_OUTPUT=$($TS_CMD_CORESCHED -v -n -p $$ 3>&2 2>&1 1>&3 | sed "s/$$/OWN_PID/g")
+CORESCHED_COOKIE=$(echo "$CORESCHED_OUTPUT" | sed 's/^.*\(0x.*$\)/\1/g')
+CORESCHED_OUTPUT=$(echo "$CORESCHED_OUTPUT" | sed "s/$CORESCHED_COOKIE/COOKIE/g")
+echo "$CORESCHED_OUTPUT" >> "$TS_OUTPUT"
+ts_finalize_subtest
+
+ts_init_subtest "get-own-pid-with-cookie"
+$TS_CMD_CORESCHED -p $$ | sed "s/$$/OWN_PID/g" | sed "s/$CORESCHED_COOKIE/COOKIE/g" >> "$TS_OUTPUT"
+ts_finalize_subtest
+
+ts_init_subtest "spawn-child-with-new-cookie"
+$TS_CMD_CORESCHED -n -- /bin/bash -c "$TS_CMD_CORESCHED -p \$\$" \
+  | sed 's/^.*\(0x.*$\)/\1/g' \
+  | sed "s/$CORESCHED_COOKIE/SAME_COOKIE/g" \
+  | sed "s/0x.*$/DIFFERENT_COOKIE/g" >> "$TS_OUTPUT"
+ts_finalize_subtest
+
+ts_init_subtest "change-cookie-of-parent"
+$TS_CMD_CORESCHED -n -- /bin/bash -c "$TS_CMD_CORESCHED -c -p \$\$ -d $$"
+$TS_CMD_CORESCHED -p $$ \
+  | sed "s/$$/OWN_PID/g" \
+  | sed "s/$CORESCHED_COOKIE/COOKIE/g" \
+  | sed "s/0x.*$/DIFFERENT_COOKIE/g" >> "$TS_OUTPUT"
+ts_finalize_subtest
+
+ts_finalize
-- 
2.44.0

