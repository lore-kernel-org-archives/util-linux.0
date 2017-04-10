Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:55590 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751564AbdDJXAo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 10 Apr 2017 19:00:44 -0400
Subject: [PATCH 5/5] hwclock: remove residual 'compare' from man-page
To: Karel Zak <kzak@redhat.com>
References: <d0e36cbd-1205-8ce8-3fb3-06efafb12227@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <dd50203f-e46e-808b-1604-53b6cb776b2e@gmx.com>
Date: Mon, 10 Apr 2017 19:00:32 -0400
MIME-Version: 1.0
In-Reply-To: <d0e36cbd-1205-8ce8-3fb3-06efafb12227@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.8.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index 80a579f..f11df80 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -19,7 +19,7 @@ Hardware Clock time; set the Hardware Clock to a specified time; set the
 Hardware Clock from the System Clock; set the System Clock from the
 Hardware Clock; compensate for Hardware Clock drift; correct the System
 Clock timescale; set the kernel's timezone, NTP timescale, and epoch
-(Alpha only); compare the System and Hardware Clocks; and predict future
+(Alpha only); and predict future
 Hardware Clock values based on its drift rate.
 .PP
 Since v2.26 important changes were made to the
