Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Ckv/uPes"
Received: from mail-yw1-x1162.google.com (mail-yw1-x1162.google.com [IPv6:2607:f8b0:4864:20::1162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED6612E
	for <util-linux@vger.kernel.org>; Sat,  9 Dec 2023 14:20:24 -0800 (PST)
Received: by mail-yw1-x1162.google.com with SMTP id 00721157ae682-5cece20f006so31651987b3.3
        for <util-linux@vger.kernel.org>; Sat, 09 Dec 2023 14:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702160423; x=1702765223;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSg11rMy0wkZIhYlSshNqMkml+h2bB0CJb+5bo0oQc4=;
        b=quXCFJ6pWeJ+atiZNnki7Yj7XKgk8QdeRtRU06XN2sQmPaavXGxt7dr1WI8g0RL4sB
         Rwj8y3qHIWaEH7WTwLjYU1sGzPDqwrD8/SzMxNuNOOugGSkVjEIUhnvDdZ6sgWGxaqZt
         A4BSU/key3NgUlMOryi2URbzG3Susk+D8KMbZ2Hq0WKZG6Niti5OJ2AJhpvDVjod/m6k
         2eqCwgozBF3171XISySA2oQHiE5OD4cb5UqjDf4s1S6f35BrU+Fu4z7sGN0RNwUUiYDE
         3outlqsuD6DctHGRexyOCJNae1DAeud3RGx96Obe9QC+63LYy8gJ8+SpFHkXkUl5vOz4
         8THA==
X-Gm-Message-State: AOJu0YxnyXOZzMydVIci1zUREs540uy/7PNNVrB7nj36PlOj/r3MbCOg
	ytnHhfmnEh8hqGzcPJlw6u/4rkaGWEeYlB/M+9qNRlgaGdPitF4kw7L2
X-Google-Smtp-Source: AGHT+IFmlFFSwuk8f9rSaA6Pg5BOPnXwKBT/1qDshbYzTzwnO0FUx41R3DFQbC4SI/Eo5oLvgU7HmJXUuYDp
X-Received: by 2002:a81:8046:0:b0:5d7:1940:f3d9 with SMTP id q67-20020a818046000000b005d71940f3d9mr1841611ywf.65.1702160423430;
        Sat, 09 Dec 2023 14:20:23 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id t21-20020a0dea15000000b005d37a7cb378sm467099ywe.21.2023.12.09.14.20.23
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Dec 2023 14:20:23 -0800 (PST)
X-Relaying-Domain: arista.com
Received: from us113.sjc.aristanetworks.com (us113.sjc.aristanetworks.com [10.242.240.8])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 81D25402056;
	Sat,  9 Dec 2023 14:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1702160422;
	bh=bSg11rMy0wkZIhYlSshNqMkml+h2bB0CJb+5bo0oQc4=;
	h=From:To:Cc:Subject:Date:From;
	b=Ckv/uPesCtZwj7cs3NrHPa4OoOUQpa1eD9j73pHTKT+7f5c8sF9cl7Y/JYHvnHJDD
	 HIW0HPztv6JpKgyUZlt7gYcIHLLuz8P1mgjhejKJ8QpKO1fwVA+k0PGrBCudaVIwYw
	 QxFTeyl7eFcfz2ISc0A2vVhdmOmCKu3ZgYKyAMoV/vu7r9SLInwtPpCZAzFRWs6Pvh
	 4vR6GCmvBGrlLcfoyuEazrMjRLvKBryCm/ZW/2r6McedWlzHuARQaaFwzQxGe1o+pq
	 Br8etTLb3ftruODuxc5IXgp40LTj+Fhz36ebuy/ci0TBMU7/a7wRoOhktFFQpGx7+d
	 mUpPh4GmzF7aQ==
Received: by us113.sjc.aristanetworks.com (Postfix, from userid 10383)
	id 75B27B840616; Sat,  9 Dec 2023 14:20:22 -0800 (PST)
From: Edward Chron <echron@arista.com>
To: util-linux@vger.kernel.org
Cc: colona@arista.com,
	echron@arista.com
Subject: [PATCH] Add dmesg syslog interface tests for PRINTK_CALLER field
Date: Sat,  9 Dec 2023 14:20:19 -0800
Message-ID: <20231209222019.954-1-echron@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>

Submission to Project: util-linux
Open Incident: #2637 at github.com/util-linux/util-linux/issues/2637
Component: util-linux/sys-utils
File: dmesg.c
Code level patch applied against: https://github.com/t-8ch/util-linux/
     and we used his local-dmesg-tests from t8ch/dmesg/tests
     as we needed the numerous improvements and fixes that Thomas has
     made to the code.

With Issue 2609 support is being added for the optional PRINTK_CALLER
dmesg field that is produced by the Linux Kernel when the PRINTK_CALLER
config option is set. This patch addresses testing issue with the SYSLOG
interface when used on Linux Kernels with the PRINTK_CALLER config
option set.

Since these tests are for dmesg SYSLOG interface we are submitting
in a separate issue to not conflate with the tests we will be submitting
for the dmesg kmsg (standard) interface.

Currently dmesg -S, the syslog interface, to dmesg already supports this
optional field and produces output that includes the PRINTK_CALLER field.

So on a Linux system with the PRINTK_CALLER configuration option set the
output looks like:

    [  520.899558] [   T3919] hub 3-3:1.0: USB hub found

on a system where the PRINTK_CALLER configuration option is not set the
output looks like:

    [  520.899558] hub 3-3:1.0: USB hub found

the additional field specifies either a Thread Id or CPU id depending on
the context of the task or thread at the time the printk that added the
message to the kernel ring buffer was executed.

The code submitted with Issue 2609 adds support for the optional
PRINTK_CALLER field for the standard /dev/ksmg dmesg interface.

Karel and Thomas pointed out that we need to add appropriate tests
for the dmesg package, so tests need to be added to the Issue 2609
submission to support PRINTK_CALLER field with the /dev/kmsg interface.

However, we noticed that though the PRINTK_CALLER optional field is
supported by the dmesg syslog interface there are no tests for that
existing facility.

It was pointed that we really need tests for both dmesg interaces, the
dmesg syslog interface which we address here and the dmesg /dev/kmsg
interface that we address in Issue 2609.

It is desirable to have tests for both dmesg interfaces since they
exercise slightly different paths in the dmesg code.

So we provide tests here specifically for dmesg syslog interface when
the Linux Kernel has PRINTK_CALLER field enabled.

We make copies of the existing tests/ts/dmesg tests and tailor them to
test with input that includes the optional PRINTK_CALLER field and output
that expects that PRINTK_CALLER optional field will be included.

By providing all the syslog-printk-caller versions of all the tests
we ensure the same thorough testing of the dmesg syslog interface.

For tests using the dmesg syslog interface we use the -F interface to
produce reliable testing results just as the existing dmesg tests do.
The -F interface is specific only to the syslog interface but that is
what we are testing here.

Note that using the -F interface means that the system executing the tests
does not need to have the PRINTK_CALLER interface to do the testing. The
files provide the correct format which is very convenient.

Testing occurred on a Fedora 39 System:

[echron@terramar util-linux]$ uname -a
Linux terramar 6.6.4-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC
      Sun Dec  3 18:13:11 UTC 2023 x86_64 GNU/Linux

[echron@terramar util-linux]$ cat /etc/fedora-release
Fedora release 39 (Thirty Nine)

The version of util-linux was from the git repository with a pull on
2023/12/09 at 10:00 AM

----------------------------
Please Note - Very Important:
----------------------------
In testing we realized we needed some fixes that we know Thomas just
added so we did a remote add of https://github.com/t-8ch/util-linux/
and we used his local-dmesg-tests t8ch/dmesg/tests

Picking up Thomas's fixes resolved the problems we were seeing with
several of our tests.

*** Please test and merge this code with Thomas's project:
     t8ch/dmesg/tests

[echron@terramar util-linux]$ ./test_dmesg -V
test_dmesg from util-linux 2.39.1003-6b081

We did the recommended make check-programs before running our programs.

Tests include syslog-printk-caller versions of all existing tests:

-------------------- util-linux regression tests --------------------

                    For development purpose only.
                 Don't execute on production system!

       kernel: 6.6.4-200.fc39.x86_64

      options: --srcdir=/usr/src/util-linux/pending/util-linux/tests/.. \
               --builddir=/usr/src/util-linux/pending/util-linux/tests/..

        dmesg: colors                         ... OK
        dmesg: colors-syslog-prtk-caller      ... OK
        dmesg: levels                         ... OK
        dmesg: levels-syslog-prtk-caller      ... OK
        dmesg: decode                         ... OK
        dmesg: decode-syslog-prtk-caller      ... OK
        dmesg: delta                          ... OK
        dmesg: delta-syslog-prtk-caller       ... OK
        dmesg: facilities                     ... OK
        dmesg: facilities-syslog-prtk-caller  ... OK
        dmesg: indentation                    ... OK
        dmesg: indent-syslog-printk-caller    ... OK
        dmesg: limit                          ... OK
        dmesg: limit-syslog-prtk-caller       ... OK

Signed-off-by: Ivan Delalande <colona@arista.com>
Signed-off-by: Edward Chron <echron@arista.com>
---
 .../dmesg/colors-syslog-printk-caller         | 105 +++++++++++++
 .../dmesg/console-levels-syslog-printk-caller | 146 ++++++++++++++++++
 .../dmesg/decode-syslog-printk-caller         | 105 +++++++++++++
 .../expected/dmesg/delta-syslog-printk-caller | 105 +++++++++++++
 .../dmesg/facilities-syslog-printk-caller     | 104 +++++++++++++
 .../dmesg/indentation-syslog-printk-caller    |  35 +++++
 .../expected/dmesg/limit-syslog-printk-caller |   4 +
 tests/ts/dmesg/colors-syslog-printk-caller    |  29 ++++
 .../dmesg/console-levels-syslog-printk-caller |  36 +++++
 tests/ts/dmesg/decode-syslog-printk-caller    |  28 ++++
 tests/ts/dmesg/delta-syslog-printk-caller     |  28 ++++
 .../ts/dmesg/facilities-syslog-printk-caller  |  30 ++++
 .../ts/dmesg/indentation-syslog-printk-caller |  40 +++++
 tests/ts/dmesg/input-syslog-printk-caller     | 105 +++++++++++++
 tests/ts/dmesg/limit-syslog-printk-caller     |  29 ++++
 tests/ts/dmesg/newlines-syslog-printk-caller  |   5 +
 16 files changed, 934 insertions(+)
 create mode 100644 tests/expected/dmesg/colors-syslog-printk-caller
 create mode 100644 tests/expected/dmesg/console-levels-syslog-printk-caller
 create mode 100644 tests/expected/dmesg/decode-syslog-printk-caller
 create mode 100644 tests/expected/dmesg/delta-syslog-printk-caller
 create mode 100644 tests/expected/dmesg/facilities-syslog-printk-caller
 create mode 100644 tests/expected/dmesg/indentation-syslog-printk-caller
 create mode 100644 tests/expected/dmesg/limit-syslog-printk-caller
 create mode 100755 tests/ts/dmesg/colors-syslog-printk-caller
 create mode 100755 tests/ts/dmesg/console-levels-syslog-printk-caller
 create mode 100755 tests/ts/dmesg/decode-syslog-printk-caller
 create mode 100755 tests/ts/dmesg/delta-syslog-printk-caller
 create mode 100755 tests/ts/dmesg/facilities-syslog-printk-caller
 create mode 100755 tests/ts/dmesg/indentation-syslog-printk-caller
 create mode 100644 tests/ts/dmesg/input-syslog-printk-caller
 create mode 100755 tests/ts/dmesg/limit-syslog-printk-caller
 create mode 100644 tests/ts/dmesg/newlines-syslog-printk-caller

diff --git a/tests/expected/dmesg/colors-syslog-printk-caller b/tests/expected/dmesg/colors-syslog-printk-caller
new file mode 100644
index 000000000..f06eb2313
--- /dev/null
+++ b/tests/expected/dmesg/colors-syslog-printk-caller
@@ -0,0 +1,105 @@
+kern  :emerg : [32m[    0.000000] [0m[    T0] example[0]
+kern  :alert : [32m[    1.000000] [0m[7m[31m[    T1] example[1][0m
+kern  :crit  : [32m[    8.000000] [0m[1m[31m[    T2] example[2][0m
+kern  :err   : [32m[   27.000000] [0m[31m[    T3] example[3][0m
+kern  :warn  : [32m[   64.000000] [0m[1m[    T4] example[4][0m
+kern  :notice: [32m[  125.000000] [0m[    T5] example[5]
+kern  :info  : [32m[  216.000000] [0m[    T6] example[6]
+kern  :debug : [32m[  343.000000] [0m[    T7] example[7]
+user  :emerg : [32m[  512.000000] [0m[    T8] example[8]
+user  :alert : [32m[  729.000000] [0m[7m[31m[    T9] example[9][0m
+user  :crit  : [32m[ 1000.000000] [0m[1m[31m[   T10] example[10][0m
+user  :err   : [32m[ 1331.000000] [0m[31m[   T11] example[11][0m
+user  :warn  : [32m[ 1728.000000] [0m[1m[   T12] example[12][0m
+user  :notice: [32m[ 2197.000000] [0m[   T13] example[13]
+user  :info  : [32m[ 2744.000000] [0m[   T14] example[14]
+user  :debug : [32m[ 3375.000000] [0m[   T15] example[15]
+mail  :emerg : [32m[ 4096.000000] [0m[   T16] example[16]
+mail  :alert : [32m[ 4913.000000] [0m[7m[31m[   T17] example[17][0m
+mail  :crit  : [32m[ 5832.000000] [0m[1m[31m[   T18] example[18][0m
+mail  :err   : [32m[ 6859.000000] [0m[31m[   T19] example[19][0m
+mail  :warn  : [32m[ 8000.000000] [0m[1m[   T20] example[20][0m
+mail  :notice: [32m[ 9261.000000] [0m[   T21] example[21]
+mail  :info  : [32m[10648.000000] [0m[   T22] example[22]
+mail  :debug : [32m[12167.000000] [0m[   T23] example[23]
+daemon:emerg : [32m[13824.000000] [0m[   T24] example[24]
+daemon:alert : [32m[15625.000000] [0m[7m[31m[   T25] example[25][0m
+daemon:crit  : [32m[17576.000000] [0m[1m[31m[   T26] example[26][0m
+daemon:err   : [32m[19683.000000] [0m[31m[   T27] example[27][0m
+daemon:warn  : [32m[21952.000000] [0m[1m[   T28] example[28][0m
+daemon:notice: [32m[24389.000000] [0m[   T29] example[29]
+daemon:info  : [32m[27000.000000] [0m[   T10] example[30]
+daemon:debug : [32m[29791.000000] [0m[   T31] example[31]
+auth  :emerg : [32m[32768.000000] [0m[   T32] example[32]
+auth  :alert : [32m[35937.000000] [0m[7m[31m[   T33] example[33][0m
+auth  :crit  : [32m[39304.000000] [0m[1m[31m[   T34] example[34][0m
+auth  :err   : [32m[42875.000000] [0m[31m[   T35] example[35][0m
+auth  :warn  : [32m[46656.000000] [0m[1m[   T36] example[36][0m
+auth  :notice: [32m[50653.000000] [0m[   T37] example[37]
+auth  :info  : [32m[54872.000000] [0m[   T38] example[38]
+auth  :debug : [32m[59319.000000] [0m[   T39] example[39]
+syslog:emerg : [32m[64000.000000] [0m[   T40] example[40]
+syslog:alert : [32m[68921.000000] [0m[7m[31m[   T41] example[41][0m
+syslog:crit  : [32m[74088.000000] [0m[1m[31m[   T42] example[42][0m
+syslog:err   : [32m[79507.000000] [0m[31m[   T43] example[43][0m
+syslog:warn  : [32m[85184.000000] [0m[1m[   T44] example[44][0m
+syslog:notice: [32m[91125.000000] [0m[   T45] example[45]
+syslog:info  : [32m[97336.000000] [0m[   T46] example[46]
+syslog:debug : [32m[103823.000000] [0m[   T47] example[47]
+lpr   :emerg : [32m[110592.000000] [0m[   T48] example[48]
+lpr   :alert : [32m[117649.000000] [0m[7m[31m[   T49] example[49][0m
+lpr   :crit  : [32m[125000.000000] [0m[1m[31m[   T50] example[50][0m
+lpr   :err   : [32m[132651.000000] [0m[31m[   T51] example[51][0m
+lpr   :warn  : [32m[140608.000000] [0m[1m[   T52] example[52][0m
+lpr   :notice: [32m[148877.000000] [0m[   T53] example[53]
+lpr   :info  : [32m[157464.000000] [0m[   T54] example[54]
+lpr   :debug : [32m[166375.000000] [0m[   T55] example[55]
+news  :emerg : [32m[175616.000000] [0m[   T56] example[56]
+news  :alert : [32m[185193.000000] [0m[7m[31m[   T57] example[57][0m
+news  :crit  : [32m[195112.000000] [0m[1m[31m[   T58] example[58][0m
+news  :err   : [32m[205379.000000] [0m[31m[   T59] example[59][0m
+news  :warn  : [32m[216000.000000] [0m[1m[   T60] example[60][0m
+news  :notice: [32m[226981.000000] [0m[   T61] example[61]
+news  :info  : [32m[238328.000000] [0m[   T62] example[62]
+news  :debug : [32m[250047.000000] [0m[   T63] example[63]
+uucp  :emerg : [32m[262144.000000] [0m[   T64] example[64]
+uucp  :alert : [32m[274625.000000] [0m[7m[31m[   T65] example[65][0m
+uucp  :crit  : [32m[287496.000000] [0m[1m[31m[   T66] example[66][0m
+uucp  :err   : [32m[300763.000000] [0m[31m[   T67] example[67][0m
+uucp  :warn  : [32m[314432.000000] [0m[1m[   T68] example[68][0m
+uucp  :notice: [32m[328509.000000] [0m[   T69] example[69]
+uucp  :info  : [32m[343000.000000] [0m[   T70] example[70]
+uucp  :debug : [32m[357911.000000] [0m[   T71] example[71]
+cron  :emerg : [32m[373248.000000] [0m[   T72] example[72]
+cron  :alert : [32m[389017.000000] [0m[7m[31m[   T73] example[73][0m
+cron  :crit  : [32m[405224.000000] [0m[1m[31m[   T74] example[74][0m
+cron  :err   : [32m[421875.000000] [0m[31m[   T75] example[75][0m
+cron  :warn  : [32m[438976.000000] [0m[1m[   T76] example[76][0m
+cron  :notice: [32m[456533.000000] [0m[   T77] example[77]
+cron  :info  : [32m[474552.000000] [0m[   T78] example[78]
+cron  :debug : [32m[493039.000000] [0m[   T79] example[79]
+authpriv:emerg : [32m[512000.000000] [0m[   T80] example[80]
+authpriv:alert : [32m[531441.000000] [0m[7m[31m[   T81] example[81][0m
+authpriv:crit  : [32m[551368.000000] [0m[1m[31m[   T82] example[82][0m
+authpriv:err   : [32m[571787.000000] [0m[31m[   T83] example[83][0m
+authpriv:warn  : [32m[592704.000000] [0m[1m[   T84] example[84][0m
+authpriv:notice: [32m[614125.000000] [0m[   T85] example[85]
+authpriv:info  : [32m[636056.000000] [0m[   T86] example[86]
+authpriv:debug : [32m[658503.000000] [0m[   T87] example[87]
+ftp   :emerg : [32m[681472.000000] [0m[   T88] example[88]
+ftp   :alert : [32m[704969.000000] [0m[7m[31m[   T89] example[89][0m
+ftp   :crit  : [32m[729000.000000] [0m[1m[31m[   T90] example[90][0m
+ftp   :err   : [32m[753571.000000] [0m[31m[   T91] example[91][0m
+ftp   :warn  : [32m[778688.000000] [0m[1m[   T92] example[92][0m
+ftp   :notice: [32m[804357.000000] [0m[   T93] example[93]
+ftp   :info  : [32m[830584.000000] [0m[   T94] example[94]
+ftp   :debug : [32m[857375.000000] [0m[   T95] example[95]
+res0  :emerg : [32m[884736.000000] [0m[   T96] example[96]
+res0  :alert : [32m[912673.000000] [0m[7m[31m[   T97] example[97][0m
+res0  :crit  : [32m[941192.000000] [0m[1m[31m[   T98] example[98][0m
+res0  :err   : [32m[970299.000000] [0m[31m[   T99] example[99][0m
+res0  :warn  : [32m[1000000.000000] [0m[1m[  T100] example[100][0m
+res0  :notice: [32m[1030301.000000] [0m[  T101] example[101]
+res0  :info  : [32m[1061208.000000] [0m[  T102] example[102]
+res0  :debug : [32m[1092727.000000] [0m[  T103] example[103]
+res1  :emerg : [32m[1124864.000000] [0m[  T104] example[104]
diff --git a/tests/expected/dmesg/console-levels-syslog-printk-caller b/tests/expected/dmesg/console-levels-syslog-printk-caller
new file mode 100644
index 000000000..625a6d55c
--- /dev/null
+++ b/tests/expected/dmesg/console-levels-syslog-printk-caller
@@ -0,0 +1,146 @@
+[    0.000000] [    T0] example[0]
+[    1.000000] [    T1] example[1]
+[    8.000000] [    T2] example[2]
+[   27.000000] [    T3] example[3]
+[  512.000000] [    T8] example[8]
+[  729.000000] [    T9] example[9]
+[ 1000.000000] [   T10] example[10]
+[ 1331.000000] [   T11] example[11]
+[ 4096.000000] [   T16] example[16]
+[ 4913.000000] [   T17] example[17]
+[ 5832.000000] [   T18] example[18]
+[ 6859.000000] [   T19] example[19]
+[13824.000000] [   T24] example[24]
+[15625.000000] [   T25] example[25]
+[17576.000000] [   T26] example[26]
+[19683.000000] [   T27] example[27]
+[32768.000000] [   T32] example[32]
+[35937.000000] [   T33] example[33]
+[39304.000000] [   T34] example[34]
+[42875.000000] [   T35] example[35]
+[64000.000000] [   T40] example[40]
+[68921.000000] [   T41] example[41]
+[74088.000000] [   T42] example[42]
+[79507.000000] [   T43] example[43]
+[110592.000000] [   T48] example[48]
+[117649.000000] [   T49] example[49]
+[125000.000000] [   T50] example[50]
+[132651.000000] [   T51] example[51]
+[175616.000000] [   T56] example[56]
+[185193.000000] [   T57] example[57]
+[195112.000000] [   T58] example[58]
+[205379.000000] [   T59] example[59]
+[262144.000000] [   T64] example[64]
+[274625.000000] [   T65] example[65]
+[287496.000000] [   T66] example[66]
+[300763.000000] [   T67] example[67]
+[373248.000000] [   T72] example[72]
+[389017.000000] [   T73] example[73]
+[405224.000000] [   T74] example[74]
+[421875.000000] [   T75] example[75]
+[512000.000000] [   T80] example[80]
+[531441.000000] [   T81] example[81]
+[551368.000000] [   T82] example[82]
+[571787.000000] [   T83] example[83]
+[681472.000000] [   T88] example[88]
+[704969.000000] [   T89] example[89]
+[729000.000000] [   T90] example[90]
+[753571.000000] [   T91] example[91]
+[884736.000000] [   T96] example[96]
+[912673.000000] [   T97] example[97]
+[941192.000000] [   T98] example[98]
+[970299.000000] [   T99] example[99]
+[1124864.000000] [  T104] example[104]
+[    0.000000] [    T0] example[0]
+[  512.000000] [    T8] example[8]
+[ 4096.000000] [   T16] example[16]
+[13824.000000] [   T24] example[24]
+[32768.000000] [   T32] example[32]
+[64000.000000] [   T40] example[40]
+[110592.000000] [   T48] example[48]
+[175616.000000] [   T56] example[56]
+[262144.000000] [   T64] example[64]
+[373248.000000] [   T72] example[72]
+[512000.000000] [   T80] example[80]
+[681472.000000] [   T88] example[88]
+[884736.000000] [   T96] example[96]
+[1124864.000000] [  T104] example[104]
+[   27.000000] [    T3] example[3]
+[   64.000000] [    T4] example[4]
+[  125.000000] [    T5] example[5]
+[  216.000000] [    T6] example[6]
+[  343.000000] [    T7] example[7]
+[ 1331.000000] [   T11] example[11]
+[ 1728.000000] [   T12] example[12]
+[ 2197.000000] [   T13] example[13]
+[ 2744.000000] [   T14] example[14]
+[ 3375.000000] [   T15] example[15]
+[ 6859.000000] [   T19] example[19]
+[ 8000.000000] [   T20] example[20]
+[ 9261.000000] [   T21] example[21]
+[10648.000000] [   T22] example[22]
+[12167.000000] [   T23] example[23]
+[19683.000000] [   T27] example[27]
+[21952.000000] [   T28] example[28]
+[24389.000000] [   T29] example[29]
+[27000.000000] [   T10] example[30]
+[29791.000000] [   T31] example[31]
+[42875.000000] [   T35] example[35]
+[46656.000000] [   T36] example[36]
+[50653.000000] [   T37] example[37]
+[54872.000000] [   T38] example[38]
+[59319.000000] [   T39] example[39]
+[79507.000000] [   T43] example[43]
+[85184.000000] [   T44] example[44]
+[91125.000000] [   T45] example[45]
+[97336.000000] [   T46] example[46]
+[103823.000000] [   T47] example[47]
+[132651.000000] [   T51] example[51]
+[140608.000000] [   T52] example[52]
+[148877.000000] [   T53] example[53]
+[157464.000000] [   T54] example[54]
+[166375.000000] [   T55] example[55]
+[205379.000000] [   T59] example[59]
+[216000.000000] [   T60] example[60]
+[226981.000000] [   T61] example[61]
+[238328.000000] [   T62] example[62]
+[250047.000000] [   T63] example[63]
+[300763.000000] [   T67] example[67]
+[314432.000000] [   T68] example[68]
+[328509.000000] [   T69] example[69]
+[343000.000000] [   T70] example[70]
+[357911.000000] [   T71] example[71]
+[421875.000000] [   T75] example[75]
+[438976.000000] [   T76] example[76]
+[456533.000000] [   T77] example[77]
+[474552.000000] [   T78] example[78]
+[493039.000000] [   T79] example[79]
+[571787.000000] [   T83] example[83]
+[592704.000000] [   T84] example[84]
+[614125.000000] [   T85] example[85]
+[636056.000000] [   T86] example[86]
+[658503.000000] [   T87] example[87]
+[753571.000000] [   T91] example[91]
+[778688.000000] [   T92] example[92]
+[804357.000000] [   T93] example[93]
+[830584.000000] [   T94] example[94]
+[857375.000000] [   T95] example[95]
+[970299.000000] [   T99] example[99]
+[1000000.000000] [  T100] example[100]
+[1030301.000000] [  T101] example[101]
+[1061208.000000] [  T102] example[102]
+[1092727.000000] [  T103] example[103]
+[  343.000000] [    T7] example[7]
+[ 3375.000000] [   T15] example[15]
+[12167.000000] [   T23] example[23]
+[29791.000000] [   T31] example[31]
+[59319.000000] [   T39] example[39]
+[103823.000000] [   T47] example[47]
+[166375.000000] [   T55] example[55]
+[250047.000000] [   T63] example[63]
+[357911.000000] [   T71] example[71]
+[493039.000000] [   T79] example[79]
+[658503.000000] [   T87] example[87]
+[857375.000000] [   T95] example[95]
+[1092727.000000] [  T103] example[103]
+test_dmesg: unknown level '+'
diff --git a/tests/expected/dmesg/decode-syslog-printk-caller b/tests/expected/dmesg/decode-syslog-printk-caller
new file mode 100644
index 000000000..515726932
--- /dev/null
+++ b/tests/expected/dmesg/decode-syslog-printk-caller
@@ -0,0 +1,105 @@
+kern  :emerg : [    0.000000] [    T0] example[0]
+kern  :alert : [    1.000000] [    T1] example[1]
+kern  :crit  : [    8.000000] [    T2] example[2]
+kern  :err   : [   27.000000] [    T3] example[3]
+kern  :warn  : [   64.000000] [    T4] example[4]
+kern  :notice: [  125.000000] [    T5] example[5]
+kern  :info  : [  216.000000] [    T6] example[6]
+kern  :debug : [  343.000000] [    T7] example[7]
+user  :emerg : [  512.000000] [    T8] example[8]
+user  :alert : [  729.000000] [    T9] example[9]
+user  :crit  : [ 1000.000000] [   T10] example[10]
+user  :err   : [ 1331.000000] [   T11] example[11]
+user  :warn  : [ 1728.000000] [   T12] example[12]
+user  :notice: [ 2197.000000] [   T13] example[13]
+user  :info  : [ 2744.000000] [   T14] example[14]
+user  :debug : [ 3375.000000] [   T15] example[15]
+mail  :emerg : [ 4096.000000] [   T16] example[16]
+mail  :alert : [ 4913.000000] [   T17] example[17]
+mail  :crit  : [ 5832.000000] [   T18] example[18]
+mail  :err   : [ 6859.000000] [   T19] example[19]
+mail  :warn  : [ 8000.000000] [   T20] example[20]
+mail  :notice: [ 9261.000000] [   T21] example[21]
+mail  :info  : [10648.000000] [   T22] example[22]
+mail  :debug : [12167.000000] [   T23] example[23]
+daemon:emerg : [13824.000000] [   T24] example[24]
+daemon:alert : [15625.000000] [   T25] example[25]
+daemon:crit  : [17576.000000] [   T26] example[26]
+daemon:err   : [19683.000000] [   T27] example[27]
+daemon:warn  : [21952.000000] [   T28] example[28]
+daemon:notice: [24389.000000] [   T29] example[29]
+daemon:info  : [27000.000000] [   T10] example[30]
+daemon:debug : [29791.000000] [   T31] example[31]
+auth  :emerg : [32768.000000] [   T32] example[32]
+auth  :alert : [35937.000000] [   T33] example[33]
+auth  :crit  : [39304.000000] [   T34] example[34]
+auth  :err   : [42875.000000] [   T35] example[35]
+auth  :warn  : [46656.000000] [   T36] example[36]
+auth  :notice: [50653.000000] [   T37] example[37]
+auth  :info  : [54872.000000] [   T38] example[38]
+auth  :debug : [59319.000000] [   T39] example[39]
+syslog:emerg : [64000.000000] [   T40] example[40]
+syslog:alert : [68921.000000] [   T41] example[41]
+syslog:crit  : [74088.000000] [   T42] example[42]
+syslog:err   : [79507.000000] [   T43] example[43]
+syslog:warn  : [85184.000000] [   T44] example[44]
+syslog:notice: [91125.000000] [   T45] example[45]
+syslog:info  : [97336.000000] [   T46] example[46]
+syslog:debug : [103823.000000] [   T47] example[47]
+lpr   :emerg : [110592.000000] [   T48] example[48]
+lpr   :alert : [117649.000000] [   T49] example[49]
+lpr   :crit  : [125000.000000] [   T50] example[50]
+lpr   :err   : [132651.000000] [   T51] example[51]
+lpr   :warn  : [140608.000000] [   T52] example[52]
+lpr   :notice: [148877.000000] [   T53] example[53]
+lpr   :info  : [157464.000000] [   T54] example[54]
+lpr   :debug : [166375.000000] [   T55] example[55]
+news  :emerg : [175616.000000] [   T56] example[56]
+news  :alert : [185193.000000] [   T57] example[57]
+news  :crit  : [195112.000000] [   T58] example[58]
+news  :err   : [205379.000000] [   T59] example[59]
+news  :warn  : [216000.000000] [   T60] example[60]
+news  :notice: [226981.000000] [   T61] example[61]
+news  :info  : [238328.000000] [   T62] example[62]
+news  :debug : [250047.000000] [   T63] example[63]
+uucp  :emerg : [262144.000000] [   T64] example[64]
+uucp  :alert : [274625.000000] [   T65] example[65]
+uucp  :crit  : [287496.000000] [   T66] example[66]
+uucp  :err   : [300763.000000] [   T67] example[67]
+uucp  :warn  : [314432.000000] [   T68] example[68]
+uucp  :notice: [328509.000000] [   T69] example[69]
+uucp  :info  : [343000.000000] [   T70] example[70]
+uucp  :debug : [357911.000000] [   T71] example[71]
+cron  :emerg : [373248.000000] [   T72] example[72]
+cron  :alert : [389017.000000] [   T73] example[73]
+cron  :crit  : [405224.000000] [   T74] example[74]
+cron  :err   : [421875.000000] [   T75] example[75]
+cron  :warn  : [438976.000000] [   T76] example[76]
+cron  :notice: [456533.000000] [   T77] example[77]
+cron  :info  : [474552.000000] [   T78] example[78]
+cron  :debug : [493039.000000] [   T79] example[79]
+authpriv:emerg : [512000.000000] [   T80] example[80]
+authpriv:alert : [531441.000000] [   T81] example[81]
+authpriv:crit  : [551368.000000] [   T82] example[82]
+authpriv:err   : [571787.000000] [   T83] example[83]
+authpriv:warn  : [592704.000000] [   T84] example[84]
+authpriv:notice: [614125.000000] [   T85] example[85]
+authpriv:info  : [636056.000000] [   T86] example[86]
+authpriv:debug : [658503.000000] [   T87] example[87]
+ftp   :emerg : [681472.000000] [   T88] example[88]
+ftp   :alert : [704969.000000] [   T89] example[89]
+ftp   :crit  : [729000.000000] [   T90] example[90]
+ftp   :err   : [753571.000000] [   T91] example[91]
+ftp   :warn  : [778688.000000] [   T92] example[92]
+ftp   :notice: [804357.000000] [   T93] example[93]
+ftp   :info  : [830584.000000] [   T94] example[94]
+ftp   :debug : [857375.000000] [   T95] example[95]
+res0  :emerg : [884736.000000] [   T96] example[96]
+res0  :alert : [912673.000000] [   T97] example[97]
+res0  :crit  : [941192.000000] [   T98] example[98]
+res0  :err   : [970299.000000] [   T99] example[99]
+res0  :warn  : [1000000.000000] [  T100] example[100]
+res0  :notice: [1030301.000000] [  T101] example[101]
+res0  :info  : [1061208.000000] [  T102] example[102]
+res0  :debug : [1092727.000000] [  T103] example[103]
+res1  :emerg : [1124864.000000] [  T104] example[104]
diff --git a/tests/expected/dmesg/delta-syslog-printk-caller b/tests/expected/dmesg/delta-syslog-printk-caller
new file mode 100644
index 000000000..756edb745
--- /dev/null
+++ b/tests/expected/dmesg/delta-syslog-printk-caller
@@ -0,0 +1,105 @@
+[    0.000000 <    0.000000>] [    T0] example[0]
+[    1.000000 <    0.000000>] [    T1] example[1]
+[    8.000000 <    7.000000>] [    T2] example[2]
+[   27.000000 <   19.000000>] [    T3] example[3]
+[   64.000000 <   37.000000>] [    T4] example[4]
+[  125.000000 <   61.000000>] [    T5] example[5]
+[  216.000000 <   91.000000>] [    T6] example[6]
+[  343.000000 <  127.000000>] [    T7] example[7]
+[  512.000000 <  169.000000>] [    T8] example[8]
+[  729.000000 <  217.000000>] [    T9] example[9]
+[ 1000.000000 <  271.000000>] [   T10] example[10]
+[ 1331.000000 <  331.000000>] [   T11] example[11]
+[ 1728.000000 <  397.000000>] [   T12] example[12]
+[ 2197.000000 <  469.000000>] [   T13] example[13]
+[ 2744.000000 <  547.000000>] [   T14] example[14]
+[ 3375.000000 <  631.000000>] [   T15] example[15]
+[ 4096.000000 <  721.000000>] [   T16] example[16]
+[ 4913.000000 <  817.000000>] [   T17] example[17]
+[ 5832.000000 <  919.000000>] [   T18] example[18]
+[ 6859.000000 < 1027.000000>] [   T19] example[19]
+[ 8000.000000 < 1141.000000>] [   T20] example[20]
+[ 9261.000000 < 1261.000000>] [   T21] example[21]
+[10648.000000 < 1387.000000>] [   T22] example[22]
+[12167.000000 < 1519.000000>] [   T23] example[23]
+[13824.000000 < 1657.000000>] [   T24] example[24]
+[15625.000000 < 1801.000000>] [   T25] example[25]
+[17576.000000 < 1951.000000>] [   T26] example[26]
+[19683.000000 < 2107.000000>] [   T27] example[27]
+[21952.000000 < 2269.000000>] [   T28] example[28]
+[24389.000000 < 2437.000000>] [   T29] example[29]
+[27000.000000 < 2611.000000>] [   T10] example[30]
+[29791.000000 < 2791.000000>] [   T31] example[31]
+[32768.000000 < 2977.000000>] [   T32] example[32]
+[35937.000000 < 3169.000000>] [   T33] example[33]
+[39304.000000 < 3367.000000>] [   T34] example[34]
+[42875.000000 < 3571.000000>] [   T35] example[35]
+[46656.000000 < 3781.000000>] [   T36] example[36]
+[50653.000000 < 3997.000000>] [   T37] example[37]
+[54872.000000 < 4219.000000>] [   T38] example[38]
+[59319.000000 < 4447.000000>] [   T39] example[39]
+[64000.000000 < 4681.000000>] [   T40] example[40]
+[68921.000000 < 4921.000000>] [   T41] example[41]
+[74088.000000 < 5167.000000>] [   T42] example[42]
+[79507.000000 < 5419.000000>] [   T43] example[43]
+[85184.000000 < 5677.000000>] [   T44] example[44]
+[91125.000000 < 5941.000000>] [   T45] example[45]
+[97336.000000 < 6211.000000>] [   T46] example[46]
+[103823.000000 < 6487.000000>] [   T47] example[47]
+[110592.000000 < 6769.000000>] [   T48] example[48]
+[117649.000000 < 7057.000000>] [   T49] example[49]
+[125000.000000 < 7351.000000>] [   T50] example[50]
+[132651.000000 < 7651.000000>] [   T51] example[51]
+[140608.000000 < 7957.000000>] [   T52] example[52]
+[148877.000000 < 8269.000000>] [   T53] example[53]
+[157464.000000 < 8587.000000>] [   T54] example[54]
+[166375.000000 < 8911.000000>] [   T55] example[55]
+[175616.000000 < 9241.000000>] [   T56] example[56]
+[185193.000000 < 9577.000000>] [   T57] example[57]
+[195112.000000 < 9919.000000>] [   T58] example[58]
+[205379.000000 <10267.000000>] [   T59] example[59]
+[216000.000000 <10621.000000>] [   T60] example[60]
+[226981.000000 <10981.000000>] [   T61] example[61]
+[238328.000000 <11347.000000>] [   T62] example[62]
+[250047.000000 <11719.000000>] [   T63] example[63]
+[262144.000000 <12097.000000>] [   T64] example[64]
+[274625.000000 <12481.000000>] [   T65] example[65]
+[287496.000000 <12871.000000>] [   T66] example[66]
+[300763.000000 <13267.000000>] [   T67] example[67]
+[314432.000000 <13669.000000>] [   T68] example[68]
+[328509.000000 <14077.000000>] [   T69] example[69]
+[343000.000000 <14491.000000>] [   T70] example[70]
+[357911.000000 <14911.000000>] [   T71] example[71]
+[373248.000000 <15337.000000>] [   T72] example[72]
+[389017.000000 <15769.000000>] [   T73] example[73]
+[405224.000000 <16207.000000>] [   T74] example[74]
+[421875.000000 <16651.000000>] [   T75] example[75]
+[438976.000000 <17101.000000>] [   T76] example[76]
+[456533.000000 <17557.000000>] [   T77] example[77]
+[474552.000000 <18019.000000>] [   T78] example[78]
+[493039.000000 <18487.000000>] [   T79] example[79]
+[512000.000000 <18961.000000>] [   T80] example[80]
+[531441.000000 <19441.000000>] [   T81] example[81]
+[551368.000000 <19927.000000>] [   T82] example[82]
+[571787.000000 <20419.000000>] [   T83] example[83]
+[592704.000000 <20917.000000>] [   T84] example[84]
+[614125.000000 <21421.000000>] [   T85] example[85]
+[636056.000000 <21931.000000>] [   T86] example[86]
+[658503.000000 <22447.000000>] [   T87] example[87]
+[681472.000000 <22969.000000>] [   T88] example[88]
+[704969.000000 <23497.000000>] [   T89] example[89]
+[729000.000000 <24031.000000>] [   T90] example[90]
+[753571.000000 <24571.000000>] [   T91] example[91]
+[778688.000000 <25117.000000>] [   T92] example[92]
+[804357.000000 <25669.000000>] [   T93] example[93]
+[830584.000000 <26227.000000>] [   T94] example[94]
+[857375.000000 <26791.000000>] [   T95] example[95]
+[884736.000000 <27361.000000>] [   T96] example[96]
+[912673.000000 <27937.000000>] [   T97] example[97]
+[941192.000000 <28519.000000>] [   T98] example[98]
+[970299.000000 <29107.000000>] [   T99] example[99]
+[1000000.000000 <29701.000000>] [  T100] example[100]
+[1030301.000000 <30301.000000>] [  T101] example[101]
+[1061208.000000 <30907.000000>] [  T102] example[102]
+[1092727.000000 <31519.000000>] [  T103] example[103]
+[1124864.000000 <32137.000000>] [  T104] example[104]
diff --git a/tests/expected/dmesg/facilities-syslog-printk-caller b/tests/expected/dmesg/facilities-syslog-printk-caller
new file mode 100644
index 000000000..b8afa3809
--- /dev/null
+++ b/tests/expected/dmesg/facilities-syslog-printk-caller
@@ -0,0 +1,104 @@
+[    0.000000] [    T0] example[0]
+[    1.000000] [    T1] example[1]
+[    8.000000] [    T2] example[2]
+[   27.000000] [    T3] example[3]
+[   64.000000] [    T4] example[4]
+[  125.000000] [    T5] example[5]
+[  216.000000] [    T6] example[6]
+[  343.000000] [    T7] example[7]
+[  512.000000] [    T8] example[8]
+[  729.000000] [    T9] example[9]
+[ 1000.000000] [   T10] example[10]
+[ 1331.000000] [   T11] example[11]
+[ 1728.000000] [   T12] example[12]
+[ 2197.000000] [   T13] example[13]
+[ 2744.000000] [   T14] example[14]
+[ 3375.000000] [   T15] example[15]
+[ 4096.000000] [   T16] example[16]
+[ 4913.000000] [   T17] example[17]
+[ 5832.000000] [   T18] example[18]
+[ 6859.000000] [   T19] example[19]
+[ 8000.000000] [   T20] example[20]
+[ 9261.000000] [   T21] example[21]
+[10648.000000] [   T22] example[22]
+[12167.000000] [   T23] example[23]
+[13824.000000] [   T24] example[24]
+[15625.000000] [   T25] example[25]
+[17576.000000] [   T26] example[26]
+[19683.000000] [   T27] example[27]
+[21952.000000] [   T28] example[28]
+[24389.000000] [   T29] example[29]
+[27000.000000] [   T10] example[30]
+[29791.000000] [   T31] example[31]
+[32768.000000] [   T32] example[32]
+[35937.000000] [   T33] example[33]
+[39304.000000] [   T34] example[34]
+[42875.000000] [   T35] example[35]
+[46656.000000] [   T36] example[36]
+[50653.000000] [   T37] example[37]
+[54872.000000] [   T38] example[38]
+[59319.000000] [   T39] example[39]
+[64000.000000] [   T40] example[40]
+[68921.000000] [   T41] example[41]
+[74088.000000] [   T42] example[42]
+[79507.000000] [   T43] example[43]
+[85184.000000] [   T44] example[44]
+[91125.000000] [   T45] example[45]
+[97336.000000] [   T46] example[46]
+[103823.000000] [   T47] example[47]
+[110592.000000] [   T48] example[48]
+[117649.000000] [   T49] example[49]
+[125000.000000] [   T50] example[50]
+[132651.000000] [   T51] example[51]
+[140608.000000] [   T52] example[52]
+[148877.000000] [   T53] example[53]
+[157464.000000] [   T54] example[54]
+[166375.000000] [   T55] example[55]
+[175616.000000] [   T56] example[56]
+[185193.000000] [   T57] example[57]
+[195112.000000] [   T58] example[58]
+[205379.000000] [   T59] example[59]
+[216000.000000] [   T60] example[60]
+[226981.000000] [   T61] example[61]
+[238328.000000] [   T62] example[62]
+[250047.000000] [   T63] example[63]
+[262144.000000] [   T64] example[64]
+[274625.000000] [   T65] example[65]
+[287496.000000] [   T66] example[66]
+[300763.000000] [   T67] example[67]
+[314432.000000] [   T68] example[68]
+[328509.000000] [   T69] example[69]
+[343000.000000] [   T70] example[70]
+[357911.000000] [   T71] example[71]
+[373248.000000] [   T72] example[72]
+[389017.000000] [   T73] example[73]
+[405224.000000] [   T74] example[74]
+[421875.000000] [   T75] example[75]
+[438976.000000] [   T76] example[76]
+[456533.000000] [   T77] example[77]
+[474552.000000] [   T78] example[78]
+[493039.000000] [   T79] example[79]
+[512000.000000] [   T80] example[80]
+[531441.000000] [   T81] example[81]
+[551368.000000] [   T82] example[82]
+[571787.000000] [   T83] example[83]
+[592704.000000] [   T84] example[84]
+[614125.000000] [   T85] example[85]
+[636056.000000] [   T86] example[86]
+[658503.000000] [   T87] example[87]
+[681472.000000] [   T88] example[88]
+[704969.000000] [   T89] example[89]
+[729000.000000] [   T90] example[90]
+[753571.000000] [   T91] example[91]
+[778688.000000] [   T92] example[92]
+[804357.000000] [   T93] example[93]
+[830584.000000] [   T94] example[94]
+[857375.000000] [   T95] example[95]
+[884736.000000] [   T96] example[96]
+[912673.000000] [   T97] example[97]
+[941192.000000] [   T98] example[98]
+[970299.000000] [   T99] example[99]
+[1000000.000000] [  T100] example[100]
+[1030301.000000] [  T101] example[101]
+[1061208.000000] [  T102] example[102]
+[1092727.000000] [  T103] example[103]
diff --git a/tests/expected/dmesg/indentation-syslog-printk-caller b/tests/expected/dmesg/indentation-syslog-printk-caller
new file mode 100644
index 000000000..b2219671e
--- /dev/null
+++ b/tests/expected/dmesg/indentation-syslog-printk-caller
@@ -0,0 +1,35 @@
+[    1.000000] [    T1] new
+               line
+[    2.000000] [    T2] two
+               new
+               lines
+user  :crit  : [    1.000000] [    T1] new
+                              line
+mail  :warn  : [    2.000000] [    T2] two
+                              new
+                              lines
+[<    0.000000>] [    T1] new
+                 line
+[<    1.000000>] [    T2] two
+                 new
+                 lines
+[    T1] new
+line
+[    T2] two
+new
+lines
+[Feb13 23:31] [    T1] new
+              line
+[  +1.000000] [    T2] two
+              new
+              lines
+[Fri Feb 13 23:31:31 2009] [    T1] new
+                           line
+[Fri Feb 13 23:31:32 2009] [    T2] two
+                           new
+                           lines
+2009-02-13T23:31:31,123456+00:00 [    T1] new
+                                 line
+2009-02-13T23:31:32,123456+00:00 [    T2] two
+                                 new
+                                 lines
diff --git a/tests/expected/dmesg/limit-syslog-printk-caller b/tests/expected/dmesg/limit-syslog-printk-caller
new file mode 100644
index 000000000..c30b4ac9a
--- /dev/null
+++ b/tests/expected/dmesg/limit-syslog-printk-caller
@@ -0,0 +1,4 @@
+[    1.000000] [    T1] example[1]
+[    8.000000] [    T2] example[2]
+[   27.000000] [    T3] example[3]
+[   64.000000] [    T4] example[4]
diff --git a/tests/ts/dmesg/colors-syslog-printk-caller b/tests/ts/dmesg/colors-syslog-printk-caller
new file mode 100755
index 000000000..d20cc689b
--- /dev/null
+++ b/tests/ts/dmesg/colors-syslog-printk-caller
@@ -0,0 +1,29 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="colors-syslog-prtk-caller"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+ts_inhibit_custom_colorscheme
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG --color=always -F $TS_SELF/input-syslog-printk-caller -x >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/console-levels-syslog-printk-caller b/tests/ts/dmesg/console-levels-syslog-printk-caller
new file mode 100755
index 000000000..6c1ad6d88
--- /dev/null
+++ b/tests/ts/dmesg/console-levels-syslog-printk-caller
@@ -0,0 +1,36 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="levels-syslog-prtk-caller"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+for I in {-1..8}; do
+	$TS_HELPER_DMESG -F $TS_SELF/input-printk-caller -l $I >> $TS_OUTPUT 2>/dev/null
+done
+
+$TS_HELPER_DMESG -F $TS_SELF/input-syslog-printk-caller -l err+ >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -F $TS_SELF/input-syslog-printk-caller -l emerg+ >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -F $TS_SELF/input-syslog-printk-caller -l +err >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -F $TS_SELF/input-syslog-printk-caller -l +debug >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -F $TS_SELF/input-syslog-printk-caller -l + 2>> $TS_OUTPUT >/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/decode-syslog-printk-caller b/tests/ts/dmesg/decode-syslog-printk-caller
new file mode 100755
index 000000000..b5494417b
--- /dev/null
+++ b/tests/ts/dmesg/decode-syslog-printk-caller
@@ -0,0 +1,28 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="decode-syslog-prtk-caller"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG -x -F $TS_SELF/input-syslog-printk-caller >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/delta-syslog-printk-caller b/tests/ts/dmesg/delta-syslog-printk-caller
new file mode 100755
index 000000000..e5fc13723
--- /dev/null
+++ b/tests/ts/dmesg/delta-syslog-printk-caller
@@ -0,0 +1,28 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="delta-syslog-prtk-caller"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG -d -F $TS_SELF/input-syslog-printk-caller >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/facilities-syslog-printk-caller b/tests/ts/dmesg/facilities-syslog-printk-caller
new file mode 100755
index 000000000..6680633ab
--- /dev/null
+++ b/tests/ts/dmesg/facilities-syslog-printk-caller
@@ -0,0 +1,30 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="facilities-syslog-prtk-caller"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+for I in {-1..12}; do
+	$TS_HELPER_DMESG -F $TS_SELF/input-syslog-printk-caller -f $I >> $TS_OUTPUT 2>/dev/null
+done
+
+ts_finalize
diff --git a/tests/ts/dmesg/indentation-syslog-printk-caller b/tests/ts/dmesg/indentation-syslog-printk-caller
new file mode 100755
index 000000000..78ee00bb1
--- /dev/null
+++ b/tests/ts/dmesg/indentation-syslog-printk-caller
@@ -0,0 +1,40 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="indent-syslog-printk-caller"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG -F $TS_SELF/newlines-syslog-printk-caller >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG -F $TS_SELF/newlines-syslog-printk-caller -x >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=delta --file $TS_SELF/newlines-syslog-printk-caller >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=notime --file $TS_SELF/newlines-syslog-printk-caller >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=reltime --file $TS_SELF/newlines-syslog-printk-caller >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=ctime --file $TS_SELF/newlines-syslog-printk-caller >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=iso --file $TS_SELF/newlines-syslog-printk-caller >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+ts_finalize
diff --git a/tests/ts/dmesg/input-syslog-printk-caller b/tests/ts/dmesg/input-syslog-printk-caller
new file mode 100644
index 000000000..5fcff6abe
--- /dev/null
+++ b/tests/ts/dmesg/input-syslog-printk-caller
@@ -0,0 +1,105 @@
+<0>[    0.000000] [    T0] example[0]
+<1>[    1.000000] [    T1] example[1]
+<2>[    8.000000] [    T2] example[2]
+<3>[   27.000000] [    T3] example[3]
+<4>[   64.000000] [    T4] example[4]
+<5>[  125.000000] [    T5] example[5]
+<6>[  216.000000] [    T6] example[6]
+<7>[  343.000000] [    T7] example[7]
+<8>[  512.000000] [    T8] example[8]
+<9>[  729.000000] [    T9] example[9]
+<10>[ 1000.000000] [   T10] example[10]
+<11>[ 1331.000000] [   T11] example[11]
+<12>[ 1728.000000] [   T12] example[12]
+<13>[ 2197.000000] [   T13] example[13]
+<14>[ 2744.000000] [   T14] example[14]
+<15>[ 3375.000000] [   T15] example[15]
+<16>[ 4096.000000] [   T16] example[16]
+<17>[ 4913.000000] [   T17] example[17]
+<18>[ 5832.000000] [   T18] example[18]
+<19>[ 6859.000000] [   T19] example[19]
+<20>[ 8000.000000] [   T20] example[20]
+<21>[ 9261.000000] [   T21] example[21]
+<22>[10648.000000] [   T22] example[22]
+<23>[12167.000000] [   T23] example[23]
+<24>[13824.000000] [   T24] example[24]
+<25>[15625.000000] [   T25] example[25]
+<26>[17576.000000] [   T26] example[26]
+<27>[19683.000000] [   T27] example[27]
+<28>[21952.000000] [   T28] example[28]
+<29>[24389.000000] [   T29] example[29]
+<30>[27000.000000] [   T10] example[30]
+<31>[29791.000000] [   T31] example[31]
+<32>[32768.000000] [   T32] example[32]
+<33>[35937.000000] [   T33] example[33]
+<34>[39304.000000] [   T34] example[34]
+<35>[42875.000000] [   T35] example[35]
+<36>[46656.000000] [   T36] example[36]
+<37>[50653.000000] [   T37] example[37]
+<38>[54872.000000] [   T38] example[38]
+<39>[59319.000000] [   T39] example[39]
+<40>[64000.000000] [   T40] example[40]
+<41>[68921.000000] [   T41] example[41]
+<42>[74088.000000] [   T42] example[42]
+<43>[79507.000000] [   T43] example[43]
+<44>[85184.000000] [   T44] example[44]
+<45>[91125.000000] [   T45] example[45]
+<46>[97336.000000] [   T46] example[46]
+<47>[103823.000000] [   T47] example[47]
+<48>[110592.000000] [   T48] example[48]
+<49>[117649.000000] [   T49] example[49]
+<50>[125000.000000] [   T50] example[50]
+<51>[132651.000000] [   T51] example[51]
+<52>[140608.000000] [   T52] example[52]
+<53>[148877.000000] [   T53] example[53]
+<54>[157464.000000] [   T54] example[54]
+<55>[166375.000000] [   T55] example[55]
+<56>[175616.000000] [   T56] example[56]
+<57>[185193.000000] [   T57] example[57]
+<58>[195112.000000] [   T58] example[58]
+<59>[205379.000000] [   T59] example[59]
+<60>[216000.000000] [   T60] example[60]
+<61>[226981.000000] [   T61] example[61]
+<62>[238328.000000] [   T62] example[62]
+<63>[250047.000000] [   T63] example[63]
+<64>[262144.000000] [   T64] example[64]
+<65>[274625.000000] [   T65] example[65]
+<66>[287496.000000] [   T66] example[66]
+<67>[300763.000000] [   T67] example[67]
+<68>[314432.000000] [   T68] example[68]
+<69>[328509.000000] [   T69] example[69]
+<70>[343000.000000] [   T70] example[70]
+<71>[357911.000000] [   T71] example[71]
+<72>[373248.000000] [   T72] example[72]
+<73>[389017.000000] [   T73] example[73]
+<74>[405224.000000] [   T74] example[74]
+<75>[421875.000000] [   T75] example[75]
+<76>[438976.000000] [   T76] example[76]
+<77>[456533.000000] [   T77] example[77]
+<78>[474552.000000] [   T78] example[78]
+<79>[493039.000000] [   T79] example[79]
+<80>[512000.000000] [   T80] example[80]
+<81>[531441.000000] [   T81] example[81]
+<82>[551368.000000] [   T82] example[82]
+<83>[571787.000000] [   T83] example[83]
+<84>[592704.000000] [   T84] example[84]
+<85>[614125.000000] [   T85] example[85]
+<86>[636056.000000] [   T86] example[86]
+<87>[658503.000000] [   T87] example[87]
+<88>[681472.000000] [   T88] example[88]
+<89>[704969.000000] [   T89] example[89]
+<90>[729000.000000] [   T90] example[90]
+<91>[753571.000000] [   T91] example[91]
+<92>[778688.000000] [   T92] example[92]
+<93>[804357.000000] [   T93] example[93]
+<94>[830584.000000] [   T94] example[94]
+<95>[857375.000000] [   T95] example[95]
+<96>[884736.000000] [   T96] example[96]
+<97>[912673.000000] [   T97] example[97]
+<98>[941192.000000] [   T98] example[98]
+<99>[970299.000000] [   T99] example[99]
+<100>[1000000.000000] [  T100] example[100]
+<101>[1030301.000000] [  T101] example[101]
+<102>[1061208.000000] [  T102] example[102]
+<103>[1092727.000000] [  T103] example[103]
+<104>[1124864.000000] [  T104] example[104]
diff --git a/tests/ts/dmesg/limit-syslog-printk-caller b/tests/ts/dmesg/limit-syslog-printk-caller
new file mode 100755
index 000000000..e2160d325
--- /dev/null
+++ b/tests/ts/dmesg/limit-syslog-printk-caller
@@ -0,0 +1,29 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="limit-syslog-prtk-caller"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG --since @1234567890.124 --until @1234567991 \
+	-F $TS_SELF/input-syslog-printk-caller >> $TS_OUTPUT 2> $TS_ERRLOG
+
+ts_finalize
diff --git a/tests/ts/dmesg/newlines-syslog-printk-caller b/tests/ts/dmesg/newlines-syslog-printk-caller
new file mode 100644
index 000000000..682ce40bb
--- /dev/null
+++ b/tests/ts/dmesg/newlines-syslog-printk-caller
@@ -0,0 +1,5 @@
+<10>[    1.000000] [    T1] new
+line
+<20>[    2.000000] [    T2] two
+new
+lines
-- 
2.43.0
