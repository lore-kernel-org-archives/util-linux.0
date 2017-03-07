Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932408AbdCGDuR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 6 Mar 2017 22:50:17 -0500
From: Masatake YAMATO <yamato@redhat.com>
To: util-linux@vger.kernel.org
Cc: yamato@redhat.com
Subject: [PATCH 3/4] tests: add cases for testing fincore command
Date: Tue,  7 Mar 2017 11:33:51 +0900
Message-Id: <20170307023352.7340-4-yamato@redhat.com>
In-Reply-To: <20170307023352.7340-1-yamato@redhat.com>
References: <20170307023352.7340-1-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 tests/commands.sh            |   1 +
 tests/expected/fincore/count |  62 ++++++++++++++
 tests/ts/fincore/count       | 194 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 257 insertions(+)
 create mode 100644 tests/expected/fincore/count
 create mode 100755 tests/ts/fincore/count

diff --git a/tests/commands.sh b/tests/commands.sh
index 2e3a276..2e5c11d 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -50,6 +50,7 @@ TS_CMD_FALLOCATE=${TS_CMD_FALLOCATE-"$top_builddir/fallocate"}
 TS_CMD_FDISK=${TS_CMD_FDISK-"$top_builddir/fdisk"}
 TS_CMD_FLOCK=${TS_CMD_FLOCK-"$top_builddir/flock"}
 TS_CMD_SFDISK=${TS_CMD_SFDISK-"$top_builddir/sfdisk"}
+TS_CMD_FINCORE=${TS_CMD_FINCORE-"$top_builddir/fincore"}
 TS_CMD_FINDMNT=${TS_CMD_FINDMNT-"$top_builddir/findmnt"}
 TS_CMD_FSCKCRAMFS=${TS_CMD_FSCKCRAMFS:-"$top_builddir/fsck.cramfs"}
 TS_CMD_FSCKMINIX=${TS_CMD_FSCKMINIX:-"$top_builddir/fsck.minix"}
