Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:40124 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757770AbdLRDdy (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 17 Dec 2017 22:33:54 -0500
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id vBI3Xp63008070
        for <util-linux@vger.kernel.org>; Sun, 17 Dec 2017 19:33:53 -0800
Message-ID: <5A37371F.5070307@tlinx.org>
Date: Sun, 17 Dec 2017 19:33:51 -0800
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Build problem in 2.31
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In some of the utils in 2.31, I've had a problem where I build
and get an error like:

make AM_DEFAULT_VERBOSITY=1  swapon
/bin/sh ./libtool  --tag=CC   --mode=link /usr/bin/gcc -fsigned-char 
-fno-common -Wall -Werror=sequence-point -Wextra -Wmissing-declarations 
-Wmissing-parameter-type -Wmissing-prototypes 
-Wno-missing-field-initializers -Wredundant-decls -Wsign-compare 
-Wtype-limits -Wuninitialized -Wunused-but-set-parameter 
-Wunused-but-set-variable -Wunused-parameter -Wunused-result 
-Wunused-variable -Wnested-externs -Wpointer-arith -Wstrict-prototypes 
-Wimplicit-function-declaration -I./libblkid/src -I./libmount/src 
-I./libsmartcols/src -fpic -march=native -pipe -Og  -fpic -march=native 
-pipe -Og -Wl,--default-symver -Wl,--stats  -o swapon 
sys-utils/swapon-swapon.o sys-utils/swapon-swapon-common.o 
lib/swapon-swapprober.o  libblkid.la libcommon.la libmount.la 
libsmartcols.la
libtool: link: /usr/bin/gcc -fsigned-char -fno-common -Wall 
-Werror=sequence-point -Wextra -Wmissing-declarations 
-Wmissing-parameter-type -Wmissing-prototypes 
-Wno-missing-field-initializers -Wredundant-decls -Wsign-compare 
-Wtype-limits -Wuninitialized -Wunused-but-set-parameter 
-Wunused-but-set-variable -Wunused-parameter -Wunused-result 
-Wunused-variable -Wnested-externs -Wpointer-arith -Wstrict-prototypes 
-Wimplicit-function-declaration -I./libblkid/src -I./libmount/src 
-I./libsmartcols/src -fpic -march=native -pipe -Og -fpic -march=native 
-pipe -Og -Wl,--default-symver -Wl,--stats -o .libs/swapon 
sys-utils/swapon-swapon.o sys-utils/swapon-swapon-common.o 
lib/swapon-swapprober.o  ./.libs/libblkid.so ./.libs/libcommon.a 
./.libs/libmount.so 
/home/tools/util-linux/util-linux-2.31/.libs/libblkid.so 
/home/tools/util-linux/util-linux-2.31/.libs/libuuid.so -lrt 
./.libs/libsmartcols.so -Wl,-rpath -Wl,//lib64
/usr/lib64/gcc/x86_64-pc-linux-gnu/7/../../../../lib64/crt1.o:/home/abuild/rpmbuild/BUILD/glibc-2.19/csu/../sysdeps/x86_64/start.S:67: 
multiple definition of `swapon'
collect2: error: ld returned 1 exit status
Makefile:6756: recipe for target 'swapon' failed
make: *** [swapon] Error 1

----
Not all of the utils have these errors, but when the util may
also be the name of a system call, is my guess of when these
arise.

Any idea of what I might be doing wrong?

Appreciate pointers!
Tnx,
-linda


