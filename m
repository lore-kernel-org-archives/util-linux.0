Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20110620101947.GA17967@nb.net.home>
References: <1307978030-13006-1-git-send-email-kerolasa@iki.fi>
	<20110620101947.GA17967@nb.net.home>
Date: Sat, 25 Jun 2011 17:26:35 +0200
Message-ID: <BANLkTimNPg6VVNS+MQ-9cMgs_ppCQYVE=A@mail.gmail.com>
Subject: Re: Pentecost weekend pull request
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 20, 2011 at 12:19, Karel Zak <kzak@redhat.com> wrote:
> On Mon, Jun 13, 2011 at 05:13:50PM +0200, Sami Kerola wrote:
>
>> [01/33] mount: take xalloc.h in use
>
>  It would be better to keep my_free() in mount/ sources only. I don't
>  think that we will use this crap outside the mount code.
>
>  Note that the final solution will be libmount/mount.c as the mount(8)
>  command implementation. So, let's keep the current mount/* code in
>  maintenance mode and don't try to rewrite it :-)

The original patch is replaced with a above note added to README.

>> [02/33] checktty: NGROUP -> sysconf
>>         This patch was sent earlier, see details bellow.
>>
>>         date    Thu, Jun 9, 2011 at 21:31
>>         subject Re: [PATCH 3/6] checktty: Use NGROUPS_MAX instead of NGROUPS
>
>  You cannot use xalloc() (and friends) in login(1). The login has to
>  call pam_end and report to syslog before exit.
>
>  I'd like to clean up login(1), it means:
>
>    - code refactoring
>    - support PAM or /etc/{passwd,shadow} *only*
>       - remove checktty support
>       - remove cryptocard support
>       - remove kerberos support

This patch is gone. IMHO the above should be in TODO file.

>> [04/33] login-utils: include fix
>>         Inspired what P?draig Brady did with coreutils I thought
>>         to give a shot to include-what-you-use as well.
>>         http://lists.gnu.org/archive/html/coreutils/2011-06/msg00004.html
>>
>>         The utility clearly works. So it is a good time to think
>>         if checking headers in all files should be TODO item?
>
>  Nice!
>
>  What about to add any wrapper to the tools/ directory and call it
>  from our top-level Makefile?
>
>  We already have some stuff there, and I use it before release.

Funny enough in the coreutils list same question was asked pretty
much immediately. I agree it would be awesome to get automatic
header checking, but for now that is not easy to achieve.

The utility relies on llvm source tree, and it gives lots of
false positive indications. For instance iwyu proposes nls.h
should be removed and replaced with libintl.h. Same happens with
c.h and err.h.

For now I recommend to use this utility when one is working with
some particular file. Something like `if you are going to touch
the file check the headers as well'.

>> [10/33] mcookie: change coding style
>>         The mcookie patches are trivial, with exception of docs
>>         change. Updating manual pages with help2man seems to be
>>         quite good idea. Using the output as is is pretty brain
>>         dead idea, but copy pasting bits of syntax etc seems to
>>         work great. Is this an approach you would like to see in
>>         future?
>
>  It depends, the --help output is usually very brief and space-saving.
>
>  Don't forget that GNU guys hate man pages and all their documentation
>  is in the horrible info files, so help2man makes sense for them ;-)
>  We don't have info files, but we have real man pages.

I did not mean help2man output should be used as is. Taking for
instance .TH line or option \fB\-h\fR, \fB\-\-help\fR lines
sounds reasonable for me. I let the patch be what it was.

>> [11/33] whereis: maintenance fixes
>
>  I can imagine more than one patch for these changes.

Split to 4 patches.

>> [12/33] cal: maintenance fixes
>
>  I'll use this patch, but next time don't mix any real changes in the
>  code with indentation changes. Please!

Sorry. Split to 3 patches.

>> [15/33] docs: rename.1 verbose, long options and warning
>>         Looking the code this utility seems to be in wrong
>>         package. Rewriting the command to rely heavily on gnulib
>>         copy.h and backupfile.h would make this to be good
>>         addition to coreutils, assuming they accept the command.
>
>  Yep, go ahead and ask at coreutils mailing list.

Eventually yes.

>>         Or it could time to deprecate the whole command, and
>>         recommend users to multimove by using scripts.
>
>  The command is used by many users. I don't think that deprecation is
>  a good idea. And I also don't think that change the default behavior
>  is a good idea. Maybe we can add --dry-run.

This is exactly why merging to coreutils might work. Providing
the same switches as there is for mv or cp is fairly easy with
gnulib. IMHO the tool is a little too unixy in doing exactly what
user asks how ever stupid it might be. Having --backup,
--interactive and --no-globber just sound right to me.

I am not sure is --dry-run in this case good idea. There's no
guarantees contents on file system have not changed in between
dry and next run. For example the command is not reentant safe.
User might simply get over confident the dry run did not report
anything and end up loosing data.

>> [18/33] write: maintenance fixes
>
>  Don't use
>
>    return (1);
>
>  use
>    return 1;
>
>  The "return" is not a function.

Fixed.

>> [23/33] uuidd: maintenance fixes
>
>    - remove die() -- use err()
>    - remove printf() + exit() -- use err[x]()
>    - print all error messages (!= debug) to stderr

Done and split to multiple patches.

>> [32/33] getopt: inform where to send bug reports
>>         I wonder should the config.h PACKAGE_BUGREPORT be
>>         util-linux mail list...
>
>  Probably ;-)
>
>  We shouldn't use PACKAGE_BUGREPORT in man pages or --help output. I
>  don't think that upstream is the right place for end-users and their
>  bug reports.
>
>  The ideal solution is downstream --patch--> upstream ;-)

This patch is gone.


All the patches are available in the git repository at:
 git://github.com/kerolasa/lelux-utiliteetit.git wknd23

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
