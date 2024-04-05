Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982D216EC05
	for <util-linux@vger.kernel.org>; Fri,  5 Apr 2024 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326471; cv=none; b=kZCglDN0GHItxDtpmtMS2VZeuUPayHJ81CZH10JcdHdWmQOcR1zMukqVP+g3X42q1rpZktl0VkiJQjrP9WN/GsKIVbm8M4vVwz1AUalrfBmUCs1HJgU9N0QfmXXTQWM+26xKN9H4R/keOdXXWJ9Y7MPjB/zw4exwxpz90e1fZ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326471; c=relaxed/simple;
	bh=L+nqX4pLI7n9zBc+o6xcUfk6uBZtAak6yfbFSlvDC70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHwXhQapYk+f/qhSqJ3y/WvcBDsXn8l8poe/ohkefJGYTDfcNFY5SQdA2Vs3Tu0SYzUWBR0uUM+cIDOseHsL6cQVF9kGGb7WFpzxcykDeEZ646MM23nvvVltrd6Y8Bdir7CUMIx57FQHNEBVRkmpMAmdpRTPQ9y8/dISZBhNNag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+9GDwUI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+9GDwUI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712326466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGoolzq3hJsJU6S/2qtnb73/hfwC1k1//W9FCZK5rgs=;
	b=J+9GDwUIiBcepcvzQRRMMbF4ZD6KPrjTbt/zlf967+v9n2/zcGHjc5UWnSk2NljjNXP42q
	Yh6sFM563LFGUazdE3JMpDtkxKfMQL1Xqn3ZqoLOyZ55kjEG+FRJ8eiwdBFf/qe1Uulzwa
	trXhpNS6PawkdWI/RI/5u63EN7wOzGE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-HGeJZ-KVMS6uXYrRUIkVGQ-1; Fri,
 05 Apr 2024 10:14:17 -0400
X-MC-Unique: HGeJZ-KVMS6uXYrRUIkVGQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 724E0382C487;
	Fri,  5 Apr 2024 14:14:11 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.16.235])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 44520492BCD;
	Fri,  5 Apr 2024 14:14:10 +0000 (UTC)
Date: Fri, 5 Apr 2024 10:14:07 -0400
From: Phil Auld <pauld@redhat.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc: Thijs Raymakers <thijs@raymakers.nl>, kzak@redhat.com,
	util-linux@vger.kernel.org
Subject: Re: [PATCH v4] coresched: Manage core scheduling cookies for tasks
Message-ID: <20240405141407.GA224852@lorien.usersys.redhat.com>
References: <cf9125a9-281f-4940-9c32-1085680d03de@t-8ch.de>
 <20240404220358.104595-1-thijs@raymakers.nl>
 <799c60ac-1ad5-4aca-8ca3-2408f1aefce2@t-8ch.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <799c60ac-1ad5-4aca-8ca3-2408f1aefce2@t-8ch.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Fri, Apr 05, 2024 at 08:26:08AM +0200 Thomas Weißschuh wrote:
> On 2024-04-05 00:03:57+0200, Thijs Raymakers wrote:
> > Co-authored-by: Phil Auld <pauld@redhat.com>
> > Signed-off-by: Thijs Raymakers <thijs@raymakers.nl>
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > ---
> > 
> > Hi Thomas,
> > 
> > Thanks for your comments. This patch addresses most of your remarks. It
> > also adds Phil Auld as a Co-author since we went back and forth on the
> > design quite a lot. His feedback has been valuable and his ideas have
> > been integrated in the util to accomodate for both our usecases.
> 
> Thanks, some more comments below.
> 
> > Op 01-04-2024 om 7:18 p.m. schreef Thomas Weißschuh:
> > > I guess you are aware, but the manpage is empty.
> > 
> > I've added the manpage in this version of the patch.
> > 
> > > Technically all types ending in _t are reserved for libc.
> > > And a conflict for cookie_t doesn't even sound that improbable.
> > > How about sched_core_scope, sched_core_cookie and enum sched_core_cmd?
> > 
> > Good suggestion, the names of these types have been changed.
> > 
> > > Would a single call to core_sched_get_cookie() not be a reliable check
> > > that can be done and reported once?
> > > ...
> > > To make clear that this works like err{,x}() maybe call it err_prctl().
> > > It's unfortunate that this has to be a macro.
> > > There are verrx() and verr() which could make this an inline function.
> > > We would need fallback implementations for it in include/c.h though,
> > > which doesn't look so hard.
> > 
> > I Initially wrote it like this to avoid doing more prctl calls than
> > necessary. All the PR_SCHED_CORE* prctl calls indicate whether or not
> > the kernel supports core scheduling whenever they return with errno
> > EINVAL.
> > 
> > However, if support is explicitly checked beforehand, then the error
> > handling becomes a bit simpler and doesn't rely on macros anymore.
> > Therefore, I've changed to code to explicitly check for kernel support
> > beforehand. This change also removes the need for the `check_prctl`
> > macro.
> 
> Thanks, would it make sense to expose this check via the CLI?
> That could then used by the tests to skip themselves if the system does
> not provide core scheduling on old kernels or qemu-user.
>

