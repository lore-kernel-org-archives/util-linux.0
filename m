Return-Path: util-linux-owner@vger.kernel.org
Received: from cthulhu.worldbroken.com ([173.230.133.178]:46241 "EHLO
	cthulhu.worldbroken.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791AbbBXRYe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 Feb 2015 12:24:34 -0500
From: wfp5p@worldbroken.com
To: util-linux@vger.kernel.org
Subject: [PATCH 6/8] hwclock.8.in: fix spelling transfered -> transferred
Date: Tue, 24 Feb 2015 12:15:21 -0500
Message-Id: <1424798123-11044-7-git-send-email-wfp5p@worldbroken.com>
In-Reply-To: <1424798123-11044-1-git-send-email-wfp5p@worldbroken.com>
References: <1424798123-11044-1-git-send-email-wfp5p@worldbroken.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Bill Pemberton <wfp5p@worldbroken.com>

Signed-off-by: Bill Pemberton <wfp5p@worldbroken.com>
---
 sys-utils/hwclock.8.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index b13be31a2cd9..fbc10caa34cc 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -854,7 +854,7 @@ running at their own speed and drifting away from the 'correct' time at
 their own rates.  The methods and software for drift correction are
 different for each of them.  However, most systems are configured to
 exchange values between these two clocks at startup and shutdown.  Now
-the individual device's time keeping errors are transfered back and
+the individual device's time keeping errors are transferred back and
 forth between each other.  Attempt to configure drift correction for only
 one of them, and the other's drift will be overlaid upon it.  If the big
 picture is not kept in mind, confusion will soon ensue.
-- 
2.1.0

