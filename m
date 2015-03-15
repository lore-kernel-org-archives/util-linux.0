Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38819 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbbCOMzM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 Mar 2015 08:55:12 -0400
Received: by wifj2 with SMTP id j2so21673012wif.1
        for <util-linux@vger.kernel.org>; Sun, 15 Mar 2015 05:55:11 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 6/8] tests: add logger(1) message format tests
Date: Sun, 15 Mar 2015 12:54:52 +0000
Message-Id: <1426424094-25451-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
References: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/logger/formats                |   0
 tests/expected/logger/formats-priorities     | 152 +++++++++++++++++++++++++++
 tests/expected/logger/formats-rfc3164        |   1 +
 tests/expected/logger/formats-rfc5424_msgid  |   1 +
 tests/expected/logger/formats-rfc5424_nohost |   1 +
 tests/expected/logger/formats-rfc5424_notime |   1 +
 tests/expected/logger/formats-rfc5424_simple |   1 +
 tests/ts/logger/formats                      |  53 ++++++++++
 8 files changed, 210 insertions(+)
 create mode 100644 tests/expected/logger/formats
 create mode 100644 tests/expected/logger/formats-priorities
 create mode 100644 tests/expected/logger/formats-rfc3164
 create mode 100644 tests/expected/logger/formats-rfc5424_msgid
 create mode 100644 tests/expected/logger/formats-rfc5424_nohost
 create mode 100644 tests/expected/logger/formats-rfc5424_notime
 create mode 100644 tests/expected/logger/formats-rfc5424_simple
 create mode 100755 tests/ts/logger/formats

