Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47301 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab1JQPII (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 17 Oct 2011 11:08:08 -0400
Date: Mon, 17 Oct 2011 17:08:04 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/3] prlimit: new program
Message-ID: <20111017150804.GA9767@nb.net.home>
References: <1318893789.5289.10.camel@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318893789.5289.10.camel@offworld>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 17, 2011 at 07:23:09PM -0400, Davidlohr Bueso wrote:
> +struct prlimit {
> +	char *name;
> +	char *help;
> +	int modify;          /* are we changing the limit? */
> +	int resource;        /* RLIMIT_* id */
> +	struct rlimit rlim;  /* soft,hard limits */
> +} default_lims[] = { /* when no --{resource_name} is passed */
> +	{"AS", "address space limit", 0, RLIMIT_AS, {0, 0}},

 N_("address space limit")

> +	{"CORE", "max core file size", 0, RLIMIT_CORE, {0, 0}},
> +	{"CPU", "CPU time in secs", 0, RLIMIT_CPU, {0, 0}},
> +	{"DATA", "max data size", 0, RLIMIT_DATA, {0, 0}},
> +	{"FSIZE", "max file size", 0, RLIMIT_FSIZE, {0, 0}},
> +	{"LOCKS", "max amount of file locks held", 0, RLIMIT_LOCKS, {0, 0}},
> +	{"MEMLOCK", "max locked-in-memory address space", 0, RLIMIT_MEMLOCK, {0, 0}},
> +	{"MSGQUEUE", "max bytes in POSIX mqueues", 0, RLIMIT_MSGQUEUE, {0, 0}},
> +	{"NICE", "max nice prio allowed to raise", 0, RLIMIT_NICE, {0, 0}},
> +	{"NOFILE", "max amount of open files", 0, RLIMIT_NOFILE, {0, 0}},
> +	{"NPROC", "max number of processes", 0, RLIMIT_NPROC, {0, 0}},
> +	{"RSS", "max resident set size", 0, RLIMIT_RSS, {0, 0}},
> +	{"RTPRIO", "max real-time priority", 0, RLIMIT_RTPRIO, {0, 0}},
> +	{"RTTIME", "timeout for real-time tasks", 0, RLIMIT_RTTIME, {0, 0}},
> +	{"SIGPENDING", "max amount of pending signals", 0, RLIMIT_SIGPENDING, {0, 0}},
> +	{"STACK", "max stack size", 0, RLIMIT_STACK, {0, 0}}
> +};
> +
> +#define MAX_RESOURCES ARRAY_SIZE(default_lims)
> +
> +/* to reuse data, maintain the same order used in default_lims[] */

 Please, define this enum before default_lims[] and use

   { 
     [enum] = { },
   }

 convention for the default_lims array. Anyway, see my note about
 default_lims below.

> +enum {
> +	AS,
> +	CORE,
> +	CPU,
> +	DATA,
> +	FSIZE,
> +	LOCKS,
> +	MEMLOCK,
> +	MSGQUEUE,
> +	NICE,
> +	NOFILE,
> +	NPROC,
> +	RSS,
> +	RTPRIO,
> +	RTTIME,
> +	SIGPENDING,
> +	STACK
> +};
> +
> +enum {
> +	COL_HELP,
> +	COL_RES,
> +	COL_SOFT,
> +	COL_HARD,
> +	__NCOLUMNS
> +};

 It would be better to use ARRAY_SIZE everywhere than __NCOLUMNS (yes,
 patch for lsblk is wanted :-)

