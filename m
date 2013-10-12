Return-Path: bruce.dubbs@gmail.com
Message-ID: <5258C359.9010407@gmail.com>
Date: Fri, 11 Oct 2013 22:34:49 -0500
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.24-rc2
References: <20131011114403.GB24613@x2.net.home>
In-Reply-To: <20131011114403.GB24613@x2.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
>
>   The util-linux release v2.24-rc2 is available at
>
>     ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.24/
>
>   Feedback and bug reports, as always, are welcomed.

When I run:

./configure --disable-su --disable-sulogin --disable-login

I get:

         util-linux  2.24-rc2

         prefix:            /usr
         exec prefix:       ${prefix}

         localstatedir:     /run
         bindir:            /lib
         sbindir:           ${exec_prefix}/sbin
         libdir:            ${exec_prefix}/lib
         includedir:        ${prefix}/include
         usrbin_execdir:    ${exec_prefix}/bin
         usrsbin_execdir:   ${exec_prefix}/sbin
         usrlib_execdir:    ${exec_prefix}/lib

         compiler:          gcc -std=gnu99
         cflags:            -g -O2
         suid cflags:
         ldflags:
         suid ldflags:

         Python:
         Python version:
         Python libs:

Surely bindir should not be /lib.  I can't even override it with 
--bindir=/bin

Indeed, if I make && make DESTDIR=/tmp/util-linux install I get:

$ ls /tmp/util-linux/lib
dmesg  findmnt  kill  lsblk  more  mount  mountpoint  umount  wdctl

I'm not an autotools expert, but I tried changing line 55 in 
configure.ac to

AS_CASE([$libdir],  ['${exec_prefix}/lib'],  [libdir=/lib;  ...
                                               ^^^
and not
AS_CASE([$libdir],  ['${exec_prefix}/lib'],  [bindir=/lib;

But that's not right either because it changes bindir to /sbin and not /bin.

Also, a lot of executables are placed in /usr/sbin when the default 
should be /sbin.  Examples are swapon, fsck*, mkfs*, etc.

   -- Bruce
