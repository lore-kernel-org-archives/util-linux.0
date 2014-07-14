Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:55597 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753305AbaGNJDN (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Jul 2014 05:03:13 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/5] build-sys: exclude Documentation/ from looking for translatable strings
Date: Mon, 14 Jul 2014 11:02:57 +0200
Message-Id: <1405328581-2202-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 po/update-potfiles |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/po/update-potfiles b/po/update-potfiles
index 925f386..884e4d9 100755
--- a/po/update-potfiles
+++ b/po/update-potfiles
@@ -28,6 +28,7 @@ source_files=$(
 		-e '/\(\.h\|\.c\)$/!d' \
 		-e '/^tests\//d' \
 		-e '/\/samples\//d' \
+		-e '/^Documentation\//d' \
 )
 
 # throw away non-existing files (dirty git repo)
-- 
1.7.0.4

