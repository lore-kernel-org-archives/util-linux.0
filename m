Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:61829 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932100AbbC0M1q (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Mar 2015 08:27:46 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0M4Wwq-1ZP2eS2CRo-00yheW for
 <util-linux@vger.kernel.org>; Fri, 27 Mar 2015 13:27:44 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: sfdisk: readline support
Date: Fri, 27 Mar 2015 13:27:43 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201503271327.43178.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

Adding readline broke some sfdisk tests. See diffs below


commit 7159b496d5f86a240b5915a213a4e3a24926e407
Author: Karel Zak <kzak@redhat.com>
Date:   Wed Mar 25 16:06:39 2015 +0100

    sfdisk: add readline support


$ sudo make check TS_OPTS="--parallel=1 sfdisk"

sfdisk: MBR                            ...
    : simple-commas               ... OK
    : activate                    ... OK
    : simple-space                ... OK
    : read-dump                   ... FAILED (sfdisk/dos-read-dump)
    : write-dump                  ... OK
    : explicit-size               ... FAILED (sfdisk/dos-explicit-size)
  ... FAILED (2 from 6 sub-tests)
sfdisk: GPT                            ...
    : all-defaults                ... FAILED (sfdisk/gpt-all-defaults)
    : uuid                        ... OK
    : label                       ... OK
    : type                        ... OK
    : attrs                       ... OK
    : read-dump                   ... FAILED (sfdisk/gpt-read-dump)
    : write-dump                  ... OK
    : list-pmbr                   ... OK
  ... FAILED (2 from 8 sub-tests)


$ cat tests/diff/sfdisk/*

--- /home/rudi/devel/util-linux/tests/expected/sfdisk/dos-explicit-size 2015-03-24 13:58:18.260127383 +0100
+++ /home/rudi/devel/util-linux/build/tests/output/sfdisk/dos-explicit-size     2015-03-27 12:57:01.984412805 +0100
@@ -1,10 +1,3 @@
-Partition 1 does not start on physical sector boundary.
-Partition 2 does not start on physical sector boundary.
-Partition 3 does not start on physical sector boundary.
-Partition 4 does not start on physical sector boundary.
-Partition 5 does not start on physical sector boundary.
-Partition 6 does not start on physical sector boundary.
-Partition 7 does not start on physical sector boundary.
 Checking that no-one is using this disk right now ... OK

 Disk <removed>: 50 MiB, 52428800 bytes, 102400 sectors
@@ -21,7 +14,14 @@
 <removed>5: Created a new <removed>.
 <removed>6: Created a new <removed>.
 <removed>7: Created a new <removed>.
-<removed>8:
+<removed>8: Partition 1 does not start on physical sector boundary.
+Partition 2 does not start on physical sector boundary.
+Partition 3 does not start on physical sector boundary.
+Partition 4 does not start on physical sector boundary.
+Partition 5 does not start on physical sector boundary.
+Partition 6 does not start on physical sector boundary.
+Partition 7 does not start on physical sector boundary.
+
 New situation:

 Device     Boot Start    End Sectors  Size Id Type
--- /home/rudi/devel/util-linux/tests/expected/sfdisk/dos-read-dump     2015-03-24 13:58:18.261127378 +0100
+++ /home/rudi/devel/util-linux/build/tests/output/sfdisk/dos-read-dump 2015-03-27 12:57:01.467417762 +0100
@@ -1,5 +1,3 @@
-Partition 5 does not start on physical sector boundary.
-Partition 6 does not start on physical sector boundary.
 Checking that no-one is using this disk right now ... OK

 Disk <removed>: 50 MiB, 52428800 bytes, 102400 sectors
@@ -9,14 +7,16 @@

 >>> Script header accepted.
 >>> Script header accepted.
->>> Created a new <removed>.
+>>> >>> Created a new <removed>.
 Created a new <removed>.
 <removed>2: Created a new <removed>.
 <removed>3: Created a new <removed>.
 <removed>4: Created a new <removed>.
 <removed>5: Created a new <removed>.
 <removed>6: Created a new <removed>.
-<removed>7:
+<removed>7: Partition 5 does not start on physical sector boundary.
+Partition 6 does not start on physical sector boundary.
+
 New situation:

 Device     Boot Start    End Sectors Size Id Type
--- /home/rudi/devel/util-linux/tests/expected/sfdisk/gpt-all-defaults  2015-03-24 13:58:18.266127352 +0100
+++ /home/rudi/devel/util-linux/build/tests/output/sfdisk/gpt-all-defaults      2015-03-27 12:57:03.583397476 +0100
@@ -7,7 +7,7 @@

 >>> Script header accepted.
 >>> Script header accepted.
->>> Created a new <removed>.
+>>> >>> Created a new <removed>.
 Created a new <removed>.
 <removed>2: Created a new <removed>.
 <removed>3: Created a new <removed>.
--- /home/rudi/devel/util-linux/tests/expected/sfdisk/gpt-read-dump     2015-03-24 13:58:18.270127330 +0100
+++ /home/rudi/devel/util-linux/build/tests/output/sfdisk/gpt-read-dump 2015-03-27 12:57:05.740376800 +0100
@@ -8,7 +8,7 @@
 >>> Script header accepted.
 >>> Script header accepted.
 >>> Script header accepted.
->>> Created a new <removed>.
+>>> >>> Created a new <removed>.
 Created a new <removed>.
 <removed>2: Created a new <removed>.
 <removed>3: Created a new <removed>.


cu,
Rudi
