Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:58592 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537AbcCVQxR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 22 Mar 2016 12:53:17 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0LlV4F-1aAjYy0VKp-00bHT8 for
 <util-linux@vger.kernel.org>; Tue, 22 Mar 2016 17:53:15 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/3] tests: improve setarch tests regarding --uname-2.6 issues
Date: Tue, 22 Mar 2016 17:53:13 +0100
Message-Id: <1458665593-7963-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1458665593-7963-1-git-send-email-sweet_f_a@gmx.de>
References: <1458665593-7963-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

* add tests for error handling "unknown arch" and
  "unknown command"
* add test without any options
* handle "kernel too old" error for --uname-2.6, add
  debug output
* test --uname-2.6 whithout any other options
* use echo(1) and true(1) for --uname-2.6

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/misc/setarch | 18 ++++++++++++++-
 tests/ts/misc/setarch       | 54 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/tests/expected/misc/setarch b/tests/expected/misc/setarch
index 0024930..e06a752 100644
--- a/tests/expected/misc/setarch
+++ b/tests/expected/misc/setarch
@@ -1,3 +1,14 @@
+###### unknown arch
+setarch: qubit: Unrecognized architecture
+exit: 1
+###### unknown command
+Execute command `/das/gibs/nicht'.
+setarch: /das/gibs/nicht: No such file or directory
+exit: 1
+###### noop uname -a
+Execute command `uname'.
+uname -a unchanged
+###### almost all options
 Switching on ADDR_NO_RANDOMIZE.
 Switching on FDPIC_FUNCPTRS.
 Switching on MMAP_PAGE_ZERO.
@@ -8,6 +19,11 @@ Switching on SHORT_INODE.
 Switching on WHOLE_SECONDS.
 Switching on STICKY_TIMEOUTS.
 Switching on ADDR_LIMIT_3GB.
-Switching on UNAME26.
 Execute command `echo'.
 success
+###### --uname-2.6 echo
+Switching on UNAME26.
+Execute command `echo'.
+2.6 works or kernel too old
+###### --uname-2.6 true, non-verbose
+2.6 works or kernel too old
diff --git a/tests/ts/misc/setarch b/tests/ts/misc/setarch
index 9b0e92e..e4d22ae 100755
--- a/tests/ts/misc/setarch
+++ b/tests/ts/misc/setarch
@@ -18,16 +18,52 @@ TS_DESC="setarch"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ARCH=$(uname -m)
+
 ts_check_test_command "$TS_CMD_SETARCH"
 
-ARCH=$(uname -m)
-case $ARCH in
-	#  setarch --uname-2.6 fails on platforms without VDS
-	*sparc* )
-		ts_skip "unsupported arch"
-		;;
-esac
+echo "###### unknown arch" >>$TS_OUTPUT
+$TS_CMD_SETARCH "qubit" -v echo "success" >>$TS_OUTPUT 2>&1
+echo "exit: $?" >>$TS_OUTPUT
+
+echo "###### unknown command" >>$TS_OUTPUT
+$TS_CMD_SETARCH  $ARCH -v /das/gibs/nicht >>$TS_OUTPUT 2>&1
+echo "exit: $?" >>$TS_OUTPUT
+
+echo "###### noop uname -a" >>$TS_OUTPUT
+uname_a=$(uname -srm)
+$TS_CMD_SETARCH $ARCH -v uname -srm >>$TS_OUTPUT 2>&1
+sed -i "$ s@${uname_a}@uname -a unchanged@" $TS_OUTPUT
+
+echo "###### almost all options" >>$TS_OUTPUT
+$TS_CMD_SETARCH $ARCH -vRFZLXBIST3 echo "success" >>$TS_OUTPUT 2>&1
+
+finmsg="" # for debugging 2.6 issues
+
+echo "###### --uname-2.6 echo" >>$TS_OUTPUT
+$TS_CMD_SETARCH $ARCH -v --uname-2.6 echo "2.6 worked" >>$TS_OUTPUT 2>&1
+if [ $? -eq 0 ]; then
+	expected='^2.6 worked$'
+else
+	# this may happen after execvp
+	expected="^FATAL: kernel too old$"
+	finmsg+=" echo"
+fi
+sed -i "$ s/$expected/2.6 works or kernel too old/" $TS_OUTPUT
+
+echo "###### --uname-2.6 true, non-verbose" >>$TS_OUTPUT
+$TS_CMD_SETARCH $ARCH --uname-2.6 true >>$TS_OUTPUT 2>&1
+if [ $? -eq 0 ]; then
+	echo "2.6 works or kernel too old" >> $TS_OUTPUT
+else
+	# this may happen after execvp
+	expected="^FATAL: kernel too old$"
+	sed -i "$ s/$expected/2.6 works or kernel too old/" $TS_OUTPUT
+	finmsg+=" true"
+fi
 
-$TS_CMD_SETARCH $(uname -m) -vRFZLXBIST3 --uname-2.6 echo "success" >$TS_OUTPUT 2>&1
+if [ -n "$finmsg" ]; then
+	finmsg=$(echo unsupported --uname-2.6: $finmsg)
+fi
 
-ts_finalize
+ts_finalize "$finmsg"
-- 
1.8.4.5

