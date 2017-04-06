Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:58255 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756788AbdDFH4R (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 6 Apr 2017 03:56:17 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Masatake YAMATO <yamato@redhat.com>
Subject: [PATCH 2/5] tests: fix fincore/count for PAGE_SIZE != 4096
Date: Thu,  6 Apr 2017 09:56:02 +0200
Message-Id: <1491465365-7515-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1491465365-7515-1-git-send-email-sweet_f_a@gmx.de>
References: <1491465365-7515-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/fincore/count        | 55 -------------------------------------
 tests/expected/fincore/count.4096   | 55 +++++++++++++++++++++++++++++++++++++
 tests/expected/fincore/count.65536  | 55 +++++++++++++++++++++++++++++++++++++
 tests/expected/fincore/count.nosize | 55 +++++++++++++++++++++++++++++++++++++
 tests/ts/fincore/count              | 18 +++++++++---
 5 files changed, 179 insertions(+), 59 deletions(-)
 delete mode 100644 tests/expected/fincore/count
 create mode 100644 tests/expected/fincore/count.4096
 create mode 100644 tests/expected/fincore/count.65536
 create mode 100644 tests/expected/fincore/count.nosize

diff --git a/tests/expected/fincore/count b/tests/expected/fincore/count
deleted file mode 100644
index 4665136..0000000
--- a/tests/expected/fincore/count
+++ /dev/null
@@ -1,55 +0,0 @@
-[ NO EXCITING FILE ]
-fincore: failed to open: no_such_file: No such file or directory
-return value: 1
-    0    0 i_EMPTY_FILE
-return value: 0
-    1  4095 i_PAGESIZE_-1__incore_
-return value: 0
-    1  4096 i_JUST_PAGESIZE_incore_
-return value: 0
-    0  4096 i_JUST_PAGESIZE_directio_
-return value: 0
-    2  8192 i_TWO_PAGES_incore_
-return value: 0
-    0  8192 i_TWO_PAGES_directio_
-return value: 0
-    1  8192 i_TWO_PAGES_mixed_directio_incore_
-return value: 0
-    1  8192 i_TWO_PAGES_mixed_incore_directio_
-return value: 0
-    2 134213632 i_WINDOW_SIZE_incore-sparse-incore_
-return value: 0
-    0 134213632 i_WINDOW_SIZE_directio-sparse-directio_
-return value: 0
-    1 134213632 i_WINDOW_SIZE_incore-sparse-directio_
-return value: 0
-    1 134213632 i_WINDOW_SIZE_directio-sparse-incore_
-return value: 0
-    2 134217728 i_WINDOW_SIZE_+_1_page_incore-sparse-incore_
-return value: 0
-    0 134217728 i_WINDOW_SIZE_+_1_page_directio-sparse-directio_
-return value: 0
-    1 134217728 i_WINDOW_SIZE_+_1_page_incore-sparse-directio_
-return value: 0
-    1 134217728 i_WINDOW_SIZE_+_1_page_directio-sparse-incore_
-return value: 0
-[ MULTIPLE FILES ]
-fincore: failed to open: no_such_file: No such file or directory
-PAGES      SIZE FILE
-    0         0 i_EMPTY_FILE
-    1      4095 i_PAGESIZE_-1__incore_
-    1      4096 i_JUST_PAGESIZE_incore_
-    0      4096 i_JUST_PAGESIZE_directio_
-    2      8192 i_TWO_PAGES_incore_
-    0      8192 i_TWO_PAGES_directio_
-    1      8192 i_TWO_PAGES_mixed_directio_incore_
-    1      8192 i_TWO_PAGES_mixed_incore_directio_
-    2 134213632 i_WINDOW_SIZE_incore-sparse-incore_
-    0 134213632 i_WINDOW_SIZE_directio-sparse-directio_
-    1 134213632 i_WINDOW_SIZE_incore-sparse-directio_
-    1 134213632 i_WINDOW_SIZE_directio-sparse-incore_
-    2 134217728 i_WINDOW_SIZE_+_1_page_incore-sparse-incore_
-    0 134217728 i_WINDOW_SIZE_+_1_page_directio-sparse-directio_
-    1 134217728 i_WINDOW_SIZE_+_1_page_incore-sparse-directio_
-    1 134217728 i_WINDOW_SIZE_+_1_page_directio-sparse-incore_
-return value: 1
diff --git a/tests/expected/fincore/count.4096 b/tests/expected/fincore/count.4096
new file mode 100644
index 0000000..4665136
--- /dev/null
+++ b/tests/expected/fincore/count.4096
@@ -0,0 +1,55 @@
+[ NO EXCITING FILE ]
+fincore: failed to open: no_such_file: No such file or directory
+return value: 1
+    0    0 i_EMPTY_FILE
+return value: 0
+    1  4095 i_PAGESIZE_-1__incore_
+return value: 0
+    1  4096 i_JUST_PAGESIZE_incore_
+return value: 0
+    0  4096 i_JUST_PAGESIZE_directio_
+return value: 0
+    2  8192 i_TWO_PAGES_incore_
+return value: 0
+    0  8192 i_TWO_PAGES_directio_
+return value: 0
+    1  8192 i_TWO_PAGES_mixed_directio_incore_
+return value: 0
+    1  8192 i_TWO_PAGES_mixed_incore_directio_
+return value: 0
+    2 134213632 i_WINDOW_SIZE_incore-sparse-incore_
+return value: 0
+    0 134213632 i_WINDOW_SIZE_directio-sparse-directio_
+return value: 0
+    1 134213632 i_WINDOW_SIZE_incore-sparse-directio_
+return value: 0
+    1 134213632 i_WINDOW_SIZE_directio-sparse-incore_
+return value: 0
+    2 134217728 i_WINDOW_SIZE_+_1_page_incore-sparse-incore_
+return value: 0
+    0 134217728 i_WINDOW_SIZE_+_1_page_directio-sparse-directio_
+return value: 0
+    1 134217728 i_WINDOW_SIZE_+_1_page_incore-sparse-directio_
+return value: 0
+    1 134217728 i_WINDOW_SIZE_+_1_page_directio-sparse-incore_
+return value: 0
+[ MULTIPLE FILES ]
+fincore: failed to open: no_such_file: No such file or directory
+PAGES      SIZE FILE
+    0         0 i_EMPTY_FILE
+    1      4095 i_PAGESIZE_-1__incore_
+    1      4096 i_JUST_PAGESIZE_incore_
+    0      4096 i_JUST_PAGESIZE_directio_
+    2      8192 i_TWO_PAGES_incore_
+    0      8192 i_TWO_PAGES_directio_
+    1      8192 i_TWO_PAGES_mixed_directio_incore_
+    1      8192 i_TWO_PAGES_mixed_incore_directio_
+    2 134213632 i_WINDOW_SIZE_incore-sparse-incore_
+    0 134213632 i_WINDOW_SIZE_directio-sparse-directio_
+    1 134213632 i_WINDOW_SIZE_incore-sparse-directio_
+    1 134213632 i_WINDOW_SIZE_directio-sparse-incore_
+    2 134217728 i_WINDOW_SIZE_+_1_page_incore-sparse-incore_
+    0 134217728 i_WINDOW_SIZE_+_1_page_directio-sparse-directio_
+    1 134217728 i_WINDOW_SIZE_+_1_page_incore-sparse-directio_
+    1 134217728 i_WINDOW_SIZE_+_1_page_directio-sparse-incore_
+return value: 1
diff --git a/tests/expected/fincore/count.65536 b/tests/expected/fincore/count.65536
new file mode 100644
index 0000000..0a9fab4
--- /dev/null
+++ b/tests/expected/fincore/count.65536
@@ -0,0 +1,55 @@
+[ NO EXCITING FILE ]
+fincore: failed to open: no_such_file: No such file or directory
+return value: 1
+    0    0 i_EMPTY_FILE
+return value: 0
+    1 65535 i_PAGESIZE_-1__incore_
+return value: 0
+    1 65536 i_JUST_PAGESIZE_incore_
+return value: 0
+    0 65536 i_JUST_PAGESIZE_directio_
+return value: 0
+    2 131072 i_TWO_PAGES_incore_
+return value: 0
+    0 131072 i_TWO_PAGES_directio_
+return value: 0
+    1 131072 i_TWO_PAGES_mixed_directio_incore_
+return value: 0
+    1 131072 i_TWO_PAGES_mixed_incore_directio_
+return value: 0
+    2 2147418112 i_WINDOW_SIZE_incore-sparse-incore_
+return value: 0
+    0 2147418112 i_WINDOW_SIZE_directio-sparse-directio_
+return value: 0
+    1 2147418112 i_WINDOW_SIZE_incore-sparse-directio_
+return value: 0
+    1 2147418112 i_WINDOW_SIZE_directio-sparse-incore_
+return value: 0
+    2 2147483648 i_WINDOW_SIZE_+_1_page_incore-sparse-incore_
+return value: 0
+    0 2147483648 i_WINDOW_SIZE_+_1_page_directio-sparse-directio_
+return value: 0
+    1 2147483648 i_WINDOW_SIZE_+_1_page_incore-sparse-directio_
+return value: 0
+    1 2147483648 i_WINDOW_SIZE_+_1_page_directio-sparse-incore_
+return value: 0
+[ MULTIPLE FILES ]
+fincore: failed to open: no_such_file: No such file or directory
+PAGES       SIZE FILE
+    0          0 i_EMPTY_FILE
+    1      65535 i_PAGESIZE_-1__incore_
+    1      65536 i_JUST_PAGESIZE_incore_
+    0      65536 i_JUST_PAGESIZE_directio_
+    2     131072 i_TWO_PAGES_incore_
+    0     131072 i_TWO_PAGES_directio_
+    1     131072 i_TWO_PAGES_mixed_directio_incore_
+    1     131072 i_TWO_PAGES_mixed_incore_directio_
+    2 2147418112 i_WINDOW_SIZE_incore-sparse-incore_
+    0 2147418112 i_WINDOW_SIZE_directio-sparse-directio_
+    1 2147418112 i_WINDOW_SIZE_incore-sparse-directio_
+    1 2147418112 i_WINDOW_SIZE_directio-sparse-incore_
+    2 2147483648 i_WINDOW_SIZE_+_1_page_incore-sparse-incore_
+    0 2147483648 i_WINDOW_SIZE_+_1_page_directio-sparse-directio_
+    1 2147483648 i_WINDOW_SIZE_+_1_page_incore-sparse-directio_
+    1 2147483648 i_WINDOW_SIZE_+_1_page_directio-sparse-incore_
+return value: 1
diff --git a/tests/expected/fincore/count.nosize b/tests/expected/fincore/count.nosize
new file mode 100644
index 0000000..d570445
--- /dev/null
+++ b/tests/expected/fincore/count.nosize
@@ -0,0 +1,55 @@
+[ NO EXCITING FILE ]
+fincore: failed to open: no_such_file: No such file or directory
+return value: 1
+    0 i_EMPTY_FILE
+return value: 0
+    1 i_PAGESIZE_-1__incore_
+return value: 0
+    1 i_JUST_PAGESIZE_incore_
+return value: 0
+    0 i_JUST_PAGESIZE_directio_
+return value: 0
+    2 i_TWO_PAGES_incore_
+return value: 0
+    0 i_TWO_PAGES_directio_
+return value: 0
+    1 i_TWO_PAGES_mixed_directio_incore_
+return value: 0
+    1 i_TWO_PAGES_mixed_incore_directio_
+return value: 0
+    2 i_WINDOW_SIZE_incore-sparse-incore_
+return value: 0
+    0 i_WINDOW_SIZE_directio-sparse-directio_
+return value: 0
+    1 i_WINDOW_SIZE_incore-sparse-directio_
+return value: 0
+    1 i_WINDOW_SIZE_directio-sparse-incore_
+return value: 0
+    2 i_WINDOW_SIZE_+_1_page_incore-sparse-incore_
+return value: 0
+    0 i_WINDOW_SIZE_+_1_page_directio-sparse-directio_
+return value: 0
+    1 i_WINDOW_SIZE_+_1_page_incore-sparse-directio_
+return value: 0
+    1 i_WINDOW_SIZE_+_1_page_directio-sparse-incore_
+return value: 0
+[ MULTIPLE FILES ]
+fincore: failed to open: no_such_file: No such file or directory
+PAGES FILE
+    0 i_EMPTY_FILE
+    1 i_PAGESIZE_-1__incore_
+    1 i_JUST_PAGESIZE_incore_
+    0 i_JUST_PAGESIZE_directio_
+    2 i_TWO_PAGES_incore_
+    0 i_TWO_PAGES_directio_
+    1 i_TWO_PAGES_mixed_directio_incore_
+    1 i_TWO_PAGES_mixed_incore_directio_
+    2 i_WINDOW_SIZE_incore-sparse-incore_
+    0 i_WINDOW_SIZE_directio-sparse-directio_
+    1 i_WINDOW_SIZE_incore-sparse-directio_
+    1 i_WINDOW_SIZE_directio-sparse-incore_
+    2 i_WINDOW_SIZE_+_1_page_incore-sparse-incore_
+    0 i_WINDOW_SIZE_+_1_page_directio-sparse-directio_
+    1 i_WINDOW_SIZE_+_1_page_incore-sparse-directio_
+    1 i_WINDOW_SIZE_+_1_page_directio-sparse-incore_
+return value: 1
diff --git a/tests/ts/fincore/count b/tests/ts/fincore/count
index 8f23fec..be81552 100755
--- a/tests/ts/fincore/count
+++ b/tests/ts/fincore/count
@@ -32,7 +32,7 @@ function run_dd_test
 	$DD if=/dev/zero of=$input count=1 bs=$bs $flags &> /dev/null
     fi
 
-    $TS_CMD_FINCORE --output PAGES,SIZE,FILE  --bytes --noheadings $input
+    $TS_CMD_FINCORE --output $COLUMNS  --bytes --noheadings $input
 
     footer "$?"
 }
