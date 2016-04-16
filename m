Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33705 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbcDPSsL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Apr 2016 14:48:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id y144so13988804wmd.0
        for <util-linux@vger.kernel.org>; Sat, 16 Apr 2016 11:48:10 -0700 (PDT)
Date: Sat, 16 Apr 2016 19:47:58 +0100 (BST)
From: Sami Kerola <kerolasa@iki.fi>
To: Nir Soffer <nirsof@gmail.com>
cc: util-linux@vger.kernel.org, Nir Soffer <nsoffer@redhat.com>
Subject: Re: [PATCH] Fail like the shell when execvp fails
In-Reply-To: <1460827912-19521-1-git-send-email-nsoffer@redhat.com>
Message-ID: <alpine.LNX.2.20.1604161937480.11582@imuri>
References: <1460827912-19521-1-git-send-email-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, 16 Apr 2016, Nir Soffer wrote:

> Commands executing another command (e.g. taskset) should fail in a
> consistent and detectable way when the other command fail to execute.
> Change most of the commands that used to fail with EXIT_FAILURE to fail
> with the special exit code 127, like the shell.
> 
> For example, running the fuser command via taskset when fuser command is
> not installed is failing now like this:
> 
>     $ taskset -c 1 fuser /path/to/file; echo $?
>     taskset: failed to execute fuser: No such file or directory
>     1
> 
> This failure looks like a real failure of the fuser command:
> 
>     $ taskset -c 1 fuser /path/to/file; echo $?
>     Specified filename /path/to/file does not exist.
>     1
> 
> Based on the exit code, a management program may do the wrong thing,
> leading to catastrophic results. Detecting such failure requires fragile
> parsing of standard error.
> 
> With this patch this failure is easy to detect:
> 
>     $ taskset -c 1 fuser /path/to/file; echo $?
>     taskset: failed to execute fuser: No such file or directory
>     127
> 
> The return code seems to be undocumented for most commands, except the
> su command, promising to exit with exit code 126 if a command cannot be
> executed, and 127 if a command was not found. However, the actual
> command always exit with exit code 1. This patch implement the
> documented behavior.
> 
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> ---
>  disk-utils/mkfs.c                   | 3 ++-
>  include/exitcodes.h                 | 7 +++++++
>  lib/pager.c                         | 3 ++-
>  login-utils/su-common.c             | 7 ++++++-
>  schedutils/chrt.c                   | 3 ++-
>  schedutils/ionice.c                 | 3 ++-
>  schedutils/taskset.c                | 3 ++-
>  sys-utils/flock.c                   | 4 +++-
>  sys-utils/nsenter.c                 | 3 ++-
>  sys-utils/prlimit.c                 | 3 ++-
>  sys-utils/setarch.c                 | 7 ++++---
>  sys-utils/setpriv.c                 | 3 ++-
>  sys-utils/setsid.c                  | 3 ++-
>  sys-utils/swapon.c                  | 3 ++-
>  sys-utils/unshare.c                 | 3 ++-
>  tests/expected/misc/setarch-options | 2 +-
>  text-utils/more.c                   | 3 ++-
>  17 files changed, 45 insertions(+), 18 deletions(-)

Lots of change in a single patch. Could these change be split to something 
like:

1. include/exitcodes.h
2. lib/pager.c
3. changes to commands
4. updates to tests
5. manual page updates


> diff --git a/disk-utils/mkfs.c b/disk-utils/mkfs.c
> index cf1a312..88f125d 100644
> --- a/disk-utils/mkfs.c
> +++ b/disk-utils/mkfs.c
> @@ -33,6 +33,7 @@
>  #include "closestream.h"
>  #include "nls.h"
>  #include "xalloc.h"
> +#include "exitcodes.h"
>  
>  #ifndef DEFAULT_FSTYPE
>  #define DEFAULT_FSTYPE	"ext2"
> @@ -136,5 +137,5 @@ int main(int argc, char **argv)
>  
>  	/* Execute the program */
>  	execvp(progname, argv + optind);
> -	err(EXIT_FAILURE, _("failed to execute %s"), progname);
> +	err(EX_EXEC, _("failed to execute %s"), progname);
>  }
> diff --git a/include/exitcodes.h b/include/exitcodes.h
> index 24ee123..2063c54 100644
> --- a/include/exitcodes.h
> +++ b/include/exitcodes.h
> @@ -32,4 +32,11 @@
>  #define MOUNT_EX_FAIL		32	/* mount failure */
>  #define MOUNT_EX_SOMEOK		64	/* some mount succeeded */
>  
> +/* Exit codes use by the su program */
> +#define SU_EX_EXEC			126 /* faied to execute a program */
> +#define SU_EX_NOENT			127 /* program was not found */
> +
> +/* General exit codes */
> +#define EX_EXEC				127 /* faied to execute a program */
> +

