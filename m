Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:45590 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101AbaHXQFe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 24 Aug 2014 12:05:34 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id 7C3D2140EB
	for <util-linux@vger.kernel.org>; Sun, 24 Aug 2014 18:05:02 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Robert Millan <rmh@debian.org>
Subject: [PATCH 1/4] Report correct disk size on GNU/kFreeBSD. Thanks Tuco.
Date: Sun, 24 Aug 2014 18:04:41 +0200
Message-Id: <1408896284-14467-2-git-send-email-andreas@fatal.se>
In-Reply-To: <1408896284-14467-1-git-send-email-andreas@fatal.se>
References: <1408896284-14467-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Robert Millan <rmh@debian.org>

Addresses-Debian-Bug: 592292
---
 lib/blkdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/blkdev.c b/lib/blkdev.c
index f8182c0..a293529 100644
--- a/lib/blkdev.c
+++ b/lib/blkdev.c
@@ -25,6 +25,10 @@
 #include <sys/disk.h>
 #endif
 
+#ifdef __FreeBSD_kernel__
+#include <sys/disk.h>
+#endif
+
 #include "blkdev.h"
 #include "c.h"
 #include "linux_version.h"
-- 
2.1.0.rc1

