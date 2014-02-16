Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f179.google.com ([74.125.82.179]:35414 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbaBPXyh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Feb 2014 18:54:37 -0500
Received: by mail-we0-f179.google.com with SMTP id q58so9925295wes.24
        for <util-linux@vger.kernel.org>; Sun, 16 Feb 2014 15:54:36 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/9] tests: make tests to run parallel
Date: Sun, 16 Feb 2014 23:54:15 +0000
Message-Id: <1392594862-15807-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1392594862-15807-1-git-send-email-kerolasa@iki.fi>
References: <1392594862-15807-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Unarguably this change makes test output to be more messy, but when I
compare run time tells with clear numbers parallel is quicker.  For me
the quickness is important factor.  Running test suite always after a
change is preferrably quick, and if something is indicated to be broken
it is ok to spend time in drilling down what happen.

$ time ./tests/run.sh --parallel=5
[...]
real    1m48.037s

Same without parallelization.

$ time ./tests/run.sh
real    3m16.687s

The default is changed to be parallel, where job count is same as number
of CPUs.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/functions.sh | 15 +++++++--------
 tests/run.sh       | 32 +++++++++++++++++++-------------
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/tests/functions.sh b/tests/functions.sh
index 17fa6d2..f6f2a5c 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -38,7 +38,7 @@ function ts_check_test_command {
 }
 
 function ts_skip_subtest {
-	echo " IGNORE ($1)"
+	echo "$TITLE IGNORE ($1)"
 }
 
 function ts_skip {
@@ -57,9 +57,9 @@ function ts_skip_nonroot {
 
 function ts_failed_subtest {
 	if [ x"$1" == x"" ]; then
-		echo " FAILED ($TS_NS)"
+		echo "$TITLE FAILED ($TS_NS)"
 	else
-		echo " FAILED ($1)"
+		echo "$TITLE FAILED ($1)"
 	fi
 }
 
@@ -70,9 +70,9 @@ function ts_failed {
 
 function ts_ok_subtest {
 	if [ x"$1" == x"" ]; then
-		echo " OK"
+		echo "$TITLE OK"
 	else
-		echo " OK ($1)"
+		echo "$TITLE OK ($1)"
 	fi
 }
 
@@ -214,8 +214,7 @@ function ts_init_subtest {
 
 	[ $TS_NSUBTESTS -eq 0 ] && echo
 	TS_NSUBTESTS=$(( $TS_NSUBTESTS + 1 ))
-
-	printf "%16s: %-27s ..." "" "$TS_SUBNAME"
+	TITLE=$(printf "%13s: %-30s ...\n%16s: %-27s ..." "$TS_COMPONENT" "$TS_DESC" "" "$TS_SUBNAME")
 }
 
 function ts_init {
@@ -229,7 +228,7 @@ function ts_init {
 
 	ts_init_env "$*"
 
-	printf "%13s: %-30s ..." "$TS_COMPONENT" "$TS_DESC"
+	TITLE=$(printf "%13s: %-30s ..." "$TS_COMPONENT" "$TS_DESC")
 
 	[ "$is_fake" == "yes" ] && ts_skip "fake mode"
 	[ "$TS_OPTIONAL" == "yes" -a "$is_force" != "yes" ] && ts_skip "optional"
diff --git a/tests/run.sh b/tests/run.sh
index 8a7924a..4f55295 100755
--- a/tests/run.sh
+++ b/tests/run.sh
@@ -23,6 +23,8 @@ OPTS=
 top_srcdir=
 top_builddir=
 
+paraller_jobs=$(lscpu -bp | grep -cv '^#')
+
 while [ -n "$1" ]; do
 	case "$1" in
 	--force)
@@ -49,6 +51,9 @@ while [ -n "$1" ]; do
 	--builddir=*)
 		top_builddir="${1##--builddir=}"
 		;;
+	--parallel=*)
+		paraller_jobs="${1##--parallel=}"
+		;;
 	--*)
 		echo "Unknown option $1"
 		echo "Usage: "
@@ -61,6 +66,7 @@ while [ -n "$1" ]; do
 		echo "  --nonroot         ignore test suite if user is root"
 		echo "  --srcdir=<path>   autotools top source directory"
 		echo "  --builddir=<path> autotools top build directory"
+		echo "  --parallel=<num>  number of parallel test jobs, default: num cpus"
 		echo
 		exit 1
 		;;
@@ -87,12 +93,12 @@ fi
 
 OPTS="$OPTS --srcdir=$top_srcdir --builddir=$top_builddir"
 
+declare -a comps
 if [ -n "$SUBTESTS" ]; then
 	# selected tests only
 	for s in $SUBTESTS; do
 		if [ -d "$top_srcdir/tests/ts/$s" ]; then
-			co=$(find $top_srcdir/tests/ts/$s -type f -perm /a+x -regex ".*/[^\.~]*" |  sort)
-			comps="$comps $co"
+			comps+=( $(find $top_srcdir/tests/ts/$s -type f -perm /a+x -regex ".*/[^\.~]*") )
 		else
 			echo "Unknown test component '$s'"
 			exit 1
@@ -104,7 +110,7 @@ else
 		exit 1
 	fi
 
-	comps=$(find $top_srcdir/tests/ts/ -type f -perm /a+x -regex ".*/[^\.~]*" |  sort)
+	comps=( $(find $top_srcdir/tests/ts/ -type f -perm /a+x -regex ".*/[^\.~]*") )
 fi
 
 
@@ -119,21 +125,21 @@ echo "                    For development purpose only.                    "
 echo "                 Don't execute on production system!                 "
 echo
 
-res=0
 count=0
-for ts in $comps; do
-	$ts "$OPTS"
-	res=$(( $res + $? ))
-	count=$(( $count + 1 ))
-done
-
+>| $top_srcdir/tests/failures
+printf "%s\n" ${comps[*]} |
+	xargs -I '{}' -P $paraller_jobs -n 1 bash -c "'{}' \"$OPTS\" ||
+		echo 1 >> $top_srcdir/tests/failures"
+declare -a fail_file
+fail_file=( $( < $top_srcdir/tests/failures ) )
+rm -f $top_srcdir/tests/failures
 echo
 echo "---------------------------------------------------------------------"
-if [ $res -eq 0 ]; then
-	echo "  All $count tests PASSED"
+if [ ${#fail_file[@]} -eq 0 ]; then
+	echo "  All ${#comps[@]} tests PASSED"
 	res=0
 else
-	echo "  $res tests of $count FAILED"
+	echo "  ${#fail_file[@]} tests of ${#comps[@]} FAILED"
 	res=1
 fi
 echo "---------------------------------------------------------------------"
-- 
1.9.0

