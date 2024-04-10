Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489C51E877
	for <util-linux@vger.kernel.org>; Wed, 10 Apr 2024 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783528; cv=none; b=i3g42S8UwaacPnQAGMqsX/YgY5MgFFG45FBv13xg7HI4g8WXE5k9f3kHIhDNBOM/hW3oUh568p+pOiMoJEYq5vvrPG9hE+iPD6KaVO7RAGNKOEUuzQkkxduJ82adMF4smXUcXA81rBKDBR7vUTHxxyoA43Z6ox4rmmJLAzNzXQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783528; c=relaxed/simple;
	bh=jN6mBD97iuLtswWV668du2iyXdVOoN39wCOdf3VFy0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pE4vuqyjb1xXMRrmMj2M3BgKWn6wdV4TmaRFdvztP/VooGYZWEQhIS4PrNTAHvc4rBcA6q8064RL5UoPfEQaIjshUpAErHqBk7jZvRZDpayXbIoPd1h+7x729/ExyBCjevWeBtn6wQFGCiv28U9N/BxQOjWeB224VnalFI/udQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raymakers.nl; spf=pass smtp.mailfrom=raymakers.nl; dkim=pass (2048-bit key) header.d=raymakers.nl header.i=@raymakers.nl header.b=d1V5hPpG; arc=none smtp.client-ip=185.233.34.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raymakers.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raymakers.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raymakers.nl header.i=@raymakers.nl header.b="d1V5hPpG"
Received: from smtp.soverin.net (c04cst-smtp-sov02.int.sover.in [10.10.4.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4VFFrS6xL7z9H;
	Wed, 10 Apr 2024 21:11:52 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.100]) by soverin.net (Postfix) with ESMTPSA id 4VFFrS3PqKzJd;
	Wed, 10 Apr 2024 21:11:52 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=raymakers.nl header.i=@raymakers.nl header.a=rsa-sha256 header.s=soverin1 header.b=d1V5hPpG;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raymakers.nl;
	s=soverin1; t=1712783512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtzrajEaDORVJdb6XTJ8rO4C11Ca9/qWeRhqFj2KXLc=;
	b=d1V5hPpGNmKZQfej/t+muHV/GkeUJuSAeujeGcrxZit0hZppEkOQPrgSXw1V58OwfX/Sj/
	Zf4v1UHHeF8Jv+zjZ06CexcvdpZoie6YX0+Ud3ujC97Dr2T7qCFGo82djcwPCkuRObr69Z
	d0aKx2W8z+Hmailm/fzdp7lRRxKjWzZpRu/zPhm5vLlgBOtJZtfmLLfXF9y4bRtKFeDIF9
	OyY0kizYYzuE+nra/FCSHeIXSSW6Ooy8IkyH2XGW2GMj5ZHtnQZjTS/iJzfNW2ABe3ylP6
	RzMM+TY6yq1QTjMwn9YmAxKyP6nxKR7qGomLupAQ+ZkBntzbl1b1D7seCTphPQ==
From: Thijs Raymakers <thijs@raymakers.nl>
To: kzak@redhat.com
Cc: thomas@t-8ch.de,
	pauld@redhat.com,
	util-linux@vger.kernel.org,
	Thijs Raymakers <thijs@raymakers.nl>
Subject: [PATCH v7] coresched: Manage core scheduling cookies for tasks
Date: Wed, 10 Apr 2024 23:11:41 +0200
Message-ID: <20240410211142.260087-1-thijs@raymakers.nl>
In-Reply-To: <20240409134430.twndleg7rxnfsf4m@ws.net.home>
References: <20240409134430.twndleg7rxnfsf4m@ws.net.home>
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

Hi Karel,

Thanks for the review!

Op 09-04-2024 om 3:44 p.m. schreef Karel Zak:
> I find it a little confusing that the --pid is sometimes used as a
> source and in other cases as a destination.
> 
>      coresched --new --pid 123              # pid is destination
>      coresched --copy --pid 123 --dest 456  # pid is source
> 
> It seems --copy always requires a source PID (according to the man
> page), why not require a PID as argument for --copy:
> 
>     coresched --copy 123 --pid 456
> 
> in this way --pid will be always destination (for 'copy' and 'new'
> functions) and you will not need extra --dest option at all.
> 
> If you want to keep the basic functions (e.g. --copy) without
> arguments, it would be better to have --source, --dest, and
> --dest-type instead of using the ambiguous --pid.
> 
> I can also imagine the basic "functions" without "--".
> 
>     coresched [get] [--dest] 123
>     coresched copy [--source] 123 [--dest] 456
>     coresched new [--dest] 456
> 
> In my opinion, we do not have to strictly adhere to old taskset or
> similar commands.

