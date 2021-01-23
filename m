Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9C9C433DB
	for <util-linux@archiver.kernel.org>; Sat, 23 Jan 2021 18:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2932322D50
	for <util-linux@archiver.kernel.org>; Sat, 23 Jan 2021 18:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbhAWS1R (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 23 Jan 2021 13:27:17 -0500
Received: from foss.arm.com ([217.140.110.172]:52642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbhAWS1Q (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 23 Jan 2021 13:27:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 312091474;
        Sat, 23 Jan 2021 10:26:29 -0800 (PST)
Received: from e107158-lin (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B8643F719;
        Sat, 23 Jan 2021 10:26:28 -0800 (PST)
Date:   Sat, 23 Jan 2021 18:26:25 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Subject: Re: [PATCH 2/5] Add uclampset schedutil
Message-ID: <20210123182625.tfeuwevvqndvkcff@e107158-lin>
References: <20210116190940.2320819-1-qais.yousef@arm.com>
 <20210116190940.2320819-3-qais.yousef@arm.com>
 <20210120122116.ways43kaigb7hcmj@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210120122116.ways43kaigb7hcmj@ws.net.home>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 01/20/21 13:21, Karel Zak wrote:
> 
>  Hi,
> 
> pretty readable code (thanks), I have some notes:

Thanks!

> 
> On Sat, Jan 16, 2021 at 07:09:37PM +0000, Qais Yousef wrote:
> >  #if defined (__linux__)
> >  # include <sys/syscall.h>
> >  #endif
> > @@ -73,6 +99,10 @@ struct sched_attr {
> >  	uint64_t sched_runtime;
> >  	uint64_t sched_deadline;
> >  	uint64_t sched_period;
> > +
> > +	/* UTILIZATION CLAMPING */
> > +	uint32_t sched_util_min;
> > +	uint32_t sched_util_max;
> >  };
> 
> This sched_attr definition is used only if regular system include files
> do not contain struct sched_attr (aka ifndef HAVE_SCHED_SETATTR).
> 
> What is expected on systems with header files from Linux < 5.3 where
> is sched_attr, but without sched_util_{min,max}?

Yes we will have a compilation error as you mention below.

> 
> I guess you need to check in ./configure.ac that struct sched_attr is
> usable for your uclampset otherwise you will see compilation error.
> You can use for example AC_LINK_IFELSE([AC_LANG_PROGRAM([[ ... and
> try to compile code with sched_attr.sched_util_min = 0.
> 
> I see two possible ways:
> 
> - do not compile uclampset at all if there is no sched_attr.sched_util_*
>   in system header files
> 
> - use you local definition from sched_attr.h, but it will probably
>   require to define own struct to avoid names collision
> 
> IMHO the first solution is more simple and it will keep your code readable.
> 
> If you not sure with the build-system stuff then ignore it and don't
> waste time with it. I can fix it before merge into master branch.

I will try. If it proved to be taking me time to get this done, I'll leave it
to you then. Thanks for offering to fix this up!

> 
> > +#define PROCFS(file)	"/proc/sys/kernel/" #file
> > +
> > +#define PROCFS_UCLAMP_MIN	PROCFS(sched_util_clamp_min)
> > +#define PROCFS_UCLAMP_MAX	PROCFS(sched_util_clamp_max)
> 
> Please, add it to include/pathnames.h as
>  
>  #define _PATH_PROC_KERNEL      "/proc/sys/kernel"
>  #define _PATH_PROC_UCLAMP_MIN  PATH_PROC_KERNEL "/sched_util_clamp_min"
>  #defene _PATH_PROC_UCLAMP_MAN  PATH_PROC_KERNEL "/sched_util_clamp_max"

Fixed.

> 
> 
> > +#define MAX_OPT		1000
> > +#define COMM_LEN	64
> > +#define NOT_SET		-1U
> > +
> > +struct uclampset {
> > +	unsigned int util_min;
> > +	unsigned int util_max;
> > +
> > +	pid_t pid;
> > +	unsigned int all_tasks;			/* all threads of the PID */
> > +
> > +	unsigned int system;
> > +
> > +	unsigned int verbose;
> 
> Seems like we can use bits only:
> 
>     unsigned int all_tasks:1
>                  system:1,
>                  verbose:1;

Fixed.

> 
> > +static void __attribute__((__noreturn__)) usage(void)
> > +{
> > +	FILE *out = stdout;
> > +
> > +	fputs(_("Show or change the utilization clamping attributes of a process or the system.\n"), out);
> 
> We usually have this description after synopsis and before "Options".

Fixed.

> 
> > +	fputs(USAGE_SEPARATOR, out);
> > +	fputs(_("Set util clamp for a process:\n"
> > +	" uclampset [options] [-m <util_min>] [-M <util_max>] [cmd <arg>...]\n"
> > +	" uclampset [options] [-m <util_min>] [-M <util_max>] --pid <pid>\n"), out);
> > +	fputs(USAGE_SEPARATOR, out);
> > +	fputs(_("Get util clamp for a process:\n"
> > +	" uclampset [options] -p <pid>\n"), out);
> > +
> > +	fputs(USAGE_SEPARATOR, out);
> > +	fputs(_("Set util clamp for the sytem:\n"
> > +	" uclampset [options] --system [-m <util_min>] [-M <util_max>]\n"), out);
> > +	fputs(USAGE_SEPARATOR, out);
> > +	fputs(_("Get util clamp for the system:\n"
> > +	" uclampset [options] -s\n"), out);
> 
> You do not have to be so verbose :-)
> 
>         fprintf(out,
>               _(" %1$s [options]\n"
>                 " %1$s [options] --pid <pid> | --system | <command> <arg>...\n",
>                 program_invocation_short_name);
> seems enough.

:-)

I got this now

	$ ./uclampset -h
	 uclampset [options]
	 uclampset [options] --pid <pid> | --system | <command> <arg>...

	Show or change the utilization clamping attributes of a process or the system.
	Utilization range: [0:1024]

	Options:
	 -m                   util_min value to set
	 -M                   util_max value to set
	 -a, --all-tasks      operate on all the tasks (threads) for a given pid
	 -p, --pid            operate on existing given pid
	 -s, --system         operate on system
	 -v, --verbose        display status information

	 -h, --help           display this help
	 -V, --version        display version

	For more details, see uclampset(1).

> 
> > +	fputs(USAGE_SEPARATOR, out);
> > +	fputs(_("Other options:\n"), out);
> 
> fputs(USAGE_OPTIONS, out);

Fixed.

> 
> > +	fputs(_(" -m                   util_min value to set\n"), out);
> > +	fputs(_(" -M                   util_max value to set\n"), out);
> > +	fputs(_(" -a, --all-tasks      operate on all the tasks (threads) for a given pid\n"), out);
> > +	fputs(_(" -p, --pid            operate on existing given pid\n"), out);
> > +	fputs(_(" -s, --system         operate on system\n"), out);
> > +	fputs(_(" --max                show min and max valid uclamp values\n"), out);
> > +	fputs(_(" -v, --verbose        display status information\n"), out);
> > +
> > +	fputs(USAGE_SEPARATOR, out);
> > +	printf(USAGE_HELP_OPTIONS(22));
> > +
> > +	printf(USAGE_MAN_TAIL("uclampset(1)"));
> > +	exit(EXIT_SUCCESS);
> > +}
> > +
> > +static void proc_pid_name(pid_t pid, char *name, int len)
> > +{
> > +	char *proc_comm_fmt = "/proc/%d/comm";
> > +	char proc_comm[COMM_LEN];
> > +	FILE *fp;
> > +	int size;
> > +
> > +	size = snprintf(proc_comm, COMM_LEN, proc_comm_fmt, pid);
> > +	if (size >= COMM_LEN || size < 0)
> > +		goto error;
> > +
> > +	fp = fopen(proc_comm, "r");
> > +	if (!fp)
> > +		goto error;
> > +
> > +	size = fread(name, 1, len, fp);
> > +	name[size-1] = '\0';
> > +
> > +	fclose(fp);
> > +
> > +	if (ferror(fp))
> > +		goto error;
> > +
> > +	return;
> > +error:
> > +	strncpy(name, "unknown", len);
> > +}
> 
> Please, use proc_get_command_name() from lib/procutils.cï¿½

Oh, I missed this one. I did search for it but clearly failed. Fixed.

> 
> > +static void show_uclamp_pid_info(pid_t pid)
> > +{
> > +#ifdef HAVE_SCHED_SETATTR
> 
> This is unnecessary #ifdef, we will not compile uclampset at all if
> sched_getattr() and sched_setattr() are not available.

Fixed.

> 
> > +	struct sched_attr sa;
> > +	char comm[COMM_LEN];
> > +
> > +	/* don't display "pid 0" as that is confusing */
> > +	if (!pid)
> > +		pid = getpid();
> > +
> > +
> > +	proc_pid_name(pid, comm, COMM_LEN);
> > +
> > +	if (sched_getattr(pid, &sa, sizeof(sa), 0) != 0)
> > +		err(EXIT_FAILURE, _("failed to get pid %d's uclamp values"), pid);
> > +
> > +	printf(_("%s-%d\n\tutil_min: %d\n\tutil_max: %d\n"),
> > +		  comm, pid, sa.sched_util_min, sa.sched_util_max);
> 
>   comm =  proc_get_command_name(pid);
> 
>   printf(_("%s-%d\n\tutil_min: %d\n\tutil_max: %d\n"),
>           comm ? : "uknown", pid, sa.sched_util_min, sa.sched_util_max);
>   
>   free(comm);
> 
> I like the idea with command name, it seems more user-friendly
> than chrt-way:  "pid 876909's current  ...", but I'm not sure with
> multiple lines for each PID (%s-%d\n\t)
> 
> Let's imagine you will use
> 
>   uclamp --all-tasks --pid 123
> 
> in your script. It would be probably better to use
> 
>    "%s (%d) utilization: min: %d, max: %d\n"
> 
> to keep it easy to parse.

I think I had it all in one line but then found my eyes were struggling to
parse it. But I think I was being picky. Making it more machine readable will
be more useful.

Changed it as you suggested except s/utilization/util_clamp/ which I think is
more descriptive.

> 
> > +#else
> > +	err(EXIT_FAILURE, _("uclamp is not supported on this system"));
> > +#endif
> > +}
> > +
> > +static unsigned int read_uclamp_sysfs(char *dir)
> 
> Please, s/dir/filename/

Fixed.

> 
> > +{
> > +	unsigned int size;
> > +	char buf[16];
> > +	FILE *fp;
> > +
> > +	fp = fopen(dir, "r");
> > +	if (!fp)
> > +		err(EXIT_FAILURE, _("cannot open %s"), dir);
> > +
> > +	size = fread(buf, 1, sizeof(buf), fp);
> > +	buf[size-1] = '\0';
> > +
> > +	if (ferror(fp)) {
> > +		fclose(fp);
> > +		err(EXIT_FAILURE, _("error writing %s"), dir);
> 
>  s/error writing %s/cannot read %s/
> 
> > +	}
> > +
> > +	fclose(fp);
> > +
> > +	return strtou32_or_err(buf, _("invalid util clamp value"));
> 
> you can replace all this code with stuff from lib/path.c
> 
>   unsigned int res;
> 
>   if (ul_path_read_u32(NULL, &res, filename) != 0)
>     err(EXIT_FAILURE, _("cannot read %s), filename);
> 
> > +}
> > +
> > +static void write_uclamp_sysfs(char *dir, unsigned int val)
> > +{
> > +	unsigned int size;
> > +	char buf[16];
> > +	FILE *fp;
> > +
> > +	fp = fopen(dir, "w");
> > +	if (!fp)
> > +		err(EXIT_FAILURE, _("cannot open %s"), dir);
> > +
> > +	size = snprintf(buf, sizeof(buf), "%d", val);
> > +	buf[size] = '\n';
> > +	buf[size+1] = '\0';
> > +	fwrite(buf, 1, sizeof(buf), fp);
> > +
> > +	if (ferror(fp)) {
> > +		fclose(fp);
> > +		err(EXIT_FAILURE, _("error writing %s"), dir);
> 
> "cannot write %s" 
> 
> If not sure see po/util-linux.pot and use the most common string. It
> will save translators' time ;-)

Ah, handy!

> 
> > +	}
> > +
> > +	fclose(fp);
> > +}
> 
> but, you want to use:  ul_path_write_u64(NULL, val, filename)

Changed to use path.h helper functions. Missed those too. I should have tried
harder :)

> 
> > +static void show_uclamp_system_info(void)
> > +{
> > +	unsigned int min, max;
> > +
> > +	min = read_uclamp_sysfs(PROCFS_UCLAMP_MIN);
> > +	max = read_uclamp_sysfs(PROCFS_UCLAMP_MAX);
> > +
> > +	printf(_("System\n\tutil_min: %u\n\tutil_max: %u\n"), min, max);
> > +}
> > +
> > +static void show_uclamp_info(struct uclampset *ctl)
> > +{
> > +	if (ctl->system) {
> > +		show_uclamp_system_info();
> > +	} else if (ctl->all_tasks) {
> > +		pid_t tid;
> > +		struct proc_tasks *ts = proc_open_tasks(ctl->pid);
> > +
> > +		if (!ts)
> > +			err(EXIT_FAILURE, _("cannot obtain the list of tasks"));
> > +
> > +		while (!proc_next_tid(ts, &tid))
> > +			show_uclamp_pid_info(tid);
> > +
> > +		proc_close_tasks(ts);
> > +	} else {
> > +		show_uclamp_pid_info(ctl->pid);
> > +	}
> > +}
> > +
> > +static void show_min_max(void)
> > +{
> > +	printf(_("util_min and util_max must be in the range of [0:1024] inclusive\n"));
> > +}
> 
> Why we need --max to get hardcode range? Would be enough to add this
> note to --usage output?

Sounds better, yes. Done.

> 
> > +#ifndef HAVE_SCHED_SETATTR
> > +static int set_uclamp_one(struct uclampset *ctl, pid_t pid)
> > +{
> > +	err(EXIT_FAILURE, _("uclamp is not supported on this system"));
> > +}
> 
> Again, unnecessary #ifndef.

Fixed.

> 
> > +#else /* !HAVE_SCHED_SETATTR */
> > +static int set_uclamp_one(struct uclampset *ctl, pid_t pid)
> > +{
> > +	struct sched_attr sa;
> > +
> > +	if (sched_getattr(pid, &sa, sizeof(sa), 0) != 0)
> > +		err(EXIT_FAILURE, _("failed to get pid %d's uclamp values"), pid);
> > +
> > +	if (ctl->util_min != NOT_SET)
> > +		sa.sched_util_min = ctl->util_min;
> > +	if (ctl->util_max != NOT_SET)
> > +		sa.sched_util_max = ctl->util_max;
> > +
> > +	sa.sched_flags = SCHED_FLAG_KEEP_POLICY |
> > +			 SCHED_FLAG_KEEP_PARAMS |
> > +			 SCHED_FLAG_UTIL_CLAMP_MIN |
> > +			 SCHED_FLAG_UTIL_CLAMP_MAX;
> > +
> > +	return sched_setattr(pid, &sa, 0);
> > +}
> 
> What about SCHED_FLAG_RESET_ON_FORK flag (aka -R for chrt(8))? Does it
> matter for the task utilization attributes?

It should have a similar effect of resetting uclamp values on fork. I guess it
would be useful to add this here too.

There's also a special value '-1' which resets the min/max to system default.
Peter suggested (offline) I add it. I was going to use -r/-R for resetting
min/max respectively.

I will get all these reset options sorted too.

Many thanks for the comprehensive review and useful suggestions!

Cheers

--
Qais Yousef

> 
> > +#endif /* HAVE_SCHED_SETATTR */
> > +
> > +static void set_uclamp_pid(struct uclampset *ctl)
> > +{
> > +	if (ctl->all_tasks) {
> > +		pid_t tid;
> > +		struct proc_tasks *ts = proc_open_tasks(ctl->pid);
> > +
> > +		if (!ts)
> > +			err(EXIT_FAILURE, _("cannot obtain the list of tasks"));
> > +
> > +		while (!proc_next_tid(ts, &tid))
> > +			if (set_uclamp_one(ctl, tid) == -1)
> > +				err(EXIT_FAILURE, _("failed to set tid %d's uclamp values"), tid);
> > +
> > +		proc_close_tasks(ts);
> > +
> > +	} else if (set_uclamp_one(ctl, ctl->pid) == -1) {
> > +		err(EXIT_FAILURE, _("failed to set pid %d's uclamp values"), ctl->pid);
> > +	}
> > +}
> > +
> > +static void set_uclamp_system(struct uclampset *ctl)
> > +{
> > +	if (ctl->util_min == NOT_SET)
> > +		ctl->util_min = read_uclamp_sysfs(PROCFS_UCLAMP_MIN);
> > +
> > +	if (ctl->util_max == NOT_SET)
> > +		ctl->util_max = read_uclamp_sysfs(PROCFS_UCLAMP_MAX);
> > +
> > +	if (ctl->util_min > ctl->util_max) {
> > +		errno = EINVAL;
> > +		err(EXIT_FAILURE, _("util_min must be <= util_max"));
> > +	}
> > +
> > +	write_uclamp_sysfs(PROCFS_UCLAMP_MIN, ctl->util_min);
> > +	write_uclamp_sysfs(PROCFS_UCLAMP_MAX, ctl->util_max);
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	struct uclampset _ctl = {
> > +		.pid = -1,
> > +		.util_min = NOT_SET,
> > +		.util_max = NOT_SET
> > +	};
> > +	struct uclampset *ctl = &_ctl;
> > +	bool no_input;
> > +	int c;
> > +
> > +	static const struct option longopts[] = {
> > +		{ "all-tasks",  no_argument, NULL, 'a' },
> > +		{ "pid",	no_argument, NULL, 'p' },
> > +		{ "system",	no_argument, NULL, 's' },
> > +		{ "help",	no_argument, NULL, 'h' },
> > +		{ "max",        no_argument, NULL, MAX_OPT },
> > +		{ "verbose",	no_argument, NULL, 'v' },
> > +		{ "version",	no_argument, NULL, 'V' },
> > +		{ NULL,		no_argument, NULL, 0 }
> > +	};
> > +
> > +	setlocale(LC_ALL, "");
> > +	bindtextdomain(PACKAGE, LOCALEDIR);
> > +	textdomain(PACKAGE);
> > +	close_stdout_atexit();
> > +
> > +	while((c = getopt_long(argc, argv, "+asphmMvV", longopts, NULL)) != -1)
> > +	{
> > +		switch (c) {
> > +		case 'a':
> > +			ctl->all_tasks = 1;
> > +			break;
> > +		case MAX_OPT:
> > +			show_min_max();
> > +			return EXIT_SUCCESS;
> > +		case 'p':
> > +			errno = 0;
> > +			ctl->pid = strtos32_or_err(argv[optind], _("invalid PID argument"));
> > +			optind++;
> > +			break;
> > +		case 's':
> > +			ctl->system = 1;
> > +			break;
> > +		case 'v':
> > +			ctl->verbose = 1;
> > +			break;
> > +		case 'm':
> > +			ctl->util_min = strtos32_or_err(argv[optind], _("invalid util_min argument"));
> > +			optind++;
> > +			break;
> > +		case 'M':
> > +			ctl->util_max = strtos32_or_err(argv[optind], _("invalid util_max argument"));
> > +			optind++;
> > +			break;
> > +		case 'V':
> > +			print_version(EXIT_SUCCESS);
> > +			/* fallthrough */
> > +		case 'h':
> > +			usage();
> > +		default:
> > +			errtryhelp(EXIT_FAILURE);
> > +		}
> > +	}
> > +
> > +	no_input = ctl->util_min == NOT_SET && ctl->util_max == NOT_SET;
> > +
> > +	if (no_input) {
> > +		show_uclamp_info(ctl);
> > +		return EXIT_SUCCESS;
> > +	}
> > +
> > +	if (ctl->pid == -1)
> > +		ctl->pid = 0;
> > +
> > +	if (ctl->system)
> > +		set_uclamp_system(ctl);
> > +	else
> > +		set_uclamp_pid(ctl);
> > +
> > +	if (ctl->verbose)
> > +		show_uclamp_info(ctl);
> > +
> > +	if (!ctl->pid && !ctl->system) {
> > +		argv += optind;
> > +		execvp(argv[0], argv);
> > +		errexec(argv[0]);
> > +	}
> > +
> > +	return EXIT_SUCCESS;
> > +}
> 
> Thanks!
> 
>  Karel
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> 
