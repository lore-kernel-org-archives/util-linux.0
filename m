Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: failed exec() exit codes
Date: Thu, 1 Feb 2018 17:01:19 +0100
Cc: util-linux@vger.kernel.org
References: <20180201145809.jjtadzla22wlw7rv@ws.net.home>
In-Reply-To: <20180201145809.jjtadzla22wlw7rv@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201802011701.19780.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Thursday 01 February 2018, Karel Zak wrote:
> Now we use on many places where commands executing another command:
>
>     execvp(argv[optind], argv + optind);
>     err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
>
> the problem is that EXIT_FAILURE is too generic and it does not
> provide any way how to detect failed exec()s.

I think you did a bit too much. I assume that these exec codes are only 
useful for the programs which get a "command" from the user's command 
line. So that the user can expect the original exit code of his 
wanted "command" if and only if it's not 126 or 127.

So for taskset(1) these exit codes are good but maybe not needed for 
swapon(1) or eject(1).


> I have added a new macro errexec() to replace err(EXIT_FAILURE, ...).
>
> The new macro is compatible with coreutils way:
>
>     #define EX_EXEC_FAILED          126     /* Program located, but
> not usable. */ #define EX_EXEC_ENOENT          127     /* Could not
> find program to exec.  */


coreutils has even 2 more in "src/system.h" and each of these kind of
exec programs are *only* using these ones.

/* Exit statuses for programs like 'env' that exec other programs.  */
enum
{
  EXIT_TIMEDOUT = 124, /* Time expired before child completed.  */
  EXIT_CANCELED = 125, /* Internal error prior to exec attempt.  */
  EXIT_CANNOT_INVOKE = 126, /* Program located, but not usable.  */
  EXIT_ENOENT = 127 /* Could not find program to exec.  */
};

like
$ chroot   --helpdassdf; echo $?
chroot: unrecognized option '--helpdassdf'
Try 'chroot --help' for more information.
125

Other projects like bash only support 126 and 127, like we do now

$ exec bla ; echo $?
bash: exec: bla: not found
127

$ exec --bla ; echo $?
bash: exec: --: invalid option
exec: usage: exec [-cl] [-a name] [command [arguments ...]] 
[redirection ...]
2

cu,
Rudi
