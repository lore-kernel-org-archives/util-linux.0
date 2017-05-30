Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbdE3J1R (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 30 May 2017 05:27:17 -0400
Date: Tue, 30 May 2017 11:27:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Assaf Gordon <assafgordon@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.30-rc2
Message-ID: <20170530092713.naze6me5cte4kl36@ws.net.home>
References: <20170523105038.hm3ryvwvghgife4j@ws.net.home>
 <E6F9AA27-1BC9-4595-9FB2-30F1BA3663CA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <E6F9AA27-1BC9-4595-9FB2-30F1BA3663CA@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 30, 2017 at 01:03:53AM -0400, Assaf Gordon wrote:
> Hello
> 
> > On May 23, 2017, at 06:50, Karel Zak <kzak@redhat.com> wrote:
> > 
> > The util-linux release v2.30-rc2 is available at
> > 
> >  http://www.kernel.org/pub/linux/utils/util-linux/v2.30/
> 
> Few results from various system:
> 
> 1.
> On several systems which do not have ncurses development files
> installed, the "configure" script does not detect it,
> and completion later fails.
> Example with Debian 8.1:
> 
> ===
>   CC       disk-utils/cfdisk-cfdisk.o
> disk-utils/cfdisk.c: In function ‘ui_get_string’:
> disk-utils/cfdisk.c:1757:3: warning: implicit declaration of function ‘get_wch’ [-Wimplicit-function-declaration]
>    if (get_wch(&c) == ERR) {
>    ^
> disk-utils/cfdisk.c:1757:3: warning: nested extern declaration of ‘get_wch’ [-Wnested-externs]
>   CCLD     cfdisk
> /usr/bin/ld: cannot find -lncursesw
> collect2: error: ld returned 1 exit status
> make[2]: *** [cfdisk] Error 1
> ===

It would be nice to have configure output. It seems you have
pkg-config (or ncursesw5-config or ncursesw6-config), but no header
files :-)

For example Fedora after "dnf remove ncurses-devel"

./configure
...
checking for NCURSESW... no
checking for ncursesw6-config... no
checking for ncursesw5-config... no
checking for initscr in -lncursesw... no
checking for NCURSES... no
checking for ncurses6-config... no
checking for ncurses5-config... no
checking for initscr in -lncurses... no


> On a X86-64 QEMU virtual machine running Fedora 25, Fedora 24, the following test failed:
>    fincore: count file contents in core    ... FAILED (fincore/count)
> Log here:
>    https://pretest.housegordon.org/g/4824/logs/make-check.log?inlined=1
> Build details here:
>    https://pretest.housegordon.org/d/4824

I have seen this test failed too. It seems like the test is unstable...

> Building with TinyCC compiler (tcc) fails with:
> ===
> CC       sys-utils/hwclock-cmos.o
> sys-utils/hwclock-cmos.c:139: warning: implicit declaration of function 'outb'
> sys-utils/hwclock-cmos.c:140: warning: implicit declaration of function 'inb'
> CC       sys-utils/hwclock-rtc.o
> CCLD     hwclock
> tcc: error: undefined symbol 'outb'
> tcc: error: undefined symbol 'inb'
> make[2]: *** [hwclock] Error 1
> ===
> (this is not a problem in util-linux, but perhaps can be detected and avoided?)

How I can force util-linux build system to accept tcc? 

    CC=tcc ./configure 
    
does not work as well as

    make CC=tcc


> 5.
> On Alpine-Linux 3.5.2 (musl-libc instead of glibc), compilation fails with:
> ===
> CC       lib/libcommon_la-loopdev.lo
> lib/loopdev.c:35:31: fatal error: linux/posix_types.h: No such file or directory
> #include <linux/posix_types.h>
> ^
> compilation terminated.
> make[2]: *** [Makefile:8466: lib/libcommon_la-loopdev.lo] Error 1
> ===
> The problem is that the alpine-linux package "linux-headers" [1]
> is not installed. It might be helpful to detect it in 'configure'.
> [1] https://pkgs.alpinelinux.org/package/v3.5/main/x86_64/linux-headers

Fixed, the header file is unnecessary.


> Still on Alpine-Linux, after installing "linux-headers" package,
> one of the binaries in "make check" fails to build due to another missing
> header:
> ===
> CC       misc-utils/test_uuidd-test_uuidd.o
> misc-utils/test_uuidd.c:26:19: fatal error: error.h: No such file or directory
> #include <error.h>
> ^
> compilation terminated.
> make[3]: *** [Makefile:11056: misc-utils/test_uuidd-test_uuidd.o] Error 1
> ===
> I guess "error.h" is glibc's header for error(3) - but alpine uses musl-libc
> and does not have it.

Fixed, err() and warn() should be enough in all package.

> 6.
> Building on GNU Hurd 0.7 (not linux), the following test fail:
>    fdisk: invalid input tests            ... FAILED (fdisk/oddinput)

need more information, for example tests/ts/diff/fdisk/oddinput

>    ipcs: headers                        ... FAILED (ipcs/headers)

not sure, what returns ipcs when executed on command line?

>    mountpoint                  ... FAILED (libmount/utils-mountpoint)
>    mountpoint-subdir           ... FAILED (libmount/utils-mountpoint-subdir)

should be fixed

>    misc: flock                          ...ps: unrecognized option '--ppid'
>      Try `ps --help' or `ps --usage' for more information.
>      ps: unrecognized option '--ppid'
>    FAILED (misc/flock)

fixed

> For the truly curious, more build reports
> from non-linux systems (e.g. OpenBSD, FreeBSD, SunOS, Darwin):
>   https://pretest.housegordon.org/q/util-linux-2.30-rc2

Thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
