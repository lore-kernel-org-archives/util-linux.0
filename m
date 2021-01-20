Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9633EC433DB
	for <util-linux@archiver.kernel.org>; Wed, 20 Jan 2021 12:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4102B2333C
	for <util-linux@archiver.kernel.org>; Wed, 20 Jan 2021 12:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbhATMxI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 20 Jan 2021 07:53:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731467AbhATMXR (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 20 Jan 2021 07:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611145286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uKmalcVVJ9tE96pCQAa+YBbfBbxBNE3+DkPIGvgv/mo=;
        b=ZAmIsrSO5Bd9swx9eAA1f0qT+BFD8F1klrA8T7yovWVkZqox1+Fr469cxBQ8AsMFjnjf53
        M4dNkZs4f72QmeOXQ7nnExPDw06qerNwxKUY6Lq8guCBFEN9RIYTeXcjXrLzshuybUyF71
        GbzhLzwq58YBQsSxEGu4mEkxHAJCLNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-NoURaTFoOEiaIVXftOtkbA-1; Wed, 20 Jan 2021 07:21:22 -0500
X-MC-Unique: NoURaTFoOEiaIVXftOtkbA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66C5DA0C06;
        Wed, 20 Jan 2021 12:21:20 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C0F219811;
        Wed, 20 Jan 2021 12:21:18 +0000 (UTC)
Date:   Wed, 20 Jan 2021 13:21:16 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     util-linux@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Subject: Re: [PATCH 2/5] Add uclampset schedutil
Message-ID: <20210120122116.ways43kaigb7hcmj@ws.net.home>
References: <20210116190940.2320819-1-qais.yousef@arm.com>
 <20210116190940.2320819-3-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210116190940.2320819-3-qais.yousef@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


 Hi,

pretty readable code (thanks), I have some notes:

On Sat, Jan 16, 2021 at 07:09:37PM +0000, Qais Yousef wrote:
>  #if defined (__linux__)
>  # include <sys/syscall.h>
>  #endif
> @@ -73,6 +99,10 @@ struct sched_attr {
>  	uint64_t sched_runtime;
>  	uint64_t sched_deadline;
>  	uint64_t sched_period;
> +
> +	/* UTILIZATION CLAMPING */
> +	uint32_t sched_util_min;
> +	uint32_t sched_util_max;
>  };

This sched_attr definition is used only if regular system include files
do not contain struct sched_attr (aka ifndef HAVE_SCHED_SETATTR).

What is expected on systems with header files from Linux < 5.3 where
is sched_attr, but without sched_util_{min,max}?

I guess you need to check in ./configure.ac that struct sched_attr is
usable for your uclampset otherwise you will see compilation error.
You can use for example AC_LINK_IFELSE([AC_LANG_PROGRAM([[ ... and
try to compile code with sched_attr.sched_util_min = 0.

I see two possible ways:

- do not compile uclampset at all if there is no sched_attr.sched_util_*
  in system header files

- use you local definition from sched_attr.h, but it will probably
  require to define own struct to avoid names collision

IMHO the first solution is more simple and it will keep your code readable.

If you not sure with the build-system stuff then ignore it and don't
waste time with it. I can fix it before merge into master branch.

> +#define PROCFS(file)	"/proc/sys/kernel/" #file
> +
> +#define PROCFS_UCLAMP_MIN	PROCFS(sched_util_clamp_min)
> +#define PROCFS_UCLAMP_MAX	PROCFS(sched_util_clamp_max)

Please, add it to include/pathnames.h as
 
 #define _PATH_PROC_KERNEL      "/proc/sys/kernel"
 #define _PATH_PROC_UCLAMP_MIN  PATH_PROC_KERNEL "/sched_util_clamp_min"
 #defene _PATH_PROC_UCLAMP_MAN  PATH_PROC_KERNEL "/sched_util_clamp_max"


> +#define MAX_OPT		1000
> +#define COMM_LEN	64
> +#define NOT_SET		-1U
> +
> +struct uclampset {
> +	unsigned int util_min;
> +	unsigned int util_max;
> +
> +	pid_t pid;
> +	unsigned int all_tasks;			/* all threads of the PID */
> +
> +	unsigned int system;
> +
> +	unsigned int verbose;

Seems like we can use bits only:

    unsigned int all_tasks:1
                 system:1,
                 verbose:1;

> +static void __attribute__((__noreturn__)) usage(void)
> +{
> +	FILE *out = stdout;
> +
> +	fputs(_("Show or change the utilization clamping attributes of a process or the system.\n"), out);

We usually have this description after synopsis and before "Options".

> +	fputs(USAGE_SEPARATOR, out);
> +	fputs(_("Set util clamp for a process:\n"
> +	" uclampset [options] [-m <util_min>] [-M <util_max>] [cmd <arg>...]\n"
> +	" uclampset [options] [-m <util_min>] [-M <util_max>] --pid <pid>\n"), out);
> +	fputs(USAGE_SEPARATOR, out);
> +	fputs(_("Get util clamp for a process:\n"
> +	" uclampset [options] -p <pid>\n"), out);
> +
> +	fputs(USAGE_SEPARATOR, out);
> +	fputs(_("Set util clamp for the sytem:\n"
> +	" uclampset [options] --system [-m <util_min>] [-M <util_max>]\n"), out);
> +	fputs(USAGE_SEPARATOR, out);
> +	fputs(_("Get util clamp for the system:\n"
> +	" uclampset [options] -s\n"), out);

You do not have to be so verbose :-)

        fprintf(out,
              _(" %1$s [options]\n"
                " %1$s [options] --pid <pid> | --system | <command> <arg>...\n",
                program_invocation_short_name);
seems enough.

> +	fputs(USAGE_SEPARATOR, out);
> +	fputs(_("Other options:\n"), out);

fputs(USAGE_OPTIONS, out);

> +	fputs(_(" -m                   util_min value to set\n"), out);
> +	fputs(_(" -M                   util_max value to set\n"), out);
> +	fputs(_(" -a, --all-tasks      operate on all the tasks (threads) for a given pid\n"), out);
> +	fputs(_(" -p, --pid            operate on existing given pid\n"), out);
> +	fputs(_(" -s, --system         operate on system\n"), out);
> +	fputs(_(" --max                show min and max valid uclamp values\n"), out);
> +	fputs(_(" -v, --verbose        display status information\n"), out);
> +
> +	fputs(USAGE_SEPARATOR, out);
> +	printf(USAGE_HELP_OPTIONS(22));
> +
> +	printf(USAGE_MAN_TAIL("uclampset(1)"));
> +	exit(EXIT_SUCCESS);
> +}
> +
> +static void proc_pid_name(pid_t pid, char *name, int len)
> +{
> +	char *proc_comm_fmt = "/proc/%d/comm";
> +	char proc_comm[COMM_LEN];
> +	FILE *fp;
> +	int size;
> +
> +	size = snprintf(proc_comm, COMM_LEN, proc_comm_fmt, pid);
> +	if (size >= COMM_LEN || size < 0)
> +		goto error;
> +
> +	fp = fopen(proc_comm, "r");
> +	if (!fp)
> +		goto error;
> +
> +	size = fread(name, 1, len, fp);
> +	name[size-1] = '\0';
> +
> +	fclose(fp);
> +
> +	if (ferror(fp))
> +		goto error;
> +
> +	return;
> +error:
> +	strncpy(name, "unknown", len);
> +}

Please, use proc_get_command_name() from lib/procutils.c 

> +static void show_uclamp_pid_info(pid_t pid)
> +{
> +#ifdef HAVE_SCHED_SETATTR

This is unnecessary #ifdef, we will not compile uclampset at all if
sched_getattr() and sched_setattr() are not available.

> +	struct sched_attr sa;
> +	char comm[COMM_LEN];
> +
> +	/* don't display "pid 0" as that is confusing */
> +	if (!pid)
> +		pid = getpid();
> +
> +
> +	proc_pid_name(pid, comm, COMM_LEN);
> +
> +	if (sched_getattr(pid, &sa, sizeof(sa), 0) != 0)
> +		err(EXIT_FAILURE, _("failed to get pid %d's uclamp values"), pid);
> +
> +	printf(_("%s-%d\n\tutil_min: %d\n\tutil_max: %d\n"),
> +		  comm, pid, sa.sched_util_min, sa.sched_util_max);

  comm =  proc_get_command_name(pid);

  printf(_("%s-%d\n\tutil_min: %d\n\tutil_max: %d\n"),
          comm ? : "uknown", pid, sa.sched_util_min, sa.sched_util_max);
  
  free(comm);

I like the idea with command name, it seems more user-friendly
than chrt-way:  "pid 876909's current  ...", but I'm not sure with
multiple lines for each PID (%s-%d\n\t)

Let's imagine you will use

  uclamp --all-tasks --pid 123

in your script. It would be probably better to use

   "%s (%d) utilization: min: %d, max: %d\n"

to keep it easy to parse.

> +#else
> +	err(EXIT_FAILURE, _("uclamp is not supported on this system"));
> +#endif
> +}
> +
> +static unsigned int read_uclamp_sysfs(char *dir)

Please, s/dir/filename/

> +{
> +	unsigned int size;
> +	char buf[16];
> +	FILE *fp;
> +
> +	fp = fopen(dir, "r");
> +	if (!fp)
> +		err(EXIT_FAILURE, _("cannot open %s"), dir);
> +
> +	size = fread(buf, 1, sizeof(buf), fp);
> +	buf[size-1] = '\0';
> +
> +	if (ferror(fp)) {
> +		fclose(fp);
> +		err(EXIT_FAILURE, _("error writing %s"), dir);

 s/error writing %s/cannot read %s/

> +	}
> +
> +	fclose(fp);
> +
> +	return strtou32_or_err(buf, _("invalid util clamp value"));

you can replace all this code with stuff from lib/path.c

  unsigned int res;

  if (ul_path_read_u32(NULL, &res, filename) != 0)
    err(EXIT_FAILURE, _("cannot read %s), filename);

> +}
> +
> +static void write_uclamp_sysfs(char *dir, unsigned int val)
> +{
> +	unsigned int size;
> +	char buf[16];
> +	FILE *fp;
> +
> +	fp = fopen(dir, "w");
> +	if (!fp)
> +		err(EXIT_FAILURE, _("cannot open %s"), dir);
> +
> +	size = snprintf(buf, sizeof(buf), "%d", val);
> +	buf[size] = '\n';
> +	buf[size+1] = '\0';
> +	fwrite(buf, 1, sizeof(buf), fp);
> +
> +	if (ferror(fp)) {
> +		fclose(fp);
> +		err(EXIT_FAILURE, _("error writing %s"), dir);

"cannot write %s" 

If not sure see po/util-linux.pot and use the most common string. It
will save translators' time ;-)

> +	}
> +
> +	fclose(fp);
> +}

but, you want to use:  ul_path_write_u64(NULL, val, filename)

> +static void show_uclamp_system_info(void)
> +{
> +	unsigned int min, max;
> +
> +	min = read_uclamp_sysfs(PROCFS_UCLAMP_MIN);
> +	max = read_uclamp_sysfs(PROCFS_UCLAMP_MAX);
> +
> +	printf(_("System\n\tutil_min: %u\n\tutil_max: %u\n"), min, max);
> +}
> +
> +static void show_uclamp_info(struct uclampset *ctl)
> +{
> +	if (ctl->system) {
> +		show_uclamp_system_info();
> +	} else if (ctl->all_tasks) {
> +		pid_t tid;
> +		struct proc_tasks *ts = proc_open_tasks(ctl->pid);
> +
> +		if (!ts)
> +			err(EXIT_FAILURE, _("cannot obtain the list of tasks"));
> +
> +		while (!proc_next_tid(ts, &tid))
> +			show_uclamp_pid_info(tid);
> +
> +		proc_close_tasks(ts);
> +	} else {
> +		show_uclamp_pid_info(ctl->pid);
> +	}
> +}
> +
> +static void show_min_max(void)
> +{
> +	printf(_("util_min and util_max must be in the range of [0:1024] inclusive\n"));
> +}

Why we need --max to get hardcode range? Would be enough to add this
note to --usage output?

> +#ifndef HAVE_SCHED_SETATTR
> +static int set_uclamp_one(struct uclampset *ctl, pid_t pid)
> +{
> +	err(EXIT_FAILURE, _("uclamp is not supported on this system"));
> +}

Again, unnecessary #ifndef.

> +#else /* !HAVE_SCHED_SETATTR */
> +static int set_uclamp_one(struct uclampset *ctl, pid_t pid)
> +{
> +	struct sched_attr sa;
> +
> +	if (sched_getattr(pid, &sa, sizeof(sa), 0) != 0)
> +		err(EXIT_FAILURE, _("failed to get pid %d's uclamp values"), pid);
> +
> +	if (ctl->util_min != NOT_SET)
> +		sa.sched_util_min = ctl->util_min;
> +	if (ctl->util_max != NOT_SET)
> +		sa.sched_util_max = ctl->util_max;
> +
> +	sa.sched_flags = SCHED_FLAG_KEEP_POLICY |
> +			 SCHED_FLAG_KEEP_PARAMS |
> +			 SCHED_FLAG_UTIL_CLAMP_MIN |
> +			 SCHED_FLAG_UTIL_CLAMP_MAX;
> +
> +	return sched_setattr(pid, &sa, 0);
> +}

What about SCHED_FLAG_RESET_ON_FORK flag (aka -R for chrt(8))? Does it
matter for the task utilization attributes?

> +#endif /* HAVE_SCHED_SETATTR */
> +
> +static void set_uclamp_pid(struct uclampset *ctl)
> +{
> +	if (ctl->all_tasks) {
> +		pid_t tid;
> +		struct proc_tasks *ts = proc_open_tasks(ctl->pid);
> +
> +		if (!ts)
> +			err(EXIT_FAILURE, _("cannot obtain the list of tasks"));
> +
> +		while (!proc_next_tid(ts, &tid))
> +			if (set_uclamp_one(ctl, tid) == -1)
> +				err(EXIT_FAILURE, _("failed to set tid %d's uclamp values"), tid);
> +
> +		proc_close_tasks(ts);
> +
> +	} else if (set_uclamp_one(ctl, ctl->pid) == -1) {
> +		err(EXIT_FAILURE, _("failed to set pid %d's uclamp values"), ctl->pid);
> +	}
> +}
> +
> +static void set_uclamp_system(struct uclampset *ctl)
> +{
> +	if (ctl->util_min == NOT_SET)
> +		ctl->util_min = read_uclamp_sysfs(PROCFS_UCLAMP_MIN);
> +
> +	if (ctl->util_max == NOT_SET)
> +		ctl->util_max = read_uclamp_sysfs(PROCFS_UCLAMP_MAX);
> +
> +	if (ctl->util_min > ctl->util_max) {
> +		errno = EINVAL;
> +		err(EXIT_FAILURE, _("util_min must be <= util_max"));
> +	}
> +
> +	write_uclamp_sysfs(PROCFS_UCLAMP_MIN, ctl->util_min);
> +	write_uclamp_sysfs(PROCFS_UCLAMP_MAX, ctl->util_max);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	struct uclampset _ctl = {
> +		.pid = -1,
> +		.util_min = NOT_SET,
> +		.util_max = NOT_SET
> +	};
> +	struct uclampset *ctl = &_ctl;
> +	bool no_input;
> +	int c;
> +
> +	static const struct option longopts[] = {
> +		{ "all-tasks",  no_argument, NULL, 'a' },
> +		{ "pid",	no_argument, NULL, 'p' },
> +		{ "system",	no_argument, NULL, 's' },
> +		{ "help",	no_argument, NULL, 'h' },
> +		{ "max",        no_argument, NULL, MAX_OPT },
> +		{ "verbose",	no_argument, NULL, 'v' },
> +		{ "version",	no_argument, NULL, 'V' },
> +		{ NULL,		no_argument, NULL, 0 }
> +	};
> +
> +	setlocale(LC_ALL, "");
> +	bindtextdomain(PACKAGE, LOCALEDIR);
> +	textdomain(PACKAGE);
> +	close_stdout_atexit();
> +
> +	while((c = getopt_long(argc, argv, "+asphmMvV", longopts, NULL)) != -1)
> +	{
> +		switch (c) {
> +		case 'a':
> +			ctl->all_tasks = 1;
> +			break;
> +		case MAX_OPT:
> +			show_min_max();
> +			return EXIT_SUCCESS;
> +		case 'p':
> +			errno = 0;
> +			ctl->pid = strtos32_or_err(argv[optind], _("invalid PID argument"));
> +			optind++;
> +			break;
> +		case 's':
> +			ctl->system = 1;
> +			break;
> +		case 'v':
> +			ctl->verbose = 1;
> +			break;
> +		case 'm':
> +			ctl->util_min = strtos32_or_err(argv[optind], _("invalid util_min argument"));
> +			optind++;
> +			break;
> +		case 'M':
> +			ctl->util_max = strtos32_or_err(argv[optind], _("invalid util_max argument"));
> +			optind++;
> +			break;
> +		case 'V':
> +			print_version(EXIT_SUCCESS);
> +			/* fallthrough */
> +		case 'h':
> +			usage();
> +		default:
> +			errtryhelp(EXIT_FAILURE);
> +		}
> +	}
> +
> +	no_input = ctl->util_min == NOT_SET && ctl->util_max == NOT_SET;
> +
> +	if (no_input) {
> +		show_uclamp_info(ctl);
> +		return EXIT_SUCCESS;
> +	}
> +
> +	if (ctl->pid == -1)
> +		ctl->pid = 0;
> +
> +	if (ctl->system)
> +		set_uclamp_system(ctl);
> +	else
> +		set_uclamp_pid(ctl);
> +
> +	if (ctl->verbose)
> +		show_uclamp_info(ctl);
> +
> +	if (!ctl->pid && !ctl->system) {
> +		argv += optind;
> +		execvp(argv[0], argv);
> +		errexec(argv[0]);
> +	}
> +
> +	return EXIT_SUCCESS;
> +}

Thanks!

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

