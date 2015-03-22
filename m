Return-Path: ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20150318172603.GE28925@ws.net.home>
Date: Sun, 22 Mar 2015 14:07:25 -0500
In-Reply-To: <20150318172603.GE28925@ws.net.home> (Karel Zak's message of
	"Wed, 18 Mar 2015 18:26:03 +0100")
Message-ID: <87y4moam1e.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: unshare(1) --propagation
List-ID: <util-linux.vger.kernel.org>

Karel Zak <kzak@redhat.com> writes:

> Comments, objections?

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

It might surprise a few folks that 
"--propagation shared" and "--propagation off" are do not do
the same thing..  But otherwise as far as functionality this looks
fine.

I will suggest instead of calling it "--propagation off" you
call it "--propagation unchanged".

I think unchanged better describes how you are changing the propagation
state and it makes it easier to read the command line.

I also think --propagation private is much less likely to burn folks.

Of course the flip side is that as soon as they finish prototyping and
start putting their logic in an application they will get burned.  But
there is only so much a person can do.  And "--propagation private" is
a common enough desire I think it makes sense.  Especially since
"--propagation private" is what any sane person will expect to happen.


Eric


> From b3dc1f57a16283b6c4ebd93239f7cfb4b9bb1950 Mon Sep 17 00:00:00 2001
> From: Karel Zak <kzak@redhat.com>
> Date: Wed, 18 Mar 2015 15:13:15 +0100
> Subject: [PATCH] unshare: add --propagation, use MS_PRIVATE by default
>
> After "unshare --mount" users assume that mount operations within the
> new namespaces are unshared (invisible for the rest of the system).
>
> Unfortunately, this is not true and the behavior depends on the
> current mount propagation setting. The kernel default is "private",
> but for example systemd based distros use "shared". The solution is to
> use "mount --make-r{private,slave}" after unshare(1).
>
> I have been requested many times to provide less fragile and more
> unified unshared mount setting *by default* to make things user
> friendly.
>
> The patch forces unshare(1) to explicitly use MS_REC|MS_PRIVATE for all
> tree by default.
>
> We can use something less (e.g MS_SLAVE), but "private" is the kernel
> default, so for many users this change (feature) will be invisible.
>
> This feature is possible to disable by "--propagation off" or it's
> possible to specify another propagation flag, supported are:
>
> 	<slave|shared|private|off>
>
> References: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=739593
> Signed-off-by: Karel Zak <kzak@redhat.com>
> ---
>  sys-utils/unshare.1 | 20 ++++++++++++++------
>  sys-utils/unshare.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+), 6 deletions(-)
>
> diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
> index 99a0d0a..a25526b 100644
> --- a/sys-utils/unshare.1
> +++ b/sys-utils/unshare.1
> @@ -14,12 +14,14 @@ options.  Unshareable namespaces are:
>  .BR "mount namespace"
>  Mounting and unmounting filesystems will not affect the rest of the system
>  (\fBCLONE_NEWNS\fP flag), except for filesystems which are explicitly marked as
> -shared (with \fBmount --make-shared\fP; see \fI/proc/self/mountinfo\fP for the
> -\fBshared\fP flags).
> +shared (with \fBmount --make-shared\fP; see \fI/proc/self/mountinfo\fP or
> +\fBfindmnt -o+PROPAGATION\fP for the \fBshared\fP flags).
>  .sp
> -It's recommended to use \fBmount --make-rprivate\fP or \fBmount --make-rslave\fP
> -after \fBunshare --mount\fP to make sure that mountpoints in the new namespace
> -are really unshared from the parental namespace.
> +.B unshare
> +since util-linux version 2.27 automatically sets propagation to \fBprivate\fP
> +in the new mount namespace to make sure that the new namespace is really
> +unshared. This feature is possible to disable by option \fB\-\-propagation off\fP.
> +Note that \fBprivate\fP is the kernel default.
>  .TP
>  .BR "UTS namespace"
>  Setting hostname or domainname will not affect the rest of the system.
> @@ -84,7 +86,13 @@ the mount namespace) even when run unprivileged.  As a mere convenience feature,
>  more sophisticated use cases, such as mapping multiple ranges of UIDs and GIDs.
>  This option implies --setgroups=deny.
>  .TP
> -.BR \-s , " \-\-setgroups \fIallow|deny\fP"
> +.BR "\-\-propagation \fIprivate|shared|slave|off\fP"
> +Recursively sets mount propagation flag in the new mount namespace. The default
> +is to set the propagation to \fIprivate\fP, this feature is possible to disable
> +by \fIoff\fP argument. The options is silently ignored when mount namespace (\fB\-\-mount\fP)
> +is not requested.
> +.TP
> +.BR "\-\-setgroups \fIallow|deny\fP"
>  Allow or deny
>  .BR setgroups (2)
>  syscall in user namespaces.
> diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
> index 58e9164..a8a31ca 100644
> --- a/sys-utils/unshare.c
> +++ b/sys-utils/unshare.c
> @@ -39,6 +39,9 @@
>  #include "pathnames.h"
>  #include "all-io.h"
>  
> +/* 'private' is kernel default */
> +#define UNSHARE_PROPAGATION_DEFAULT	(MS_REC | MS_PRIVATE)
> +
>  enum {
>  	SETGROUPS_NONE = -1,
>  	SETGROUPS_DENY = 0,
> @@ -100,6 +103,36 @@ static void map_id(const char *file, uint32_t from, uint32_t to)
>  	close(fd);
>  }
>  
> +static unsigned long parse_propagation(const char *str)
> +{
> +	size_t i;
> +	struct prop_opts {
> +		const char *name;
> +		unsigned long flag;
> +	} opts[] = {
> +		{ "slave",	MS_REC | MS_SLAVE },
> +		{ "private",	MS_REC | MS_PRIVATE },
> +		{ "shared",     MS_REC | MS_SHARED },
> +		{ "off",        0 }
> +	};
> +
> +	for (i = 0; i < ARRAY_SIZE(opts); i++) {
> +		if (strcmp(opts[i].name, str) == 0)
> +			return opts[i].flag;
> +	}
> +
> +	errx(EXIT_FAILURE, _("unsupported propagation mode: %s"), str);
> +}
> +
> +static void set_propagation(unsigned long flags)
> +{
> +	if (flags == 0)
> +		return;
> +
> +	if (mount("none", "/", NULL, flags, NULL) != 0)
> +		err(EXIT_FAILURE, _("cannot change propagation"));
> +}
> +
>  static void usage(int status)
>  {
>  	FILE *out = status == EXIT_SUCCESS ? stdout : stderr;
> @@ -121,6 +154,8 @@ static void usage(int status)
>  	fputs(_(" -f, --fork                fork before launching <program>\n"), out);
>  	fputs(_("     --mount-proc[=<dir>]  mount proc filesystem first (implies --mount)\n"), out);
>  	fputs(_(" -r, --map-root-user       map current user to root (implies --user)\n"), out);
> +	fputs(_("     --propagation <slave|shared|private|off>\n"
> +	        "                           modify mount propagation in mount namespace\n"), out);
>  	fputs(_(" -s, --setgroups allow|deny  control the setgroups syscall in user namespaces\n"), out);
>  
>  	fputs(USAGE_SEPARATOR, out);
> @@ -135,6 +170,7 @@ int main(int argc, char *argv[])
>  {
>  	enum {
>  		OPT_MOUNTPROC = CHAR_MAX + 1,
> +		OPT_PROPAGATION,
>  		OPT_SETGROUPS
>  	};
>  	static const struct option longopts[] = {
> @@ -149,6 +185,7 @@ int main(int argc, char *argv[])
>  		{ "fork", no_argument, 0, 'f' },
>  		{ "mount-proc", optional_argument, 0, OPT_MOUNTPROC },
>  		{ "map-root-user", no_argument, 0, 'r' },
> +		{ "propagation", required_argument, 0, OPT_PROPAGATION },
>  		{ "setgroups", required_argument, 0, OPT_SETGROUPS },
>  		{ NULL, 0, 0, 0 }
>  	};
> @@ -157,6 +194,7 @@ int main(int argc, char *argv[])
>  	int unshare_flags = 0;
>  	int c, forkit = 0, maproot = 0;
>  	const char *procmnt = NULL;
> +	unsigned long propagation = UNSHARE_PROPAGATION_DEFAULT;
>  	uid_t real_euid = geteuid();
>  	gid_t real_egid = getegid();;
>  
> @@ -204,6 +242,9 @@ int main(int argc, char *argv[])
>  		case OPT_SETGROUPS:
>  			setgrpcmd = setgroups_str2id(optarg);
>  			break;
> +		case OPT_PROPAGATION:
> +			propagation = parse_propagation(optarg);
> +			break;
>  		default:
>  			usage(EXIT_FAILURE);
>  		}
> @@ -248,6 +289,9 @@ int main(int argc, char *argv[])
>  	} else if (setgrpcmd != SETGROUPS_NONE)
>  		setgroups_control(setgrpcmd);
>  
> +	if ((unshare_flags & CLONE_NEWNS) && propagation)
> +		set_propagation(propagation);
> +
>  	if (procmnt &&
>  	    (mount("none", procmnt, NULL, MS_PRIVATE|MS_REC, NULL) != 0 ||
>  	     mount("proc", procmnt, "proc", MS_NOSUID|MS_NOEXEC|MS_NODEV, NULL) != 0))
