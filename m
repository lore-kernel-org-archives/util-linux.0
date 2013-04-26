Return-Path: ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Richard Weinberger <richard@nod.at>
Cc: kzak@redhat.com, util-linux@vger.kernel.org, davidlohr.bueso@hp.com
References: <1366917100-10581-1-git-send-email-richard@nod.at>
Date: Thu, 25 Apr 2013 18:01:02 -0700
In-Reply-To: <1366917100-10581-1-git-send-email-richard@nod.at> (Richard
	Weinberger's message of "Thu, 25 Apr 2013 21:11:40 +0200")
Message-ID: <871u9yqf5d.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH] nsenter: Allow selecting the uid and gid to be used in the entered userns
List-ID: <util-linux.vger.kernel.org>

Richard Weinberger <richard@nod.at> writes:

> Using -S (--setuid) and -G (--setgid) one can select
> the uid/gid which will be used in the entered user namespace.

There is definitely utility here.  I don't have a strong preference but
I am inclined to suggest that you remove the set_uid and set_gid
variables, and unconditionally call setuid and setgid when entering
a user namespace.

The only case where setting the uid and gid in a user namespace could be
problematic is where the uid/gid mapping has not been set.  And entering
or running a user namespace with a mapping not setup is very unlikely to
be the common practice.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  sys-utils/nsenter.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
> index 106349c..7b2255c 100644
> --- a/sys-utils/nsenter.c
> +++ b/sys-utils/nsenter.c
> @@ -72,6 +72,8 @@ static void usage(int status)
>  	fputs(_(" -n, --net   [=<file>]  enter network namespace\n"), out);
>  	fputs(_(" -p, --pid   [=<file>]  enter pid namespace\n"), out);
>  	fputs(_(" -U, --user  [=<file>]  enter user namespace\n"), out);
> +	fputs(_(" -S, --setuid <uid>     set uid in user namespace\n"), out);
> +	fputs(_(" -G, --setgid <gid>     set gid in user namespace\n"), out);
>  	fputs(_(" -r, --root  [=<dir>]   set the root directory\n"), out);
>  	fputs(_(" -w, --wd    [=<dir>]   set the working directory\n"), out);
>  	fputs(_(" -F, --no-fork          do not fork before exec'ing <program>\n"), out);
> @@ -169,6 +171,8 @@ int main(int argc, char *argv[])
>  		{ "net", optional_argument, NULL, 'n' },
>  		{ "pid", optional_argument, NULL, 'p' },
>  		{ "user", optional_argument, NULL, 'U' },
> +		{ "setuid", required_argument, NULL, 'S' },
> +		{ "setgid", required_argument, NULL, 'G' },
>  		{ "root", optional_argument, NULL, 'r' },
>  		{ "wd", optional_argument, NULL, 'w' },
>  		{ "no-fork", no_argument, NULL, 'F' },
> @@ -179,6 +183,10 @@ int main(int argc, char *argv[])
>  	int c, namespaces = 0;
>  	bool do_rd = false, do_wd = false;
>  	int do_fork = -1; /* unknown yet */
> +	bool set_uid = false;
> +	bool set_gid = false;
> +	uid_t uid = 0;
> +	gid_t gid = 0;
>  
>  	setlocale(LC_MESSAGES, "");
>  	bindtextdomain(PACKAGE, LOCALEDIR);
> @@ -186,7 +194,7 @@ int main(int argc, char *argv[])
>  	atexit(close_stdout);
>  
>  	while ((c =
> -		getopt_long(argc, argv, "hVt:m::u::i::n::p::U::r::w::F",
> +		getopt_long(argc, argv, "hVt:m::u::i::n::p::U::S:G:r::w::F",
>  			    longopts, NULL)) != -1) {
>  		switch (c) {
>  		case 'h':
> @@ -234,6 +242,14 @@ int main(int argc, char *argv[])
>  			else
>  				namespaces |= CLONE_NEWUSER;
>  			break;
> +		case 'S':
> +			uid = strtoul_or_err(optarg, _("failed to parse uid"));
> +			set_uid = true;
> +			break;
> +		case 'G':
> +			gid = strtoul_or_err(optarg, _("failed to parse gid"));
> +			set_gid = true;
> +			break;
>  		case 'F':
>  			do_fork = 0;
>  			break;
> @@ -319,5 +335,15 @@ int main(int argc, char *argv[])
>  		execvp(argv[optind], argv + optind);
>  		err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
>  	}
> +
> +	if (namespaces & CLONE_NEWUSER) {
> +		if (set_uid)
> +			if (setuid(uid) < 0)
> +				err(EXIT_FAILURE, _("setuid failed"));
> +		if (set_gid)
> +			if (setgid(gid) < 0)
> +				err(EXIT_FAILURE, _("setgid failed"));
> +	}
> +
>  	exec_shell();
>  }