diff --git a/tests/expected/logger/formats b/tests/expected/logger/formats
new file mode 100644
index 0000000..e69de29
diff --git a/tests/expected/logger/formats-priorities b/tests/expected/logger/formats-priorities
new file mode 100644
index 0000000..32d136f
--- /dev/null
+++ b/tests/expected/logger/formats-priorities
@@ -0,0 +1,152 @@
+<32>Feb 13 23:31:30 prio: auth.emerg
+<33>Feb 13 23:31:30 prio: auth.alert
+<34>Feb 13 23:31:30 prio: auth.crit
+<35>Feb 13 23:31:30 prio: auth.err
+<36>Feb 13 23:31:30 prio: auth.warning
+<37>Feb 13 23:31:30 prio: auth.notice
+<38>Feb 13 23:31:30 prio: auth.info
+<39>Feb 13 23:31:30 prio: auth.debug
+<80>Feb 13 23:31:30 prio: authpriv.emerg
+<81>Feb 13 23:31:30 prio: authpriv.alert
+<82>Feb 13 23:31:30 prio: authpriv.crit
+<83>Feb 13 23:31:30 prio: authpriv.err
+<84>Feb 13 23:31:30 prio: authpriv.warning
+<85>Feb 13 23:31:30 prio: authpriv.notice
+<86>Feb 13 23:31:30 prio: authpriv.info
+<87>Feb 13 23:31:30 prio: authpriv.debug
+<72>Feb 13 23:31:30 prio: cron.emerg
+<73>Feb 13 23:31:30 prio: cron.alert
+<74>Feb 13 23:31:30 prio: cron.crit
+<75>Feb 13 23:31:30 prio: cron.err
+<76>Feb 13 23:31:30 prio: cron.warning
+<77>Feb 13 23:31:30 prio: cron.notice
+<78>Feb 13 23:31:30 prio: cron.info
+<79>Feb 13 23:31:30 prio: cron.debug
+<24>Feb 13 23:31:30 prio: daemon.emerg
+<25>Feb 13 23:31:30 prio: daemon.alert
+<26>Feb 13 23:31:30 prio: daemon.crit
+<27>Feb 13 23:31:30 prio: daemon.err
+<28>Feb 13 23:31:30 prio: daemon.warning
+<29>Feb 13 23:31:30 prio: daemon.notice
+<30>Feb 13 23:31:30 prio: daemon.info
+<31>Feb 13 23:31:30 prio: daemon.debug
+<88>Feb 13 23:31:30 prio: ftp.emerg
+<89>Feb 13 23:31:30 prio: ftp.alert
+<90>Feb 13 23:31:30 prio: ftp.crit
+<91>Feb 13 23:31:30 prio: ftp.err
+<92>Feb 13 23:31:30 prio: ftp.warning
+<93>Feb 13 23:31:30 prio: ftp.notice
+<94>Feb 13 23:31:30 prio: ftp.info
+<95>Feb 13 23:31:30 prio: ftp.debug
+<48>Feb 13 23:31:30 prio: lpr.emerg
+<49>Feb 13 23:31:30 prio: lpr.alert
+<50>Feb 13 23:31:30 prio: lpr.crit
+<51>Feb 13 23:31:30 prio: lpr.err
+<52>Feb 13 23:31:30 prio: lpr.warning
+<53>Feb 13 23:31:30 prio: lpr.notice
+<54>Feb 13 23:31:30 prio: lpr.info
+<55>Feb 13 23:31:30 prio: lpr.debug
+<16>Feb 13 23:31:30 prio: mail.emerg
+<17>Feb 13 23:31:30 prio: mail.alert
+<18>Feb 13 23:31:30 prio: mail.crit
+<19>Feb 13 23:31:30 prio: mail.err
+<20>Feb 13 23:31:30 prio: mail.warning
+<21>Feb 13 23:31:30 prio: mail.notice
+<22>Feb 13 23:31:30 prio: mail.info
+<23>Feb 13 23:31:30 prio: mail.debug
+<56>Feb 13 23:31:30 prio: news.emerg
+<57>Feb 13 23:31:30 prio: news.alert
+<58>Feb 13 23:31:30 prio: news.crit
+<59>Feb 13 23:31:30 prio: news.err
+<60>Feb 13 23:31:30 prio: news.warning
+<61>Feb 13 23:31:30 prio: news.notice
+<62>Feb 13 23:31:30 prio: news.info
+<63>Feb 13 23:31:30 prio: news.debug
+<40>Feb 13 23:31:30 prio: syslog.emerg
+<41>Feb 13 23:31:30 prio: syslog.alert
+<42>Feb 13 23:31:30 prio: syslog.crit
+<43>Feb 13 23:31:30 prio: syslog.err
+<44>Feb 13 23:31:30 prio: syslog.warning
+<45>Feb 13 23:31:30 prio: syslog.notice
+<46>Feb 13 23:31:30 prio: syslog.info
+<47>Feb 13 23:31:30 prio: syslog.debug
+<8>Feb 13 23:31:30 prio: user.emerg
+<9>Feb 13 23:31:30 prio: user.alert
+<10>Feb 13 23:31:30 prio: user.crit
+<11>Feb 13 23:31:30 prio: user.err
+<12>Feb 13 23:31:30 prio: user.warning
+<13>Feb 13 23:31:30 prio: user.notice
+<14>Feb 13 23:31:30 prio: user.info
+<15>Feb 13 23:31:30 prio: user.debug
+<64>Feb 13 23:31:30 prio: uucp.emerg
+<65>Feb 13 23:31:30 prio: uucp.alert
+<66>Feb 13 23:31:30 prio: uucp.crit
+<67>Feb 13 23:31:30 prio: uucp.err
+<68>Feb 13 23:31:30 prio: uucp.warning
+<69>Feb 13 23:31:30 prio: uucp.notice
+<70>Feb 13 23:31:30 prio: uucp.info
+<71>Feb 13 23:31:30 prio: uucp.debug
+<128>Feb 13 23:31:30 prio: local0.emerg
+<129>Feb 13 23:31:30 prio: local0.alert
+<130>Feb 13 23:31:30 prio: local0.crit
+<131>Feb 13 23:31:30 prio: local0.err
+<132>Feb 13 23:31:30 prio: local0.warning
+<133>Feb 13 23:31:30 prio: local0.notice
+<134>Feb 13 23:31:30 prio: local0.info
+<135>Feb 13 23:31:30 prio: local0.debug
+<136>Feb 13 23:31:30 prio: local1.emerg
+<137>Feb 13 23:31:30 prio: local1.alert
+<138>Feb 13 23:31:30 prio: local1.crit
+<139>Feb 13 23:31:30 prio: local1.err
+<140>Feb 13 23:31:30 prio: local1.warning
+<141>Feb 13 23:31:30 prio: local1.notice
+<142>Feb 13 23:31:30 prio: local1.info
+<143>Feb 13 23:31:30 prio: local1.debug
+<144>Feb 13 23:31:30 prio: local2.emerg
+<145>Feb 13 23:31:30 prio: local2.alert
+<146>Feb 13 23:31:30 prio: local2.crit
+<147>Feb 13 23:31:30 prio: local2.err
+<148>Feb 13 23:31:30 prio: local2.warning
+<149>Feb 13 23:31:30 prio: local2.notice
+<150>Feb 13 23:31:30 prio: local2.info
+<151>Feb 13 23:31:30 prio: local2.debug
+<152>Feb 13 23:31:30 prio: local3.emerg
+<153>Feb 13 23:31:30 prio: local3.alert
+<154>Feb 13 23:31:30 prio: local3.crit
+<155>Feb 13 23:31:30 prio: local3.err
+<156>Feb 13 23:31:30 prio: local3.warning
+<157>Feb 13 23:31:30 prio: local3.notice
+<158>Feb 13 23:31:30 prio: local3.info
+<159>Feb 13 23:31:30 prio: local3.debug
+<160>Feb 13 23:31:30 prio: local4.emerg
+<161>Feb 13 23:31:30 prio: local4.alert
+<162>Feb 13 23:31:30 prio: local4.crit
+<163>Feb 13 23:31:30 prio: local4.err
+<164>Feb 13 23:31:30 prio: local4.warning
+<165>Feb 13 23:31:30 prio: local4.notice
+<166>Feb 13 23:31:30 prio: local4.info
+<167>Feb 13 23:31:30 prio: local4.debug
+<168>Feb 13 23:31:30 prio: local5.emerg
+<169>Feb 13 23:31:30 prio: local5.alert
+<170>Feb 13 23:31:30 prio: local5.crit
+<171>Feb 13 23:31:30 prio: local5.err
+<172>Feb 13 23:31:30 prio: local5.warning
+<173>Feb 13 23:31:30 prio: local5.notice
+<174>Feb 13 23:31:30 prio: local5.info
+<175>Feb 13 23:31:30 prio: local5.debug
+<176>Feb 13 23:31:30 prio: local6.emerg
+<177>Feb 13 23:31:30 prio: local6.alert
+<178>Feb 13 23:31:30 prio: local6.crit
+<179>Feb 13 23:31:30 prio: local6.err
+<180>Feb 13 23:31:30 prio: local6.warning
+<181>Feb 13 23:31:30 prio: local6.notice
+<182>Feb 13 23:31:30 prio: local6.info
+<183>Feb 13 23:31:30 prio: local6.debug
+<184>Feb 13 23:31:30 prio: local7.emerg
+<185>Feb 13 23:31:30 prio: local7.alert
+<186>Feb 13 23:31:30 prio: local7.crit
+<187>Feb 13 23:31:30 prio: local7.err
+<188>Feb 13 23:31:30 prio: local7.warning
+<189>Feb 13 23:31:30 prio: local7.notice
+<190>Feb 13 23:31:30 prio: local7.info
+<191>Feb 13 23:31:30 prio: local7.debug
diff --git a/tests/expected/logger/formats-rfc3164 b/tests/expected/logger/formats-rfc3164
new file mode 100644
index 0000000..0353460
--- /dev/null
+++ b/tests/expected/logger/formats-rfc3164
@@ -0,0 +1 @@
+<13>Feb 13 23:31:30 test-hostname rfc3164: message
diff --git a/tests/expected/logger/formats-rfc5424_msgid b/tests/expected/logger/formats-rfc5424_msgid
new file mode 100644
index 0000000..2ebe0de
--- /dev/null
+++ b/tests/expected/logger/formats-rfc5424_msgid
@@ -0,0 +1 @@
+<13>1 2009-02-13T23:31:30.123456+00:00 test-hostname rfc5424 - MSGID [timeQuality tzKnown="1" isSynced="1" syncAccuracy="123456"] message
diff --git a/tests/expected/logger/formats-rfc5424_nohost b/tests/expected/logger/formats-rfc5424_nohost
new file mode 100644
index 0000000..15d80a2
--- /dev/null
+++ b/tests/expected/logger/formats-rfc5424_nohost
@@ -0,0 +1 @@
+<13>1 2009-02-13T23:31:30.123456+00:00 - rfc5424 - - [timeQuality tzKnown="1" isSynced="1" syncAccuracy="123456"] message
diff --git a/tests/expected/logger/formats-rfc5424_notime b/tests/expected/logger/formats-rfc5424_notime
new file mode 100644
index 0000000..1b434de
--- /dev/null
+++ b/tests/expected/logger/formats-rfc5424_notime
@@ -0,0 +1 @@
+<13>1 - test-hostname rfc5424 - -  message
diff --git a/tests/expected/logger/formats-rfc5424_simple b/tests/expected/logger/formats-rfc5424_simple
new file mode 100644
index 0000000..b14789e
--- /dev/null
+++ b/tests/expected/logger/formats-rfc5424_simple
@@ -0,0 +1 @@
+<13>1 2009-02-13T23:31:30.123456+00:00 test-hostname rfc5424 - - [timeQuality tzKnown="1" isSynced="1" syncAccuracy="123456"] message
diff --git a/tests/ts/logger/formats b/tests/ts/logger/formats
new file mode 100755
index 0000000..cb7f61b
--- /dev/null
+++ b/tests/ts/logger/formats
@@ -0,0 +1,53 @@
+#!/bin/bash
+
+#
+# Copyright (C) 2015 Sami Kerola <kerolasa@iki.fi>
+#
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
+#
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="formats"
+
+. $TS_TOPDIR/functions.sh
+
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_LOGGER"
+
+ts_init_subtest "rfc3164"
+$TS_HELPER_LOGGER -s -t "rfc3164" --rfc3164 "message" > "$TS_OUTPUT" 2>&1
+ts_finalize_subtest
+
+ts_init_subtest "rfc5424_simple"
+$TS_HELPER_LOGGER -s -t "rfc5424" --rfc5424 "message" > "$TS_OUTPUT" 2>&1
+ts_finalize_subtest
+ts_init_subtest "rfc5424_notime"
+$TS_HELPER_LOGGER -s -t "rfc5424" --rfc5424=notime "message" > "$TS_OUTPUT" 2>&1
+ts_finalize_subtest
+ts_init_subtest "rfc5424_nohost"
+$TS_HELPER_LOGGER -s -t "rfc5424" --rfc5424=nohost "message" > "$TS_OUTPUT" 2>&1
+ts_finalize_subtest
+ts_init_subtest "rfc5424_msgid"
+$TS_HELPER_LOGGER -s -t "rfc5424" --rfc5424 --msgid "MSGID" "message" > "$TS_OUTPUT" 2>&1
+ts_finalize_subtest
+
+ts_init_subtest "priorities"
+for facility in auth authpriv cron daemon ftp lpr mail news syslog user uucp local{0..7}; do
+	for level in emerg alert crit err warning notice info debug; do
+		$TS_HELPER_LOGGER -s -t "prio" -p "$facility.$level" "$facility.$level" >> "$TS_OUTPUT" 2>&1
+	done
+done
+ts_finalize_subtest
+
+ts_finalize
-- 
2.3.2

