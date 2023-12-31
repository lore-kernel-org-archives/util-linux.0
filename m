Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8E4944B
	for <util-linux@vger.kernel.org>; Sun, 31 Dec 2023 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="HCFvn9Gh"
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-7bae735875bso344362139f.2
        for <util-linux@vger.kernel.org>; Sun, 31 Dec 2023 10:28:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704047280; x=1704652080;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZQdNUrA+tFHG3rxLAqJfzU2VZ2t5JlPiPOAi+lhY9o=;
        b=V5iQWZe9sBCCiuJXmq9MyY2ncnchi6sPeyvBnM/V6VQrFacdYcW/O/lrUgmxBys8fW
         tdDZXYW5tahnavFaBoe6NOpkZ3JJpdPwmg3Gg21FvLgtBdebqojaJN2mHVHoxOsGRbbM
         P71zM6K1jKlUwxdyO2RKfRUzV537Ix5Su7qIOt3iRFNYU1p3xK7VpVMspBJIt35mSLL3
         ACGA8K0pHFoEmp7X5i5YFk6jBQIgdjSXs32Mva5XFSCC2YoqIXqmGblc51V8K/AtH9Cm
         dsQBuYgFXFFw9UOXfynDGFJDzss+lBBfYmSRrfmdb4IEHqumbEzoPwZj4Zua6bLiJED6
         JxEg==
X-Gm-Message-State: AOJu0YxzaQUVMXwVuP6K77by/iO3zsy8NOFCZGhf/odI2XvmKuEi4EKJ
	joDVVKEm97FCVUP4slaoBPM89UqGGP0F8JfpxBTbBR59mg7zQMCAgMA=
X-Google-Smtp-Source: AGHT+IHE3AL4fVMVM37jnWCvTmLT0EQzoh/vFvHEYSZm54p2V2tJgss8NABJvLzG6kBy0XXZE7FNkacWNSIc
X-Received: by 2002:a05:6602:178f:b0:7bb:8d37:6fec with SMTP id y15-20020a056602178f00b007bb8d376fecmr1754438iox.0.1704047279739;
        Sun, 31 Dec 2023 10:27:59 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id c16-20020a6bec10000000b007834bb58f75sm847103ioh.20.2023.12.31.10.27.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Dec 2023 10:27:59 -0800 (PST)
X-Relaying-Domain: arista.com
X-SMTP-Authentication: Allow-List-permitted
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1704047278;
	bh=fZQdNUrA+tFHG3rxLAqJfzU2VZ2t5JlPiPOAi+lhY9o=;
	h=From:To:Cc:Subject:Date:From;
	b=HCFvn9GhElPiOLSJkzmFSDyzcacJHYy+XPgt2ogzvG6ocn7VvhsJBLt+lOSOKYKg0
	 WSR4JxkyxbYPsCAinfP+OhXytpZsx4LE518UI2vU3z6n5ofFUuyYEMKhlkmxxGyCHd
	 twA+X/+G7/kiRSndlNDk1z3W+6Tau61MC9NqfgVwTWOequ9t1w72pii8zU9If81JoT
	 SGoB8MjoMFcBpec+Hgq3mrejLmAzZZoGcLLjKMH6G02cI6vBxzjqFTsp7LEAf+J5iQ
	 F3DMqFzhu0w5jIx+ml291HMpAc7lopodzWmXPoSzRxNes7BBQzFRflZNfCrok/qyX9
	 uVusl0tCmtdxQ==
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: from us113.sjc.aristanetworks.com (us113.sjc.aristanetworks.com [10.242.240.8])
	by smtp.aristanetworks.com (Postfix) with ESMTP id E324E400F82;
	Sun, 31 Dec 2023 10:27:58 -0800 (PST)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: by us113.sjc.aristanetworks.com (Postfix, from userid 10383)
	id D9CADB84091E; Sun, 31 Dec 2023 10:27:58 -0800 (PST)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Edward Chron <echron@arista.com>
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
To: util-linux@vger.kernel.org
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Cc: colona@arista.com,
	echron@arista.com,
	echron@gmail.com
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Subject: [PATCH] Add dmesg syslog interface caller_id tests Issue: #2637
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Date: Sun, 31 Dec 2023 10:27:57 -0800
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Message-ID: <20231231182757.2455-1-echron@arista.com>
X-SMTP-Authentication: Allow-List-permitted
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>

