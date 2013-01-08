Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52755 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099Ab3AHIbi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Jan 2013 03:31:38 -0500
Date: Tue, 8 Jan 2013 09:31:30 +0100
From: Karel Zak <kzak@redhat.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: util-linux@vger.kernel.org,
        =?iso-8859-1?Q?P=E1draig?= Brady <P@draigbrady.com>,
        =?iso-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
Subject: Re: [PATCH] Add setpriv, a tool to set privileges and such
Message-ID: <20130108083130.GA13020@x2.net.home>
References: <b9e1a13168f41cde97e1fdaa21cdc5354ef535ea.1353702119.git.luto@amacapital.net>
 <5a4bb50baed87dbe00be9003dad7cc1ba59ca571.1354954632.git.luto@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5a4bb50baed87dbe00be9003dad7cc1ba59ca571.1354954632.git.luto@amacapital.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Sorry for the delay, I had 3 weeks vacation.

On Sat, Dec 08, 2012 at 12:19:12AM -0800, Andy Lutomirski wrote:
> +if BUILD_SETPRIV
> +usrbin_exec_PROGRAMS += setpriv
> +dist_man_MANS += sys-utils/setpriv.1
> +setpriv_SOURCES = sys-utils/setpriv.c
> +setpriv_LDADD = -lcap-ng
> +endif

 Maybe the caps support should be optional, anyway you need to check
 for the library in the configure script.

> +static void complain(const char *fmt, ...)
> +{
> +	va_list ap;
> +	va_start(ap, fmt);
> +	vfprintf(stderr, fmt, ap);
> +	va_end(ap);
> +	fputc('\n', stderr);
> +	usage(EXIT_FAILURE);
> +}

 seems like poor reimplementation of err() from err.h :-)

> +// Returns the number of capabilities printed

 please use /* comment */

> +static void stdout_perror(const char *prefix)
> +{
> +	if (errno < 0 || errno >= sys_nerr)
> +		printf(_("%s: error %d\n"), prefix, errno);
> +	else
> +		printf(_("%s: %s\n"), prefix, sys_errlist[errno]);
> +}

 warnx() from err.h

> +static void dump_label(const char *name)
> +{
> +	int fd = open("/proc/self/attr/current", O_RDONLY);
> +	if (fd == -1) {
> +		stdout_perror(name);
> +		return;
> +	}
> +
> +	char buf[4097];
> +	ssize_t len = read(fd, buf, sizeof(buf));
> +	int e = errno;

 we usually have declarations at the begin of block (function)...

> +struct options {

 ...and structs at the begin of the file. The name "options" seems
 also too generic (like anything for getopt_long), what about 

  struct privcxt {

  }

 or so.

>   bool nnp;

don't use bool in util-linux, within structs you can use bit arrays.

>   // real and effective (in that order)
>   bool have_uid[2];
>   uid_t uid[2];
>   bool have_gid[2];
>   gid_t gid[2];

 it would be more readable to use

    uid_t ruid;
    uid_t euid;
   
    unsigned have_ruid:1,
             have_euid:1;

 (and the same for groups)  rather than depend on an order.

> +static void priverr(const char *str)
> +{
> +	perror(str);
> +	exit(127);
> +}

 err(127, str);

it would be also nice to have a macro (SETPRV_EX_* ?) in the code
rather than the magic number.

> +
> +static void parse_groups(struct options *opts, const char *str)
> +{
> +	char *groups = strdup(str);
> +	char *buf = groups;  /* We'll reuse it */
> +	char *c;
> +
> +	opts->have_groups = true;
> +	opts->num_groups = 0;
> +	while ((c = strsep(&groups, ",")) != 0)
> +		opts->num_groups++;
> +
> +	// Start again
> +	strcpy(buf, str);  // It's exactly the right length
> +	groups = buf;
> +
> +	opts->groups = calloc(opts->num_groups, sizeof(gid_t));
> +	size_t i = 0;
> +	while ((c = strsep(&groups, ",")) != 0) {
> +		char *end;
> +		errno = 0;
> +		long val = strtol(c, &end, 10);

   strtol_or_err()  (include/strutils.h)

> +		if (!*c || *end || errno || val != (long long)(gid_t)val)
> +			complain(_("Invalid supplementary group id"));
> +		opts->groups[i++] = (gid_t)val;
> +	}
> +
> +	free(groups);;
> +}
> +

> +int main(int argc, char *argv[])
> +{
> +	enum {
> +		NNP = 256,

 SETPRIV_OPT_NNP = CHAR_MAX + 1

> +		RUID = 256,
> +		EUID,
> +		RGID,
> +		EGID,
> +		REUID,
> +		REGID,
> +		CLEAR_GROUPS,
> +		KEEP_GROUPS,
> +		GROUPS,
> +		INHCAPS,
> +		LISTCAPS,
> +		CAPBSET,
> +		SECUREBITS,
> +		SELINUX_LABEL,
> +		APPARMOR_PROFILE
> +	};

[...]
	
> +		if (RUID <= c && c <= REGID) {
> +			/* This is easier than six independent cases. */
> +			char *end;
> +			errno = 0;
> +			long val = strtol(optarg, &end, 10);
> +			if (!*optarg || errno || *end)
> +				complain(_("Failed to parse uid or gid"));
> +
> +			if (c == REUID) {

              if (opts.have_euid)
                err(EXIT_FAILURE, _("duplicate euid");
              opts.have_euid = 1;
              opts.euid = strtol_or_err(optarg, _("failed to parse euid");

 ... no loop, no arrays for uids, just readable code.

 [..]

> +	if (dumplevel) {
> +		if (total_opts != dumplevel || optind < argc)
> +			complain(_("--dump is incompatible with all other options"));
> +		dump(dumplevel);
> +		return 0;


 this is main(), so return EXIT_SUCCES;

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
