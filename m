Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15642 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457Ab1FTKT5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 20 Jun 2011 06:19:57 -0400
Date: Mon, 20 Jun 2011 12:19:47 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: Pentecost weekend pull request
Message-ID: <20110620101947.GA17967@nb.net.home>
References: <1307978030-13006-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307978030-13006-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 13, 2011 at 05:13:50PM +0200, Sami Kerola wrote:
> I feel a bit embarrassed to see how many patches I wrote. My
> excuse is long, mostly rainy, weekend. Here comes a pull request;

 :-)

> [01/33] mount: take xalloc.h in use

 It would be better to keep my_free() in mount/ sources only. I don't
 think that we will use this crap outside the mount code.

 Note that the final solution will be libmount/mount.c as the mount(8)
 command implementation. So, let's keep the current mount/* code in
 maintenance mode and don't try to rewrite it :-)

> [02/33] checktty: NGROUP -> sysconf
>         This patch was sent earlier, see details bellow.
> 
>         date    Thu, Jun 9, 2011 at 21:31
>         subject Re: [PATCH 3/6] checktty: Use NGROUPS_MAX instead of NGROUPS
 
 You cannot use xalloc() (and friends) in login(1). The login has to
 call pam_end and report to syslog before exit.

 I'd like to clean up login(1), it means:
 
    - code refactoring
    - support PAM or /etc/{passwd,shadow} *only*
       - remove checktty support
       - remove cryptocard support
       - remove kerberos support

> [04/33] login-utils: include fix
>         Inspired what P?draig Brady did with coreutils I thought
>         to give a shot to include-what-you-use as well.
>         http://lists.gnu.org/archive/html/coreutils/2011-06/msg00004.html
> 
>         The utility clearly works. So it is a good time to think
>         if checking headers in all files should be TODO item?

 Nice!

 What about to add any wrapper to the tools/ directory and call it
 from our top-level Makefile? 
 
 We already have some stuff there, and I use it before release.

> [10/33] mcookie: change coding style
>         The mcookie patches are trivial, with exception of docs
>         change. Updating manual pages with help2man seems to be
>         quite good idea. Using the output as is is pretty brain
>         dead idea, but copy pasting bits of syntax etc seems to
>         work great. Is this an approach you would like to see in
>         future?

 It depends, the --help output is usually very brief and space-saving.
 
 Don't forget that GNU guys hate man pages and all their documentation
 is in the horrible info files, so help2man makes sense for them ;-) 
 We don't have info files, but we have real man pages.

> [11/33] whereis: maintenance fixes

 I can imagine more than one patch for these changes.

> [12/33] cal: maintenance fixes

 I'll use this patch, but next time don't mix any real changes in the 
 code with indentation changes. Please!

> [15/33] docs: rename.1 verbose, long options and warning
>         Looking the code this utility seems to be in wrong
>         package. Rewriting the command to rely heavily on gnulib
>         copy.h and backupfile.h would make this to be good
>         addition to coreutils, assuming they accept the command.

 Yep, go ahead and ask at coreutils mailing list.

>         Or it could time to deprecate the whole command, and
>         recommend users to multimove by using scripts.

 The command is used by many users. I don't think that deprecation is
 a good idea. And I also don't think that change the default behavior
 is a good idea. Maybe we can add --dry-run.
 
> [18/33] write: maintenance fixes

 Don't use 

    return (1);
    
 use 
    return 1;
 
 The "return" is not a function.

> [23/33] uuidd: maintenance fixes

    - remove die() -- use err()
    - remove printf() + exit() -- use err[x]()
    - print all error messages (!= debug) to stderr

> [32/33] getopt: inform where to send bug reports
>         I wonder should the config.h PACKAGE_BUGREPORT be
>         util-linux mail list...

 Probably ;-)
 
 We shouldn't use PACKAGE_BUGREPORT in man pages or --help output. I
 don't think that upstream is the right place for end-users and their
 bug reports. 
 
 The ideal solution is downstream --patch--> upstream ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