Submission to Project: util-linux
Open Incident: #2637 at github.com/util-linux/util-linux/issues/2637
Component: util-linux/sys-utils
Files: tests/ts/dmesg syslog interface caller-id files, tests
       and related expected files
Testing on Fedora 39 with Linux-6.6.6 Kernel and CONFIG_PRINTK_CALLER
config option set.
Patch tested and generated with the latest util-linux code pulled.
Retro-fitted to merge on top of the patch for Issue: #2609

For Issue #2609 Thomas and Zak pointed out the we need tests to verify
that the dmesg command works correctly and to allow us to compare the
results from PRINTK_CALLER id field tests provided by #2609 with the
standard (syslog interface) dmesg tests.

Currently, dmesg only has standard syslog interface tests even though
dmesg -S the syslog interface supports the caller_id field. There
are no syslog caller-id tests.

We would like syslog caller-id tests both to validate that the dmesg
code works correctly with the caller-id field being present and also
to compare against the addition of dmesg kmsg caller_id support added
by Issue #2609.

These tests are for the dmesg syslog interface with caller-id follow the
existing test structure for dmesg tests. The existing dmesg -F interface
is used to input our test files.

Until Thomas added a dmesg kmsg interface for json format testing
there were no dmesg tests except the tests for the generic dmesg
syslog tests. So we're naming the syslog caller-id tests to follow
the test naming convention that Thomas introduced.

For caller_id tests we prefix the test name with cid- abbreviating
the caller_id name to keep the names short. There is no unqiue
indentifier for syslog tests, so syslog tests are currently:

colors, console-levels, decode, delta, facilities, indentation,
limit, json

The cid versions of these test files are just prefixed with cid-
The patch for Issue: #2609 has the files:
cid-input and cid-json and the expected file for cide-json

Additional new dmesg tests are found with Issue #2663 which add
standard dmesg kmsg interface tests providing equivalent tests to
the existing dmesg syslog interface tests.

Also, Issue #2609 introduces dmesg kmsg interface caller-id tests
equivalent to the dmesg syslog interface with caller-id tests introduced
here along with the necessary dmesg kmsg interface caller-id support
needed to accomodate the PRINTK_CALLER id field.

Just for reference, on a Linux system with the CONFIG_PRINTK_CALLER
configuration option set the output from dmesg -S looks like:

    [  520.899558] [   T3919] hub 3-3:1.0: USB hub found

on a system where the PRINTK_CALLER configuration option is not set the
output looks like:

    [  520.899558] hub 3-3:1.0: USB hub found

the additional field specifies either a Thread Id or CPU id depending on
the context of the task or thread at the time the printk that added the
message to the kernel ring buffer was executed.

Signed-off-by: Ivan Delalande <colona@arista.com>
Signed-off-by: Edward Chron <echron@arista.com>
---
 tests/expected/dmesg/cid-colors         | 106 ++++++++++
 tests/expected/dmesg/cid-console-levels | 253 ++++++++++++++++++++++++
 tests/expected/dmesg/cid-decode         | 106 ++++++++++
 tests/expected/dmesg/cid-delta          | 106 ++++++++++
 tests/expected/dmesg/cid-facilities     | 104 ++++++++++
 tests/expected/dmesg/cid-indentation    |  35 ++++
 tests/expected/dmesg/cid-limit          |   4 +
 tests/ts/dmesg/cid-colors               |  29 +++
 tests/ts/dmesg/cid-console-levels       |  36 ++++
 tests/ts/dmesg/cid-decode               |  28 +++
 tests/ts/dmesg/cid-delta                |  27 +++
 tests/ts/dmesg/cid-facilities           |  30 +++
 tests/ts/dmesg/cid-indentation          |  40 ++++
 tests/ts/dmesg/cid-limit                |  29 +++
 tests/ts/dmesg/cid-newlines             |   5 +
 15 files changed, 938 insertions(+)
 create mode 100644 tests/expected/dmesg/cid-colors
 create mode 100644 tests/expected/dmesg/cid-console-levels
 create mode 100644 tests/expected/dmesg/cid-decode
 create mode 100644 tests/expected/dmesg/cid-delta
 create mode 100644 tests/expected/dmesg/cid-facilities
 create mode 100644 tests/expected/dmesg/cid-indentation
 create mode 100644 tests/expected/dmesg/cid-limit
 create mode 100755 tests/ts/dmesg/cid-colors
 create mode 100755 tests/ts/dmesg/cid-console-levels
 create mode 100755 tests/ts/dmesg/cid-decode
 create mode 100755 tests/ts/dmesg/cid-delta
 create mode 100755 tests/ts/dmesg/cid-facilities
 create mode 100755 tests/ts/dmesg/cid-indentation
 create mode 100755 tests/ts/dmesg/cid-limit
 create mode 100644 tests/ts/dmesg/cid-newlines

