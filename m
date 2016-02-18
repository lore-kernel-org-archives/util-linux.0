Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:56505 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426383AbcBRNMw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Feb 2016 08:12:52 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0MH07e-1akBto49bu-00Dmm9 for
 <util-linux@vger.kernel.org>; Thu, 18 Feb 2016 14:12:51 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 02/15] build-sys: portable usage of find command
Date: Thu, 18 Feb 2016 14:12:42 +0100
Message-Id: <1455801169-10470-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
References: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

 - use dot instead of skipping search-path
 - avoid -perm /a+x
 - avoid -path

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/run.sh              | 11 +++++++++--
 tests/ts/build-sys/config |  2 +-
 tests/ts/cramfs/mkfs      |  2 +-
 tools/checkmans.sh        |  2 +-
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tests/run.sh b/tests/run.sh
index dca9c6c..03cd9f5 100755
--- a/tests/run.sh
+++ b/tests/run.sh
@@ -34,6 +34,13 @@ function num_cpus()
 	fi
 }
 
+function find_test_scripts()
+{
+	local searchdir="$1"
+	find "$searchdir" -type f -regex ".*/[^\.~]*" \
+		\( -perm -u=x -o -perm -g=x -o -perm -o=x \)
+}
+
 while [ -n "$1" ]; do
 	case "$1" in
 	--force)
@@ -117,7 +124,7 @@ if [ -n "$SUBTESTS" ]; then
 	# selected tests only
 	for s in $SUBTESTS; do
 		if [ -d "$top_srcdir/tests/ts/$s" ]; then
-			comps+=( $(find $top_srcdir/tests/ts/$s -type f -perm /a+x -regex ".*/[^\.~]*") )
+			comps+=( $(find_test_scripts "$top_srcdir/tests/ts/$s") ) || exit 1
 		else
 			echo "Unknown test component '$s'"
 			exit 1
@@ -129,7 +136,7 @@ else
 		exit 1
 	fi
 
-	comps=( $(find $top_srcdir/tests/ts/ -type f -perm /a+x -regex ".*/[^\.~]*") )
+	comps=( $(find_test_scripts "$top_srcdir/tests/ts") ) || exit 1
 fi
 
 if [ -n "$EXCLUDETESTS" ]; then
diff --git a/tests/ts/build-sys/config b/tests/ts/build-sys/config
index 15b3551..bc48c50 100755
--- a/tests/ts/build-sys/config
+++ b/tests/ts/build-sys/config
@@ -32,7 +32,7 @@ for conf in $config_gen_dir/config-gen.d/*.conf; do
 	./configure $opts &> /dev/null
 	make -j &> /dev/null
 
-	bins=$(find . -type f -perm /a+x | sort)
+	bins=$(find . -type f \( -perm -u=x -o -perm -g=x -o -perm -o=x \) | sort)
 	for b in $bins; do
 		libs=$(readelf --dynamic $b 2> /dev/null   | \
 			awk '/NEEDED/ { print $5 }' | \
diff --git a/tests/ts/cramfs/mkfs b/tests/ts/cramfs/mkfs
index 78e5c17..07f703f 100755
--- a/tests/ts/cramfs/mkfs
+++ b/tests/ts/cramfs/mkfs
@@ -66,7 +66,7 @@ fi
 ts_cd "$IMAGE_SRC"
 
 ts_log "list checksums from original data"
-find -type f -exec md5sum {} \; | sort >> $TS_OUTPUT
+find . -type f -exec md5sum {} \; | sort >> $TS_OUTPUT
 echo >> $TS_OUTPUT
 
 ts_log "create cramfs image"
diff --git a/tools/checkmans.sh b/tools/checkmans.sh
index 9a13778..63da3d7 100755
--- a/tools/checkmans.sh
+++ b/tools/checkmans.sh
@@ -70,7 +70,7 @@ remove_repeats()
 cd $(git rev-parse --show-toplevel)
 
 for I in $(
-	find -path './autom4te.cache' -prune -o -path './.libs' -prune -o -name '*[[:alpha:]].[1-8]' -print
+	find . -type f -name '*[[:alpha:]].[1-8]' |grep -v "autom4te.cache\|\.libs/"
 ); do
 	MAN_FILE=${I##*/}
 	MAN_LIST[${MAN_FILE%%.[0-9]}]=1
-- 
1.8.4.5

