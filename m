Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:49636 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751605AbbBAOBb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Feb 2015 09:01:31 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 7/8] build-sys: improve wording and punctuation of several messages
Date: Sun,  1 Feb 2015 15:00:12 +0100
Message-Id: <1422799213-16717-7-git-send-email-bensberg@justemail.net>
In-Reply-To: <1422799213-16717-1-git-send-email-bensberg@justemail.net>
References: <1422799213-16717-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 autogen.sh |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/autogen.sh b/autogen.sh
index d0b340f..546d468 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -24,7 +24,7 @@ autopoint_fun ()
 		sed -n -e 's/.* \(0\.18\|0\.18\.[1-2]\)$/\1/p'`
 
 	if [ -n "$gt_ver" ]; then
-		echo "warning, force autopoint to use old gettext $gt_ver"
+		echo "warning: forcing autopoint to use old gettext $gt_ver"
 		rm -f configure.ac.autogenbak
 		sed -i.autogenbak configure.ac \
 			-e "s/\(AM_GNU_GETTEXT_VERSION\).*/\1([$gt_ver])/"
@@ -41,41 +41,41 @@ autopoint_fun ()
 
 test -f sys-utils/mount.c || {
 	echo
-	echo "You must run this script in the top-level util-linux directory"
+	echo "You must run this script in the top-level util-linux directory."
 	echo
 	DIE=1
 }
 
 (autopoint --version) < /dev/null > /dev/null 2>&1 || {
         echo
-        echo "You must have autopoint installed to generate util-linux build system."
+        echo "You must have autopoint installed to generate the util-linux build system."
         echo "The autopoint command is part of the GNU gettext package."
 	echo
         DIE=1
 }
 (autoconf --version) < /dev/null > /dev/null 2>&1 || {
 	echo
-	echo "You must have autoconf installed to generate util-linux build system."
+	echo "You must have autoconf installed to generate the util-linux build system."
 	echo
 	DIE=1
 }
 (autoheader --version) < /dev/null > /dev/null 2>&1 || {
 	echo
-	echo "You must have autoheader installed to generate util-linux build system."
+	echo "You must have autoheader installed to generate the util-linux build system."
 	echo "The autoheader command is part of the GNU autoconf package."
 	echo
 	DIE=1
 }
 (libtoolize --version) < /dev/null > /dev/null 2>&1 || {
 	echo
-	echo "You must have libtool-2 installed to generate util-linux build system."
+	echo "You must have libtool-2 installed to generate the util-linux build system."
 	echo
 	DIE=1
 }
 (automake --version) < /dev/null > /dev/null 2>&1 || {
 	echo
-	echo "You must have automake installed to generate util-linux build system."
-	echo 
+	echo "You must have automake installed to generate the util-linux build system."
+	echo
 	DIE=1
 }
 
@@ -91,7 +91,7 @@ if test "$DIE" -eq 1; then
 fi
 
 echo
-echo "Generate build-system by:"
+echo "Generating build-system with:"
 echo "   autopoint:  $(autopoint --version | head -1)"
 echo "   aclocal:    $(aclocal --version | head -1)"
 echo "   autoconf:   $(autoconf --version | head -1)"
-- 
1.7.0.4

