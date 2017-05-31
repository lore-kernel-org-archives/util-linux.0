Return-Path: assafgordon@gmail.com
Date: Wed, 31 May 2017 17:41:40 +0000
From: Assaf Gordon <assafgordon@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.30-rc2
Message-ID: <20170531174139.GA30064@gmail.com>
References: <20170523105038.hm3ryvwvghgife4j@ws.net.home>
 <E6F9AA27-1BC9-4595-9FB2-30F1BA3663CA@gmail.com>
 <20170530151814.wm26bajmdihwaryo@ws.net.home>
 <89E326AC-7FC7-48E9-8781-02791E0E8A7F@gmail.com>
 <20170531091648.3eql47zhfo6sy6sd@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20170531091648.3eql47zhfo6sy6sd@ws.net.home>
List-ID: <util-linux.vger.kernel.org>

Hello,

On Wed, May 31, 2017 at 11:16:48AM +0200, Karel Zak wrote:
>On Tue, May 30, 2017 at 11:48:46PM -0400, Assaf Gordon wrote:
>> I'm still seeing this error (tested with util-linux-2.30-rc2-16-2ac1b on
>> same Debian 8.1 system).
>
>Ah, I had another issues with ncurses on debian, so I forget to very
>this one. Fixed now (I hope).

Thanks, works now (tested with Debian 8.1, 7.6, Ubuntu 16.04, 15.04,
14.04).


>> On alpine-linux, the compilation now fails with:
>
>So, now the header file <linux/version.h> is required by ./configure
>on Linux. I guess it's not overkill.

Yes, works well and the error message is clear.
Adding linux-headers with `sudo apk add linux-headers` solves the issue.

Now that it builds on alpine-linux, two other issues (not necessarily 
show-stoppers for the release):

1.
The test infrastrucutre uses some GNU extensions which aren't
available by default on Alpine-Linux (it has busybox instead of GNU 
coreuils). Specifically: ./tests/run.sh uses `#!/bin/bash`, `xargs -P` 
and `grep --after-context=1` .
The `grep` at least is easy to fix as busybox's grep supports the 
short-option equivalent of `-A1`.

As a work-around, the GNU programs can be installed on alpine with:
    sudo apk add findutils bash grep


2.
After installing the gnu programs `make check` works, but few tests 
fail:
============
   col: multibyte input                ... FAILED (col/multibyte)
colcrt: regressions                    ...
      : crash1                      ... FAILED (colcrt/regressions-crash1)
      : crash2                      ... FAILED (colcrt/regressions-crash2)
      : hang1                       ... FAILED (colcrt/regressions-hang1)
      ... FAILED (3 from 3 sub-tests)
column: invalid multibyte              ... FAILED (column/invalid-multibyte)
 fdisk: invalid input tests            ... FAILED (fdisk/oddinput)
getopt: options                        ...
      : alternative_option_clash    ... FAILED (getopt/options-alternative_option_clash)
      : posix_correctly             ... FAILED (getopt/options-posix_correctly)
      ... FAILED (2 from 29 sub-tests)
  misc: swaplabel                      ... FAILED (misc/swaplabel)
rename: exit codes                     ... FAILED (rename/exit_codes)
  utmp: subsecond                      ... FAILED (utmp/utmpdump-subsecond)
==============

Regarding the 'multibyte' failures - these could stem from musl-libc's differences
(compared to glibc).
'utmp' failure might be because musl-libc does not implement utmp support (only stubs).

I'm happy to test further if you have specific suggestions of what to test.

-----


Lastly,
I've hit a snag when trying to run 'make dist' on the latest version.
make failed with:
===
make[5]: Entering directory `/localdata2/sources/util-linux/po'
File da.new.po does not exist. If you are a translator, you can create it through 'msginit'.
make[5]: *** [da.new.po-create] Error 1
make[5]: Leaving directory `/localdata2/sources/util-linux/po'
===

I have no clue when this is coming from (it didn't fail on in previous builds).
Could be a problem on my system, or something else. Didn't investigate further
(just manually removed 'da.new.*' from po/Makefile).


regards,
 - assaf
