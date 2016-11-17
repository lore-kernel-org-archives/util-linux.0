Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:51550 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754320AbcKQCKG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 16 Nov 2016 21:10:06 -0500
Received: from tenfore.ga-group.nl ([77.12.158.253]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LdKs1-1cXUPS1vJh-00iT6x for
 <util-linux@vger.kernel.org>; Thu, 17 Nov 2016 03:10:03 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/5] build-sys: cosmetics PACKAGE_VERSION_MINOR
Date: Thu, 17 Nov 2016 03:10:00 +0100
Message-Id: <1479348602-31744-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1479348602-31744-1-git-send-email-sweet_f_a@gmx.de>
References: <1479348602-31744-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This should changes nothing.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5c32511..680f7f1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -21,8 +21,8 @@ AC_PREFIX_DEFAULT([/usr])
 
 dnl version details from <major>.<minor>[-<suffix>]
 PACKAGE_VERSION_MAJOR=$(echo $PACKAGE_VERSION | awk -F. '{print $1}')
-PACKAGE_VERSION_MINOR=$(echo $PACKAGE_VERSION | awk -F. '{print $2}' \
-					      | awk -F- '{print $1}')
+PACKAGE_VERSION_MINOR=$(echo $PACKAGE_VERSION | awk -F. '{
+                                                   sub("-.*","",$2); print $2}')
 PACKAGE_VERSION_RELEASE=$(echo $PACKAGE_VERSION | awk -F. '{
                      sub("-.*","",$3); print $3 ~ /^@<:@[0-9]@:>@+$/ ? $3 : 0}')
 
-- 
1.8.5.6