The command line arguments are currently somewhat similar in meaning
to the arguments of taskset, which Phil mentioned he preferred.
taskset (and others) uses --pid to refer to the PID. This works
fine if you operate on just a single PID.

I agree that this version of coresched can be indeed confusing to
use if --pid is overloaded to mean both "source" and
"destination", depending on the context. coresched needs at most two
PIDs and can thus not use --pid for everything.

How those two options are called/used seems to be a tradeoff between
the familiarity by taskset users vs consistency within coreset.
Either you use --pid which is familiar to users because other programs
define PIDs like that, but the semantics will be inconsistent and will
change depending what function of coresched you use.
Or you use --source and --dest, which is a bit more inconvenient to
use because you cannot use the same option to refer to a PID across the
different coresed functions, but you will have consistent behavior of
each option.

Since you mention that we don't strictly have to adhere to taskset, I
do have a slight preference for --source/--dest instead of --pid/--dest.
With the help of the usage and/or man page, this difference shouldn't be
too cumbersome to users that are familiar with other tools. The benefit
of internal consistency outweights the benefit of familiarity in my
opinion.

Version 7 of the patch changes the arguments from --pid/--dest/--type
(-t/-d/-t) to --source/--dest/--dest-type (-s/-d/-t). It also has the
functions without the "--", as well as the other suggestions that you
made. I've also added two more tests.

The commands now look something like this

    coresched [get] [--source <PID>]
    coresched new [-t <TYPE>] --dest <PID>
    coresched new [-t <TYPE>] -- PROGRAM [ARGS...]
    coresched copy [--source <PID>] [-t <TYPE>] --dest <PID>
    coresched copy [--source <PID>] [-t <TYPE>] -- PROGRAM [ARGS...]

> It should be noted that command line arguments are crucial, as they
> are difficult to modify after release.

It is good that you mentioned that the arguments felt confusing to use,
because that is something that became a bit invisible to me after using
the util for some time. It is important to get the arguments right, and
making sure that they are sensible and self-consistent. These new
command line arguments work for me as well. Phil previously expressed a
preference for the --pid style so would like to know what his opinion is.

> pedantic note, use extra space within ifdef
> 
> #ifndef PR_SCHED_CORE
> # define PR_SCHED_CORE 62
> #endif

I've changed to

#ifndef PR_SCHED_CORE
	#define PR_SCHED_CORE 62
#endif

which looks a bit nicer in my opinion than what clang-format does with
the AfterHash option. (I've used IndentPPDirectives: BeforeHash instead
of IndentPPDirectives: None, which is the default in the kernel
clang-format file)


CC: Phil Auld and Thomas Weißschuh
I've removed your Signed-off-by/Reviewed-by tags since this version
differs significantly from the version that you've previously reviewed.
I did't want to just assume that you approve of this version as well.
With your permission, I can add the tags back again.


Thijs

