Return-Path: d@falconindy.com
Date: Fri, 7 Dec 2012 09:17:09 -0500
From: Dave Reisner <d@falconindy.com>
To: Werner Fink <werner@suse.de>
Cc: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 4/5] sulogin: mount temporary /dev and /proc if not found
Message-ID: <20121207141709.GF603@rampage>
References: <1354867258-14206-1-git-send-email-werner@suse.de>
 <1354867258-14206-4-git-send-email-werner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354867258-14206-4-git-send-email-werner@suse.de>
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 07, 2012 at 09:00:57AM +0100, Werner Fink wrote:
> This is very usefull if initrd can not loaded that is no /dev and no
> /proc is found.  Also if the /etc/shadow and /etc/passwd is copied into
> the initrd the sulogin can be used in initrd even before /dev and/or /proc
> are mounted.
> 
> Signed-off-by: Werner Fink <werner@suse.de>
> ---
>  configure.ac          |   10 ++++++++
>  login-utils/sulogin.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
> 
> diff --git configure.ac configure.ac
> index 3be3715..631002f 100644
> --- configure.ac
> +++ configure.ac
> @@ -1296,6 +1296,16 @@ if test "x$enable_use_tty_group" = xyes; then
>    AC_DEFINE(USE_TTY_GROUP, 1, [Should wall and write be installed setgid tty?])
>  fi
>  
> +AC_ARG_ENABLE([use-emergency-dev],
> +  AS_HELP_STRING([--disable-use-emergency-dev], [do not use emergency mount of /dev and /proc for sulogin]),
> +  [], enable_use_emergency_dev=yes
> +)
> +AM_CONDITIONAL(USE_EMERGENCY_DEV, test "x$enable_use_emergency_dev" = xyes)
> +
> +if test "x$enable_use_emergency_dev" = xyes; then
> +  AC_DEFINE(USE_EMERGENCY_DEV, 1, [Should sulogin use a emergency mount of /dev and /proc?])
> +fi
> +
>  AC_ARG_ENABLE([makeinstall-chown],
>    AS_HELP_STRING([--disable-makeinstall-chown], [do not do chown-like operations during "make install"]),
>    [], enable_makeinstall_chown=yes
> diff --git login-utils/sulogin.c login-utils/sulogin.c
> index dbcc855..0b0d21c 100644
> --- login-utils/sulogin.c
> +++ login-utils/sulogin.c
> @@ -47,6 +47,20 @@
>  # include <selinux/get_context_list.h>
>  #endif
>  
> +#ifdef USE_EMERGENCY_DEV
> +# include <sys/statfs.h>
> +# include <sys/mount.h>
> +# include <linux/fs.h>
> +# include <linux/magic.h>
> +# include <linux/major.h>
> +# ifndef TMPFS_MAGIC
> +#  define TMPFS_MAGIC	0x01021994
> +# endif
> +# ifndef MNT_DETACH
> +#  define MNT_DETACH	2
> +# endif
> +#endif
> +
>  #include "c.h"
>  #include "closestream.h"
>  #include "nls.h"
> @@ -441,6 +455,49 @@ static void fixtty(void)
>  		warn(_("tcsetattr failed"));
>  }
>  
> +#ifdef USE_EMERGENCY_DEV
> +/*
> + * Make C library standard calls such like ttyname(3) work
> + * even if the system does not show any of the standard
> + * directories.
> + */
> +
> +static uint32_t mounts;
> +# define MNT_PROCFS	0x0001
> +# define MNT_DEVTMPFS	0x0002
> +
> +static __attribute__((__noinline__)) void putmounts(void)
> +{
> +	if (mounts & MNT_DEVTMPFS)
> +		umount2("/dev", MNT_DETACH);
> +	if (mounts & MNT_PROCFS)
> +		umount2("/proc", MNT_DETACH);
> +}
> +
> +# define dovoid(f)	if ((f)){}
> +static __attribute__((__constructor__)) void getmounts(void)
> +{
> +	struct statfs st;
> +	if (statfs("/proc", &st) == 0 && st.f_type != PROC_SUPER_MAGIC) {

Why not use the standard mountpoint check -- compare the devno with / ?

> +		if (mount("proc", "/proc", "proc", MS_RELATIME, NULL) == 0)
> +			mounts |= MNT_PROCFS;
> +	}
> +	if (statfs("/dev", &st) == 0 && st.f_type != TMPFS_MAGIC) {
> +		if (mount("devtmpfs", "/dev", "devtmpfs", MS_RELATIME, "mode=0755,nr_inodes=0") == 0) {
> +			mounts |= MNT_DEVTMPFS;

Isn't all the work below here redundant? devtmpfs provides these
things.

> +			(void)mknod("/dev/console", S_IFCHR|S_IRUSR|S_IWUSR, makedev(TTYAUX_MAJOR, 1));
> +			if (symlink("/proc/self/fd", "/dev/fd") == 0) {
> +				dovoid(symlink("fd/0", "/dev/stdin"));
> +				dovoid(symlink("fd/1", "/dev/stdout"));
> +				dovoid(symlink("fd/2", "/dev/stderr"));
> +			}
> +		}
> +	}
> +	if (mounts) atexit(putmounts);
> +}
> +# undef dovoid
> +#endif
> +
>  static void usage(FILE *out)
>  {
>  	fputs(USAGE_HEADER, out);
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
