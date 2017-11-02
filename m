Return-Path: util-linux-owner@vger.kernel.org
Received: from imap.cs.msu.ru ([188.44.42.39]:52625 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752183AbdKBBtM (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 1 Nov 2017 21:49:12 -0400
Received: from [10.4.30.50] (port=34356)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89 (FreeBSD))
        (envelope-from <m.vorobyov@cs.msu.ru>)
        id 1eA3w2-000EZm-Q4
        for util-linux@vger.kernel.org; Thu, 02 Nov 2017 04:04:43 +0300
To: util-linux@vger.kernel.org
From: Mikhail Vorobyov <m.vorobyov@cs.msu.ru>
Message-ID: <48789bdc-3354-5282-dbe8-fd81281324eb@cs.msu.ru>
Date: Thu, 2 Nov 2017 04:04:42 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH] libfdisk: (sun) fix creation of whole disk partition
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

sun_add_partition() allowed the 1st sector to be 0 for the 3rd partition
only if that sector was free or if other partitions covered the whole
disk. Now it's always allowed for the 1st sector to be set to 0 for
the 3rd partition.

Signed-off-by: Mikhail Vorobyov <m.vorobyov@cs.msu.ru>
---
 libfdisk/src/sun.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libfdisk/src/sun.c b/libfdisk/src/sun.c
index 0526227ce..c058637f5 100644
--- a/libfdisk/src/sun.c
+++ b/libfdisk/src/sun.c
@@ -543,6 +543,10 @@ static int sun_add_partition(
                                fdisk_ask_number_set_low(ask,     0);   /* minimal */
                                fdisk_ask_number_set_default(ask, 0);   /* default */
                                fdisk_ask_number_set_high(ask,    0);   /* maximal */
+                       } else if (n == 2) {
+                               fdisk_ask_number_set_low(ask,     0);   /* minimal */
+                               fdisk_ask_number_set_default(ask, fdisk_scround(cxt, start));   /* default */
+                               fdisk_ask_number_set_high(ask,    fdisk_scround(cxt, stop));    /* maximal */
                        } else {
                                fdisk_ask_number_set_low(ask,     fdisk_scround(cxt, start));   /* minimal */
                                fdisk_ask_number_set_default(ask, fdisk_scround(cxt, start));   /* default */
--
2.13.6
