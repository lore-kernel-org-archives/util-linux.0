Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754955AbeBAUWx (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Feb 2018 15:22:53 -0500
Date: Thu, 1 Feb 2018 21:22:49 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: failed exec() exit codes
Message-ID: <20180201202249.65v5yicgejiewwvu@ws.net.home>
References: <20180201145809.jjtadzla22wlw7rv@ws.net.home>
 <201802011701.19780.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201802011701.19780.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 01, 2018 at 05:01:19PM +0100, Ruediger Meier wrote:
> On Thursday 01 February 2018, Karel Zak wrote:
> > Now we use on many places where commands executing another command:
> >
> >     execvp(argv[optind], argv + optind);
> >     err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
> >
> > the problem is that EXIT_FAILURE is too generic and it does not
> > provide any way how to detect failed exec()s.
> 
> I think you did a bit too much. I assume that these exec codes are only 
> useful for the programs which get a "command" from the user's command 
> line. So that the user can expect the original exit code of his 
> wanted "command" if and only if it's not 126 or 127.
> 
> So for taskset(1) these exit codes are good but maybe not needed for 
> swapon(1) or eject(1).

I know, but it seems no problem and it's good way to consolidate the
error message and use the came code pattern.

> > I have added a new macro errexec() to replace err(EXIT_FAILURE, ...).
> >
> > The new macro is compatible with coreutils way:
> >
> >     #define EX_EXEC_FAILED          126     /* Program located, but
> > not usable. */ #define EX_EXEC_ENOENT          127     /* Could not
> > find program to exec.  */
> 
> 
> coreutils has even 2 more in "src/system.h" and each of these kind of
> exec programs are *only* using these ones.

I have copied from this file ;-)

> 
> /* Exit statuses for programs like 'env' that exec other programs.  */
> enum
> {
>   EXIT_TIMEDOUT = 124, /* Time expired before child completed.  */
>   EXIT_CANCELED = 125, /* Internal error prior to exec attempt.  */
>   EXIT_CANNOT_INVOKE = 126, /* Program located, but not usable.  */
>   EXIT_ENOENT = 127 /* Could not find program to exec.  */
> };
> 
> like
> $ chroot   --helpdassdf; echo $?
> chroot: unrecognized option '--helpdassdf'
> Try 'chroot --help' for more information.
> 125
> 
> Other projects like bash only support 126 and 127, like we do now

yes, I guess it's good enough.

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