> +/* column names */
> +struct colinfo {
> +	const char	*name;	/* header */
> +	double		whint;	/* width hint (N < 1 is in percent of termwidth) */
> +	int		flags;	/* TT_FL_* */
> +	const char      *help;
> +};
> +
> +/* columns descriptions */
> +struct colinfo infos[__NCOLUMNS] = {

  struct colinfo infos[] =

is enough.

> +	[COL_RES]     = { "RESOURCE",    0.25, TT_FL_RIGHT, N_("resource name") },
> +	[COL_HELP]    = { "DESCRIPTION", 0.1,  TT_FL_TRUNC, N_("resource description")},
> +	[COL_SOFT]    = { "SOFT",        0.1,  TT_FL_TRUNC, N_("soft limit")},

 Please, always use TT_FL_RIGHT for numbers.

> +	[COL_HARD]    = { "HARD",        1,    TT_FL_RIGHT, N_("hard limit (ceiling)")},
> +};
> +
> +/* array with IDs of enabled columns */
> +static int columns[__NCOLUMNS], ncolumns;
> +
> +static void __attribute__ ((__noreturn__)) usage(FILE * out)
> +{
> +	size_t i;
> +
> +	fputs(_("\nUsage:\n"), out);

 fputs(HELP_USAGE, out);  See c.h for HELP_* macros.

> +	fprintf(out,
> +		_(" %s [options]\n"), program_invocation_short_name);
> +
> +	fputs(_("\nGeneral Options:\n"), out);
> +	fputs(_(" -p, --pid <pid>        process id\n"
> +		" -o, --output <type>    define which output columns to use\n"
> +		" -h, --help             display this help and exit\n"
> +		" -V, --version          output version information and exit\n"), out);
> +
> +	fputs(_("\nResources Options:\n"), out);
> +	fputs(_(" -a, --as               address space limit\n"
> +		" -c, --core             max core file size\n"
> +		" -C, --cpu              CPU time in secs\n"
> +		" -d, --data             max data size\n"
> +		" -f, --fsize            max file size\n"
> +		" -l, --locks            max amount of file locks held\n"
> +		" -m, --memlock          max locked-in-memory address space\n"
> +		" -M, --msgqueue         max bytes in POSIX mqueues\n"
> +		" -n, --nice             max nice priority allowed to raise\n"
> +		" -N, --nofile           max amount of open files\n"
> +		" -P, --nproc            max number of processes\n"
> +		" -r, --rss              max resident set size\n"
> +		" -R, --rtprio           max real-time priority\n"
> +		" -t, --rttime           timeout for real-time teasks\n"
> +		" -s, --sigpending       max amount of pending signals\n"
> +		" -S, --stack            max stack size\n"), out);
> +
> +	fputs(_("\nAvailable columns (for --output):\n"), out);
> +
> +	for (i = 0; i < __NCOLUMNS; i++)
> +		fprintf(out, " %11s  %s\n", infos[i].name, _(infos[i].help));
> +
> +
> +	fprintf(out, _("\nFor more information see prlimit(1).\n\n"));

  fprintf(out, USAGE_MAN_TAIL("prlimit(1)");

 [...]

> +/*
> + * Obtain the soft and hard limits, from arguments in the form <soft>:<hard>
> + */
> +static int parse_prlim(pid_t pid, struct rlimit *lim, int res, const char *ops, const char *errmsg)
> +{
> +	int soft, hard;
> +
> +	if (parse_range(ops, &soft, &hard, -3))

please, don't use magic constants, use:

    if (parse_range(ops, &soft, &hard, PRLIMIT_UNKNOWN))

or so...

> +		errx(EXIT_FAILURE, "%s", errmsg);

It would be nice to support RLIM_INFINITY, something like:

   --core=unlimited or --core=10000:unlimited

btw it would be better to use RLIM_INFINITY macro rather than -1 in the code.

> +static void do_prlimit(pid_t pid, struct prlimit lims[], const int n)
> +{
> +	int i;
> +	struct rlimit *new;

int nshows = 0;

> +	for (i = 0; i < n; i++) {
> +		new = lims[i].modify ? &lims[i].rlim : NULL;

        struct rlimit *new = NULL;

        if (lims[i].modify)
            new = &lims[i].rlim;
        else
            nshows++;

> +		if (prlimit(pid, lims[i].resource, new, &lims[i].rlim) == -1)
> +			err(EXIT_FAILURE, _("failed to get resource limits for PID %d"), pid);
> +	}
> +
> +	show_limits(lims, 0, n);

 if (nshows)
    show_limits(lims, 0, n);

 .. so don't waste time with show_limits() for commands like

    prlimit --pid $$ --core=10000

 where nothing is expected on stdout ;-)

> +}
> +
> +/*
> + * Add a resource limit to the limits array
> + */
> +static int add_prlimit(pid_t pid, struct prlimit lims[], const char *ops,
> +		       int n, int id, const char *errmsg)
> +{
> +	/* setup basic data */
> +	lims[n].name = default_lims[id].name;
> +	lims[n].help = default_lims[id].help;
> +	lims[n].resource = default_lims[id].resource;

 Hmmm... this is poor design, the data structs are core of the well
 designed programs.
 
 What about:

 struct prlimit_desc {
    const char *name,
               *help;
    int        resource;
 };

 struct prlimit {
   struct prlimit_desc *desc;

   int           modify;
   struct rlimit rlim;
 };

I think it would be better to split resources description and the
limits.

> +	if (ops) { /* planning on modifying a limit? */
> +		lims[n].modify = 1;
> +		parse_prlim(pid, &lims[n].rlim, lims[n].resource, ops, errmsg);
> +	} else
> +		lims[n].modify = 0;
> +
> +	return 0;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int opt, n = 0;
> +	pid_t pid = 0; /* calling process (default) */
> +	struct prlimit lims[MAX_RESOURCES];
> +	static const struct option longopts[] = {
> +		{"pid", required_argument, NULL, 'p'},
> +		{"output", required_argument, NULL, 'o'},
> +		{"as", optional_argument, NULL, 'a'},
> +		{"core", optional_argument, NULL, 'c'},
> +		{"cpu", optional_argument, NULL, 'C'},
> +		{"data", optional_argument, NULL, 'd'},
> +		{"fsize", optional_argument, NULL, 'f'},
> +		{"locks", optional_argument, NULL, 'l'},
> +		{"memlock", optional_argument, NULL, 'm'},
> +		{"msgqueue", optional_argument, NULL, 'M'},
> +		{"nice", optional_argument, NULL, 'n'},
> +		{"nofile", optional_argument, NULL, 'N'},
> +		{"nproc", optional_argument, NULL, 'P'},
> +		{"rss", optional_argument, NULL, 'r'},
> +		{"rtprio", optional_argument, NULL, 'R'},
> +		{"rttime", optional_argument, NULL, 't'},
> +		{"sigpending", optional_argument, NULL, 's'},
> +		{"stack", optional_argument, NULL, 'S'},
> +		{"version", no_argument, NULL, 'V'},
> +		{"help", no_argument, NULL, 'h'},
> +		{NULL, 0, NULL, 0}
> +	};
> +
> +	setlocale(LC_ALL, "");
> +	bindtextdomain(PACKAGE, LOCALEDIR);
> +	textdomain(PACKAGE);
> +
> +	memset(lims, 0, sizeof(lims));
> +
> +	/*
> +	 * Something is very wrong if this doesn't succeed,
> +	 * assuming STACK is the last resource, of course.
> +	 */
> +	assert(MAX_RESOURCES == STACK + 1);
> +
> +	while((opt = getopt_long(argc, argv,
> +				 "a::c::C::d::f::l::m::M::n::N::P::r::R::t::s::S::p:o:vVh",
> +				 longopts, NULL)) != -1) {
> +		switch(opt) {
> +		case 'p':
> +			pid = strtol_or_err(optarg, _("cannot parse PID"));
> +			break;

 What will happen if:

    prlimit --pid 123 --code=10000 --pid 456 --cpu=1
    
> +		case 'a':
> +			add_prlimit(pid, lims, optarg, n++, AS, "failed to parse AS limit");

 The error message is unnecessary here. You can compose the message in
 the parse_prlim() function from resource ID. 

 It would be also better to use pointer to the prlimit struct in your
 parse_* function that use two options 'struct rlimit *lim' and 'int res'.

 So:

       case 'a':
           add_prlimit(pid, optarg, &lims[n++], AS);

 and in add_prlimit() you can initialize the pointer to desc:

    lims->desc = prlimit_desc[id];

 [...]

> +	n == 0 ? do_prlimit(pid, default_lims, MAX_RESOURCES) :
> +		 do_prlimit(pid, lims, n);

 or if you replace default_lims with prlimit_desc:

  if (!n) {
    for (n = 0; n < MAX_RESOURCES; n++)
        add_prlimit(pid, NULL, &lims[n], n);
  }

  do_prlimit(pid, lims, n);

 ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
