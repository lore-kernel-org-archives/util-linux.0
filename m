Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20110914174600.GD1829@nb.net.home>
References: <CAG27Bk342RY_dMN5BFW9G+9z-KmmasX0XOA4UVSrn+tSsvmVRA@mail.gmail.com>
	<20110914174600.GD1829@nb.net.home>
Date: Sat, 17 Sep 2011 15:10:39 +0200
Message-ID: <CAG27Bk3FNu-ofpfCZAZ3Ln34wggcJ6Djbx9jkK4dn-__gvAM5A@mail.gmail.com>
Subject: Re: [pull] some sys-utils improvements
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 14, 2011 at 19:04, Davidlohr Bueso <dave@gnu.org> wrote:

Thanks Dave. Now when I look the fix it's obvious. The patch is
added to my branch, with tiny modifications

* The if shorthands are put to one line.
* After the patch function always returned as it would have failed, which now
  is fixed.

On Wed, Sep 14, 2011 at 19:46, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Sep 13, 2011 at 11:13:57PM +0200, Sami Kerola wrote:
>> I started to look sys-utils directory, and got obsessed by getting ipc
>> stuff to behave like a tool from this millennium. The whole directory
>> is not done, but I feel this is already big enough patch set.
>
>  Some notes about USAGE_*:
>
> * USAGE_BEGIN_TAIL is unnecessary if we know that USAGE_MAN_TAIL is
>  always on new line, we can use \n at the begin of the
>  USAGE_MAN_TAIL:
>
>      "\nFor more details see %s.\n"

When writing that to usage howto I thought there could be an executable which
does not have manual page. That was a misconception; everything has manual page,
and if something does not it will be created. I'll scrap the
USAGE_BEGIN_TAIL.

> * I don't like the current
>
>     #define USAGE_MAN_TAIL   _("For more details see %s.\n")
>
>  macro. It's bad manner to use hidden argument(s) for macros, it would
>  be better to have:
>
>     #define USAGE_MAN_TAIL(_man)   _("\nFor more details see %s.\n"), _man

Corrected.

