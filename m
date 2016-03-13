Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:61545 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754300AbcCMWb0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 Mar 2016 18:31:26 -0400
Received: from tenfore.ga-group.nl ([2.247.85.77]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0Me5Q2-1aTcu30Q86-00PvrH for
 <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 23:31:25 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 11/12] travis: switch to Ubuntu 14.04 Trusty
Date: Sun, 13 Mar 2016 23:31:19 +0100
Message-Id: <1457908280-15588-12-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
References: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Now we have a reasonable recent build system with systemd, etc. We still
keep old Ubuntu 12.04 Precise to check backward compatibility but
remove the hack to install socat.

Note the new env variable PRECISE="yes" is only there to see it on travis
website.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 .travis-functions.sh | 11 ++++++-----
 .travis.yml          | 10 ++++++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/.travis-functions.sh b/.travis-functions.sh
index 3c18559..e4318d6 100755
--- a/.travis-functions.sh
+++ b/.travis-functions.sh
@@ -71,6 +71,7 @@ function travis_install_script
 	sudo apt-get -qq update || return
 	sudo apt-get install -qq >/dev/null \
 		bc \
+		btrfs-tools \
 		dnsutils \
 		libcap-ng-dev \
 		libpam-dev \
@@ -78,14 +79,14 @@ function travis_install_script
 		gtk-doc-tools \
 		mdadm \
 		ntp \
+		socat \
 		|| return
 
-	# install/upgrade custom stuff from non-official sources
-	sudo add-apt-repository -y ppa:malcscott/socat || return
-	sudo apt-get -qq update || return
+	# install only if available (e.g. Ubuntu Trusty)
 	sudo apt-get install -qq >/dev/null \
-		socat \
-		|| return
+		libsystemd-daemon-dev \
+		libsystemd-journal-dev \
+		|| true
 }
 
 function travis_before_script
diff --git a/.travis.yml b/.travis.yml
index e27adc4..545b915 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,5 +1,8 @@
 language: c
 
+sudo: required
+dist: trusty
+
 git:
   depth: 1500
 
@@ -12,6 +15,13 @@ env:
   - MAKE_CHECK="root"
   - MAKE_CHECK="dist"
 
+matrix:
+  include:
+    - os: linux
+      dist: precise
+      compiler: gcc
+      env: PRECISE="yes" MAKE_CHECK="root"
+
 branches:
   only:
     - master
-- 
1.8.4.5