diff --git a/tests/expected/dmesg/cid-colors b/tests/expected/dmesg/cid-colors
new file mode 100644
index 000000000..3b7aff6d7
--- /dev/null
+++ b/tests/expected/dmesg/cid-colors
@@ -0,0 +1,106 @@
+kern  :emerg : [32m[    0.000000] [0m[    T0] example[0]
+kern  :alert : [32m[    1.000000] [0m[    T1] [7m[31mexample[1][0m
+kern  :crit  : [32m[    8.000000] [0m[    T2] [1m[31mexample[2][0m
+kern  :err   : [32m[   27.000000] [0m[    T3] [31mexample[3][0m
+kern  :warn  : [32m[   64.000000] [0m[    T4] [1mexample[4][0m
+kern  :notice: [32m[  125.000000] [0m[    T5] example[5]
+kern  :info  : [32m[  216.000000] [0m[    T6] example[6]
+kern  :debug : [32m[  343.000000] [0m[    T7] example[7]
+user  :emerg : [32m[  512.000000] [0m[    T8] example[8]
+user  :alert : [32m[  729.000000] [0m[    T9] [7m[31mexample[9][0m
+user  :crit  : [32m[ 1000.000000] [0m[   T10] [1m[31mexample[10][0m
+user  :err   : [32m[ 1331.000000] [0m[   T11] [31mexample[11][0m
+user  :warn  : [32m[ 1728.000000] [0m[   T12] [1mexample[12][0m
+user  :notice: [32m[ 2197.000000] [0m[   T13] example[13]
+user  :info  : [32m[ 2744.000000] [0m[   T14] example[14]
+user  :debug : [32m[ 3375.000000] [0m[   T15] example[15]
+mail  :emerg : [32m[ 4096.000000] [0m[   T16] example[16]
+mail  :alert : [32m[ 4913.000000] [0m[   T17] [7m[31mexample[17][0m
+mail  :crit  : [32m[ 5832.000000] [0m[   T18] [1m[31mexample[18][0m
+mail  :err   : [32m[ 6859.000000] [0m[   T19] [31mexample[19][0m
+mail  :warn  : [32m[ 8000.000000] [0m[   T20] [1mexample[20][0m
+mail  :notice: [32m[ 9261.000000] [0m[   T21] example[21]
+mail  :info  : [32m[10648.000000] [0m[   T22] example[22]
+mail  :debug : [32m[12167.000000] [0m[   T23] example[23]
+daemon:emerg : [32m[13824.000000] [0m[   T24] example[24]
+daemon:alert : [32m[15625.000000] [0m[   T25] [7m[31mexample[25][0m
+daemon:crit  : [32m[17576.000000] [0m[   T26] [1m[31mexample[26][0m
+daemon:err   : [32m[19683.000000] [0m[   T27] [31mexample[27][0m
+daemon:warn  : [32m[21952.000000] [0m[   T28] [1mexample[28][0m
+daemon:notice: [32m[24389.000000] [0m[   T29] example[29]
+daemon:info  : [32m[27000.000000] [0m[   T10] example[30]
+daemon:debug : [32m[29791.000000] [0m[   T31] example[31]
+auth  :emerg : [32m[32768.000000] [0m[   T32] example[32]
+auth  :alert : [32m[35937.000000] [0m[   T33] [7m[31mexample[33][0m
+auth  :crit  : [32m[39304.000000] [0m[   T34] [1m[31mexample[34][0m
+auth  :err   : [32m[42875.000000] [0m[   T35] [31mexample[35][0m
+auth  :warn  : [32m[46656.000000] [0m[   T36] [1mexample[36][0m
+auth  :notice: [32m[50653.000000] [0m[   T37] example[37]
+auth  :info  : [32m[54872.000000] [0m[   T38] example[38]
+auth  :debug : [32m[59319.000000] [0m[   T39] example[39]
+syslog:emerg : [32m[64000.000000] [0m[   T40] example[40]
+syslog:alert : [32m[68921.000000] [0m[   T41] [7m[31mexample[41][0m
+syslog:crit  : [32m[74088.000000] [0m[   T42] [1m[31mexample[42][0m
+syslog:err   : [32m[79507.000000] [0m[   T43] [31mexample[43][0m
+syslog:warn  : [32m[85184.000000] [0m[   T44] [1mexample[44][0m
+syslog:notice: [32m[91125.000000] [0m[   T45] example[45]
+syslog:info  : [32m[97336.000000] [0m[   T46] example[46]
+syslog:debug : [32m[103823.000000] [0m[   T47] example[47]
+lpr   :emerg : [32m[110592.000000] [0m[   T48] example[48]
+lpr   :alert : [32m[117649.000000] [0m[   T49] [7m[31mexample[49][0m
+lpr   :crit  : [32m[125000.000000] [0m[   T50] [1m[31mexample[50][0m
+lpr   :err   : [32m[132651.000000] [0m[   T51] [31mexample[51][0m
+lpr   :warn  : [32m[140608.000000] [0m[   T52] [1mexample[52][0m
+lpr   :notice: [32m[148877.000000] [0m[   T53] example[53]
+lpr   :info  : [32m[157464.000000] [0m[   T54] example[54]
+lpr   :debug : [32m[166375.000000] [0m[   T55] example[55]
+news  :emerg : [32m[175616.000000] [0m[   T56] example[56]
+news  :alert : [32m[185193.000000] [0m[   T57] [7m[31mexample[57][0m
+news  :crit  : [32m[195112.000000] [0m[   T58] [1m[31mexample[58][0m
+news  :err   : [32m[205379.000000] [0m[   T59] [31mexample[59][0m
+news  :warn  : [32m[216000.000000] [0m[   T60] [1mexample[60][0m
+news  :notice: [32m[226981.000000] [0m[   T61] example[61]
+news  :info  : [32m[238328.000000] [0m[   T62] example[62]
+news  :debug : [32m[250047.000000] [0m[   T63] example[63]
+uucp  :emerg : [32m[262144.000000] [0m[   T64] example[64]
+uucp  :alert : [32m[274625.000000] [0m[   T65] [7m[31mexample[65][0m
+uucp  :crit  : [32m[287496.000000] [0m[   T66] [1m[31mexample[66][0m
+uucp  :err   : [32m[300763.000000] [0m[   T67] [31mexample[67][0m
+uucp  :warn  : [32m[314432.000000] [0m[   T68] [1mexample[68][0m
+uucp  :notice: [32m[328509.000000] [0m[   T69] example[69]
+uucp  :info  : [32m[343000.000000] [0m[   T70] example[70]
+uucp  :debug : [32m[357911.000000] [0m[   T71] example[71]
+cron  :emerg : [32m[373248.000000] [0m[   T72] example[72]
+cron  :alert : [32m[389017.000000] [0m[   T73] [7m[31mexample[73][0m
+cron  :crit  : [32m[405224.000000] [0m[   T74] [1m[31mexample[74][0m
+cron  :err   : [32m[421875.000000] [0m[   T75] [31mexample[75][0m
+cron  :warn  : [32m[438976.000000] [0m[   T76] [1mexample[76][0m
+cron  :notice: [32m[456533.000000] [0m[   T77] example[77]
+cron  :info  : [32m[474552.000000] [0m[   T78] example[78]
+cron  :debug : [32m[493039.000000] [0m[   T79] example[79]
+authpriv:emerg : [32m[512000.000000] [0m[   T80] example[80]
+authpriv:alert : [32m[531441.000000] [0m[   T81] [7m[31mexample[81][0m
+authpriv:crit  : [32m[551368.000000] [0m[   T82] [1m[31mexample[82][0m
+authpriv:err   : [32m[571787.000000] [0m[   T83] [31mexample[83][0m
+authpriv:warn  : [32m[592704.000000] [0m[   T84] [1mexample[84][0m
+authpriv:notice: [32m[614125.000000] [0m[   T85] example[85]
+authpriv:info  : [32m[636056.000000] [0m[   T86] example[86]
+authpriv:debug : [32m[658503.000000] [0m[   T87] example[87]
+ftp   :emerg : [32m[681472.000000] [0m[   T88] example[88]
+ftp   :alert : [32m[704969.000000] [0m[   T89] [7m[31mexample[89][0m
+ftp   :crit  : [32m[729000.000000] [0m[   T90] [1m[31mexample[90][0m
+ftp   :err   : [32m[753571.000000] [0m[   T91] [31mexample[91][0m
+ftp   :warn  : [32m[778688.000000] [0m[   T92] [1mexample[92][0m
+ftp   :notice: [32m[804357.000000] [0m[   T93] example[93]
+ftp   :info  : [32m[830584.000000] [0m[   T94] example[94]
+ftp   :debug : [32m[857375.000000] [0m[   T95] example[95]
+res0  :emerg : [32m[884736.000000] [0m[   T96] example[96]
+res0  :alert : [32m[912673.000000] [0m[   T97] [7m[31mexample[97][0m
+res0  :crit  : [32m[941192.000000] [0m[   T98] [1m[31mexample[98][0m
+res0  :err   : [32m[970299.000000] [0m[   T99] [31mexample[99][0m
+res0  :warn  : [32m[1000000.000000] [0m[  T100] [1mexample[100][0m
+res0  :notice: [32m[1030301.000000] [0m[  T101] example[101]
+res0  :info  : [32m[1061208.000000] [0m[  T102] example[102]
+res0  :debug : [32m[1092727.000000] [0m[  T103] example[103]
+res1  :emerg : [32m[1124864.000000] [0m[  T104] example[104]
+local2:info  : [32m[4557523.000000] [0m[  T105] example[105]
diff --git a/tests/expected/dmesg/cid-console-levels b/tests/expected/dmesg/cid-console-levels
new file mode 100644
index 000000000..9fe993b20
--- /dev/null
+++ b/tests/expected/dmesg/cid-console-levels
@@ -0,0 +1,253 @@
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
+[    1.000000] [    T1] example[1]
+[  729.000000] [    T9] example[9]
+[ 4913.000000] [   T17] example[17]
+[15625.000000] [   T25] example[25]
+[35937.000000] [   T33] example[33]
+[68921.000000] [   T41] example[41]
+[117649.000000] [   T49] example[49]
+[185193.000000] [   T57] example[57]
+[274625.000000] [   T65] example[65]
+[389017.000000] [   T73] example[73]
+[531441.000000] [   T81] example[81]
+[704969.000000] [   T89] example[89]
+[912673.000000] [   T97] example[97]
+[    8.000000] [    T2] example[2]
+[ 1000.000000] [   T10] example[10]
+[ 5832.000000] [   T18] example[18]
+[17576.000000] [   T26] example[26]
+[39304.000000] [   T34] example[34]
+[74088.000000] [   T42] example[42]
+[125000.000000] [   T50] example[50]
+[195112.000000] [   T58] example[58]
+[287496.000000] [   T66] example[66]
+[405224.000000] [   T74] example[74]
+[551368.000000] [   T82] example[82]
+[729000.000000] [   T90] example[90]
+[941192.000000] [   T98] example[98]
+[   27.000000] [    T3] example[3]
+[ 1331.000000] [   T11] example[11]
+[ 6859.000000] [   T19] example[19]
+[19683.000000] [   T27] example[27]
+[42875.000000] [   T35] example[35]
+[79507.000000] [   T43] example[43]
+[132651.000000] [   T51] example[51]
+[205379.000000] [   T59] example[59]
+[300763.000000] [   T67] example[67]
+[421875.000000] [   T75] example[75]
+[571787.000000] [   T83] example[83]
+[753571.000000] [   T91] example[91]
+[970299.000000] [   T99] example[99]
+[   64.000000] [    T4] example[4]
+[ 1728.000000] [   T12] example[12]
+[ 8000.000000] [   T20] example[20]
+[21952.000000] [   T28] example[28]
+[46656.000000] [   T36] example[36]
+[85184.000000] [   T44] example[44]
+[140608.000000] [   T52] example[52]
+[216000.000000] [   T60] example[60]
+[314432.000000] [   T68] example[68]
+[438976.000000] [   T76] example[76]
+[592704.000000] [   T84] example[84]
+[778688.000000] [   T92] example[92]
+[1000000.000000] [  T100] example[100]
+[  125.000000] [    T5] example[5]
+[ 2197.000000] [   T13] example[13]
+[ 9261.000000] [   T21] example[21]
+[24389.000000] [   T29] example[29]
+[50653.000000] [   T37] example[37]
+[91125.000000] [   T45] example[45]
+[148877.000000] [   T53] example[53]
+[226981.000000] [   T61] example[61]
+[328509.000000] [   T69] example[69]
+[456533.000000] [   T77] example[77]
+[614125.000000] [   T85] example[85]
+[804357.000000] [   T93] example[93]
+[1030301.000000] [  T101] example[101]
+[  216.000000] [    T6] example[6]
+[ 2744.000000] [   T14] example[14]
+[10648.000000] [   T22] example[22]
+[27000.000000] [   T10] example[30]
+[54872.000000] [   T38] example[38]
+[97336.000000] [   T46] example[46]
+[157464.000000] [   T54] example[54]
+[238328.000000] [   T62] example[62]
+[343000.000000] [   T70] example[70]
+[474552.000000] [   T78] example[78]
+[636056.000000] [   T86] example[86]
+[830584.000000] [   T94] example[94]
+[1061208.000000] [  T102] example[102]
+[4557523.000000] [  T105] example[105]
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
+[4557523.000000] [  T105] example[105]
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
diff --git a/tests/expected/dmesg/cid-decode b/tests/expected/dmesg/cid-decode
new file mode 100644
index 000000000..757b9284d
--- /dev/null
+++ b/tests/expected/dmesg/cid-decode
@@ -0,0 +1,106 @@
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
+local2:info  : [4557523.000000] [  T105] example[105]
diff --git a/tests/expected/dmesg/cid-delta b/tests/expected/dmesg/cid-delta
new file mode 100644
index 000000000..9b75c63af
--- /dev/null
+++ b/tests/expected/dmesg/cid-delta
@@ -0,0 +1,106 @@
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
+[4557523.000000 <3432659.000000>] [  T105] example[105]
diff --git a/tests/expected/dmesg/cid-facilities b/tests/expected/dmesg/cid-facilities
new file mode 100644
index 000000000..b8afa3809
--- /dev/null
+++ b/tests/expected/dmesg/cid-facilities
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
diff --git a/tests/expected/dmesg/cid-indentation b/tests/expected/dmesg/cid-indentation
new file mode 100644
index 000000000..573682795
--- /dev/null
+++ b/tests/expected/dmesg/cid-indentation
@@ -0,0 +1,35 @@
+[    1.000000] [    T1] new
+                        line
+[    2.000000] [    T2] two
+                        new
+                        lines
+user  :crit  : [    1.000000] [    T1] new
+                                       line
+mail  :warn  : [    2.000000] [    T2] two
+                                       new
+                                       lines
+[<    0.000000>] [    T1] new
+                          line
+[<    1.000000>] [    T2] two
+                          new
+                          lines
+[    T1] new
+         line
+[    T2] two
+         new
+         lines
+[Feb13 23:31] [    T1] new
+                       line
+[  +1.000000] [    T2] two
+                       new
+                       lines
+[Fri Feb 13 23:31:31 2009] [    T1] new
+                                    line
+[Fri Feb 13 23:31:32 2009] [    T2] two
+                                    new
+                                    lines
+2009-02-13T23:31:31,123456+00:00 [    T1] new
+                                          line
+2009-02-13T23:31:32,123456+00:00 [    T2] two
+                                          new
+                                          lines
diff --git a/tests/expected/dmesg/cid-limit b/tests/expected/dmesg/cid-limit
new file mode 100644
index 000000000..c30b4ac9a
--- /dev/null
+++ b/tests/expected/dmesg/cid-limit
@@ -0,0 +1,4 @@
+[    1.000000] [    T1] example[1]
+[    8.000000] [    T2] example[2]
+[   27.000000] [    T3] example[3]
+[   64.000000] [    T4] example[4]
diff --git a/tests/ts/dmesg/cid-colors b/tests/ts/dmesg/cid-colors
new file mode 100755
index 000000000..d17dd17c0
--- /dev/null
+++ b/tests/ts/dmesg/cid-colors
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
+TS_DESC="cid-colors"
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
+$TS_HELPER_DMESG --color=always -F $TS_SELF/cid-input -x >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/cid-console-levels b/tests/ts/dmesg/cid-console-levels
new file mode 100755
index 000000000..e2f241bde
--- /dev/null
+++ b/tests/ts/dmesg/cid-console-levels
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
+TS_DESC="cid-levels"
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
+	$TS_HELPER_DMESG -F $TS_SELF/cid-input -l $I >> $TS_OUTPUT 2>/dev/null
+done
+
+$TS_HELPER_DMESG -F $TS_SELF/cid-input -l err+ >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -F $TS_SELF/cid-input -l emerg+ >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -F $TS_SELF/cid-input -l +err >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -F $TS_SELF/cid-input -l +debug >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -F $TS_SELF/cid-input -l + 2>> $TS_OUTPUT >/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/cid-decode b/tests/ts/dmesg/cid-decode
new file mode 100755
index 000000000..488f52a32
--- /dev/null
+++ b/tests/ts/dmesg/cid-decode
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
+TS_DESC="cid-decode"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG -x -F $TS_SELF/cid-input >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/cid-delta b/tests/ts/dmesg/cid-delta
new file mode 100755
index 000000000..8ba952a5d
--- /dev/null
+++ b/tests/ts/dmesg/cid-delta
@@ -0,0 +1,27 @@
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
+TS_DESC="cid-delta"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+$TS_HELPER_DMESG -d -F $TS_SELF/cid-input >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/cid-facilities b/tests/ts/dmesg/cid-facilities
new file mode 100755
index 000000000..b4b613e8b
--- /dev/null
+++ b/tests/ts/dmesg/cid-facilities
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
+TS_DESC="cid-facilities"
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
+	$TS_HELPER_DMESG -F $TS_SELF/cid-input -f $I >> $TS_OUTPUT 2>/dev/null
+done
+
+ts_finalize
diff --git a/tests/ts/dmesg/cid-indentation b/tests/ts/dmesg/cid-indentation
new file mode 100755
index 000000000..434e1694b
--- /dev/null
+++ b/tests/ts/dmesg/cid-indentation
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
+TS_DESC="cid-indentation"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG -F $TS_SELF/cid-newlines >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG -F $TS_SELF/cid-newlines -x >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=delta --file $TS_SELF/cid-newlines >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=notime --file $TS_SELF/cid-newlines >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=reltime --file $TS_SELF/cid-newlines >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=ctime --file $TS_SELF/cid-newlines >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=iso --file $TS_SELF/cid-newlines >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+ts_finalize
diff --git a/tests/ts/dmesg/cid-limit b/tests/ts/dmesg/cid-limit
new file mode 100755
index 000000000..34f928a9e
--- /dev/null
+++ b/tests/ts/dmesg/cid-limit
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
+TS_DESC="cid-limit"
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
+	-F $TS_SELF/cid-input >> $TS_OUTPUT 2> $TS_ERRLOG
+
+ts_finalize
diff --git a/tests/ts/dmesg/cid-newlines b/tests/ts/dmesg/cid-newlines
new file mode 100644
index 000000000..682ce40bb
--- /dev/null
+++ b/tests/ts/dmesg/cid-newlines
@@ -0,0 +1,5 @@
+<10>[    1.000000] [    T1] new
+line
+<20>[    2.000000] [    T2] two
+new
+lines
-- 
2.43.0

