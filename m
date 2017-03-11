Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:46728 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753882AbdCKWul (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 11 Mar 2017 17:50:41 -0500
Message-ID: <58C47F38.9030104@tlinx.org>
Date: Sat, 11 Mar 2017 14:50:32 -0800
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: J William Piggott <elseifthen@gmx.com>
CC: util-linux@vger.kernel.org
Subject: Re: ideas of what lib might be missing? (2.29.2 has missing symbols
 @ link)
References: <58C3F064.4060904@tlinx.org> <0b737f79-ed0d-53f0-bbf7-2b4e44be7543@gmx.com>
In-Reply-To: <0b737f79-ed0d-53f0-bbf7-2b4e44be7543@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

J William Piggott wrote:
> On 03/11/2017 07:41 AM, L A Walsh wrote:
>   
>> I thought 'configure' was supposed to test for what was present and
>> what was missing?  Seems to have missed a few... :-(
>>
>> In trying to make new release 2.29.2, I'm getting several undefined
>> symbols:
>>
>> color_fdisable color_scheme_fenable color_sequence_from_colorname
>> colormode_or_err colors_init get_fd_tabsize get_terminal_name
>> initproctitle pager_redirect parse_kmsg_recordsetproctitle 
>> plymouth_command string_to_bitarray strnchr strtimeval_iso
>> strtos32_or_err strtou32_or_err unhexmangle_to_buffer
>>     
>
> These are all in util-linux/src/include/*.h
> Where did you get your util-linux source from?
>   
----
    
https://www.kernel.org/pub/linux/utils/util-linux/v2.29/util-linux-2.29.2.tar.xz

----
    The build had use the include files in that directory, or they
wouldn't have compiled, but the link phase must be missing output
from that directory.   This is one of the links that
emits the error:

libtool: link: /usr/bin/gcc -std=gnu99 -fsigned-char -fno-common -Wall 
-Werror=sequence-point -Wextra -Wmissing-declarations 
-Wmissing-parameter-type -Wmissing-prototypes 
-Wno-missing-field-initializers -Wredundant-decls -Wsign-compare 
-Wtype-limits -Wuninitialized -Wunused-but-set-parameter 
-Wunused-but-set-variable -Wunused-parameter -Wunused-result 
-Wunused-variable -Wnested-externs -Wpointer-arith -Wstrict-prototypes 
-Wimplicit-function-declaration -m64 -march=native -pipe -O2 
-fasynchronous-unwind-tables -fbranch-target-load-optimize 
-fdelete-null-pointer-checks -fgcse-after-reload -fgcse-las -fgcse-sm 
-fgraphite-identity -finline-functions -fipa-pta -fivopts -floop-block 
-floop-flatten -floop-interchange -floop-strip-mine -fmessage-length=0 
-fpredictive-commoning -frename-registers -freorder-blocks-and-partition 
-ftracer -fsched-stalled-insns=1 -fsched-stalled-insns-dep=1 
-ftree-loop-linear -ftree-loop-distribution 
-ftree-loop-distribute-patterns -ftree-loop-im -ftree-loop-ivcanon 
-ftree-partial-pre -ftree-vectorize -ftree-slp-vectorize 
-funswitch-loops -funwind-tables -fvariable-expansion-in-unroller 
-fvect-cost-model -fweb -flto -Og -g3 -ggdb -m64 -march=native -pipe -O2 
-fasynchronous-unwind-tables -fbranch-target-load-optimize 
-fdelete-null-pointer-checks -fgcse-after-reload -fgcse-las -fgcse-sm 
-fgraphite-identity -finline-functions -fipa-pta -fivopts -floop-block 
-floop-flatten -floop-interchange -floop-strip-mine -fmessage-length=0 
-fpredictive-commoning -frename-registers -freorder-blocks-and-partition 
-ftracer -fsched-stalled-insns=1 -fsched-stalled-insns-dep=1 
-ftree-loop-linear -ftree-loop-distribution 
-ftree-loop-distribute-patterns -ftree-loop-im -ftree-loop-ivcanon 
-ftree-partial-pre -ftree-vectorize -ftree-slp-vectorize 
-funswitch-loops -funwind-tables -fvariable-expansion-in-unroller 
-fvect-cost-model -fweb -flto -Og -g3 -ggdb -o login login-utils/login.o 
login-utils/logindefs.o  ./.libs/libcommon.a -lpam -lpam_misc -laudit
/tmp/ccTKupap.ltrans0.ltrans.o: In function `init_tty':
/home/tools/util-linux/util-linux-2.29.2/login-utils/login.c:360: 
undefined reference to `get_terminal_name'
/tmp/ccTKupap.ltrans0.ltrans.o: In function `main':
/home/tools/util-linux/util-linux-2.29.2/login-utils/login.c:1153: 
undefined reference to `initproctitle'
/home/tools/util-linux/util-linux-2.29.2/login-utils/login.c:1207: 
undefined reference to `get_fd_tabsize'
/home/tools/util-linux/util-linux-2.29.2/login-utils/login.c:1288: 
undefined reference to `setproctitle'
collect2: error: ld returned 1 exit status
Makefile:6042: recipe for target 'login' failed
make[2]: *** [login] Error 1
make[2]: Leaving directory '/home/tools/util-linux/util-linux-2.29.2'
Makefile:11443: recipe for target 'all-recursive' failed
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory '/home/tools/util-linux/util-linux-2.29.2'
Makefile:4774: recipe for target 'all' failed
make: *** [all] Error 2


--------

Should there be a -L.libs/ in the above?

