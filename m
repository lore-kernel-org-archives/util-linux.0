Return-Path: assafgordon@gmail.com
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [ANNOUNCE] util-linux v2.30-rc2
From: Assaf Gordon <assafgordon@gmail.com>
In-Reply-To: <20170530151814.wm26bajmdihwaryo@ws.net.home>
Date: Tue, 30 May 2017 23:48:46 -0400
Cc: util-linux@vger.kernel.org
Message-Id: <89E326AC-7FC7-48E9-8781-02791E0E8A7F@gmail.com>
References: <20170523105038.hm3ryvwvghgife4j@ws.net.home> <E6F9AA27-1BC9-4595-9FB2-30F1BA3663CA@gmail.com> <20170530151814.wm26bajmdihwaryo@ws.net.home>
To: Karel Zak <kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Hello,

> On May 30, 2017, at 11:18, Karel Zak <kzak@redhat.com> wrote:
>=20
> On Tue, May 30, 2017 at 01:03:53AM -0400, Assaf Gordon wrote:
>> /usr/bin/ld: cannot find -lncursesw
>> collect2: error: ld returned 1 exit status
>> make[2]: *** [cfdisk] Error 1
>> =3D=3D=3D
>=20
> OK, I had nice afternoon with Debian (after 10 years;-)


I'm still seeing this error (tested with util-linux-2.30-rc2-16-2ac1b on
same Debian 8.1 system).

"config.log" is here: http://sprunge.us/XXfX

This might be a problem with some interplay between 'libncurses' and =
'libncursesw' (the wide-character variant).

The installed packages on the system are:
=3D=3D=3D=3D
$ dpkg -l '*ncurs*'
Desired=3DUnknown/Install/Remove/Purge/Hold
| =
Status=3DNot/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-=
pend
|/ Err?=3D(none)/Reinst-required (Status,Err: uppercase=3Dbad)
||/ Name                    Version          Architecture     =
Description
=
+++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
un  libncurses-dev          <none>           <none>           (no =
description available)
ii  libncurses5:amd64       5.9+20140913-1+b amd64            shared =
libraries for terminal handling
ii  libncurses5-dev:amd64   5.9+20140913-1+b amd64            =
developer's libraries for ncurses
ii  libncursesw5:amd64      5.9+20140913-1+b amd64            shared =
libraries for terminal handling (wide charact
un  ncurses                 <none>           <none>           (no =
description available)
ii  ncurses-base            5.9+20140913-1   all              basic =
terminal type definitions
ii  ncurses-bin             5.9+20140913-1+b amd64            =
terminal-related programs and man pages
un  ncurses-dev             <none>           <none>           (no =
description available)
un  ncurses-doc             <none>           <none>           (no =
description available)
un  ncurses-runtime         <none>           <none>           (no =
description available)
ii  ncurses-term            5.9+20140913-1   all              additional =
terminal type definitions
=3D=3D=3D=3D

I see that both the uni-byte and the wide-character versions are =
installed,
but only the uni-byte '-dev' version is installed,
And the error is about linking with the wide-char variant:
  /usr/bin/ld: cannot find -lncursesw

It could be that this is not an optimal system to build util-linux on
(e.g. messed up packages combination? yet all done with valid 'apt-get' =
commands).
However it would be nice to detect it during "./configure" if possible.

----

Also,
On alpine-linux, the compilation now fails with:
=3D=3D=3D
CC       sys-utils/dmesg-dmesg.o
sys-utils/dmesg.c:9:26: fatal error: linux/unistd.h: No such file or =
directory
compilation terminated.
Makefile:9274: recipe for target 'sys-utils/dmesg-dmesg.o' failed
make[2]: *** [sys-utils/dmesg-dmesg.o] Error 1
=3D=3D=3D
Again, this could be due to missing "linux-headers" package - but is it =
really the kernel's
"unistd.h" that's needed, or could this work with the standard one?



Thanks for all your quick fixes,
 - assaf
