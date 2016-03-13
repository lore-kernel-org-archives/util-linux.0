Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:65365 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023AbcCMWb1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 Mar 2016 18:31:27 -0400
Received: from tenfore.ga-group.nl ([2.247.85.77]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MLA45-1aexYq1Ni5-000I8a for
 <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 23:31:25 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 12/12] travis: add OSX build
Date: Sun, 13 Mar 2016 23:31:20 +0100
Message-Id: <1457908280-15588-13-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
References: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Of course OSX is not an important target but since it's available on
travis we can (mis)use it to generally improve non-Linux and non-GNU
compatibility. People are using musl, busybox or whatever and
util-linux should work for them. Having OSX build running regularly
will help us to freeze the lately improved BSD compatibility and
to check code which is usually ifdef'ed.

We are using the most recent OSX 10.11.x / Xcode 7.3 though the older
travis OSX images are working too currently.

If it turns out that this OSX build is too annoying when we are about
to add support for latest Linux features then we could add:
  allow_failures:
    - os: osx
to let it fail silently.

Note I've tried hard to keep .travis-functions.sh readable for the
Linux case. I've removed --with-python because it's default anyway,
--enable-gtk-doc is still tested in discheck.

OSX root check would also work (almost, using another --prefix) but
would only run one more test yet (minix).

OSX distcheck would have some issues with conditionally built man
pages and does not work with default distcheck confopts. No need to
fix that because distcheck is more for maintainer machines.

BTW to increase travis build speed again we could remove some targets
from the matrix without losing tested scenarios:
 - nonroot for Linux seems to be waste of time
 - clang/Linux could be root check only
For now we keep it as is.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 .travis-functions.sh | 58 ++++++++++++++++++++++++++++++++++++++++++++++++----
 .travis.yml          |  4 ++++
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/.travis-functions.sh b/.travis-functions.sh
index e4318d6..3e16d09 100755
--- a/.travis-functions.sh
+++ b/.travis-functions.sh
@@ -19,7 +19,7 @@ export TS_OPT_parsable="yes"
 
 function xconfigure
 {
-	./configure "$@"
+	./configure "$@" $OSX_CONFOPTS
 	err=$?
 	if [ "$DUMP_CONFIG_LOG" = "short" ]; then
 		grep -B1 -A10000 "^## Output variables" config.log | grep -v "_FALSE="
@@ -35,12 +35,13 @@ function check_nonroot
 
 	xconfigure \
 		--disable-use-tty-group \
-		--with-python \
 		--enable-all-programs \
-		--enable-gtk-doc \
 		|| return
 	$MAKE || return
+
+	osx_prepare_check
 	$MAKE check TS_OPTS="$opts" || return
+
 	$MAKE install DESTDIR=/tmp/dest || return
 }
 
@@ -49,12 +50,14 @@ function check_root
 	local opts="$MAKE_CHECK_OPTS --parallel=1"
 
 	xconfigure \
-		--with-python \
 		--enable-all-programs \
 		|| return
 	$MAKE || return
+
 	$MAKE check TS_COMMAND="true" || return
+	osx_prepare_check
 	sudo -E $MAKE check TS_OPTS="$opts" || return
+
 	sudo $MAKE install || return
 }
 
@@ -67,6 +70,11 @@ function check_dist
 
 function travis_install_script
 {
+	if [ "$TRAVIS_OS_NAME" = "osx" ]; then
+		osx_install_script
+		return
+	fi
+
 	# install some packages from Ubuntu's default sources
 	sudo apt-get -qq update || return
 	sudo apt-get install -qq >/dev/null \
@@ -89,6 +97,48 @@ function travis_install_script
 		|| true
 }
 
+function osx_install_script
+{
+	brew update >/dev/null
+	brew tap homebrew/dupes
+
+	brew install gettext ncurses socat xz
+	brew link --force gettext
+	brew link --force ncurses
+
+	OSX_CONFOPTS="
+		--disable-runuser \
+		--disable-su \
+		--disable-login \
+		--disable-last \
+		--disable-utmpdump \
+		--disable-agetty \
+		--disable-wall \
+		--disable-ipcrm \
+		--disable-ipcs \
+		--disable-write \
+	"
+}
+
+function osx_prepare_check
+{
+	[ "$TRAVIS_OS_NAME" = "osx" ] || return 0
+
+	# these ones only need to be gnu for our test-suite
+	brew install coreutils findutils gnu-tar gnu-sed
+
+	# symlink minimally needed gnu commands into PATH
+	mkdir ~/bin
+	for cmd in md5sum readlink seq truncate find xargs tar sed; do
+		ln -s /usr/local/bin/g$cmd $HOME/bin/$cmd
+	done
+	hash -r
+
+	export TS_OPT_col_multibyte_known_fail=yes
+	export TS_OPT_colcrt_regressions_known_fail=yes
+	export TS_OPT_column_invalid_multibyte_known_fail=yes
+}
+
 function travis_before_script
 {
 	set -o xtrace
diff --git a/.travis.yml b/.travis.yml
index 545b915..598b5f1 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -21,6 +21,10 @@ matrix:
       dist: precise
       compiler: gcc
       env: PRECISE="yes" MAKE_CHECK="root"
+    - os: osx
+      osx_image: xcode7.3
+      compiler: clang
+      env: MAKE_CHECK="nonroot"
 
 branches:
   only:
-- 
1.8.4.5

