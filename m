Return-Path: bensberg@justemail.net
Message-Id: <1424030549.2886406.227807181.7F9CF45A@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [ANNOUNCE] util-linux v2.26-rc2
Date: Sun, 15 Feb 2015 21:02:29 +0100
In-Reply-To: <20150204115353.GC1238@ws.net.home>
References: <20150204115353.GC1238@ws.net.home>
List-ID: <util-linux.vger.kernel.org>


Running 'make check' here reports the following failures:

          cal: Year 2147483646                ...  FAILED (cal/bigyear)
        blkid: low-level superblocks probing  ...
                : ext3                        ...  OK
          cal: Year 2147483646 with week numbers ...  FAILED (cal/bigyearw)

ipcs: id 917526 not found
ipcs: id 950294 not found
         ipcs: mk-rm-shm                      ...  FAILED (ipcs/mk-rm-shm)

         misc: fallocate                      ...  FAILED (misc/fallocate)

         misc: getopt2                        ...
                : long_option_ambiguous_1     ...  FAILED (misc/getopt2-long_option_ambiguous_1)

         misc: getopt2                        ...
                : quiet_output_option_long    ...  FAILED (misc/getopt2-quiet_output_option_long)
         misc: getopt2                        ...
                : quiet_output_option_short   ...  FAILED (misc/getopt2-quiet_output_option_short)

         misc: getopt2                        ...
                : weird_quoting_tcsh          ...  OK
           ...         misc: getopt2                        ...
                : weird_quoting_tcsh          ...  FAILED (3 from 23 sub-tests)


         misc: swaplabel                      ...  FAILED (misc/swaplabel)
         misc: ul                             ...  FAILED (misc/ul)

---------------------------------------------------------------------
  7 tests of 155 FAILED
---------------------------------------------------------------------


When there are subtests, something goes wrong in the alignment and
in the messages of the summary line.  For example:


         misc: getopt3                        ...
                : non-option                  ...  OK
           ...         misc: getopt3                        ...
                : non-option                  ...  OK (all 6 sub-tests PASSED)


Also, the complete testsuite summary is printed before the tests
are even run, which I find odd:

============================================================================
Testsuite summary for util-linux 2.26-rc2
============================================================================
# TOTAL: 0
# PASS:  0
# SKIP:  0
# XFAIL: 0
# FAIL:  0
# XPASS: 0
# ERROR: 0
============================================================================


$ gcc --version | head -1
gcc (Ubuntu 4.4.3-4ubuntu5.1) 4.4.3

$ uname -rvm
2.6.32-72-generic #139-Ubuntu SMP Wed Jan 14 21:19:14 UTC 2015 i686

Benno

-- 
http://www.fastmail.com - Choose from over 50 domains or use your own
