Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:53322 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754084AbcKQCKG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 16 Nov 2016 21:10:06 -0500
Received: from tenfore.ga-group.nl ([77.12.158.253]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MV30j-1cGutK01Qj-00YUFL for
 <util-linux@vger.kernel.org>; Thu, 17 Nov 2016 03:10:03 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/5] build-sys: fix empty package release number
Date: Thu, 17 Nov 2016 03:09:58 +0100
Message-Id: <1479348602-31744-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Was broken for major releases since b0e6b25e:
  $ blkid -V
  blkid from util-linux 2.28  (libblkid 2.28., 12-Apr-2016)

Now we also set 0 in this case, like:
  $ blkid -V
  blkid from util-linux 2.30  (libblkid 2.30.0, 12-Apr-2016)

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 1bd7d2e..f3521ae 100644
--- a/configure.ac
+++ b/configure.ac
@@ -23,10 +23,8 @@ dnl version details from <major>.<minor>[-<suffix>]
 PACKAGE_VERSION_MAJOR=$(echo $PACKAGE_VERSION | awk -F. '{print $1}')
 PACKAGE_VERSION_MINOR=$(echo $PACKAGE_VERSION | awk -F. '{print $2}' \
 					      | awk -F- '{print $1}')
-
-PACKAGE_VERSION_RELEASE=$(echo $PACKAGE_VERSION | awk -F. '{print $3}' \
-						| sed 's/.*@<:@^@<:@:digit:@:>@@:>@.*/0/')
-
+PACKAGE_VERSION_RELEASE=$(echo $PACKAGE_VERSION | awk -F. '{
+                                       print $3 ~ /^@<:@[0-9]@:>@+$/ ? $3 : 0}')
 
 dnl libblkid version
 LIBBLKID_VERSION="$PACKAGE_VERSION_MAJOR.$PACKAGE_VERSION_MINOR.$PACKAGE_VERSION_RELEASE"
-- 
1.8.5.6

