Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-da0-f50.google.com ([209.85.210.50]:60650 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab3ALI7u (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 12 Jan 2013 03:59:50 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so1116307dan.23
        for <util-linux@vger.kernel.org>; Sat, 12 Jan 2013 00:59:50 -0800 (PST)
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
In-Reply-To: <87fw283rht.fsf@xmission.com>
References: <876234812z.fsf@xmission.com> <CAKgNAkjOw-KPJO5AFRSwtoOb0k7K64pk1O-gRs-GS18ZQCYmaQ@mail.gmail.com>
 <87fw283rht.fsf@xmission.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Sat, 12 Jan 2013 09:59:30 +0100
Message-ID: <CAKgNAkjD3puAgwutExLR3+sb_qUOwu11W83HVNJeZvN16BNiXQ@mail.gmail.com>
Subject: Re: [PATCH] enter: new command (light wrapper around setns)
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: util-linux@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
        Karel Zak <kzak@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 11, 2013 at 12:10 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> writes:
>
>> Hi Eric,
>>
>> On Fri, Jan 11, 2013 at 11:29 AM, Eric W. Biederman
>> <ebiederm@xmission.com> wrote:
>>>
>>> Inspired by unshare, enter is a simple wrapper around setns that
>>> allows running a new process in the context of an existing process.
>>
>> The name "enter" seems way too generic (far more so than even
>> "unshare"). How about "nsexec" or "execns" or some such?
>
> Enter unlike exec is the right concept, and the name is free.
>
>> Aside from that, what is the purpose of the -f "fork" option?
>
> To tell when you are tired, and should go to bed.  There is no fork
> option ony an exec option.  And the exec option is documented and
> explained.

That's the truth. Thanks for pointing me in the right direction.

Cheers,

Michael



>>> Full paths may be specified to the namespace arguments so that
>>> namespace file descriptors may be used wherever they reside in the
>>> filesystem.
>>>
>>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>> ---
>>>
>>> While doing a final check on this patch I just realized I am a week or
>>> two late to the discussion.  So much for waiting until my code had
>>> merged into the kernel before submitting patches.  I have been
>>> developing enter off and on as I have been developing these patches
>>> and it seems to be stable and feature complete at this point.
>>>
>>> I really don't like the the idea of adding setns support into unshare.
>>> Creating new namespaces and using existing namespaces are related
>>> but different concepts and place different demands on the evolotion
>>> of the code.  Especially when the pid and user namespaces come into
>>> play.
>>>
>>> Little things like retaining the the ability for unshare to be suid root
>>> safely and sanely become intractable if you call setns() and join a
>>> user namespace.
>>>
>>> Supporting the ability for the command to be setuid root does not
>>> work in combination with the user namespace.  As after entering
>>> the user namespace you can not reliably change your uid back to
>>> your uid without setuid as your uid may not be mapped.
>>>
>>> When joining an existing mount namespace you most likely want to change
>>> your root directory and your working directory to the directory of the
>>> process whoose mount namespace you are entering.  Something you don't
>>> even think about when just unsharing a mount namespace.
>>>
>>> Then there is the practical wish to call fork after entering a pid
>>> namespace and before launching a command.  You don't always want that
>>> but almost always so that the command will actually be run in the new
>>> pid namespace with a new pid, instead of having it's children in the new
>>> pid namespace.
>>>
>>> I really can't see support for using setns being in the same binary as
>>> unshare that just mixes two different but closely related things that
>>> will want to evolve in different directions.
>>>
>>> My inclination is to send a follow up patch to remove setns and migrate
>>> from unshare.  And a second patch to add pid and user namespace support
>>> to unshare.  But since I am going against the way that seems to have
>>> already been decided I will hold off on those patches until after we
>>> there is agreement on this one.
>>>
>>> Eric
>>>
>>>  configure.ac            |   11 ++
>>>  sys-utils/Makemodule.am |    7 +
>>>  sys-utils/enter.1       |  101 +++++++++++++++++
>>>  sys-utils/enter.c       |  286 +++++++++++++++++++++++++++++++++++++++++++++++
>>>  4 files changed, 405 insertions(+), 0 deletions(-)
>>>  create mode 100644 sys-utils/enter.1
>>>  create mode 100644 sys-utils/enter.c
>>>
>>> diff --git a/configure.ac b/configure.ac
>>> index e937736..b0c9c6f 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -867,6 +867,17 @@ if test "x$build_unshare" = xyes; then
>>>    AC_CHECK_FUNCS([unshare])
>>>  fi
>>>
>>> +AC_ARG_ENABLE([enter],
>>> +  AS_HELP_STRING([--disable-enter], [do not build enter]),
>>> +  [], enable_enter=check
>>> +)
>>> +UL_BUILD_INIT([enter])
>>> +UL_REQUIRES_LINUX([enter])
>>> +UL_REQUIRES_SYSCALL_CHECK([setns], [UL_CHECK_SYSCALL([setns])])
>>> +AM_CONDITIONAL(BUILD_ENTER, test "x$build_enter" = xyes)
>>> +if test "x$build_enter" = xyes; then
>>> +  AC_CHECK_FUNCS([setns])
>>> +fi
>>>
>>>  AC_ARG_ENABLE([arch],
>>>    AS_HELP_STRING([--enable-arch], [do build arch]),
>>> diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
>>> index 5636f70..6ad09b2 100644
>>> --- a/sys-utils/Makemodule.am
>>> +++ b/sys-utils/Makemodule.am
>>> @@ -290,6 +290,13 @@ unshare_SOURCES = sys-utils/unshare.c
>>>  unshare_LDADD = $(LDADD) libcommon.la
>>>  endif
>>>
>>> +if BUILD_UNSHARE
>>> +usrbin_exec_PROGRAMS += enter
>>> +dist_man_MANS += sys-utils/enter.1
>>> +enter_SOURCES = sys-utils/enter.c
>>> +enter_LDADD = $(LDADD) libcommon.la
>>> +endif
>>> +
>>>  if BUILD_ARCH
>>>  bin_PROGRAMS += arch
>>>  dist_man_MANS += sys-utils/arch.1
>>> diff --git a/sys-utils/enter.1 b/sys-utils/enter.1
>>> new file mode 100644
>>> index 0000000..0829ee2
>>> --- /dev/null
>>> +++ b/sys-utils/enter.1
>>> @@ -0,0 +1,101 @@
>>> +.TH ENTER 1 "January 2013" "util-linux" "User Commands"
>>> +.SH NAME
>>> +enter \- run program with namespaces of other processes
>>> +.SH SYNOPSIS
>>> +.B enter
>>> +.RI [ options ]
>>> +program
>>> +.RI [ arguments ]
>>> +.SH DESCRIPTION
>>> +Enters the contexts of one or more other processes and then executes specified
>>> +program. Enterable namespaces are:
>>> +.TP
>>> +.BR "mount namespace"
>>> +mounting and unmounting filesystems will not affect rest of the system
>>> +(\fBCLONE_NEWNS\fP flag), except for filesystems which are explicitly marked as
>>> +shared (by mount --make-shared). See /proc/self/mountinfo for the shared flags.
>>> +.TP
>>> +.BR "UTS namespace"
>>> +setting hostname, domainname will not affect rest of the system
>>> +(\fBCLONE_NEWUTS\fP flag).
>>> +.TP
>>> +.BR "IPC namespace"
>>> +process will have independent namespace for System V message queues, semaphore
>>> +sets and shared memory segments (\fBCLONE_NEWIPC\fP flag).
>>> +.TP
>>> +.BR "network namespace"
>>> +process will have independent IPv4 and IPv6 stacks, IP routing tables, firewall
>>> +rules, the \fI/proc/net\fP and \fI/sys/class/net\fP directory trees, sockets
>>> +etc. (\fBCLONE_NEWNET\fP flag).
>>> +.TP
>>> +.BR "pid namespace"
>>> +children will have a distinct set of pid to process mappings thantheir parent.
>>> +(\fBCLONE_NEWPID\fP flag).
>>> +.TP
>>> +.BR "user namespace"
>>> +process will have distinct set of uids, gids and capabilities. (\fBCLONE_NEWUSER\fP flag).
>>> +.TP
>>> +See the \fBclone\fR(2) for exact semantics of the flags.
>>> +.SH OPTIONS
>>> +.TP
>>> +.BR \-h , " \-\-help"
>>> +Print a help message,
>>> +.TP
>>> +.BR \-t , " \-\-target " \fIpid\fP
>>> +Specify a target process to get contexts from.
>>> +.TP
>>> +.BR \-m , " \-\-mount"=[\fIfile\fP]
>>> +Enter the mount namespace.
>>> +If no file is specified enter the mount namespace of the target process.
>>> +If file is specified enter the mount namespace specified by file.
>>> +.TP
>>> +.BR \-u , " \-\-uts"=[\fIfile\fP]
>>> +Enter the uts namespace.
>>> +If no file is specified enter the uts namespace of the target process.
>>> +If file is specified enter the uts namespace specified by file.
>>> +.TP
>>> +.BR \-i , " \-\-ipc "=[\fIfile\fP]
>>> +Enter the IPC namespace.
>>> +If no file is specified enter the IPC namespace of the target process.
>>> +If file is specified enter the uts namespace specified by file.
>>> +.TP
>>> +.BR \-n , " \-\-net"=[\fIfile\fP]
>>> +Enter the network namespace.
>>> +If no file is specified enter the network namespace of the target process.
>>> +If file is specified enter the network namespace specified by file.
>>> +.TP
>>> +.BR \-p , " \-\-pid"=[\fIfile\fP]
>>> +Enter the pid namespace.
>>> +If no file is specified enter the pid namespace of the target process.
>>> +If file is specified enter the pid namespace specified by file.
>>> +.TP
>>> +.BR \-U , " \-\-user"=[\fIfile\fP]
>>> +Enter the user namespace.
>>> +If no file is specified enter the user namespace of the target process.
>>> +If file is specified enter the user namespace specified by file.
>>> +.TP
>>> +.BR \-r , " \-\-root"=[\fIdirectory\fP]
>>> +Set the root directory.
>>> +If no directory is specified set the root directory to the root directory of the target process.
>>> +If directory is specified set the root directory to the specified directory.
>>> +.TP
>>> +.BR \-w , " \-\-wd"=[\fIdirectory\fP]
>>> +Set the working directory.
>>> +If no directory is specified set the working directory to the working directory of the target process.
>>> +If directory is specified set the working directory to the specified directory.
>>> +.TP
>>> +.BR \-e , " \-\-exec"
>>> +Don't fork before exec'ing the specified program.  By default when entering
>>> +a pid namespace enter calls fork before calling exec so that the children will
>>> +be in the newly entered pid namespace.
>>> +.SH NOTES
>>> +.SH SEE ALSO
>>> +.BR setns (2),
>>> +.BR clone (2)
>>> +.SH BUGS
>>> +None known so far.
>>> +.SH AUTHOR
>>> +Eric Biederman <ebiederm@xmission.com>
>>> +.SH AVAILABILITY
>>> +The enter command is part of the util-linux package and is available from
>>> +ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
>>> diff --git a/sys-utils/enter.c b/sys-utils/enter.c
>>> new file mode 100644
>>> index 0000000..d7bd540
>>> --- /dev/null
>>> +++ b/sys-utils/enter.c
>>> @@ -0,0 +1,286 @@
>>> +/*
>>> + * enter(1) - command-line interface for setns(2)
>>> + *
>>> + * Copyright (C) 2012-2013 Eric Biederman <ebiederm@xmission.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify it
>>> + * under the terms of the GNU General Public License as published by the
>>> + * Free Software Foundation; version 2.
>>> + *
>>> + * This program is distributed in the hope that it will be useful, but
>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>> + * General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License along
>>> + * with this program; if not, write to the Free Software Foundation, Inc.,
>>> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>>> + */
>>> +
>>> +#include <sys/types.h>
>>> +#include <sys/wait.h>
>>> +#include <dirent.h>
>>> +#include <errno.h>
>>> +#include <getopt.h>
>>> +#include <sched.h>
>>> +#include <stdio.h>
>>> +#include <stdlib.h>
>>> +#include <unistd.h>
>>> +
>>> +#include "nls.h"
>>> +#include "c.h"
>>> +#include "closestream.h"
>>> +
>>> +#ifndef CLONE_NEWSNS
>>> +# define CLONE_NEWNS 0x00020000
>>> +#endif
>>> +#ifndef CLONE_NEWUTS
>>> +# define CLONE_NEWUTS 0x04000000
>>> +#endif
>>> +#ifndef CLONE_NEWIPC
>>> +# define CLONE_NEWIPC 0x08000000
>>> +#endif
>>> +#ifndef CLONE_NEWNET
>>> +# define CLONE_NEWNET 0x40000000
>>> +#endif
>>> +#ifndef CLONE_NEWUSER
>>> +# define CLONE_NEWUSER 0x10000000
>>> +#endif
>>> +#ifndef CLONE_NEWPID
>>> +# define CLONE_NEWPID 0x20000000
>>> +#endif
>>> +
>>> +#ifndef HAVE_SETNS
>>> +# include <sys/syscall.h>
>>> +static int setns(int fd, int nstype)
>>> +{
>>> +       return syscall(SYS_setns, fd, nstype);
>>> +}
>>> +#endif /* HAVE_SETNS */
>>> +
>>> +static struct namespace_file{
>>> +       int nstype;
>>> +       char *name;
>>> +       int fd;
>>> +} namespace_files[] = {
>>> +       /* Careful the order is signifcant in this array.
>>> +        *
>>> +        * The user namespace comes first, so that it is entered
>>> +        * first.  This gives an unprivileged user the potential to
>>> +        * enter the other namespaces.
>>> +        */
>>> +       { .nstype = CLONE_NEWUSER, .name = "ns/user", .fd = -1 },
>>> +       { .nstype = CLONE_NEWIPC,  .name = "ns/ipc",  .fd = -1 },
>>> +       { .nstype = CLONE_NEWUTS,  .name = "ns/uts",  .fd = -1 },
>>> +       { .nstype = CLONE_NEWNET,  .name = "ns/net",  .fd = -1 },
>>> +       { .nstype = CLONE_NEWPID,  .name = "ns/pid",  .fd = -1 },
>>> +       { .nstype = CLONE_NEWNS,   .name = "ns/mnt",  .fd = -1 },
>>> +       {}
>>> +};
>>> +
>>> +static void usage(int status)
>>> +{
>>> +       FILE *out = status == EXIT_SUCCESS ? stdout : stderr;
>>> +
>>> +       fputs(USAGE_HEADER, out);
>>> +       fprintf(out, _(" %s [options] <program> [args...]\n"),
>>> +               program_invocation_short_name);
>>> +
>>> +       fputs(USAGE_OPTIONS, out);
>>> +       fputs(_(" -t, --target <pid>   target process to get namespaces from\n"
>>> +               " -m, --mount [<file>] enter mount namespace\n"
>>> +               " -u, --uts   [<file>] enter UTS namespace (hostname etc)\n"
>>> +               " -i, --ipc   [<file>] enter System V IPC namespace\n"
>>> +               " -n, --net   [<file>] enter network namespace\n"
>>> +               " -p, --pid   [<file>] enter pid namespace\n"
>>> +               " -U, --user  [<file>] enter user namespace\n"
>>> +               " -e, --exec           don't fork before exec'ing <program>\n"
>>> +               " -r, --root  [<dir>]  set the root directory\n"
>>> +               " -w, --wd    [<dir>]  set the working directory\n"), out);
>>> +       fputs(USAGE_SEPARATOR, out);
>>> +       fputs(USAGE_HELP, out);
>>> +       fputs(USAGE_VERSION, out);
>>> +       fprintf(out, USAGE_MAN_TAIL("enter(1)"));
>>> +
>>> +       exit(status);
>>> +}
>>> +
>>> +static pid_t namespace_target_pid = 0;
>>> +static int root_fd = -1;
>>> +static int wd_fd = -1;
>>> +
>>> +static void open_target_fd(int *fd, const char *type, char *path)
>>> +{
>>> +       char pathbuf[PATH_MAX];
>>> +
>>> +       if (!path && namespace_target_pid) {
>>> +               snprintf(pathbuf, sizeof(pathbuf), "/proc/%u/%s",
>>> +                       namespace_target_pid, type);
>>> +               path = pathbuf;
>>> +       }
>>> +       if (!path)
>>> +               err(EXIT_FAILURE, _("No filename and no target pid supplied for %s"),
>>> +                   type);
>>> +
>>> +       if (*fd >= 0)
>>> +               close(*fd);
>>> +
>>> +       *fd = open(path, O_RDONLY);
>>> +       if (*fd < 0)
>>> +               err(EXIT_FAILURE, _("open of '%s' failed"), path);
>>> +}
>>> +
>>> +static void open_namespace_fd(int nstype, char *path)
>>> +{
>>> +       struct namespace_file *nsfile;
>>> +
>>> +       for (nsfile = namespace_files; nsfile->nstype; nsfile++) {
>>> +               if (nstype != nsfile->nstype)
>>> +                       continue;
>>> +
>>> +               open_target_fd(&nsfile->fd, nsfile->name, path);
>>> +               return;
>>> +       }
>>> +       /* This should never happen */
>>> +       err(EXIT_FAILURE, "Unrecognized namespace type");
>>> +}
>>> +
>>> +int main(int argc, char *argv[])
>>> +{
>>> +       static const struct option longopts[] = {
>>> +               { "help", no_argument, NULL, 'h' },
>>> +               { "version", no_argument, NULL, 'V'},
>>> +               { "target", required_argument, NULL, 't' },
>>> +               { "mount", optional_argument, NULL, 'm' },
>>> +               { "uts", optional_argument, NULL, 'u' },
>>> +               { "ipc", optional_argument, NULL, 'i' },
>>> +               { "net", optional_argument, NULL, 'n' },
>>> +               { "pid", optional_argument, NULL, 'p' },
>>> +               { "user", optional_argument, NULL, 'U' },
>>> +               { "exec", no_argument, NULL, 'e' },
>>> +               { "root", optional_argument, NULL, 'r' },
>>> +               { "wd", optional_argument, NULL, 'w' },
>>> +               { NULL, 0, NULL, 0 }
>>> +       };
>>> +
>>> +       struct namespace_file *nsfile;
>>> +       int do_fork = 0;
>>> +       char *end;
>>> +       int c;
>>> +
>>> +       setlocale(LC_MESSAGES, "");
>>> +       bindtextdomain(PACKAGE, LOCALEDIR);
>>> +       textdomain(PACKAGE);
>>> +       atexit(close_stdout);
>>> +
>>> +       while((c = getopt_long(argc, argv, "hVt:m::u::i::n::p::U::er::w::", longopts, NULL)) != -1) {
>>> +               switch(c) {
>>> +               case 'h':
>>> +                       usage(EXIT_SUCCESS);
>>> +               case 'V':
>>> +                       printf(UTIL_LINUX_VERSION);
>>> +                       return EXIT_SUCCESS;
>>> +               case 't':
>>> +                       errno = 0;
>>> +                       namespace_target_pid = strtoul(optarg, &end, 10);
>>> +                       if (!*optarg || (*optarg && *end) || errno != 0) {
>>> +                               err(EXIT_FAILURE,
>>> +                                   _("Pid '%s' is not a valid number"),
>>> +                                   optarg);
>>> +                       }
>>> +                       break;
>>> +               case 'm':
>>> +                       open_namespace_fd(CLONE_NEWNS, optarg);
>>> +                       break;
>>> +               case 'u':
>>> +                       open_namespace_fd(CLONE_NEWUTS, optarg);
>>> +                       break;
>>> +               case 'i':
>>> +                       open_namespace_fd(CLONE_NEWIPC, optarg);
>>> +                       break;
>>> +               case 'n':
>>> +                       open_namespace_fd(CLONE_NEWNET, optarg);
>>> +                       break;
>>> +               case 'p':
>>> +                       do_fork = 1;
>>> +                       open_namespace_fd(CLONE_NEWPID, optarg);
>>> +                       break;
>>> +               case 'U':
>>> +                       open_namespace_fd(CLONE_NEWUSER, optarg);
>>> +                       break;
>>> +               case 'e':
>>> +                       do_fork = 0;
>>> +                       break;
>>> +               case 'r':
>>> +                       open_target_fd(&root_fd, "root", optarg);
>>> +                       break;
>>> +               case 'w':
>>> +                       open_target_fd(&wd_fd, "cwd", optarg);
>>> +                       break;
>>> +               default:
>>> +                       usage(EXIT_FAILURE);
>>> +               }
>>> +       }
>>> +
>>> +       if(optind >= argc)
>>> +               usage(EXIT_FAILURE);
>>> +
>>> +       /*
>>> +        * Now that we know which namespaces we want to enter, enter them.
>>> +        */
>>> +       for (nsfile = namespace_files; nsfile->nstype; nsfile++) {
>>> +               if (nsfile->fd < 0)
>>> +                       continue;
>>> +               if (setns(nsfile->fd, nsfile->nstype))
>>> +                       err(EXIT_FAILURE, _("setns of '%s' failed"),
>>> +                           nsfile->name);
>>> +               close(nsfile->fd);
>>> +               nsfile->fd = -1;
>>> +       }
>>> +
>>> +       /* Remember the current working directory if I'm not changing it */
>>> +       if (root_fd >= 0 && wd_fd < 0) {
>>> +               wd_fd = open(".", O_RDONLY);
>>> +               if (wd_fd < 0)
>>> +                       err(EXIT_FAILURE, _("open of . failed"));
>>> +       }
>>> +
>>> +       /* Change the root directory */
>>> +       if (root_fd >= 0) {
>>> +               if (fchdir(root_fd) < 0)
>>> +                       err(EXIT_FAILURE, _("fchdir to root_fd failed"));
>>> +
>>> +               if (chroot(".") < 0)
>>> +                       err(EXIT_FAILURE, _("chroot failed"));
>>> +
>>> +               close(root_fd);
>>> +               root_fd = -1;
>>> +       }
>>> +
>>> +       /* Change the working directory */
>>> +       if (wd_fd >= 0) {
>>> +               if (fchdir(wd_fd) < 0)
>>> +                       err(EXIT_FAILURE, _("fchdir to wd_fd failed"));
>>> +
>>> +               close(wd_fd);
>>> +               wd_fd = -1;
>>> +       }
>>> +
>>> +       if (do_fork) {
>>> +               pid_t child = fork();
>>> +               if (child < 0)
>>> +                       err(EXIT_FAILURE, _("fork failed"));
>>> +               if (child != 0) {
>>> +                       int status;
>>> +                       if ((waitpid(child, &status, 0) == child) &&
>>> +                            WIFEXITED(status)) {
>>> +                               exit(WEXITSTATUS(status));
>>> +                       }
>>> +                       exit(EXIT_FAILURE);
>>> +               }
>>> +       }
>>> +
>>> +       execvp(argv[optind], argv + optind);
>>> +
>>> +       err(EXIT_FAILURE, _("exec %s failed"), argv[optind]);
>>> +}
>>> --
>>> 1.7.5.4
>>>



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Author of "The Linux Programming Interface"; http://man7.org/tlpi/
