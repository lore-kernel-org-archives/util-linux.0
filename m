Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbbj.dreamhost.com ([208.97.132.119]:48264 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751724Ab1LTNmP (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 20 Dec 2011 08:42:15 -0500
Subject: [PATCH 4/5] fdisk: remove packed definitions
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 20 Dec 2011 14:42:07 +0100
Message-ID: <1324388527.3316.10.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index 84be09c..d8832e9 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -26,12 +26,6 @@
 #define cround(n)	(display_in_cyl_units ? ((n)/units_per_sector)+1 : (n))
 #define scround(x)	(((x)+units_per_sector-1)/units_per_sector)
 
-#if defined(__GNUC__) && (defined(__arm__) || defined(__alpha__))
-# define PACKED __attribute__ ((packed))
-#else
-# define PACKED
-#endif
-
 struct partition {
 	unsigned char boot_ind;         /* 0x80 - active */
 	unsigned char head;             /* starting head */
-- 
1.7.4.1