@@ -51,7 +51,7 @@ function run_dd_dd_test
     $DD if=/dev/zero of=$input count=1 bs=$bs $flags0 &> /dev/null
     $DD if=/dev/zero of=$input count=1 bs=$bs $flags1 &> /dev/null
 
-    $TS_CMD_FINCORE --output PAGES,SIZE,FILE --bytes --noheadings $input
+    $TS_CMD_FINCORE --output $COLUMNS --bytes --noheadings $input
 
     footer "$?"
 }
@@ -65,6 +65,16 @@ ts_init "$*"
 PAGE_SIZE=$($TS_HELPER_SYSINFO pagesize)
 WINDOW_SIZE=$(( 32 * 1024 * PAGE_SIZE ))
 
+# we use PAGE_SIZE dependent output for a few systems
+if test -f "$TS_EXPECTED.$PAGE_SIZE"; then
+	TS_EXPECTED+=".$PAGE_SIZE"
+	COLUMNS="PAGES,SIZE,FILE"
+else
+	TS_EXPECTED+=".nosize"
+	COLUMNS="PAGES,FILE"
+fi
+
+
 # seems unsupported by some dd(1) version
 #DD_FLAGS="status=none"
 
@@ -83,7 +93,7 @@ input=
     INPUT="${INPUT} ${input}"
 
     header "NO EXCITING FILE"
-    $TS_CMD_FINCORE --output PAGES,SIZE,FILE --bytes --noheadings $input
+    $TS_CMD_FINCORE --output $COLUMNS --bytes --noheadings $input
     footer "$?"
 } >> $TS_OUTPUT 2>&1
 
@@ -181,7 +191,7 @@ input=
 
 {
     header "MULTIPLE FILES"
-    $TS_CMD_FINCORE --output PAGES,SIZE,FILE --bytes $INPUT
+    $TS_CMD_FINCORE --output $COLUMNS --bytes $INPUT
     footer "$?"
 } >> $TS_OUTPUT 2>&1
 
-- 
1.8.5.6

