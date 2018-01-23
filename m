Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:54262 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752252AbeAWP7c (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 23 Jan 2018 10:59:32 -0500
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M8m7Q-1eWLTL0GC4-00CEKU for <util-linux@vger.kernel.org>; Tue, 23 Jan 2018
 16:59:31 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 7/7] rfkill: provide RFKILL_TYPE_FM if undefined
Date: Tue, 23 Jan 2018 16:59:28 +0100
Message-Id: <20180123155928.7629-8-sweet_f_a@gmx.de>
In-Reply-To: <20180123155928.7629-1-sweet_f_a@gmx.de>
References: <20180123155928.7629-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

As discussed last year it's nice to be compatible to 2.6.32
https://www.spinics.net/lists/util-linux-ng/msg13963.html

BTW also re-define NUM_RFKILL_TYPES if needed, although we are
not really using it.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/rfkill.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sys-utils/rfkill.c b/sys-utils/rfkill.c
index 75804ad41..031fe436f 100644
--- a/sys-utils/rfkill.c
+++ b/sys-utils/rfkill.c
@@ -45,7 +45,12 @@
  * year 2009 (2.6.33) or older.
  */
 #ifndef RFKILL_TYPE_NFC
+# ifndef RFKILL_TYPE_FM
+#  define RFKILL_TYPE_FM	RFKILL_TYPE_GPS + 1
+# endif
 # define RFKILL_TYPE_NFC	RFKILL_TYPE_FM + 1
+# undef NUM_RFKILL_TYPES
+# define NUM_RFKILL_TYPES	RFKILL_TYPE_NFC + 1
 #endif
 
 struct rfkill_type_str {
-- 
2.13.6