I don't think so. It's checking by doing an operation so just do a "get"
if you really want to check first. An explicit check would just be that
anyway. 


> > > It would be nicer if these helpers are closer named to the prctl
> > > operations.
> > > sched_core_share_from_thread() for example.
> > 
> > I've followed the terminology of the kernel documentation of core
> > scheduling (Documentation/admin-guide/hw-vuln/core-scheduling.rst) here.
> > There, `PR_SCHED_CORE_SHARE_TO` is described as "push core_sched cookie
> > to pid." and `PR_SCHED_CORE_SHARE_FROM` is described as "pull core_sched
> > cookie from pid"
> > 
> > I prefer that terminology because I find it a little less ambiguous than
> > SHARE_TO and SHARE_FROM.
> 
> Ok.
> 
> > Op 01-04-2024 om 7:18 p.m. schreef Thomas Weißschuh:
> > > On 2024-03-27 16:30:08+0100, Thijs Raymakers wrote:
> > >> +	printf("%s: copied cookie 0x%lx from PID %d to PID %d\n",
> > >> +	       program_invocation_short_name, before, from, to);
> > > stderr and only with --verbose?
> > 
> > This has been changed now. All operations, except getting a cookie,
> > will no longer print this type of information unless --verbose is passed.
> > 
> > > Also, please some tests.
> > 
> > This version adds 5 tests for coresched:
> > - getting the cookie of itself when no cookie is set
> > - setting the cookie of itself
> > - getting the cookie of itself when the cookie is set (must be equal to
> >   the cookie that was set)
> > - spawn a child process with a new cookie (must be different than the
> >   cookie of the parent process)
> > - spawn a child process with a new cookie and push that cookie to the
> >   parent process (afterwards, the cookie of the parent must be different)
> 
> Nice!
> 
> > An interdiff between the previous version and this version is listed
> > below. It also address your other remarks not mentioned in this email.
> > 
> > Only the bash completion script is missing, but I think that is better
> > suited for a follow-up patch.
> 
> Sounds fair.
> 
> > Thijs
> > 
> > Interdiff against v3:
> 
> [snip]
> 
> >  .gitignore                                    |   1 +
> >  bash-completion/coresched                     |   0
> >  configure.ac                                  |  12 +-
> >  meson.build                                   |  16 +-
> >  meson_options.txt                             |   2 +-
> >  schedutils/Makemodule.am                      |   8 +
> >  schedutils/coresched.1.adoc                   | 116 ++++++
> >  schedutils/coresched.c                        | 380 ++++++++++++++++++
> >  tests/commands.sh                             |   1 +
> >  .../coresched-change-cookie-of-parent         |   1 +
> >  .../coresched-get-own-pid-no-cookie           |   1 +
> >  .../coresched-get-own-pid-with-cookie         |   1 +
> >  .../schedutils/coresched-set-cookie-own-pid   |   1 +
> >  .../coresched-spawn-child-with-new-cookie     |   1 +
> >  tests/ts/schedutils/coresched                 |  55 +++
> >  15 files changed, 590 insertions(+), 6 deletions(-)
> >  create mode 100644 bash-completion/coresched
> >  create mode 100644 schedutils/coresched.1.adoc
> >  create mode 100644 schedutils/coresched.c
> >  create mode 100644 tests/expected/schedutils/coresched-change-cookie-of-parent
> >  create mode 100644 tests/expected/schedutils/coresched-get-own-pid-no-cookie
> >  create mode 100644 tests/expected/schedutils/coresched-get-own-pid-with-cookie
> >  create mode 100644 tests/expected/schedutils/coresched-set-cookie-own-pid
> >  create mode 100644 tests/expected/schedutils/coresched-spawn-child-with-new-cookie
> >  create mode 100755 tests/ts/schedutils/coresched
> 
> [snip]
> 
> > diff --git a/schedutils/coresched.c b/schedutils/coresched.c
> > new file mode 100644
> > index 000000000..3d9392b1a
> > --- /dev/null
> > +++ b/schedutils/coresched.c
> > @@ -0,0 +1,380 @@
> > +/**
> > + * SPDX-License-Identifier: EUPL-1.2
> > + *
> > + * coresched.c - manage core scheduling cookies for tasks
> > + *
> > + * Copyright (C) 2024 Thijs Raymakers, Phil Auld
> > + * Licensed under the EUPL v1.2
> > + */
> > +
> > +#include <getopt.h>
> > +#include <stdbool.h>
> > +#include <stdio.h>
> > +#include <sys/prctl.h>
> > +#include <sys/wait.h>
> > +#include <unistd.h>
> > +
> > +#include "c.h"
> > +#include "closestream.h"
> > +#include "nls.h"
> > +#include "optutils.h"
> > +#include "strutils.h"
> > +
> > +// These definitions might not be defined in the header files, even if the
> > +// prctl interface in the kernel accepts them as valid.
> > +#ifndef PR_SCHED_CORE
> > +#define PR_SCHED_CORE 62
> > +#endif
> > +#ifndef PR_SCHED_CORE_GET
> > +#define PR_SCHED_CORE_GET 0
> > +#endif
> > +#ifndef PR_SCHED_CORE_CREATE
> > +#define PR_SCHED_CORE_CREATE 1
> > +#endif
> > +#ifndef PR_SCHED_CORE_SHARE_TO
> > +#define PR_SCHED_CORE_SHARE_TO 2
> > +#endif
> > +#ifndef PR_SCHED_CORE_SHARE_FROM
> > +#define PR_SCHED_CORE_SHARE_FROM 3
> > +#endif
> > +#ifndef PR_SCHED_CORE_SCOPE_THREAD
> > +#define PR_SCHED_CORE_SCOPE_THREAD 0
> > +#endif
> > +#ifndef PR_SCHED_CORE_SCOPE_THREAD_GROUP
> > +#define PR_SCHED_CORE_SCOPE_THREAD_GROUP 1
> > +#endif
> > +#ifndef PR_SCHED_CORE_SCOPE_PROCESS_GROUP
> > +#define PR_SCHED_CORE_SCOPE_PROCESS_GROUP 2
> > +#endif
> > +
> > +typedef int sched_core_scope;
> > +typedef unsigned long sched_core_cookie;
> > +typedef enum {
> > +	SCHED_CORE_CMD_GET,
> > +	SCHED_CORE_CMD_NEW,
> > +	SCHED_CORE_CMD_COPY,
> > +} sched_core_cmd;
> > +
> > +struct args {
> > +	pid_t pid;
> > +	pid_t dest;
> > +	sched_core_scope type;
> > +	sched_core_cmd cmd;
> > +	int exec_argv_offset;
> > +};
> > +
> > +static bool sched_core_verbose = false;
> > +
> > +static void __attribute__((__noreturn__)) usage(void)
> > +{
> > +	fputs(USAGE_HEADER, stdout);
> > +	fprintf(stdout, _(" %s [-p PID]\n"), program_invocation_short_name);
> > +	fprintf(stdout, _(" %s --new [-t <TYPE>] -p <PID>\n"),
> > +		program_invocation_short_name);
> > +	fprintf(stdout, _(" %s --new [-t <TYPE>] -- PROGRAM [ARGS...]\n"),
> > +		program_invocation_short_name);
> > +	fprintf(stdout, _(" %s --copy -p <PID> [-t <TYPE>] -d <PID>\n"),
> > +		program_invocation_short_name);
> > +	fprintf(stdout,
> > +		_(" %s --copy -p <PID> [-t <TYPE>] -- PROGRAM [ARGS...]\n"),
> > +		program_invocation_short_name);
> > +
> > +	fputs(USAGE_SEPARATOR, stdout);
> > +	fputsln(_("Manage core scheduling cookies for tasks."), stdout);
> > +
> > +	fputs(USAGE_FUNCTIONS, stdout);
> > +	fputsln(_(" -n, --new          assign a new core scheduling cookie to an existing PID or\n"
> > +		  "                      execute a program with a new cookie."),
> > +		stdout);
> > +	fputsln(_(" -c, --copy         copy the core scheduling cookie from an existing PID to\n"
> > +		  "                      either another PID, or copy it to a new program"),
> > +		stdout);
> > +	fputsln(_("\n If no function is provided, it will retrieve and print the cookie from\n"
> > +		  "   the PID provided via --pid.\n"),
> > +		stdout);
> > +
> > +	fputs(USAGE_OPTIONS, stdout);
> > +	fputsln(_(" -p, --pid <PID>    operate on an existing PID"), stdout);
> > +	fputsln(_(" -d, --dest <PID>   when copying a cookie from an existing PID, --dest is\n"
> > +		  "                      the destination PID where to copy the cookie to."),
> > +		stdout);
> > +	fputsln(_(" -t, --type <TYPE>  type of the destination PID, or the type of the PID\n"
> > +		  "                      when a new core scheduling cookie is created.\n"
> > +		  "                      Can be one of the following: pid, tgid or pgid.\n"
> > +		  "                      The default is tgid."),
> > +		stdout);
> > +	fputs(USAGE_SEPARATOR, stdout);
> > +	fputsln(_(" -v, --verbose      verbose"), stdout);
> > +	fprintf(stdout,
> > +		USAGE_HELP_OPTIONS(
> > +			20)); /* char offset to align option descriptions */
> > +	fprintf(stdout, USAGE_MAN_TAIL("coresched(1)"));
> > +	exit(EXIT_SUCCESS);
> > +}
> > +
> > +#define bad_usage(FMT...) \
> > +	warnx(FMT);       \
> > +	errtryhelp(EXIT_FAILURE);
> > +
> > +static sched_core_cookie core_sched_get_cookie(pid_t pid)
> > +{
> > +	sched_core_cookie cookie = 0;
> > +	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, pid,
> > +		  PR_SCHED_CORE_SCOPE_THREAD, &cookie)) {
> > +		err(EXIT_FAILURE, _("Failed to get cookie from PID %d"), pid);
> > +	}
> > +	return cookie;
> > +}
> > +
> > +static void core_sched_create_cookie(pid_t pid, sched_core_scope type)
> > +{
> > +	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pid, type, 0)) {
> > +		err(EXIT_FAILURE, _("Failed to create cookie for PID %d"), pid);
> > +	}
> 
> General codestyle is to leave out braces around single-statement blocks.
> (I mentioned this before, if you want to keep them please mention it)
> 
> > +}
> > +
> > +static void core_sched_pull_cookie(pid_t from)
> > +{
> > +	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, from,
> > +		  PR_SCHED_CORE_SCOPE_THREAD, 0)) {
> > +		err(EXIT_FAILURE, _("Failed to pull cookie from PID %d"), from);
> > +	}
> > +}
> > +
> > +static void core_sched_push_cookie(pid_t to, sched_core_scope type)
> > +{
> > +	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, to, type, 0)) {
> > +		err(EXIT_FAILURE, _("Failed to push cookie to PID %d"), to);
> > +	}
> > +}
> > +
> > +static void core_sched_copy_cookie(pid_t from, pid_t to,
> > +				   sched_core_scope to_type)
> > +{
> > +	core_sched_pull_cookie(from);
> > +	core_sched_push_cookie(to, to_type);
> > +
> > +	if (sched_core_verbose) {
> > +		sched_core_cookie before = core_sched_get_cookie(from);
> > +		fprintf(stderr,
> > +			_("%s: copied cookie 0x%lx from PID %d to PID %d\n"),
> > +			program_invocation_short_name, before, from, to);
> > +	}
> > +}
> > +
> > +static void core_sched_get_and_print_cookie(pid_t pid)
> > +{
> > +	if (sched_core_verbose) {
> > +		sched_core_cookie after = core_sched_get_cookie(pid);
> > +		fprintf(stderr, _("%s: set cookie of PID %d to 0x%lx\n"),
> > +			program_invocation_short_name, pid, after);
> > +	}
> > +}
> > +
> > +static void core_sched_exec_with_cookie(struct args *args, char **argv)
> > +{
> > +	if (!args->exec_argv_offset)
> > +		usage();
> > +
> > +	// Move the argument list to the first argument of the program
> > +	argv = &argv[args->exec_argv_offset];
> > +
> > +	// If a source PID is provided, try to copy the cookie from
> > +	// that PID. Otherwise, create a brand new cookie with the
> > +	// provided type.
> > +	if (args->pid) {
> > +		core_sched_pull_cookie(args->pid);
> > +		core_sched_get_and_print_cookie(args->pid);
> > +	} else {
> > +		pid_t pid = getpid();
> > +		core_sched_create_cookie(pid, args->type);
> > +		core_sched_get_and_print_cookie(pid);
> > +	}
> > +
> > +	if (execvp(argv[0], argv)) {
> > +		errexec(argv[0]);
> > +	}
> > +}
> > +
> > +// If PR_SCHED_CORE is not recognized, or not supported on this system,
> > +// then prctl will set errno to EINVAL. Assuming all other operands of
> > +// prctl are valid, we can use errno==EINVAL as a check to see whether
> > +// core scheduling is available on this system.
> > +static bool is_core_sched_supported(void)
> > +{
> > +	sched_core_cookie cookie = 0;
> > +	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, getpid(),
> > +		  PR_SCHED_CORE_SCOPE_THREAD, &cookie)) {
> > +		if (errno == EINVAL) {
> > +			return false;
> > +		}
> > +	}
> > +	return true;
> > +}
> > +
> > +static sched_core_scope parse_core_sched_type(char *str)
> > +{
> > +	if (!strncmp(str, "pid", 4))
> 
> These can be plain strcmp().
> 
> > +		return PR_SCHED_CORE_SCOPE_THREAD;
> > +	else if (!strncmp(str, "tgid", 5))
> > +		return PR_SCHED_CORE_SCOPE_THREAD_GROUP;
> > +	else if (!strncmp(str, "pgid", 5))
> > +		return PR_SCHED_CORE_SCOPE_PROCESS_GROUP;
> > +
> > +	bad_usage(_("'%s' is an invalid option. Must be one of pid/tgid/pgid"),
> > +		  str);
> > +}
> > +
> > +static void parse_arguments(int argc, char **argv, struct args *args)
> > +{
> > +	int c;
> > +
> > +	static const struct option longopts[] = {
> > +		{ "new", no_argument, NULL, 'n' },
> > +		{ "copy", no_argument, NULL, 'c' },
> > +		{ "pid", required_argument, NULL, 'p' },
> > +		{ "dest", required_argument, NULL, 'd' },
> > +		{ "type", required_argument, NULL, 't' },
> > +		{ "verbose", no_argument, NULL, 'v' },
> > +		{ "version", no_argument, NULL, 'V' },
> > +		{ "help", no_argument, NULL, 'h' },
> > +		{ NULL, 0, NULL, 0 }
> > +	};
> > +	static const ul_excl_t excl[] = {
> > +		{ 'c', 'n' }, // Cannot do both --new and --copy
> > +		{ 'd', 'n' }, // Cannot have both --new and --dest
> > +		{ 0 }
> > +	};
> > +
> > +	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
> > +
> > +	while ((c = getopt_long(argc, argv, "ncp:d:t:vVh", longopts, NULL)) !=
> > +	       -1) {
> > +		err_exclusive_options(c, longopts, excl, excl_st);
> > +		switch (c) {
> > +		case 'n':
> > +			args->cmd = SCHED_CORE_CMD_NEW;
> > +			break;
> > +		case 'c':
> > +			args->cmd = SCHED_CORE_CMD_COPY;
> > +			break;
> > +		case 'p':
> > +			args->pid = strtopid_or_err(
> > +				optarg, _("Failed to parse PID for -p/--pid"));
> > +			break;
> > +		case 'd':
> > +			args->dest = strtopid_or_err(
> > +				optarg, _("Failed to parse PID for -d/--dest"));
> > +			break;
> > +		case 't':
> > +			args->type = parse_core_sched_type(optarg);
> > +			break;
> > +		case 'v':
> > +			sched_core_verbose = true;
> > +			break;
> > +		case 'V':
> > +			print_version(EXIT_SUCCESS);
> > +		case 'h':
> > +			usage();
> > +		default:
> > +			errtryhelp(EXIT_FAILURE);
> > +		}
> > +	}
> > +
> > +	if (args->cmd == SCHED_CORE_CMD_COPY && !args->pid) {
> > +		bad_usage(_("--copy: requires a -p/--pid"));
> > +	}
> > +
> > +	// More arguments have been passed, which means that the user wants to run
> > +	// another program with a core scheduling cookie.
> > +	if (argc > optind) {
> > +		switch (args->cmd) {
> > +		case SCHED_CORE_CMD_GET:
> > +			bad_usage(_("Unknown command"));
> > +			break;
> > +		case SCHED_CORE_CMD_NEW:
> > +			if (args->pid) {
> > +				bad_usage(_(
> > +					"--new: cannot accept both a -p/--pid and a command"));
> > +			} else {
> > +				args->exec_argv_offset = optind;
> > +			}
> > +			break;
> > +		case SCHED_CORE_CMD_COPY:
> > +			if (args->dest) {
> > +				bad_usage(_(
> > +					"--copy: cannot accept both a destination PID "
> > +					"-d/--dest and a command"))
> > +			} else {
> > +				args->exec_argv_offset = optind;
> > +			}
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (argc <= optind) {
> > +		if (args->cmd == SCHED_CORE_CMD_NEW && !args->pid) {
> > +			bad_usage(_(
> > +				"--new: requires either a -p/--pid or a command"));
> > +		}
> > +		if (args->cmd == SCHED_CORE_CMD_COPY && !args->dest) {
> > +			bad_usage(_(
> > +				"--copy: requires either a -d/--dest or a command"));
> > +		}
> > +	}
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	struct args args = { 0 };
> > +	args.cmd = SCHED_CORE_CMD_GET;
> > +	args.type = PR_SCHED_CORE_SCOPE_THREAD_GROUP;
> > +
> > +	setlocale(LC_ALL, "");
> > +	bindtextdomain(PACKAGE, LOCALEDIR);
> > +	textdomain(PACKAGE);
> > +	close_stdout_atexit();
> > +
> > +	parse_arguments(argc, argv, &args);
> > +
> > +	if (!is_core_sched_supported()) {
> > +		errx(ENOTSUP, _("Does your kernel support CONFIG_SCHED_CORE?"));
> 
> Afaik errnos are not guaranteed to have the same numeric value
> everywhere. If you want to signal something special, use your own
> constant (and document it in the manpage).
>

I don't think we should make up an errno but use one that already exists.

If not ENOPTSUP we can just leave it as EINVAL I suppose. That should be
the same everywhere. 


> > +	}
> > +
> > +	sched_core_cookie cookie;
> > +
> > +	switch (args.cmd) {
> > +	case SCHED_CORE_CMD_GET:
> > +		if (args.pid) {
> > +			cookie = core_sched_get_cookie(args.pid);
> > +			if (cookie) {
> > +				printf(_("%s: cookie of pid %d is 0x%lx\n"),
> > +				       program_invocation_short_name, args.pid,
> > +				       cookie);
> 
> program_invocation_short_name seems unnecessary.
> 
> The pid itself also seems unnecessary as the users know which cookie
> they asked for.
> 
> Ah, taskset works like this. I disagree :-)
>

Yes, trying to make it sort of obvious for taskset users since I think
they will mostly be the same people.


> > +			} else {
> > +				errx(ENODATA,
> > +				     _("pid %d doesn't have a core scheduling cookie"),
> > +				     args.pid);
> 
> Is this really a failure case?
> I would make the print only on --verbose and otherwise succeed without
> output.

Agree. This is not an error. 

Cheers,
Phil


> 
> > +			}
> > +		} else {
> > +			usage();
> 
> Why not print the current cookie here?
> 
> > +		}
> > +		break;
> > +	case SCHED_CORE_CMD_NEW:
> > +		if (args.pid) {
> > +			core_sched_create_cookie(args.pid, args.type);
> > +			core_sched_get_and_print_cookie(args.pid);
> > +		} else {
> > +			core_sched_exec_with_cookie(&args, argv);
> > +		}
> > +		break;
> > +	case SCHED_CORE_CMD_COPY:
> > +		if (args.dest)
> > +			core_sched_copy_cookie(args.pid, args.dest, args.type);
> > +		else
> > +			core_sched_exec_with_cookie(&args, argv);
> > +		break;
> > +	default:
> > +		usage();
> > +	}
> > +}
> > diff --git a/tests/commands.sh b/tests/commands.sh
> > index 5674c5ff0..9eef92ccb 100644
> > --- a/tests/commands.sh
> > +++ b/tests/commands.sh
> > @@ -71,6 +71,7 @@ TS_CMD_COLCRT=${TS_CMD_COLCRT:-"${ts_commandsdir}colcrt"}
> >  TS_CMD_COLRM=${TS_CMD_COLRM:-"${ts_commandsdir}colrm"}
> >  TS_CMD_COL=${TS_CMD_COL:-"${ts_commandsdir}col"}
> >  TS_CMD_COLUMN=${TS_CMD_COLUMN:-"${ts_commandsdir}column"}
> > +TS_CMD_CORESCHED=${TS_CMD_CORESCHED:-"${ts_commandsdir}coresched"}
> >  TS_CMD_ENOSYS=${TS_CMD_ENOSYS-"${ts_commandsdir}enosys"}
> >  TS_CMD_EJECT=${TS_CMD_EJECT-"${ts_commandsdir}eject"}
> >  TS_CMD_EXCH=${TS_CMD_EXCH-"${ts_commandsdir}exch"}
> > diff --git a/tests/expected/schedutils/coresched-change-cookie-of-parent b/tests/expected/schedutils/coresched-change-cookie-of-parent
> > new file mode 100644
> > index 000000000..97ab7ea23
> > --- /dev/null
> > +++ b/tests/expected/schedutils/coresched-change-cookie-of-parent
> > @@ -0,0 +1 @@
> > +coresched: cookie of pid OWN_PID is DIFFERENT_COOKIE
> > diff --git a/tests/expected/schedutils/coresched-get-own-pid-no-cookie b/tests/expected/schedutils/coresched-get-own-pid-no-cookie
> > new file mode 100644
> > index 000000000..7f64a98b3
> > --- /dev/null
> > +++ b/tests/expected/schedutils/coresched-get-own-pid-no-cookie
> > @@ -0,0 +1 @@
> > +coresched: pid OWN_PID doesn't have a core scheduling cookie
> > diff --git a/tests/expected/schedutils/coresched-get-own-pid-with-cookie b/tests/expected/schedutils/coresched-get-own-pid-with-cookie
> > new file mode 100644
> > index 000000000..556e31a65
> > --- /dev/null
> > +++ b/tests/expected/schedutils/coresched-get-own-pid-with-cookie
> > @@ -0,0 +1 @@
> > +coresched: cookie of pid OWN_PID is COOKIE
> > diff --git a/tests/expected/schedutils/coresched-set-cookie-own-pid b/tests/expected/schedutils/coresched-set-cookie-own-pid
> > new file mode 100644
> > index 000000000..1816a4fbd
> > --- /dev/null
> > +++ b/tests/expected/schedutils/coresched-set-cookie-own-pid
> > @@ -0,0 +1 @@
> > +coresched: set cookie of PID OWN_PID to COOKIE
> > diff --git a/tests/expected/schedutils/coresched-spawn-child-with-new-cookie b/tests/expected/schedutils/coresched-spawn-child-with-new-cookie
> > new file mode 100644
> > index 000000000..5b9c40052
> > --- /dev/null
> > +++ b/tests/expected/schedutils/coresched-spawn-child-with-new-cookie
> > @@ -0,0 +1 @@
> > +DIFFERENT_COOKIE
> > diff --git a/tests/ts/schedutils/coresched b/tests/ts/schedutils/coresched
> > new file mode 100755
> > index 000000000..5381a56f2
> > --- /dev/null
> > +++ b/tests/ts/schedutils/coresched
> > @@ -0,0 +1,55 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: EUPL-1.2
> > +#
> > +# This file is part of util-linux
> > +#
> > +# Copyright (C) 2024 Thijs Raymakers
> > +# Licensed under the EUPL v1.2
> > +
> > +TS_TOPDIR="${0%/*}/../.."
> > +TS_DESC="coresched"
> > +
> > +. "$TS_TOPDIR"/functions.sh
> > +ts_init "$*"
> > +
> > +ts_check_test_command "$TS_CMD_CORESCHED"
> > +
> > +# The output of coresched contains PIDs and core scheduling cookies, both of which should be
> > +# assumed to be random values as we have no control over them. The tests replace these values
> > +# with sed before writing them to the output file, so it can match the expected output file.
> > +# - The PID of this bash script is replaced with the placeholder `OWN_PID`
> > +# - The core scheduling cookie of this bash script is replaced by `COOKIE`
> > +# - Any other cookie is replaced by `DIFFERENT_COOKIE`
> > +# The behavior of coresched does not depend on the exact values of these cookies, so using
> > +# placeholder values does not change the behavior tests.
> > +ts_init_subtest "get-own-pid-no-cookie"
> > +$TS_CMD_CORESCHED -p $$ 3>&2 2>&1 1>&3 | sed "s/$$/OWN_PID/g" >> "$TS_OUTPUT"
> 
> This test fails if the process starting it already has a cookie set.
> Also in that case the output is printed past the redirections.
> 
> > +ts_finalize_subtest
> > +
> > +ts_init_subtest "set-cookie-own-pid"
> > +CORESCHED_OUTPUT=$($TS_CMD_CORESCHED -v -n -p $$ 3>&2 2>&1 1>&3 | sed "s/$$/OWN_PID/g")
> > +CORESCHED_COOKIE=$(echo "$CORESCHED_OUTPUT" | sed 's/^.*\(0x.*$\)/\1/g')
> > +CORESCHED_OUTPUT=$(echo "$CORESCHED_OUTPUT" | sed "s/$CORESCHED_COOKIE/COOKIE/g")
> > +echo "$CORESCHED_OUTPUT" >> "$TS_OUTPUT"
> > +ts_finalize_subtest
> > +
> > +ts_init_subtest "get-own-pid-with-cookie"
> > +$TS_CMD_CORESCHED -p $$ | sed "s/$$/OWN_PID/g" | sed "s/$CORESCHED_COOKIE/COOKIE/g" >> "$TS_OUTPUT"
> > +ts_finalize_subtest
> > +
> > +ts_init_subtest "spawn-child-with-new-cookie"
> > +$TS_CMD_CORESCHED -n -- /bin/bash -c "$TS_CMD_CORESCHED -p \$\$" \
> 
> When coresched without arguments prints the current value this bash
> trickery can be removed.
> 
> > +  | sed 's/^.*\(0x.*$\)/\1/g' \
> > +  | sed "s/$CORESCHED_COOKIE/SAME_COOKIE/g" \
> > +  | sed "s/0x.*$/DIFFERENT_COOKIE/g" >> "$TS_OUTPUT"
> > +ts_finalize_subtest
> > +
> > +ts_init_subtest "change-cookie-of-parent"
> > +$TS_CMD_CORESCHED -n -- /bin/bash -c "$TS_CMD_CORESCHED -c -p \$\$ -d $$"
> > +$TS_CMD_CORESCHED -p $$ \
> > +  | sed "s/$$/OWN_PID/g" \
> > +  | sed "s/$CORESCHED_COOKIE/COOKIE/g" \
> > +  | sed "s/0x.*$/DIFFERENT_COOKIE/g" >> "$TS_OUTPUT"
> > +ts_finalize_subtest
> > +
> > +ts_finalize
> > -- 
> > 2.44.0
> > 
> 

-- 

