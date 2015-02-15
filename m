Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f179.google.com ([209.85.214.179]:36478 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241AbbBOVUY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 Feb 2015 16:20:24 -0500
Received: by mail-ob0-f179.google.com with SMTP id wp4so36405259obc.10
        for <util-linux@vger.kernel.org>; Sun, 15 Feb 2015 13:20:24 -0800 (PST)
Message-ID: <54E10D95.2030100@gmail.com>
Date: Sun, 15 Feb 2015 15:20:21 -0600
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>, Karel Zak <kzak@redhat.com>
CC: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [ANNOUNCE] util-linux v2.26-rc2
References: <20150204115353.GC1238@ws.net.home> <1424030549.2886406.227807181.7F9CF45A@webmail.messagingengine.com>
In-Reply-To: <1424030549.2886406.227807181.7F9CF45A@webmail.messagingengine.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Benno Schulenberg wrote:
>
> Running 'make check' here reports the following failures:
>
>            cal: Year 2147483646                ...  FAILED (cal/bigyear)
>          blkid: low-level superblocks probing  ...
>                  : ext3                        ...  OK
>            cal: Year 2147483646 with week numbers ...  FAILED (cal/bigyearw)
>
> ipcs: id 917526 not found
> ipcs: id 950294 not found
>           ipcs: mk-rm-shm                      ...  FAILED (ipcs/mk-rm-shm)
>
>           misc: fallocate                      ...  FAILED (misc/fallocate)
>
>           misc: getopt2                        ...
>                  : long_option_ambiguous_1     ...  FAILED (misc/getopt2-long_option_ambiguous_1)
>
>           misc: getopt2                        ...
>                  : quiet_output_option_long    ...  FAILED (misc/getopt2-quiet_output_option_long)
>           misc: getopt2                        ...
>                  : quiet_output_option_short   ...  FAILED (misc/getopt2-quiet_output_option_short)
>
>           misc: getopt2                        ...
>                  : weird_quoting_tcsh          ...  OK
>             ...         misc: getopt2                        ...
>                  : weird_quoting_tcsh          ...  FAILED (3 from 23 sub-tests)
>
>
>           misc: swaplabel                      ...  FAILED (misc/swaplabel)
>           misc: ul                             ...  FAILED (misc/ul)
>
> ---------------------------------------------------------------------
>    7 tests of 155 FAILED
> ---------------------------------------------------------------------
>
>
> When there are subtests, something goes wrong in the alignment and
> in the messages of the summary line.  For example:
>
>
>           misc: getopt3                        ...
>                  : non-option                  ...  OK
>             ...         misc: getopt3                        ...
>                  : non-option                  ...  OK (all 6 sub-tests PASSED)
>
>
> Also, the complete testsuite summary is printed before the tests
> are even run, which I find odd:
>
> ============================================================================
> Testsuite summary for util-linux 2.26-rc2
> ============================================================================
> # TOTAL: 0
> # PASS:  0
> # SKIP:  0
> # XFAIL: 0
> # FAIL:  0
> # XPASS: 0
> # ERROR: 0
> ============================================================================

This only seems to be before the actual tests and is meaningless.  The only 
thing that is really meaningful is the line at the end,  In my case:

---------------------------------------------------------------------
   2 tests of 155 FAILED
---------------------------------------------------------------------

I only has the following failures:

cal: Year 2147483646                   ...  FAILED (cal/bigyear)
cal: Year 2147483646 with week numbers ...  FAILED (cal/bigyearw)

The others passed for me:

hwclock: system to hw                   ...  IGNORE (not root permissions)
    ipcs: headers                        ...  OK
    ipcs: limits overflow                ...  IGNORE (not root permissions)
    ipcs: basic limits                   ...  OK
    ipcs: mk-rm-msg                      ...  OK
    ipcs: mk-rm-sem                      ...  OK
    ipcs: mk-rm-shm                      ...  OK

misc: fallocate                      ...  IGNORE ('ext3' not supported)

   Perhaps this is something special about ubuntu, because I think
   ext3 does not support fallocate by default.

misc: getopt2                        ...
        : long_option_ambiguous_1     ...  OK

misc: getopt2                        ...
        : quiet_output_option_long    ...  OK

misc: getopt2                        ...
        : quiet_output_option_short   ...  OK

misc: getopt2                        ...
        : weird_quoting_tcsh          ...  OK
   ...         misc: getopt2                        ...
        : weird_quoting_tcsh          ...  OK (all 23 sub-tests PASSED)

misc: swaplabel                      ...  OK
misc: ul                             ...  OK

> $ gcc --version | head -1
> gcc (Ubuntu 4.4.3-4ubuntu5.1) 4.4.3
>
> $ uname -rvm
> 2.6.32-72-generic #139-Ubuntu SMP Wed Jan 14 21:19:14 UTC 2015 i686

$  gcc --version | head -1
gcc (GCC) 4.7.0

$ uname -a
Linux lfs6 3.4.1-LFS-4 #2 SMP PREEMPT Thu Oct 9 23:02:58 CDT 2014 i686 GNU/Linux

Note: On x86_64, linux-3.18.3, and gcc-4.9.2, all tests either passed or were 
ignored for me.

   -- Bruce

