Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48305 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754950Ab1INRqD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 14 Sep 2011 13:46:03 -0400
Date: Wed, 14 Sep 2011 19:46:00 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] some sys-utils improvements
Message-ID: <20110914174600.GD1829@nb.net.home>
References: <CAG27Bk342RY_dMN5BFW9G+9z-KmmasX0XOA4UVSrn+tSsvmVRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk342RY_dMN5BFW9G+9z-KmmasX0XOA4UVSrn+tSsvmVRA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 13, 2011 at 11:13:57PM +0200, Sami Kerola wrote:
> I started to look sys-utils directory, and got obsessed by getting ipc
> stuff to behave like a tool from this millennium. The whole directory
> is not done, but I feel this is already big enough patch set.

 Some notes about USAGE_*:

* USAGE_BEGIN_TAIL is unnecessary if we know that USAGE_MAN_TAIL is
  always on new line, we can use \n at the begin of the
  USAGE_MAN_TAIL:
    
      "\nFor more details see %s.\n"

* I don't like the current

     #define USAGE_MAN_TAIL   _("For more details see %s.\n")

 macro. It's bad manner to use hidden argument(s) for macros, it would
 be better to have:

     #define USAGE_MAN_TAIL(_man)   _("\nFor more details see %s.\n"), _man


* how we want to use USAGE_HELP and USAGE_VERSION macros? The strings
  in the macros are the same for all programs, it means that there is
  the same space between "-h, --help" and "display this help and exit"
  in all programs. For example:

   printf(_("-x, --extra-mega-cool <file>    enable the best feature for <file>\n");
   printf(USAGE_HELP);
   printf(USAGE_USAGE);

   -x, --extra-mega-cool <file>    enable the best feature for <file>
   -h, --help     display this help and exit
   -V, --version  output version information and exit

 mess, maybe we need an extra line between program specific options
 and the common options:

   printf(_("-x, --extra-mega-cool <file>    enable the best feature for <file>\n");
   printf(USAGE_SEPARATOR);
   printf(USAGE_HELP);
   printf(USAGE_USAGE);
   printf(USAGE_MAN_TAIL("foo(1)");

 output:

   -x, --extra-mega-cool <file>    enable the best feature for <file>

   -h, --help     display this help and exit
   -V, --version  output version information and exit

   For more details see foo(1).
  
 it also means that --help and --version should be at the end of the
 options list.

>       setarch: move options struct to function scope
>       setarch: use program_invocation_short_name
>       setarch: add version printing
>       ipcmk: add long options & fix usage()
>       ipcmk: remove useless code
>       ipcmk: validate numeric option arguments
>       ipcmk: remove camel casing
>       ipcmk: include-what-you-use header check

 Note that in the 2.20 release we have introduced a new bug by
 include-what-you-use patch. It's necessary to test it with
 (at least) --disable-nls.

 The ideal solution would be to add something like tools/checkbuilds
 to test different ./configure scenarios (enable/disable NLS,
 slang/ncurses/ncursesw, ...). Now it's possible that not all
 scenarios are tested now. We have to test it, because people are too
 lazy to test -rc releases...

>       ipcrm: add long options
>       ipcrm: exit if unknown error occurs

 Please, don't use "else" after non-return functions. For example:

  if (x)
     non_return_func()
  else
     ...


 Heee.. smatch should be improved to detect this code :-)

>       ipcrm: refactor new and old main to share code

 Please:

    - check strtoul() result. See strutils.c

    - if possible, then use only one line for  var = E ? x : y;  it's
      unnecessary to move ": y" to another line.

    - don't use "error" as variable name, glibc provides such function.

    - btw, do we have regression test for ipcrm? :-)

>       ipcrm: include-what-you-use header check
>       ipcs: add long options
>       ipcs: include-what-you-use header check
>       ipcs: comment & white space clean up
>       pivot_root: add version & help option
>       docs: mention long options in pivot_root.8

 Hmm... there should be also switch_root(8) in SEE ALSO section. 

>       ctrlaltdel: add version & help options
>       docs: mention long options in ctrlaltdel.8
>       docs: add --version to setarch.8
>       docs: add long options to ipcmk.1 man page
>       docs: add long options to ipcrm.1 man page
>       docs: add long options to ipcs.1 man page
>       ipcrm: add --all option
>       ipcmk: allow high speed ipc creation
>       ipcrm: add --verbose option
...
>  13 files changed, 788 insertions(+), 564 deletions(-)

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
