Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:59066 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753891AbcKQCKG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 16 Nov 2016 21:10:06 -0500
Received: from tenfore.ga-group.nl ([77.12.158.253]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mhej1-1cTWLw0ygt-00MtfN for
 <util-linux@vger.kernel.org>; Thu, 17 Nov 2016 03:10:03 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/5] build-sys: update package release number during development
Date: Thu, 17 Nov 2016 03:09:59 +0100
Message-Id: <1479348602-31744-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1479348602-31744-1-git-send-email-sweet_f_a@gmx.de>
References: <1479348602-31744-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Now we use
   v2.29-5-g8ffab30  -> 2.29.5-8ffa   (libblkid 2.29.5)
instead of
   v2.29-5-g8ffab30  -> 2.29.5-8ffa   (libblkid 2.29.0)

otherwise the bugfix releases (2.29.1) would look newer that latest HEAD.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index f3521ae..5c32511 100644
--- a/configure.ac
+++ b/configure.ac
@@ -24,7 +24,7 @@ PACKAGE_VERSION_MAJOR=$(echo $PACKAGE_VERSION | awk -F. '{print $1}')
 PACKAGE_VERSION_MINOR=$(echo $PACKAGE_VERSION | awk -F. '{print $2}' \
 					      | awk -F- '{print $1}')
 PACKAGE_VERSION_RELEASE=$(echo $PACKAGE_VERSION | awk -F. '{
-                                       print $3 ~ /^@<:@[0-9]@:>@+$/ ? $3 : 0}')
+                     sub("-.*","",$3); print $3 ~ /^@<:@[0-9]@:>@+$/ ? $3 : 0}')
 
 dnl libblkid version
 LIBBLKID_VERSION="$PACKAGE_VERSION_MAJOR.$PACKAGE_VERSION_MINOR.$PACKAGE_VERSION_RELEASE"
-- 
1.8.5.6