diff --git a/tests/expected/fincore/count b/tests/expected/fincore/count
new file mode 100644
index 0000000..0ee335e
--- /dev/null
+++ b/tests/expected/fincore/count
@@ -0,0 +1,62 @@
+[ NO EXCITING FILE ]
+fincore: failed to open: no_such_file: No such file or directory
+failed     -1         no_such_file
+return value: 1
+0          0          i_EMPTY_FILE
+return value: 0
+1          2048       i_SMALLER_THAN_PAGESIZE__incore_
+return value: 0
+1          4095       i_PAGESIZE_-1__incore_
+return value: 0
+1          4096       i_JUST_PAGESIZE_incore_
+return value: 0
+0          4096       i_JUST_PAGESIZE_directio_
+return value: 0
+2          4097       i_PAGESIZE_+_1__incore_
+return value: 0
+2          8192       i_TWO_PAGES_incore_
+return value: 0
+0          8192       i_TWO_PAGES_directio_
+return value: 0
+1          8192       i_TWO_PAGES_mixed_directio_incore_
+return value: 0
+1          8192       i_TWO_PAGES_mixed_incore_directio_
+return value: 0
+2          134213632  i_WINDOW_SIZE_incore-sparse-incore_
+return value: 0
+0          134213632  i_WINDOW_SIZE_directio-sparse-directio_
+return value: 0
+1          134213632  i_WINDOW_SIZE_incore-sparse-directio_
+return value: 0
+1          134213632  i_WINDOW_SIZE_directio-sparse-incore_
+return value: 0
+2          134217728  i_WINDOW_SIZE_+_1_page_incore-sparse-incore_
+return value: 0
+0          134217728  i_WINDOW_SIZE_+_1_page_directio-sparse-directio_
+return value: 0
+1          134217728  i_WINDOW_SIZE_+_1_page_incore-sparse-directio_
+return value: 0
+1          134217728  i_WINDOW_SIZE_+_1_page_directio-sparse-incore_
+return value: 0
+[ MULTIPLE FILES ]
+fincore: failed to open: no_such_file: No such file or directory
+failed     -1         no_such_file
+0          0          i_EMPTY_FILE
+1          2048       i_SMALLER_THAN_PAGESIZE__incore_
+1          4095       i_PAGESIZE_-1__incore_
+1          4096       i_JUST_PAGESIZE_incore_
+0          4096       i_JUST_PAGESIZE_directio_
+2          4097       i_PAGESIZE_+_1__incore_
+2          8192       i_TWO_PAGES_incore_
+0          8192       i_TWO_PAGES_directio_
+1          8192       i_TWO_PAGES_mixed_directio_incore_
+1          8192       i_TWO_PAGES_mixed_incore_directio_
+2          134213632  i_WINDOW_SIZE_incore-sparse-incore_
+0          134213632  i_WINDOW_SIZE_directio-sparse-directio_
+1          134213632  i_WINDOW_SIZE_incore-sparse-directio_
+1          134213632  i_WINDOW_SIZE_directio-sparse-incore_
+2          134217728  i_WINDOW_SIZE_+_1_page_incore-sparse-incore_
+0          134217728  i_WINDOW_SIZE_+_1_page_directio-sparse-directio_
+1          134217728  i_WINDOW_SIZE_+_1_page_incore-sparse-directio_
+1          134217728  i_WINDOW_SIZE_+_1_page_directio-sparse-incore_
+return value: 1
diff --git a/tests/ts/fincore/count b/tests/ts/fincore/count
new file mode 100755
index 0000000..4bb8912
--- /dev/null
+++ b/tests/ts/fincore/count
@@ -0,0 +1,194 @@
+#!/bin/bash
+
+function header
+{
+    echo "[" "$1" "]"
+}
+
+function footer
+{
+    echo "return value: $1"
+}
+
+function make_input_name
+{
+    header=$1
+    prefix=i_
+    echo ${prefix}$(sed -e "s/[^-+a-zA-Z0-9_]/_/g"<<<"$header")
+}
+
+function run_dd_test
+{
+    header=$1
+    bs=$2
+    flags=$3
+
+    input=$(make_input_name "$header")
+    INPUT="${INPUT} ${input}"
+
+    if [ "$bs" = 0 ]; then
+	touch $input
+    else
+	$DD if=/dev/zero of=$input count=1 bs=$bs $flags
+    fi
+
+    $TS_CMD_FINCORE $input
+
+    footer "$?"
+}
+
+function run_dd_dd_test
+{
+    header=$1
+    flags0=$2
+    flags1=$3
+
+    bs=$PAGE_SIZE
+
+    input=$(make_input_name "$header")
+    INPUT="${INPUT} ${input}"
+
+    $DD if=/dev/zero of=$input count=1 bs=$bs $flags0
+    $DD if=/dev/zero of=$input count=1 bs=$bs $flags1
+
+    $TS_CMD_FINCORE $input
+
+    footer "$?"
+}
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="count file contents in core"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+PAGE_SIZE=$($TS_HELPER_SYSINFO pagesize)
+WINDOW_SIZE=$(( 32 * 1024 * PAGE_SIZE ))
+
+DD_FLAGS="status=none"
+DD="dd $DD_FLAGS"
+
+
+ts_check_test_command "$TS_CMD_FINCORE"
+ts_cd "$TS_OUTDIR"
+
+INPUT=
+input=
+
+{
+    input=no_such_file
+    INPUT="${INPUT} ${input}"
+
+    header "NO EXCITING FILE"
+    $TS_CMD_FINCORE $input
+    footer "$?"
+} >> $TS_OUTPUT 2>&1
+
+{
+    run_dd_test "EMPTY FILE" 0
+} >> $TS_OUTPUT 2>&1
+
+{
+    run_dd_test "SMALLER THAN PAGESIZE (incore)" $(( PAGE_SIZE / 2 ))
+} >> $TS_OUTPUT 2>&1
+
+{
+    run_dd_test "PAGESIZE -1 (incore)" $(( PAGE_SIZE - 1 ))
+} >> $TS_OUTPUT 2>&1
+
+{
+    run_dd_test "JUST PAGESIZE(incore)" $(( PAGE_SIZE ))
+} >> $TS_OUTPUT 2>&1
+
+{
+    run_dd_test "JUST PAGESIZE(directio)" $(( PAGE_SIZE )) "oflag=direct"
+} >> $TS_OUTPUT 2>&1
+
+{
+    run_dd_test "PAGESIZE + 1 (incore)" $(( PAGE_SIZE + 1 ))
+} >> $TS_OUTPUT 2>&1
+
+{
+    run_dd_test "TWO PAGES(incore)" $(( 2 * PAGE_SIZE ))
+} >> $TS_OUTPUT 2>&1
+
+{
+    run_dd_test "TWO PAGES(directio)" $(( 2 * PAGE_SIZE )) "oflag=direct"
+} >> $TS_OUTPUT 2>&1
+
+{
+    run_dd_dd_test "TWO PAGES(mixed directio/incore)" \
+			    oflag=direct \
+			    "oflag=append seek=1"
+} >> $TS_OUTPUT 2>&1
+
+{
+    run_dd_dd_test "TWO PAGES(mixed incore/directio)" \
+		   "" \
+		   "oflag=direct,append seek=1"
+} >> $TS_OUTPUT 2>&1
+
+{
+    hole_count=$(( WINDOW_SIZE / PAGE_SIZE - 2 ))
+    run_dd_dd_test "WINDOW SIZE(incore-sparse-incore)" \
+		   "" \
+		   "oflag=append seek=$hole_count"
+} >> $TS_OUTPUT 2>&1
+
+{
+    hole_count=$(( WINDOW_SIZE / PAGE_SIZE - 2 ))
+    run_dd_dd_test "WINDOW SIZE(directio-sparse-directio)" \
+		   "oflag=direct" \
+		   "oflag=append,direct seek=$hole_count"
+} >> $TS_OUTPUT 2>&1
+
+{
+    hole_count=$(( WINDOW_SIZE / PAGE_SIZE - 2 ))
+    run_dd_dd_test "WINDOW SIZE(incore-sparse-directio)" \
+		   "" \
+		   "oflag=append,direct seek=$hole_count"
+} >> $TS_OUTPUT 2>&1
+
+{
+    hole_count=$(( WINDOW_SIZE / PAGE_SIZE - 2 ))
+    run_dd_dd_test "WINDOW SIZE(directio-sparse-incore)" \
+		   "oflag=direct" \
+		   "oflag=append seek=$hole_count"
+} >> $TS_OUTPUT 2>&1
+
+{
+    hole_count=$(( WINDOW_SIZE / PAGE_SIZE - 1 ))
+    run_dd_dd_test "WINDOW SIZE + 1 page(incore-sparse-incore)" \
+		   "" \
+		   "oflag=append seek=$hole_count"
+} >> $TS_OUTPUT 2>&1
+
+{
+    hole_count=$(( WINDOW_SIZE / PAGE_SIZE - 1 ))
+    run_dd_dd_test "WINDOW SIZE + 1 page(directio-sparse-directio)" \
+		   "oflag=direct" \
+		   "oflag=append,direct seek=$hole_count"
+} >> $TS_OUTPUT 2>&1
+
+{
+    hole_count=$(( WINDOW_SIZE / PAGE_SIZE - 1 ))
+    run_dd_dd_test "WINDOW SIZE + 1 page(incore-sparse-directio)" \
+		   "" \
+		   "oflag=append,direct seek=$hole_count"
+} >> $TS_OUTPUT 2>&1
+
+{
+    hole_count=$(( WINDOW_SIZE / PAGE_SIZE - 1 ))
+    run_dd_dd_test "WINDOW SIZE + 1 page(directio-sparse-incore)" \
+		   "oflag=direct" \
+		   "oflag=append seek=$hole_count"
+} >> $TS_OUTPUT 2>&1
+
+{
+    header "MULTIPLE FILES"
+    $TS_CMD_FINCORE $INPUT
+    footer "$?"
+} >> $TS_OUTPUT 2>&1
+
+rm -f $INPUT
+ts_finalize
-- 
2.9.3