Interdiff against v6:
  diff --git a/schedutils/coresched.1.adoc b/schedutils/coresched.1.adoc
  index c83fcdf91..00f2603e0 100644
  --- a/schedutils/coresched.1.adoc
  +++ b/schedutils/coresched.1.adoc
  @@ -17,9 +17,15 @@ coresched - manage core scheduling cookies for tasks
   
   == SYNOPSIS
   
  -*{command}* [options] *-p* _pid_
  +*{command}* [*get*] [*-s* _pid_]
   
  -*{command}* [options] \-- _command_ [_argument_...]
  +*{command}* *new* [*-t* _type_] *-d* _pid_
  +
  +*{command}* *new* [*-t* _type_] \-- _command_ [_argument_...]
  +
  +*{command}* *copy* [*-s* _pid_] [*-t* _type_] *-d* _pid_
  +
  +*{command}* *copy* [*-s* _pid_] [*-t* _type_] \-- _command_ [_argument_...]
   
   == DESCRIPTION
   The *{command}* command is used to retrieve or modify the core scheduling cookies of a running process given its _pid_, or to spawn a new _command_ with core scheduling cookies.
  @@ -31,22 +37,28 @@ Only tasks have the same cookie are allowed to be scheduled on the same physical
   It is possible to either assign a new random cookie to a task, or copy a cookie from another task. It is not possible to choose the value of the cookie.
   
   == FUNCTIONS
  -*-n*, *--new*::
  -Assign a new cookie to an existing PID or to execute _command_ with a new cookie.
  +*get*::
  +Retrieve the core scheduling cookie of the PID specified in *-s*.
  +If *-s* is omitted, it will get the cookie of the current *{command}* process.
   
  -*-c*, *--copy*::
  -Copy the cookie from an existing PID to another PID, or execute _command_ with that copied cookie.
  +*new*::
  +Assign a new cookie to an existing PID specified in *-d*, or execute _command_ with a new cookie.
   
  -If no function is specified, it will print the cookie of the current task, or of the task specified with the *-p* option.
  +*copy*::
  +Copy the cookie from an existing PID (*-s*) to another PID (*-d*), or execute _command_ with that cookie.
  +If *-s* is omitted, it will get the cookie of the current *{command}* process.
  +
  +If no function is specified, it will run the *get* function.
   
   == OPTIONS
  -*-p*, *--pid* _PID_::
  -Operate on an existing PID and do not launch a new task.
  +*-s*, *--source* _PID_::
  +Which _PID_ to get the cookie from.
  +If this option is omitted, it will get the cookie from the current *{command}* process.
   
   *-d*, *--dest* _PID_::
  -When using *--copy*, specify a destination PID where you want to copy the cookie to.
  +Which _PID_ to modify the cookie of.
   
  -*-t*, *--type* _TYPE_::
  +*-t*, *--dest-type* _TYPE_::
   The type of the PID whose cookie will be modified. This can be one of three values:
   - *pid*, or process ID
   - *tgid*, or thread group ID (default value)
  @@ -63,25 +75,28 @@ Print version and exit.
   
   == EXAMPLES
   Get the core scheduling cookie of the {command} task itself, usually inherited from its parent{colon}::
  -*{command}*
  +*{command} get*
   
   Get the core scheduling cookie of a task with PID _123_{colon}::
  -*{command} -p* _123_
  +*{command} get -s* _123_
   
   Give a task with PID _123_ a new core scheduling cookie{colon}::
  -*{command} --new -p* _123_
  +*{command} new -d* _123_
   
   Spawn a new task with a new core scheduling cookie{colon}::
  -*{command} --new* \-- _command_ [_argument_...]
  +*{command} new* \-- _command_ [_argument_...]
  +
  +Copy the cookie from the current {command} process another task with pid _456_{colon}::
  +*{command} copy -d* _456_
   
   Copy the cookie from a task with pid _123_ to another task with pid _456_{colon}::
  -*{command} --copy -p* _123_ *-d* _456_
  +*{command} copy -s* _123_ *-d* _456_
   
   Copy the cookie from a task with pid _123_ to a new task _command_{colon}::
  -*{command} --copy -p* _123_ \-- _command_ [_argument_...]
  +*{command} copy -s* _123_ \-- _command_ [_argument_...]
   
   Copy the cookie from a task with pid _123_ to the process group ID _456_{colon}::
  -*{command} --copy -p* _123_ *-t* pgid *-d* _456_
  +*{command} copy -s* _123_ *-t* _pgid_ *-d* _456_
   
   == PERMISSIONS
   When retrieving or modifying the core scheduling cookie of a process, you need to have *PTRACE_MODE_READ_REALCREDS* ptrace access to that process.
  @@ -98,12 +113,11 @@ If a _command_ is being executed, the return value of *{command}* will be the re
   This can be enabled via the *CONFIG_SCHED_CORE* kernel config option.
   
   == AUTHORS
  -mailto:thijs@raymakers.nl[Thijs Raymakers],
  -mailto:pauld@redhat.com[Phil Auld]
  +mailto:thijs@raymakers.nl[Thijs Raymakers]
   
   == COPYRIGHT
   
  -Copyright {copyright} 2024 Thijs Raymakers and Phil Auld. This is free software licensed under the EUPL.
  +Copyright {copyright} 2024 Thijs Raymakers. This is free software licensed under the EUPL.
   
   == SEE ALSO
   *chrt*(1),
  diff --git a/schedutils/coresched.c b/schedutils/coresched.c
  index b6be1717d..7e3cc46d2 100644
  --- a/schedutils/coresched.c
  +++ b/schedutils/coresched.c
  @@ -3,7 +3,7 @@
    *
    * coresched.c - manage core scheduling cookies for tasks
    *
  - * Copyright (C) 2024 Thijs Raymakers, Phil Auld
  + * Copyright (C) 2024 Thijs Raymakers
    * Licensed under the EUPL v1.2
    */
   
  @@ -16,34 +16,33 @@
   #include "c.h"
   #include "closestream.h"
   #include "nls.h"
  -#include "optutils.h"
   #include "strutils.h"
   
   // These definitions might not be defined in the header files, even if the
   // prctl interface in the kernel accepts them as valid.
   #ifndef PR_SCHED_CORE
  -#define PR_SCHED_CORE 62
  +	#define PR_SCHED_CORE 62
   #endif
   #ifndef PR_SCHED_CORE_GET
  -#define PR_SCHED_CORE_GET 0
  +	#define PR_SCHED_CORE_GET 0
   #endif
   #ifndef PR_SCHED_CORE_CREATE
  -#define PR_SCHED_CORE_CREATE 1
  +	#define PR_SCHED_CORE_CREATE 1
   #endif
   #ifndef PR_SCHED_CORE_SHARE_TO
  -#define PR_SCHED_CORE_SHARE_TO 2
  +	#define PR_SCHED_CORE_SHARE_TO 2
   #endif
   #ifndef PR_SCHED_CORE_SHARE_FROM
  -#define PR_SCHED_CORE_SHARE_FROM 3
  +	#define PR_SCHED_CORE_SHARE_FROM 3
   #endif
   #ifndef PR_SCHED_CORE_SCOPE_THREAD
  -#define PR_SCHED_CORE_SCOPE_THREAD 0
  +	#define PR_SCHED_CORE_SCOPE_THREAD 0
   #endif
   #ifndef PR_SCHED_CORE_SCOPE_THREAD_GROUP
  -#define PR_SCHED_CORE_SCOPE_THREAD_GROUP 1
  +	#define PR_SCHED_CORE_SCOPE_THREAD_GROUP 1
   #endif
   #ifndef PR_SCHED_CORE_SCOPE_PROCESS_GROUP
  -#define PR_SCHED_CORE_SCOPE_PROCESS_GROUP 2
  +	#define PR_SCHED_CORE_SCOPE_PROCESS_GROUP 2
   #endif
   
   typedef int sched_core_scope;
  @@ -55,7 +54,7 @@ typedef enum {
   } sched_core_cmd;
   
   struct args {
  -	pid_t pid;
  +	pid_t src;
   	pid_t dest;
   	sched_core_scope type;
   	sched_core_cmd cmd;
  @@ -67,40 +66,44 @@ static bool sched_core_verbose = false;
   static void __attribute__((__noreturn__)) usage(void)
   {
   	fputs(USAGE_HEADER, stdout);
  -	fprintf(stdout, _(" %s [-p PID]\n"), program_invocation_short_name);
  -	fprintf(stdout, _(" %s --new [-t <TYPE>] -p <PID>\n"),
  +	fprintf(stdout, _(" %s [get] [--source <PID>]\n"),
   		program_invocation_short_name);
  -	fprintf(stdout, _(" %s --new [-t <TYPE>] -- PROGRAM [ARGS...]\n"),
  +	fprintf(stdout, _(" %s new [-t <TYPE>] --dest <PID>\n"),
   		program_invocation_short_name);
  -	fprintf(stdout, _(" %s --copy -p <PID> [-t <TYPE>] -d <PID>\n"),
  +	fprintf(stdout, _(" %s new [-t <TYPE>] -- PROGRAM [ARGS...]\n"),
   		program_invocation_short_name);
   	fprintf(stdout,
  -		_(" %s --copy -p <PID> [-t <TYPE>] -- PROGRAM [ARGS...]\n"),
  +		_(" %s copy [--source <PID>] [-t <TYPE>] --dest <PID>\n"),
  +		program_invocation_short_name);
  +	fprintf(stdout,
  +		_(" %s copy [--source <PID>] [-t <TYPE>] -- PROGRAM [ARGS...]\n"),
   		program_invocation_short_name);
   
   	fputs(USAGE_SEPARATOR, stdout);
   	fputsln(_("Manage core scheduling cookies for tasks."), stdout);
   
   	fputs(USAGE_FUNCTIONS, stdout);
  -	fputsln(_(" -n, --new          assign a new core scheduling cookie to an existing PID or\n"
  -		  "                      execute a program with a new cookie."),
  +	fputsln(_(" get                      retrieve the core scheduling cookie of a PID"),
   		stdout);
  -	fputsln(_(" -c, --copy         copy the core scheduling cookie from an existing PID to\n"
  -		  "                      either another PID, or copy it to a new program"),
  +	fputsln(_(" new                      assign a new core scheduling cookie to an existing\n"
  +		  "                            PID or execute a program with a new cookie"),
   		stdout);
  -	fputsln(_("\n If no function is provided, it will retrieve and print the cookie from\n"
  -		  "   the PID provided via --pid.\n"),
  +	fputsln(_(" copy                     copy the core scheduling cookie from an existing PID\n"
  +		  "                            to another PID, or execute a program with that\n"
  +		  "                            copied cookie"),
   		stdout);
   
   	fputs(USAGE_OPTIONS, stdout);
  -	fputsln(_(" -p, --pid <PID>    operate on an existing PID"), stdout);
  -	fputsln(_(" -d, --dest <PID>   when copying a cookie from an existing PID, --dest is\n"
  -		  "                      the destination PID where to copy the cookie to."),
  +	fprintf(stdout,
  +		_(" -s, --source <PID>       which PID to get the cookie from\n"
  +		  "                            If omitted, it is the PID of %s itself\n"),
  +		program_invocation_short_name);
  +	fputsln(_(" -d, --dest <PID>         which PID to modify the cookie of\n"),
   		stdout);
  -	fputsln(_(" -t, --type <TYPE>  type of the destination PID, or the type of the PID\n"
  -		  "                      when a new core scheduling cookie is created.\n"
  -		  "                      Can be one of the following: pid, tgid or pgid.\n"
  -		  "                      The default is tgid."),
  +	fputsln(_(" -t, --dest-type <TYPE>   type of the destination PID, or the type of the PID\n"
  +		  "                            when a new core scheduling cookie is created.\n"
  +		  "                            Can be one of the following: pid, tgid or pgid.\n"
  +		  "                            The default is tgid."),
   		stdout);
   	fputs(USAGE_SEPARATOR, stdout);
   	fputsln(_(" -v, --verbose      verbose"), stdout);
  @@ -151,9 +154,8 @@ static void core_sched_copy_cookie(pid_t from, pid_t to,
   
   	if (sched_core_verbose) {
   		sched_core_cookie before = core_sched_get_cookie(from);
  -		fprintf(stderr,
  -			_("%s: copied cookie 0x%lx from PID %d to PID %d\n"),
  -			program_invocation_short_name, before, from, to);
  +		warnx(_("copied cookie 0x%lx from PID %d to PID %d"), before,
  +		      from, to);
   	}
   }
   
  @@ -161,25 +163,21 @@ static void core_sched_get_and_print_cookie(pid_t pid)
   {
   	if (sched_core_verbose) {
   		sched_core_cookie after = core_sched_get_cookie(pid);
  -		fprintf(stderr, _("%s: set cookie of PID %d to 0x%lx\n"),
  -			program_invocation_short_name, pid, after);
  +		warnx(_("set cookie of PID %d to 0x%lx"), pid, after);
   	}
   }
   
   static void core_sched_exec_with_cookie(struct args *args, char **argv)
   {
  -	if (!args->exec_argv_offset)
  -		usage();
  -
   	// Move the argument list to the first argument of the program
   	argv = &argv[args->exec_argv_offset];
   
   	// If a source PID is provided, try to copy the cookie from
   	// that PID. Otherwise, create a brand new cookie with the
   	// provided type.
  -	if (args->pid) {
  -		core_sched_pull_cookie(args->pid);
  -		core_sched_get_and_print_cookie(args->pid);
  +	if (args->src) {
  +		core_sched_pull_cookie(args->src);
  +		core_sched_get_and_print_cookie(args->src);
   	} else {
   		pid_t pid = getpid();
   		core_sched_create_cookie(pid, args->type);
  @@ -218,42 +216,26 @@ static sched_core_scope parse_core_sched_type(char *str)
   		  str);
   }
   
  -static void parse_arguments(int argc, char **argv, struct args *args)
  +static void parse_and_verify_arguments(int argc, char **argv, struct args *args)
   {
   	int c;
   
   	static const struct option longopts[] = {
  -		{ "new", no_argument, NULL, 'n' },
  -		{ "copy", no_argument, NULL, 'c' },
  -		{ "pid", required_argument, NULL, 'p' },
  +		{ "source", required_argument, NULL, 's' },
   		{ "dest", required_argument, NULL, 'd' },
  -		{ "type", required_argument, NULL, 't' },
  +		{ "dest-type", required_argument, NULL, 't' },
   		{ "verbose", no_argument, NULL, 'v' },
   		{ "version", no_argument, NULL, 'V' },
   		{ "help", no_argument, NULL, 'h' },
   		{ NULL, 0, NULL, 0 }
   	};
  -	static const ul_excl_t excl[] = {
  -		{ 'c', 'n' }, // Cannot do both --new and --copy
  -		{ 'd', 'n' }, // Cannot have both --new and --dest
  -		{ 0 }
  -	};
  -
  -	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
   
  -	while ((c = getopt_long(argc, argv, "ncp:d:t:vVh", longopts, NULL)) !=
  -	       -1) {
  -		err_exclusive_options(c, longopts, excl, excl_st);
  +	while ((c = getopt_long(argc, argv, "s:d:t:vVh", longopts, NULL)) != -1)
   		switch (c) {
  -		case 'n':
  -			args->cmd = SCHED_CORE_CMD_NEW;
  -			break;
  -		case 'c':
  -			args->cmd = SCHED_CORE_CMD_COPY;
  -			break;
  -		case 'p':
  -			args->pid = strtopid_or_err(
  -				optarg, _("Failed to parse PID for -p/--pid"));
  +		case 's':
  +			args->src = strtopid_or_err(
  +				optarg,
  +				_("Failed to parse PID for -s/--source"));
   			break;
   		case 'd':
   			args->dest = strtopid_or_err(
  @@ -272,58 +254,77 @@ static void parse_arguments(int argc, char **argv, struct args *args)
   		default:
   			errtryhelp(EXIT_FAILURE);
   		}
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
   	}
   
  -	if (args->cmd == SCHED_CORE_CMD_COPY && !args->pid)
  -		bad_usage(_("--copy: requires a -p/--pid"));
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
   
   	// More arguments have been passed, which means that the user wants to run
   	// another program with a core scheduling cookie.
   	if (argc > optind) {
   		switch (args->cmd) {
   		case SCHED_CORE_CMD_GET:
  -			bad_usage(_("Unknown command"));
  +			bad_usage(_("bad usage of the get function"));
   			break;
   		case SCHED_CORE_CMD_NEW:
  -			if (args->pid)
  +			if (args->dest)
   				bad_usage(_(
  -					"--new: cannot accept both a -p/--pid and a command"));
  +					"new requires either a -d/--dest or a command"));
   			else
   				args->exec_argv_offset = optind;
   			break;
   		case SCHED_CORE_CMD_COPY:
   			if (args->dest)
   				bad_usage(_(
  -					"--copy: cannot accept both a destination PID "
  -					"-d/--dest and a command"));
  +					"copy requires either a -d/--dest or a command"));
   			else
   				args->exec_argv_offset = optind;
   			break;
   		}
  -	}
  -
  -	if (argc <= optind) {
  -		if (args->cmd == SCHED_CORE_CMD_NEW && !args->pid)
  +	} else {
  +		if (args->cmd == SCHED_CORE_CMD_NEW && !args->dest)
   			bad_usage(_(
  -				"--new: requires either a -p/--pid or a command"));
  +				"new requires either a -d/--dest or a command"));
   		if (args->cmd == SCHED_CORE_CMD_COPY && !args->dest)
   			bad_usage(_(
  -				"--copy: requires either a -d/--dest or a command"));
  +				"copy requires either a -d/--dest or a command"));
   	}
   }
   
   int main(int argc, char **argv)
   {
  -	struct args args = { 0 };
  -	args.cmd = SCHED_CORE_CMD_GET;
  -	args.type = PR_SCHED_CORE_SCOPE_THREAD_GROUP;
  +	struct args args = { .type = PR_SCHED_CORE_SCOPE_THREAD_GROUP };
   
   	setlocale(LC_ALL, "");
   	bindtextdomain(PACKAGE, LOCALEDIR);
   	textdomain(PACKAGE);
   	close_stdout_atexit();
   
  -	parse_arguments(argc, argv, &args);
  +	parse_and_verify_arguments(argc, argv, &args);
   
   	if (!is_core_sched_supported())
   		errx(EXIT_FAILURE,
  @@ -331,27 +332,25 @@ int main(int argc, char **argv)
   		       "support CONFIG_SCHED_CORE?"));
   
   	sched_core_cookie cookie;
  -	pid_t pid;
   
   	switch (args.cmd) {
   	case SCHED_CORE_CMD_GET:
  -		pid = args.pid ? args.pid : getpid();
  -		cookie = core_sched_get_cookie(pid);
  -		printf(_("cookie of pid %d is 0x%lx\n"), pid, cookie);
  +		cookie = core_sched_get_cookie(args.src);
  +		printf(_("cookie of pid %d is 0x%lx\n"), args.src, cookie);
   		break;
   	case SCHED_CORE_CMD_NEW:
  -		if (args.pid) {
  -			core_sched_create_cookie(args.pid, args.type);
  -			core_sched_get_and_print_cookie(args.pid);
  -		} else {
  +		if (args.exec_argv_offset) {
   			core_sched_exec_with_cookie(&args, argv);
  +		} else {
  +			core_sched_create_cookie(args.dest, args.type);
  +			core_sched_get_and_print_cookie(args.dest);
   		}
   		break;
   	case SCHED_CORE_CMD_COPY:
  -		if (args.dest)
  -			core_sched_copy_cookie(args.pid, args.dest, args.type);
  -		else
  +		if (args.exec_argv_offset)
   			core_sched_exec_with_cookie(&args, argv);
  +		else
  +			core_sched_copy_cookie(args.src, args.dest, args.type);
   		break;
   	default:
   		usage();
  diff --git a/tests/expected/schedutils/coresched-change-cookie-of-parent b/tests/expected/schedutils/coresched-change-cookie-of-parent
  deleted file mode 100644
  index d08118c02..000000000
  --- a/tests/expected/schedutils/coresched-change-cookie-of-parent
  +++ /dev/null
  @@ -1 +0,0 @@
  -cookie of pid OWN_PID is DIFFERENT_COOKIE
  diff --git a/tests/expected/schedutils/coresched-spawn-child-with-new-cookie b/tests/expected/schedutils/coresched-copy-from-child-to-parent
  similarity index 100%
  rename from tests/expected/schedutils/coresched-spawn-child-with-new-cookie
  rename to tests/expected/schedutils/coresched-copy-from-child-to-parent
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
  diff --git a/tests/expected/schedutils/coresched-get-own-pid-with-cookie b/tests/expected/schedutils/coresched-get-own-pid-with-cookie
  deleted file mode 100644
  index 3d7f08040..000000000
  --- a/tests/expected/schedutils/coresched-get-own-pid-with-cookie
  +++ /dev/null
  @@ -1 +0,0 @@
  -cookie of pid OWN_PID is COOKIE
  diff --git a/tests/expected/schedutils/coresched-new-child-with-new-cookie b/tests/expected/schedutils/coresched-new-child-with-new-cookie
  new file mode 100644
  index 000000000..5b9c40052
  --- /dev/null
  +++ b/tests/expected/schedutils/coresched-new-child-with-new-cookie
  @@ -0,0 +1 @@
  +DIFFERENT_COOKIE
  diff --git a/tests/expected/schedutils/coresched-set-cookie-own-pid.err b/tests/expected/schedutils/coresched-set-cookie-own-pid.err
  deleted file mode 100644
  index 1816a4fbd..000000000
  --- a/tests/expected/schedutils/coresched-set-cookie-own-pid.err
  +++ /dev/null
  @@ -1 +0,0 @@
  -coresched: set cookie of PID OWN_PID to COOKIE
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
  index ed96d89de..e34fa319f 100755
  --- a/tests/ts/schedutils/coresched
  +++ b/tests/ts/schedutils/coresched
  @@ -13,8 +13,8 @@ TS_DESC="coresched"
   ts_init "$*"
   
   ts_check_test_command "$TS_CMD_CORESCHED"
  -ts_check_test_command "tee"
  -ts_check_test_command "sed"
  +ts_check_prog "tee"
  +ts_check_prog "sed"
   
   # If there is no kernel support, skip the test suite
   CORESCHED_TEST_KERNEL_SUPPORT_CMD=$($TS_CMD_CORESCHED 2>&1)
  @@ -30,33 +30,54 @@ fi
   # - Any other cookie is replaced by `DIFFERENT_COOKIE`
   # The behavior of coresched does not depend on the exact values of these cookies, so using
   # placeholder values does not change the behavior tests.
  -ts_init_subtest "set-cookie-own-pid"
  -CORESCHED_OUTPUT=$( ($TS_CMD_CORESCHED -v -n -p $$ | tee -a "$TS_OUTPUT") 3>&1 1>&2 2>&3 | sed "s/$$/OWN_PID/g")
  -CORESCHED_COOKIE=$(echo "$CORESCHED_OUTPUT" | sed 's/^.*\(0x.*$\)/\1/g')
  -if [ -z "$CORESCHED_COOKIE" ]; then
  -  ts_failed "empty value for CORESCHED_COOKIE "
  +ts_init_subtest "set-cookie-parent-pid"
  +CORESCHED_OUTPUT=$( ($TS_CMD_CORESCHED -v new -d $$ \
  +  | tee -a "$TS_OUTPUT") 3>&1 1>&2 2>&3 \
  +  | sed "s/$$/PARENT_PID/g")
  +CORESCHED_PARENT_COOKIE=$(echo "$CORESCHED_OUTPUT" | sed 's/^.*\(0x.*$\)/\1/g')
  +if [ -z "$CORESCHED_PARENT_COOKIE" ]; then
  +  ts_failed "empty value for CORESCHED_PARENT_COOKIE"
   fi
  -CORESCHED_OUTPUT=$(echo "$CORESCHED_OUTPUT" | sed "s/$CORESCHED_COOKIE/COOKIE/g")
  +CORESCHED_OUTPUT=$(echo "$CORESCHED_OUTPUT" \
  +  | sed "s/$CORESCHED_PARENT_COOKIE/PARENT_COOKIE/g")
   echo "$CORESCHED_OUTPUT" >> "$TS_ERRLOG"
   ts_finalize_subtest
   
  -ts_init_subtest "get-own-pid-with-cookie"
  -$TS_CMD_CORESCHED -p $$ 2>> "$TS_ERRLOG" | sed "s/$$/OWN_PID/g" | sed "s/$CORESCHED_COOKIE/COOKIE/g" >> "$TS_OUTPUT"
  +ts_init_subtest "get-cookie-parent-pid"
  +$TS_CMD_CORESCHED get -s $$ 2>> "$TS_ERRLOG" \
  +  | sed -e "s/$$/PARENT_PID/g" \
  +        -e "s/$CORESCHED_PARENT_COOKIE/PARENT_COOKIE/g" >> "$TS_OUTPUT"
   ts_finalize_subtest
   
  -ts_init_subtest "spawn-child-with-new-cookie"
  -$TS_CMD_CORESCHED -n -- "$TS_CMD_CORESCHED" 2>> "$TS_ERRLOG" \
  -  | sed 's/^.*\(0x.*$\)/\1/g' \
  -  | sed "s/$CORESCHED_COOKIE/SAME_COOKIE/g" \
  -  | sed "s/0x.*$/DIFFERENT_COOKIE/g" >> "$TS_OUTPUT"
  +ts_init_subtest "get-cookie-own-pid"
  +$TS_CMD_CORESCHED get 2>> "$TS_ERRLOG" \
  +  | sed -e "s/pid [0-9]\+/pid OWN_PID/g" \
  +        -e "s/$CORESCHED_PARENT_COOKIE/PARENT_COOKIE/g" >> "$TS_OUTPUT"
   ts_finalize_subtest
   
  -ts_init_subtest "change-cookie-of-parent"
  -$TS_CMD_CORESCHED -n -- /bin/bash -c "$TS_CMD_CORESCHED -c -p \$\$ -d $$"
  -$TS_CMD_CORESCHED -p $$ 2>> "$TS_ERRLOG" \
  -  | sed "s/$$/OWN_PID/g" \
  -  | sed "s/$CORESCHED_COOKIE/COOKIE/g" \
  -  | sed "s/0x.*$/DIFFERENT_COOKIE/g" >> "$TS_OUTPUT"
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
   ts_finalize_subtest
   
   ts_finalize

 .gitignore                                    |   1 +
 bash-completion/coresched                     |   0
 configure.ac                                  |  12 +-
 meson.build                                   |  16 +-
 meson_options.txt                             |   2 +-
 schedutils/Makemodule.am                      |   8 +
 schedutils/coresched.1.adoc                   | 138 +++++++
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
 17 files changed, 620 insertions(+), 6 deletions(-)
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
index 000000000..00f2603e0
--- /dev/null
+++ b/schedutils/coresched.1.adoc
@@ -0,0 +1,138 @@
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
+mailto:thijs@raymakers.nl[Thijs Raymakers]
+
+== COPYRIGHT
+
+Copyright {copyright} 2024 Thijs Raymakers. This is free software licensed under the EUPL.
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
index 000000000..7e3cc46d2
--- /dev/null
+++ b/schedutils/coresched.c
@@ -0,0 +1,358 @@
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