> * how we want to use USAGE_HELP and USAGE_VERSION macros? The strings
>  in the macros are the same for all programs, it means that there is
>  the same space between "-h, --help" and "display this help and exit"
>  in all programs. For example:
>
>   printf(_("-x, --extra-mega-cool <file>    enable the best feature for <file>\n");
>   printf(USAGE_HELP);
>   printf(USAGE_USAGE);
>
>   -x, --extra-mega-cool <file>    enable the best feature for <file>
>   -h, --help     display this help and exit
>   -V, --version  output version information and exit
>
>  mess, maybe we need an extra line between program specific options
>  and the common options:
>
>   printf(_("-x, --extra-mega-cool <file>    enable the best feature for <file>\n");
>   printf(USAGE_SEPARATOR);
>   printf(USAGE_HELP);
>   printf(USAGE_USAGE);
>   printf(USAGE_MAN_TAIL("foo(1)");
>
>  output:
>
>   -x, --extra-mega-cool <file>    enable the best feature for <file>
>
>   -h, --help     display this help and exit
>   -V, --version  output version information and exit
>
>   For more details see foo(1).
>
>  it also means that --help and --version should be at the end of the
>  options list.

The usage howto is already telling --help and --version are expected to be
last in list, so that should be OK. The separator in between specific and
'common' options is added to howto and code. Obvious good thing about the
separator is that if we end up not liking it it's trivial to make
ineffective.

>>       setarch: move options struct to function scope
>>       setarch: use program_invocation_short_name
>>       setarch: add version printing
>>       ipcmk: add long options & fix usage()
>>       ipcmk: remove useless code
>>       ipcmk: validate numeric option arguments
>>       ipcmk: remove camel casing
>>       ipcmk: include-what-you-use header check
>
>  Note that in the 2.20 release we have introduced a new bug by
>  include-what-you-use patch. It's necessary to test it with
>  (at least) --disable-nls.
>
>  The ideal solution would be to add something like tools/checkbuilds
>  to test different ./configure scenarios (enable/disable NLS,
>  slang/ncurses/ncursesw, ...). Now it's possible that not all
>  scenarios are tested now. We have to test it, because people are too
>  lazy to test -rc releases...

Problem being is that the include-what-you-use gives very good hints and
false positives, so a tiny slip with copy and paste will result to a such
regressions what happen earlier.

Maybe the best way to deal the headers is to catch whether a file has
includes which are dealt some smart way in util-linux/include files. AFAIK
the list such includes at least following.

err.h
langinfo.h
libintl.h
linux/version.h
locale.h
paths.h
stdint.h
sys/ioccom.h
sys/mkdev.h
wchar.h
wctype.h

My suggestion is to expand utility we alrady have

tools/checkincludes.pl

If no-one else will pickup making the utility more useful I will do that at
some day. BTW I'll stop doing the header clean ups until the check is done.

>>       ipcrm: add long options
>>       ipcrm: exit if unknown error occurs
>
>  Please, don't use "else" after non-return functions. For example:
>
>  if (x)
>     non_return_func()
>  else
>     ...

Corrected & the principle is added to howto-contribute.

>  Heee.. smatch should be improved to detect this code :-)
>
>>       ipcrm: refactor new and old main to share code
>
>  Please:
>
>    - check strtoul() result. See strutils.c

Corrected.

>    - if possible, then use only one line for  var = E ? x : y;  it's
>      unnecessary to move ": y" to another line.

Corrected & the principle is added to howto-contribute.

>    - don't use "error" as variable name, glibc provides such function.

Corrected.

>    - btw, do we have regression test for ipcrm? :-)

We don't yet. I added this to my list of things to do. Initial thought about
the test is that is should not rely on ipcs to validate anything, because it
should test that utility. Separate similar utility is needed. Secondly the
iprm testing should not be destructive, which rules out remove all testing
unless 'I know what I am doing' switch is used.

>>       ipcrm: include-what-you-use header check
>>       ipcs: add long options
>>       ipcs: include-what-you-use header check
>>       ipcs: comment & white space clean up
>>       pivot_root: add version & help option
>>       docs: mention long options in pivot_root.8
>
>  Hmm... there should be also switch_root(8) in SEE ALSO section.

Added.

The request-pull bellow updates the previous I sent.

The following changes since commit 4e9b3bfda20ebbaf5d925dedad6ce8e2b678b563:

  lib,cpuset: fix compiler warning [-Wuninitialized] (2011-09-10 00:02:00 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit sys-utils

Davidlohr Bueso (1):
      ipcrm: check IPC syscalls

Sami Kerola (28):
      setarch: move options struct to function scope
      setarch: use program_invocation_short_name
      setarch: add version printing
      ipcmk: add long options & fix usage()
      ipcmk: remove useless code
      ipcmk: validate numeric option arguments
      ipcmk: remove camel casing
      ipcmk: include-what-you-use header check
      ipcrm: add long options
      ipcrm: exit if unknown error occurs
      ipcrm: refactor new and old main to share code
      ipcrm: include-what-you-use header check
      ipcs: add long options
      ipcs: include-what-you-use header check
      ipcs: comment & white space clean up
      pivot_root: add version & help option
      docs: mention long options in pivot_root.8
      ctrlaltdel: add version & help options
      docs: mention long options in ctrlaltdel.8
      docs: add --version to setarch.8
      docs: add long options to ipcmk.1 man page
      docs: add long options to ipcrm.1 man page
      docs: add long options to ipcs.1 man page
      ipcrm: add --all option
      ipcmk: allow high speed ipc creation
      ipcrm: add --verbose option
      build-sys: fixes to USAGE_* macros
      docs: add non-return function and if shorthand tips

 Documentation/howto-contribute.txt     |   18 ++
 Documentation/howto-usage-function.txt |    6 +-
 include/c.h                            |    4 +-
 sys-utils/Makefile.am                  |    2 +
 sys-utils/arch.c                       |    5 +-
 sys-utils/ctrlaltdel.8                 |   20 +-
 sys-utils/ctrlaltdel.c                 |   39 +++-
 sys-utils/ipcmk.1                      |   52 ++--
 sys-utils/ipcmk.c                      |  144 ++++-----
 sys-utils/ipcrm.1                      |   65 ++---
 sys-utils/ipcrm.c                      |  515 ++++++++++++++++++++------------
 sys-utils/ipcs.1                       |  101 ++++---
 sys-utils/ipcs.c                       |  278 +++++++++---------
 sys-utils/pivot_root.8                 |   10 +-
 sys-utils/pivot_root.c                 |   60 +++-
 sys-utils/setarch.8                    |   21 +-
 sys-utils/setarch.c                    |   74 +++---
 17 files changed, 841 insertions(+), 573 deletions(-)

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
