Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f173.google.com ([209.85.217.173]:32809 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbcDBP6Z (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 2 Apr 2016 11:58:25 -0400
Received: by mail-lb0-f173.google.com with SMTP id u8so101385441lbk.0
        for <util-linux@vger.kernel.org>; Sat, 02 Apr 2016 08:58:24 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] colcrt: avoid the command getting hung [afl]
Date: Sat,  2 Apr 2016 16:58:14 +0100
Message-Id: <1459612694-30128-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Some inputs make getwc(3) not to progress file descriptor and neither to
report EILSEQ.  Detect such situation and skip the bad input.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/colcrt                            | Bin 0 -> 14720 bytes
 tests/expected/colcrt/regressions-hang1 |   3 +++
 tests/ts/colcrt/hang1                   |   1 +
 tests/ts/colcrt/regressions             |   3 ++-
 text-utils/colcrt.c                     |   7 +++++++
 5 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100755 tests/colcrt
 create mode 100644 tests/expected/colcrt/regressions-hang1
 create mode 100644 tests/ts/colcrt/hang1

diff --git a/tests/colcrt b/tests/colcrt
new file mode 100755
index 0000000000000000000000000000000000000000..d8c792bcae3fb52d48c2ad8cfe65af0838c02a10
GIT binary patch
literal 14720
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
Fe*kVR+V%hd

literal 0
HcmV?d00001

diff --git a/tests/expected/colcrt/regressions-hang1 b/tests/expected/colcrt/regressions-hang1
new file mode 100644
index 0000000..cb16e46
--- /dev/null
+++ b/tests/expected/colcrt/regressions-hang1
@@ -0,0 +1,3 @@
+789:;<=>=>?IABUVNXYZ[ `abcdefgg !"#$%&'()*+,-./01234)*:,-./0123456789:;[=>?1234)*:,-./0123456789:;[=>?4456789:;<=>?IABUVN`abcdefg !"
+                     -
+return value: 0
diff --git a/tests/ts/colcrt/hang1 b/tests/ts/colcrt/hang1
new file mode 100644
index 0000000..d26259e
--- /dev/null
+++ b/tests/ts/colcrt/hang1
@@ -0,0 +1 @@
+789:;<=>=>?IABUVNXYZ[_`abcdefgg !"#$%&'()*+,-./01234)*:,-./0123456789:;[=>?1234)*:,-./0123456789:;[=>?4456789:;<=>?IABUVN`abcdefg !" $%&'()*+,-./0123z{|ü~e
\ No newline at end of file
diff --git a/tests/ts/colcrt/regressions b/tests/ts/colcrt/regressions
index 067523f..2ab751c 100755
--- a/tests/ts/colcrt/regressions
+++ b/tests/ts/colcrt/regressions
@@ -23,12 +23,13 @@ ts_check_test_command "$TS_CMD_COLCRT"
 
 check_input_file() {
 	ts_init_subtest ${1##*/}
-	$TS_CMD_COLCRT < $1 > $TS_OUTPUT 2>&1
+	timeout 2 $TS_CMD_COLCRT < $1 > $TS_OUTPUT 2>&1
 	echo "return value: $?" >> $TS_OUTPUT
 	ts_finalize_subtest
 }
 
 check_input_file "$TS_SELF/crash1"
 check_input_file "$TS_SELF/crash2"
+check_input_file "$TS_SELF/hang1"
 
 ts_finalize
diff --git a/text-utils/colcrt.c b/text-utils/colcrt.c
index abe3a07..62f8425 100644
--- a/text-utils/colcrt.c
+++ b/text-utils/colcrt.c
@@ -152,6 +152,7 @@ static void colcrt(struct colcrt_control *ctl)
 {
 	int col;
 	wint_t c;
+	long old_pos;
 
 	ctl->print_nl = 1;
 	if (ctl->half_lines)
@@ -161,7 +162,13 @@ static void colcrt(struct colcrt_control *ctl)
 		if (OUTPUT_COLS - 1 < col) {
 			output_lines(ctl, col);
 			errno = 0;
+			old_pos = ftell(ctl->f);
 			while ((c = getwc(ctl->f)) != L'\n') {
+				long new_pos = ftell(ctl->f);
+				if (old_pos == new_pos)
+					fseek(ctl->f, 1, SEEK_CUR);
+				else
+					old_pos = new_pos;
 				if (errno == 0 && c == WEOF)
 					return;
 				else
-- 
2.8.0

