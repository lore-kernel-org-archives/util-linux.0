Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759263AbdLRMiK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 18 Dec 2017 07:38:10 -0500
Date: Mon, 18 Dec 2017 13:38:05 +0100
From: Karel Zak <kzak@redhat.com>
To: L A Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: Build problem in 2.31
Message-ID: <20171218123805.tkhhuyemgntv4gie@ws.net.home>
References: <5A37371F.5070307@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5A37371F.5070307@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 17, 2017 at 07:33:51PM -0800, L A Walsh wrote:
> In some of the utils in 2.31, I've had a problem where I build
> and get an error like:

Tarball or git tree?

> 
> make AM_DEFAULT_VERBOSITY=1  swapon
> /bin/sh ./libtool  --tag=CC   --mode=link /usr/bin/gcc -fsigned-char
> -fno-common -Wall -Werror=sequence-point -Wextra -Wmissing-declarations
> -Wmissing-parameter-type -Wmissing-prototypes
> -Wno-missing-field-initializers -Wredundant-decls -Wsign-compare
> -Wtype-limits -Wuninitialized -Wunused-but-set-parameter
> -Wunused-but-set-variable -Wunused-parameter -Wunused-result
> -Wunused-variable -Wnested-externs -Wpointer-arith -Wstrict-prototypes
> -Wimplicit-function-declaration -I./libblkid/src -I./libmount/src
> -I./libsmartcols/src -fpic -march=native -pipe -Og  -fpic -march=native
> -pipe -Og -Wl,--default-symver -Wl,--stats  -o swapon
> sys-utils/swapon-swapon.o sys-utils/swapon-swapon-common.o
> lib/swapon-swapprober.o  libblkid.la libcommon.la libmount.la
> libsmartcols.la
> libtool: link: /usr/bin/gcc -fsigned-char -fno-common -Wall
> -Werror=sequence-point -Wextra -Wmissing-declarations
> -Wmissing-parameter-type -Wmissing-prototypes
> -Wno-missing-field-initializers -Wredundant-decls -Wsign-compare
> -Wtype-limits -Wuninitialized -Wunused-but-set-parameter
> -Wunused-but-set-variable -Wunused-parameter -Wunused-result
> -Wunused-variable -Wnested-externs -Wpointer-arith -Wstrict-prototypes
> -Wimplicit-function-declaration -I./libblkid/src -I./libmount/src
> -I./libsmartcols/src -fpic -march=native -pipe -Og -fpic -march=native -pipe
> -Og -Wl,--default-symver -Wl,--stats -o .libs/swapon
> sys-utils/swapon-swapon.o sys-utils/swapon-swapon-common.o
> lib/swapon-swapprober.o  ./.libs/libblkid.so ./.libs/libcommon.a
> ./.libs/libmount.so /home/tools/util-linux/util-linux-2.31/.libs/libblkid.so
> /home/tools/util-linux/util-linux-2.31/.libs/libuuid.so -lrt
> ./.libs/libsmartcols.so -Wl,-rpath -Wl,//lib64
> /usr/lib64/gcc/x86_64-pc-linux-gnu/7/../../../../lib64/crt1.o:/home/abuild/rpmbuild/BUILD/glibc-2.19/csu/../sysdeps/x86_64/start.S:67:
> multiple definition of `swapon'
> collect2: error: ld returned 1 exit status
> Makefile:6756: recipe for target 'swapon' failed
> make: *** [swapon] Error 1
> 
> ----
> Not all of the utils have these errors, but when the util may
> also be the name of a system call, is my guess of when these
> arise.

Do you have /usr/include/sys/swap.h? And if yes, what do you have in
the file? (copy & past).

Please, see also config.h and "SWAPON_HAS_TWO_ARGS" there. 

[Hmm... I think all this SWAPON_HAS_TWO_ARGS is pretty unnecessary,
swapon() with two args has been introduced by kernel 1.3.2 :-)]

Maybe send all output from ./configure too.
    

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
