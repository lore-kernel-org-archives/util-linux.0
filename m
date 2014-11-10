Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f50.google.com ([74.125.82.50]:63174 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146AbaKJVuS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Nov 2014 16:50:18 -0500
Received: by mail-wg0-f50.google.com with SMTP id z12so10077444wgg.37
        for <util-linux@vger.kernel.org>; Mon, 10 Nov 2014 13:50:17 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 6/6] tests: mark python libmount tests known to fail with AddressSanitizer
Date: Mon, 10 Nov 2014 21:49:55 +0000
Message-Id: <1415656195-20458-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
References: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The tests fail with an error similar to this.

Traceback (most recent call last):
  File "/home/src/util-linux/libmount/python/test_mount_tab_update.py", line 7, in <module>
    import pylibmount as mnt
ImportError: /home/src/util-linux/.libs/libuuid.so.1: undefined symbol: __asan_option_detect_stack_use_after_return

It might be possible to build ASAN-DSO and set LD_PRELOAD, but this
solution is not officially supported.  See the reference for details.

Reference: https://code.google.com/p/address-sanitizer/wiki/AsanAsDso
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/ts/libmount/tabfiles-py      | 4 ++++
 tests/ts/libmount/tabfiles-tags    | 4 ++++
 tests/ts/libmount/tabfiles-tags-py | 4 ++++
 tests/ts/libmount/update-py        | 6 +++++-
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tests/ts/libmount/tabfiles-py b/tests/ts/libmount/tabfiles-py
index f0c4836..b157460 100755
--- a/tests/ts/libmount/tabfiles-py
+++ b/tests/ts/libmount/tabfiles-py
@@ -9,6 +9,10 @@ TS_DESC="tab files-py"
 ts_init "$*"
 ts_init_py libmount
 
+if [ -f "$ASAN_SYMBOLIZER_PATH" ]; then
+	TS_KNOWN_FAIL="yes"
+fi
+
 PYDBG="$PYTHON -m pdb"
 TESTPROG="$TS_HELPER_PYLIBMOUNT_TAB"
 [ -x $TESTPROG ] || ts_die "test script missing"
diff --git a/tests/ts/libmount/tabfiles-tags b/tests/ts/libmount/tabfiles-tags
index 1d9534b..15696b0 100755
--- a/tests/ts/libmount/tabfiles-tags
+++ b/tests/ts/libmount/tabfiles-tags
@@ -7,6 +7,10 @@ TS_DESC="tags"
 ts_init "$*"
 ts_skip_nonroot
 
+if [ -f "$ASAN_SYMBOLIZER_PATH" ]; then
+	TS_KNOWN_FAIL="yes"
+fi
+
 TESTPROG="$TS_HELPER_LIBMOUNT_TAB"
 
 [ -x $TESTPROG ] || ts_skip "test not compiled"
diff --git a/tests/ts/libmount/tabfiles-tags-py b/tests/ts/libmount/tabfiles-tags-py
index 2f462a0..d6ca470 100755
--- a/tests/ts/libmount/tabfiles-tags-py
+++ b/tests/ts/libmount/tabfiles-tags-py
@@ -8,6 +8,10 @@ ts_init "$*"
 ts_init_py libmount
 ts_skip_nonroot
 
+if [ -f "$ASAN_SYMBOLIZER_PATH" ]; then
+	TS_KNOWN_FAIL="yes"
+fi
+
 TESTPROG="$TS_HELPER_PYLIBMOUNT_TAB"
 [ -x $TESTPROG ] || ts_die "test script missing"
 
diff --git a/tests/ts/libmount/update-py b/tests/ts/libmount/update-py
index 6493224..66f1754 100755
--- a/tests/ts/libmount/update-py
+++ b/tests/ts/libmount/update-py
@@ -10,6 +10,10 @@ ts_init "$*"
 ts_init_py libmount
 ts_skip_nonroot
 
+if [ -f "$ASAN_SYMBOLIZER_PATH" ]; then
+	TS_KNOWN_FAIL="yes"
+fi
+
 TESTPROG="$TS_HELPER_PYLIBMOUNT_UPDATE"
 [ -x $TESTPROG ] || ts_die "test script missing"
 
@@ -21,7 +25,7 @@ rm -f $LIBMOUNT_FSTAB
 cp "$TS_SELF/files/fstab.comment" $LIBMOUNT_FSTAB
 
 ts_init_subtest "fstab-replace"
-$PYTHON $TESTPROG --replace "LABEL=foo" "/mnt/foo"
+$PYTHON $TESTPROG --replace "LABEL=foo" "/mnt/foo" >/dev/null 2>&1
 cp $LIBMOUNT_FSTAB $TS_OUTPUT	# save the fstab aside
 ts_finalize_subtest		#checks the fstab
 
-- 
2.1.3

