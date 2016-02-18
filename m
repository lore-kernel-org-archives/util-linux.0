Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:59067 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426323AbcBRNMw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Feb 2016 08:12:52 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0M7pDs-1Zjo4Q36S8-00vP5H for
 <util-linux@vger.kernel.org>; Thu, 18 Feb 2016 14:12:50 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 01/15] travis: minor cleanup
Date: Thu, 18 Feb 2016 14:12:41 +0100
Message-Id: <1455801169-10470-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
References: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

 - print env for debugging
 - remove unused builddir stuff
 - avoid non-portable find/xargs usage

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 .travis-functions.sh | 31 ++++++++++---------------------
 .travis.yml          |  2 ++
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/.travis-functions.sh b/.travis-functions.sh
index bef4597..3315a91 100755
--- a/.travis-functions.sh
+++ b/.travis-functions.sh
@@ -11,23 +11,14 @@ if [ ! -f "configure.ac" ]; then
 	return 1 || exit 1
 fi
 
-# some config settings
-MAKE="make -j4"
+## some config settings
+# travis docs say we get 1.5 CPUs
+MAKE="make -j2"
 DUMP_CONFIG_LOG="short"
 
-# We could test (exotic) out-of-tree build dirs using relative or abs paths.
-# After sourcing this script we are living in build dir. Tasks for source dir
-# have to use $SOURCE_DIR.
-SOURCE_DIR="."
-BUILD_DIR="."
-CONFIGURE="$SOURCE_DIR/configure"
-
-mkdir -p "$BUILD_DIR"
-cd "$BUILD_DIR" || return 1 || exit 1
-
-function configure_travis
+function xconfigure
 {
-	"$CONFIGURE" "$@"
+	./configure "$@"
 	err=$?
 	if [ "$DUMP_CONFIG_LOG" = "short" ]; then
 		grep -B1 -A10000 "^## Output variables" config.log | grep -v "_FALSE="
@@ -41,7 +32,7 @@ function check_nonroot
 {
 	local opts="$MAKE_CHECK_OPTS"
 
-	configure_travis \
+	xconfigure \
 		--disable-use-tty-group \
 		--with-python \
 		--enable-all-programs \
@@ -56,7 +47,7 @@ function check_root
 {
 	local opts="$MAKE_CHECK_OPTS --parallel=1"
 
-	configure_travis \
+	xconfigure \
 		--with-python \
 		--enable-all-programs \
 		|| return
@@ -68,7 +59,7 @@ function check_root
 
 function check_dist
 {
-	configure_travis \
+	xconfigure \
 		|| return
 	$MAKE distcheck || return
 }
@@ -98,14 +89,12 @@ function travis_install_script
 
 function travis_before_script
 {
-	pushd "$SOURCE_DIR" || return
 	set -o xtrace
 
 	./autogen.sh
 	ret=$?
 
 	set +o xtrace
-	popd
 	return $ret
 }
 
@@ -142,10 +131,10 @@ function travis_after_script
 	local tmp
 
 	# find diff dir from check as well as from distcheck
-	diff_dir=$(find -type d -a -name "diff" | grep "tests/diff" | head -n 1)
+	diff_dir=$(find . -type d -name "diff" | grep "tests/diff" | head -n 1)
 	if [ -d "$diff_dir" ]; then
 		tmp=$(find "$diff_dir" -type f | sort)
 		echo -en "dump test diffs:\n${tmp}\n"
-		echo "$tmp" | xargs -r cat
+		echo "$tmp" | xargs cat
 	fi
 }
diff --git a/.travis.yml b/.travis.yml
index 85a753d..e27adc4 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -19,6 +19,8 @@ branches:
     - /^travis.*/
 
 before_install:
+  # print some host info
+  - env | grep -v "encrypted" | LC_ALL=C sort
   - $CC --version
   - which $CC
   # workaround clang not system wide, fail on sudo make install
-- 
1.8.4.5