Looks like typo x2

s/faied/failed/

>  #endif	/* UTIL_LINUX_EXITCODES_H */
> diff --git a/lib/pager.c b/lib/pager.c
> index 330659e..381294a 100644
> --- a/lib/pager.c
> +++ b/lib/pager.c
> @@ -17,6 +17,7 @@
>  #include "c.h"
>  #include "xalloc.h"
>  #include "nls.h"
> +#include "exitcodes.h"
>  
>  #define NULL_DEVICE	"/dev/null"
>  
> @@ -73,7 +74,7 @@ static int start_command(struct child_process *cmd)
>  
>  		cmd->preexec_cb();
>  		execvp(cmd->argv[0], (char *const*) cmd->argv);
> -		exit(127); /* cmd not found */
> +		exit(EX_EXEC); /* cmd not found */
>  	}
>  
>  	if (cmd->pid < 0) {
> diff --git a/login-utils/su-common.c b/login-utils/su-common.c
> index fe6d0c8..b17b133 100644
> --- a/login-utils/su-common.c
> +++ b/login-utils/su-common.c
> @@ -71,6 +71,7 @@ enum
>  #include "closestream.h"
>  #include "strutils.h"
>  #include "ttyutils.h"
> +#include "exitcodes.h"
>  
>  /* name of the pam configuration files. separate configs for su and su -  */
>  #define PAM_SRVNAME_SU "su"
> @@ -983,7 +984,11 @@ su_main (int argc, char **argv, int mode)
>      run_shell (shell, command, argv + optind, max (0, argc - optind));
>    else {
>      execvp(argv[optind], &argv[optind]);
> -    err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
> +    /* su(1) promise to fail with exit code 126 if the command
> +       cannot be executed, and 127 if the command was not
> +       found. */
> +    err(errno == ENOENT ? SU_EX_NOENT : SU_EX_EXEC,
> +        _("failed to execute %s"), argv[optind]);
>    }
>  }
>  
> diff --git a/schedutils/chrt.c b/schedutils/chrt.c
> index 202ce25..40f6cfe 100644
> --- a/schedutils/chrt.c
> +++ b/schedutils/chrt.c
> @@ -32,6 +32,7 @@
>  #include "closestream.h"
>  #include "strutils.h"
>  #include "procutils.h"
> +#include "exitcodes.h"
>  
>  /* the SCHED_BATCH is supported since Linux 2.6.16
>   *  -- temporary workaround for people with old glibc headers
> @@ -517,7 +518,7 @@ int main(int argc, char **argv)
>  	if (!ctl->pid) {
>  		argv += optind + 1;
>  		execvp(argv[0], argv);
> -		err(EXIT_FAILURE, _("failed to execute %s"), argv[0]);
> +		err(EX_EXEC, _("failed to execute %s"), argv[0]);
>  	}
>  
>  	return EXIT_SUCCESS;
> diff --git a/schedutils/ionice.c b/schedutils/ionice.c
> index 5528afe..0d6a2d2 100644
> --- a/schedutils/ionice.c
> +++ b/schedutils/ionice.c
> @@ -18,6 +18,7 @@
>  #include "strutils.h"
>  #include "c.h"
>  #include "closestream.h"
> +#include "exitcodes.h"
>  
>  static int tolerant;
>  
> @@ -257,7 +258,7 @@ int main(int argc, char **argv)
>  		 */
>  		ioprio_setid(0, ioclass, data, IOPRIO_WHO_PROCESS);
>  		execvp(argv[optind], &argv[optind]);
> -		err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
> +		err(EX_EXEC, _("failed to execute %s"), argv[optind]);
>  	} else
>  		usage(stderr);
>  
> diff --git a/schedutils/taskset.c b/schedutils/taskset.c
> index d6b21e4..e68068d 100644
> --- a/schedutils/taskset.c
> +++ b/schedutils/taskset.c
> @@ -34,6 +34,7 @@
>  #include "procutils.h"
>  #include "c.h"
>  #include "closestream.h"
> +#include "exitcodes.h"
>  
>  struct taskset {
>  	pid_t		pid;		/* task PID */
> @@ -236,7 +237,7 @@ int main(int argc, char **argv)
>  	if (!pid) {
>  		argv += optind + 1;
>  		execvp(argv[0], argv);
> -		err(EXIT_FAILURE, _("failed to execute %s"), argv[0]);
> +		err(EX_EXEC, _("failed to execute %s"), argv[0]);
>  	}
>  
>  	return EXIT_SUCCESS;
> diff --git a/sys-utils/flock.c b/sys-utils/flock.c
> index b5c4d91..d2d994a 100644
> --- a/sys-utils/flock.c
> +++ b/sys-utils/flock.c
> @@ -45,6 +45,7 @@
>  #include "closestream.h"
>  #include "monotonic.h"
>  #include "timer.h"
> +#include "exitcodes.h"
>  
>  static void __attribute__((__noreturn__)) usage(int ex)
>  {
> @@ -330,7 +331,8 @@ int main(int argc, char *argv[])
>  			execvp(cmd_argv[0], cmd_argv);
>  			/* execvp() failed */
>  			warn(_("failed to execute %s"), cmd_argv[0]);
> -			_exit((errno == ENOMEM) ? EX_OSERR : EX_UNAVAILABLE);
> +			/* Behave mostly like the shell */
> +			_exit((errno == ENOMEM) ? EX_OSERR : EX_EXEC);

This conflicts with flock(1) manual page. Either this change should not be 
done, or manual page needs update as well.

>  		} else {
>  			do {
>  				w = waitpid(f, &status, 0);
> diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
> index d8690db..558b4d0 100644
> --- a/sys-utils/nsenter.c
> +++ b/sys-utils/nsenter.c
> @@ -40,6 +40,7 @@
>  #include "closestream.h"
>  #include "namespace.h"
>  #include "exec_shell.h"
> +#include "exitcodes.h"
>  
>  static struct namespace_file {
>  	int nstype;
> @@ -413,7 +414,7 @@ int main(int argc, char *argv[])
>  
>  	if (optind < argc) {
>  		execvp(argv[optind], argv + optind);
> -		err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
> +		err(EX_EXEC, _("failed to execute %s"), argv[optind]);
>  	}
>  	exec_shell();
>  }
> diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
> index b244ddb..6a3d527 100644
> --- a/sys-utils/prlimit.c
> +++ b/sys-utils/prlimit.c
> @@ -35,6 +35,7 @@
>  #include "strutils.h"
>  #include "list.h"
>  #include "closestream.h"
> +#include "exitcodes.h"
>  
>  #ifndef RLIMIT_RTTIME
>  # define RLIMIT_RTTIME 15
> @@ -641,7 +642,7 @@ int main(int argc, char **argv)
>  	if (argc > optind) {
>  		/* prlimit [options] COMMAND */
>  		execvp(argv[optind], &argv[optind]);
> -		err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
> +		err(EX_EXEC, _("failed to execute %s"), argv[optind]);
>  	}
>  
>  	return EXIT_SUCCESS;
> diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
> index cf29cf7..bda3e8f 100644
> --- a/sys-utils/setarch.c
> +++ b/sys-utils/setarch.c
> @@ -35,6 +35,7 @@
>  #include "nls.h"
>  #include "c.h"
>  #include "closestream.h"
> +#include "exitcodes.h"
>  
>  #ifndef HAVE_PERSONALITY
>  # include <syscall.h>
> @@ -399,10 +400,10 @@ int main(int argc, char *argv[])
>  
>  	if (!argc) {
>  		execl("/bin/sh", "-sh", NULL);
> -		err(EXIT_FAILURE, _("failed to execute %s"), "/bin/sh");
> +		err(EX_EXEC, _("failed to execute %s"), "/bin/sh");
>  	}
>  
>  	execvp(argv[0], argv);
> -	err(EXIT_FAILURE, "%s", argv[0]);
> -	return EXIT_FAILURE;
> +	err(EX_EXEC, "%s", argv[0]);
> +	return EX_EXEC;
>  }
> diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
> index 1630122..2015f30 100644
> --- a/sys-utils/setpriv.c
> +++ b/sys-utils/setpriv.c
> @@ -38,6 +38,7 @@
>  #include "strutils.h"
>  #include "xalloc.h"
>  #include "pathnames.h"
> +#include "exitcodes.h"
>  
>  #ifndef PR_SET_NO_NEW_PRIVS
>  # define PR_SET_NO_NEW_PRIVS 38
> @@ -839,5 +840,5 @@ int main(int argc, char **argv)
>  
>  	execvp(argv[optind], argv + optind);
>  
> -	err(EXIT_FAILURE, _("cannot execute: %s"), argv[optind]);
> +	err(EX_EXEC, _("cannot execute: %s"), argv[optind]);
>  }
> diff --git a/sys-utils/setsid.c b/sys-utils/setsid.c
> index bb089df..466c5cf 100644
> --- a/sys-utils/setsid.c
> +++ b/sys-utils/setsid.c
> @@ -24,6 +24,7 @@
>  #include "c.h"
>  #include "nls.h"
>  #include "closestream.h"
> +#include "exitcodes.h"
>  
>  static void __attribute__ ((__noreturn__)) usage(FILE * out)
>  {
> @@ -114,5 +115,5 @@ int main(int argc, char **argv)
>  			err(EXIT_FAILURE, _("failed to set the controlling terminal"));
>  	}
>  	execvp(argv[optind], argv + optind);
> -	err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
> +	err(EX_EXEC, _("failed to execute %s"), argv[optind]);
>  }
> diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
> index 97acf1e..294112b 100644
> --- a/sys-utils/swapon.c
> +++ b/sys-utils/swapon.c
> @@ -23,6 +23,7 @@
>  #include "strutils.h"
>  #include "optutils.h"
>  #include "closestream.h"
> +#include "exitcodes.h"
>  
>  #include "swapheader.h"
>  #include "swapprober.h"
> @@ -337,7 +338,7 @@ static int swap_reinitialize(struct swap_device *dev)
>  		cmd[idx++] = dev->path;
>  		cmd[idx++] = NULL;
>  		execvp(cmd[0], (char * const *) cmd);
> -		err(EXIT_FAILURE, _("failed to execute %s"), cmd[0]);
> +		err(EX_EXEC, _("failed to execute %s"), cmd[0]);
>  
>  	default: /* parent */
>  		do {
> diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
> index 234c750..9e6b4bb 100644
> --- a/sys-utils/unshare.c
> +++ b/sys-utils/unshare.c
> @@ -40,6 +40,7 @@
>  #include "xalloc.h"
>  #include "pathnames.h"
>  #include "all-io.h"
> +#include "exitcodes.h"
>  
>  /* synchronize parent and child by pipe */
>  #define PIPE_SYNC_BYTE	0x06
> @@ -458,7 +459,7 @@ int main(int argc, char *argv[])
>  
>  	if (optind < argc) {
>  		execvp(argv[optind], argv + optind);
> -		err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
> +		err(EX_EXEC, _("failed to execute %s"), argv[optind]);
>  	}
>  	exec_shell();
>  }
> diff --git a/tests/expected/misc/setarch-options b/tests/expected/misc/setarch-options
> index 698db52..ebe52f0 100644
> --- a/tests/expected/misc/setarch-options
> +++ b/tests/expected/misc/setarch-options
> @@ -4,7 +4,7 @@ exit: 1
>  ###### unknown command
>  Execute command `/das/gibs/nicht'.
>  setarch: /das/gibs/nicht: No such file or directory
> -exit: 1
> +exit: 127
>  ###### noop uname -a
>  Execute command `uname'.
>  uname -a unchanged
> diff --git a/text-utils/more.c b/text-utils/more.c
> index 0a5f494..42f49ba 100644
> --- a/text-utils/more.c
> +++ b/text-utils/more.c
> @@ -65,6 +65,7 @@
>  #include "xalloc.h"
>  #include "widechar.h"
>  #include "closestream.h"
> +#include "exitcodes.h"
>  
>  #include <regex.h>
>  
> @@ -1622,7 +1623,7 @@ void execute(char *filename, char *cmd, ...)
>  
>  		execvp(cmd, args);
>  		putserr(_("exec failed\n"));
> -		exit(EXIT_FAILURE);
> +		exit(EX_EXEC);
>  	}
>  	if (id > 0) {
>  		signal(SIGINT, SIG_IGN);
> 

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
