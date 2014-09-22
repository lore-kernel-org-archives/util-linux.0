Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:57711 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754851AbaIVUQM (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Sep 2014 16:16:12 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 08/10] textual: grammarize another error message
Date: Mon, 22 Sep 2014 22:15:38 +0200
Message-Id: <1411416940-3249-8-git-send-email-bensberg@justemail.net>
In-Reply-To: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
References: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/hwclock-cmos.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/hwclock-cmos.c b/sys-utils/hwclock-cmos.c
index 7ffbf95..ca6ab1c 100644
--- a/sys-utils/hwclock-cmos.c
+++ b/sys-utils/hwclock-cmos.c
@@ -319,7 +319,7 @@ static inline unsigned long cmos_read(unsigned long reg)
 			       clock_ctl_addr);
 		lseek(dev_port_fd, clock_data_addr, 0);
 		if (read(dev_port_fd, &v, 1) == -1 && debug)
-			warn(_("cmos_read(): read data address %X failed"),
+			warn(_("cmos_read(): read from data address %X failed"),
 			       clock_data_addr);
 		return v;
 	} else {
-- 
1.7.0.4

