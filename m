Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:57287 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932231AbbBOUuN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 15 Feb 2015 15:50:13 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Benno Schulenberg <bensberg@justemail.net>
Subject: Re: [ANNOUNCE] util-linux v2.26-rc2
Date: Sun, 15 Feb 2015 21:50:03 +0100
Cc: Karel Zak <kzak@redhat.com>, "Util-Linux" <util-linux@vger.kernel.org>
References: <20150204115353.GC1238@ws.net.home> <1424030549.2886406.227807181.7F9CF45A@webmail.messagingengine.com>
In-Reply-To: <1424030549.2886406.227807181.7F9CF45A@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201502152150.03592.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On Sunday 15 February 2015, Benno Schulenberg wrote:
> Running 'make check' here reports the following failures:

A few of them might be fixed already in latest HEAD.

And could you please also show us the test diffs:
$ find tests/diff/ -type f | xargs -r cat  

>
>           cal: Year 2147483646                ...  FAILED
> (cal/bigyear) blkid: low-level superblocks probing  ...
>
>                 : ext3                        ...  OK
>
>           cal: Year 2147483646 with week numbers ...  FAILED
> (cal/bigyearw)
>
> ipcs: id 917526 not found
> ipcs: id 950294 not found
>          ipcs: mk-rm-shm                      ...  FAILED
> (ipcs/mk-rm-shm)
>
>          misc: fallocate                      ...  FAILED
> (misc/fallocate)
>
>          misc: getopt2                        ...
>
>                 : long_option_ambiguous_1     ...  FAILED
>                 : (misc/getopt2-long_option_ambiguous_1)
>
>          misc: getopt2                        ...
>
>                 : quiet_output_option_long    ...  FAILED
>                 : (misc/getopt2-quiet_output_option_long)
>
>          misc: getopt2                        ...
>
>                 : quiet_output_option_short   ...  FAILED
>                 : (misc/getopt2-quiet_output_option_short)
>
>          misc: getopt2                        ...
>
>                 : weird_quoting_tcsh          ...  OK
>
>            ...         misc: getopt2                        ...
>
>                 : weird_quoting_tcsh          ...  FAILED (3 from 23
>                 : sub-tests)
>
>          misc: swaplabel                      ...  FAILED
> (misc/swaplabel) misc: ul                             ...  FAILED
> (misc/ul)
>
> ---------------------------------------------------------------------
>   7 tests of 155 FAILED
> ---------------------------------------------------------------------
>
>
> When there are subtests, something goes wrong in the alignment and
> in the messages of the summary line.  For example:
>
>
>          misc: getopt3                        ...
>
>                 : non-option                  ...  OK
>
>            ...         misc: getopt3                        ...
>
>                 : non-option                  ...  OK (all 6
>                 : sub-tests PASSED)
>
> Also, the complete testsuite summary is printed before the tests
> are even run, which I find odd:
>
> =====================================================================
>======= Testsuite summary for util-linux 2.26-rc2
> =====================================================================
>======= # TOTAL: 0
> # PASS:  0
> # SKIP:  0
> # XFAIL: 0
> # FAIL:  0
> # XPASS: 0
> # ERROR: 0
> =====================================================================
>=======
>
>
> $ gcc --version | head -1
> gcc (Ubuntu 4.4.3-4ubuntu5.1) 4.4.3
>
> $ uname -rvm
> 2.6.32-72-generic #139-Ubuntu SMP Wed Jan 14 21:19:14 UTC 2015 i686
>
> Benno
