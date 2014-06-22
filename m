Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f179.google.com ([74.125.82.179]:46482 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbaFVKcR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Jun 2014 06:32:17 -0400
Received: by mail-we0-f179.google.com with SMTP id w62so5503081wes.38
        for <util-linux@vger.kernel.org>; Sun, 22 Jun 2014 03:32:16 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/6] tests: use ts_cd everywhere to change direcrory
Date: Sun, 22 Jun 2014 11:31:54 +0100
Message-Id: <1403433117-32652-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1403433117-32652-1-git-send-email-kerolasa@iki.fi>
References: <1403433117-32652-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/ts/build-sys/config         | 6 +++---
 tests/ts/column/fillrow           | 2 +-
 tests/ts/column/invalid-multibyte | 2 +-
 tests/ts/column/multi-file        | 2 +-
 tests/ts/column/separator_table   | 2 +-
 tests/ts/cramfs/mkfs              | 8 ++++----
 tests/ts/namei/logic              | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/ts/build-sys/config b/tests/ts/build-sys/config
index 5ae83a3..15b3551 100755
--- a/tests/ts/build-sys/config
+++ b/tests/ts/build-sys/config
@@ -19,7 +19,7 @@ config_gen_dir="$top_srcdir/tools"
 
 [ -n "$CFLAGS" ] && export CFLAGS="$CFLAGS"
 
-cd $top_builddir && make -j clean &> /dev/null
+ts_cd $top_builddir && make -j clean &> /dev/null
 
 for conf in $config_gen_dir/config-gen.d/*.conf; do
 	ts_init_subtest $(basename $conf | sed 's/\.conf//')
@@ -27,7 +27,7 @@ for conf in $config_gen_dir/config-gen.d/*.conf; do
 	opts=$(ul_get_configuration $conf)
 
 	olddir=$(pwd)
-	cd $top_builddir
+	ts_cd $top_builddir
 
 	./configure $opts &> /dev/null
 	make -j &> /dev/null
@@ -63,7 +63,7 @@ for conf in $config_gen_dir/config-gen.d/*.conf; do
 	[ -d tests/diff.save ]   && mv tests/diff.save   tests/diff
 	[ -d tests/output.save ] && mv tests/output.save tests/output
 
-	cd $olddir
+	ts_cd $olddir
 	ts_finalize_subtest
 done
 
diff --git a/tests/ts/column/fillrow b/tests/ts/column/fillrow
index 263a267..5700924 100755
--- a/tests/ts/column/fillrow
+++ b/tests/ts/column/fillrow
@@ -23,7 +23,7 @@ ts_init "$*"
 
 ts_check_test_command "$TS_CMD_COLUMN"
 
-cd $TS_OUTDIR
+ts_cd "$TS_OUTDIR"
 
 $TS_CMD_COLUMN -x -c 50 $TS_SELF/input >> $TS_OUTPUT 2>&1
 
diff --git a/tests/ts/column/invalid-multibyte b/tests/ts/column/invalid-multibyte
index 9935a38..a9e3710 100755
--- a/tests/ts/column/invalid-multibyte
+++ b/tests/ts/column/invalid-multibyte
@@ -23,7 +23,7 @@ ts_init "$*"
 
 ts_check_test_command "$TS_CMD_COLUMN"
 
-cd $TS_OUTDIR
+ts_cd "$TS_OUTDIR"
 
 printf "£\n" | LC_ALL=C $TS_CMD_COLUMN >> $TS_OUTPUT 2>&1
 
diff --git a/tests/ts/column/multi-file b/tests/ts/column/multi-file
index 76b8686..bc7b331 100755
--- a/tests/ts/column/multi-file
+++ b/tests/ts/column/multi-file
@@ -24,7 +24,7 @@ ts_init "$*"
 
 ts_check_test_command "$TS_CMD_COLUMN"
 
-cd $TS_OUTDIR
+ts_cd "$TS_OUTDIR"
 
 $TS_CMD_COLUMN -x -c 50 $TS_SELF/input \
 			$TS_SELF/input \
diff --git a/tests/ts/column/separator_table b/tests/ts/column/separator_table
index 8be1e20..7c5caae 100755
--- a/tests/ts/column/separator_table
+++ b/tests/ts/column/separator_table
@@ -23,7 +23,7 @@ ts_init "$*"
 
 ts_check_test_command "$TS_CMD_COLUMN"
 
-cd $TS_OUTDIR
+ts_cd "$TS_OUTDIR"
 
 $TS_CMD_COLUMN -s 2 -t $TS_SELF/input >> $TS_OUTPUT 2>&1
 
diff --git a/tests/ts/cramfs/mkfs b/tests/ts/cramfs/mkfs
index 06cdfbd..5a10ba9 100755
--- a/tests/ts/cramfs/mkfs
+++ b/tests/ts/cramfs/mkfs
@@ -53,7 +53,7 @@ if [ ! -d "$IMAGE_SRC" ]; then
 	done
 fi
 
-cd $IMAGE_SRC
+ts_cd "$IMAGE_SRC"
 
 ts_log "list checksums from original data"
 find -type f -exec md5sum {} \; | sort >> $TS_OUTPUT
@@ -63,7 +63,7 @@ ts_log "create cramfs image"
 $TS_CMD_MKCRAMFS -n $LABEL $IMAGE_SRC $IMAGE_PATH 2>&1 >> $TS_OUTPUT
 [ -s "$IMAGE_PATH" ] || ts_die "Cannot create $IMAGE_PATH"
 
-cd $TS_OUTDIR
+ts_cd "$TS_OUTDIR"
 
 ts_log "count MD5 from the image"
 md5sum $IMAGE_NAME 2>&1 | sort >> $TS_OUTPUT
@@ -82,7 +82,7 @@ ts_mount "cramfs" -r -L $LABEL $TS_MOUNTPOINT
 # check it
 ts_is_mounted $DEVICE || ts_die "Cannot find $DEVICE in /proc/mounts" $DEVICE
 
-cd $TS_MOUNTPOINT
+ts_cd "$TS_MOUNTPOINT"
 
 ts_log "list the image"
 export TZ='GMT-1'
@@ -93,7 +93,7 @@ ts_log "list checksums from new data"
 find . -type f -exec md5sum {} \; | sort >> $TS_OUTPUT
 echo >> $TS_OUTPUT
 
-cd $ORIGPWD
+ts_cd "$ORIGPWD"
 
 ts_log "umount the image"
 $TS_CMD_UMOUNT $DEVICE
diff --git a/tests/ts/namei/logic b/tests/ts/namei/logic
index df48b76..703cc10 100755
--- a/tests/ts/namei/logic
+++ b/tests/ts/namei/logic
@@ -23,7 +23,7 @@ ts_init "$*"
 
 ts_check_test_command "$TS_CMD_NAMEI"
 
-cd $TS_OUTDIR
+ts_cd "$TS_OUTDIR"
 
 mkdir -p namei1/namei2
 touch namei1/namei2/a namei1/namei2/b
-- 
2.0.0

