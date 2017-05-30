Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35076 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbdE3FD4 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 30 May 2017 01:03:56 -0400
Received: by mail-qk0-f194.google.com with SMTP id v195so3383657qka.2
        for <util-linux@vger.kernel.org>; Mon, 29 May 2017 22:03:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [ANNOUNCE] util-linux v2.30-rc2
From: Assaf Gordon <assafgordon@gmail.com>
In-Reply-To: <20170523105038.hm3ryvwvghgife4j@ws.net.home>
Date: Tue, 30 May 2017 01:03:53 -0400
Cc: util-linux@vger.kernel.org
Message-Id: <E6F9AA27-1BC9-4595-9FB2-30F1BA3663CA@gmail.com>
References: <20170523105038.hm3ryvwvghgife4j@ws.net.home>
To: Karel Zak <kzak@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello

> On May 23, 2017, at 06:50, Karel Zak <kzak@redhat.com> wrote:
>=20
> The util-linux release v2.30-rc2 is available at
>=20
>  http://www.kernel.org/pub/linux/utils/util-linux/v2.30/

Few results from various system:

1.
On several systems which do not have ncurses development files
installed, the "configure" script does not detect it,
and completion later fails.
Example with Debian 8.1:

=3D=3D=3D
  CC       disk-utils/cfdisk-cfdisk.o
disk-utils/cfdisk.c: In function =E2=80=98ui_get_string=E2=80=99:
disk-utils/cfdisk.c:1757:3: warning: implicit declaration of function =
=E2=80=98get_wch=E2=80=99 [-Wimplicit-function-declaration]
   if (get_wch(&c) =3D=3D ERR) {
   ^
disk-utils/cfdisk.c:1757:3: warning: nested extern declaration of =
=E2=80=98get_wch=E2=80=99 [-Wnested-externs]
  CCLD     cfdisk
/usr/bin/ld: cannot find -lncursesw
collect2: error: ld returned 1 exit status
make[2]: *** [cfdisk] Error 1
=3D=3D=3D


2.
On ppc64 machine running Fedora 20, kernel 3.17.2-200.fc20.ppc64p7, gcc =
4.8.3,
the following tests fail:
   misc: flock: [04] exclusive                         ... FAILED =
(misc/flock-exclusive)
   misc: flock                                         ... FAILED (1 =
from 6 sub-tests)
Log here:
   https://pretest.housegordon.org/g/4806/logs/make-check.log?inlined=3D1
Build details here:
   https://pretest.housegordon.org/d/4806


3.
On a X86-64 QEMU virtual machine running Fedora 25, Fedora 24, the =
following test failed:
   fincore: count file contents in core    ... FAILED (fincore/count)
Log here:
   https://pretest.housegordon.org/g/4824/logs/make-check.log?inlined=3D1
Build details here:
   https://pretest.housegordon.org/d/4824



more exotic cases:

4.
Building with TinyCC compiler (tcc) fails with:
=3D=3D=3D
CC       sys-utils/hwclock-cmos.o
sys-utils/hwclock-cmos.c:139: warning: implicit declaration of function =
'outb'
sys-utils/hwclock-cmos.c:140: warning: implicit declaration of function =
'inb'
CC       sys-utils/hwclock-rtc.o
CCLD     hwclock
tcc: error: undefined symbol 'outb'
tcc: error: undefined symbol 'inb'
make[2]: *** [hwclock] Error 1
=3D=3D=3D
(this is not a problem in util-linux, but perhaps can be detected and =
avoided?)



5.
On Alpine-Linux 3.5.2 (musl-libc instead of glibc), compilation fails =
with:
=3D=3D=3D
CC       lib/libcommon_la-loopdev.lo
lib/loopdev.c:35:31: fatal error: linux/posix_types.h: No such file or =
directory
#include <linux/posix_types.h>
^
compilation terminated.
make[2]: *** [Makefile:8466: lib/libcommon_la-loopdev.lo] Error 1
=3D=3D=3D
The problem is that the alpine-linux package "linux-headers" [1]
is not installed. It might be helpful to detect it in 'configure'.
[1] https://pkgs.alpinelinux.org/package/v3.5/main/x86_64/linux-headers


Still on Alpine-Linux, after installing "linux-headers" package,
one of the binaries in "make check" fails to build due to another =
missing
header:
=3D=3D=3D
CC       misc-utils/test_uuidd-test_uuidd.o
misc-utils/test_uuidd.c:26:19: fatal error: error.h: No such file or =
directory
#include <error.h>
^
compilation terminated.
make[3]: *** [Makefile:11056: misc-utils/test_uuidd-test_uuidd.o] Error =
1
=3D=3D=3D
I guess "error.h" is glibc's header for error(3) - but alpine uses =
musl-libc
and does not have it.





6.
Building on GNU Hurd 0.7 (not linux), the following test fail:
   fdisk: invalid input tests            ... FAILED (fdisk/oddinput)
   ipcs: headers                        ... FAILED (ipcs/headers)
   mountpoint                  ... FAILED (libmount/utils-mountpoint)
   mountpoint-subdir           ... FAILED =
(libmount/utils-mountpoint-subdir)
   misc: flock                          ...ps: unrecognized option =
'--ppid'
     Try `ps --help' or `ps --usage' for more information.
     ps: unrecognized option '--ppid'
   FAILED (misc/flock)

Log here:
   https://pretest.housegordon.org/g/4834/logs/make-check.log?inlined=3D1
Build details here:
   https://pretest.housegordon.org/d/4834


7.
For the truly curious, more build reports
from non-linux systems (e.g. OpenBSD, FreeBSD, SunOS, Darwin):
  https://pretest.housegordon.org/q/util-linux-2.30-rc2



regards,
 - assaf



