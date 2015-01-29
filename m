Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:44523 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbbA2Hwc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 29 Jan 2015 02:52:32 -0500
Received: by mail-wi0-f172.google.com with SMTP id h11so22020484wiw.5
        for <util-linux@vger.kernel.org>; Wed, 28 Jan 2015 23:52:31 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] docs: mention nice(1) in renice(1) manual page
Date: Thu, 29 Jan 2015 07:52:27 +0000
Message-Id: <1422517947-4470-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Addresses: https://bugs.debian.org/260984
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/renice.1 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sys-utils/renice.1 b/sys-utils/renice.1
index 4acdfb0..a407b70 100644
--- a/sys-utils/renice.1
+++ b/sys-utils/renice.1
@@ -97,6 +97,7 @@ negative (to make things go very fast).
 .B /etc/passwd
 to map user names to user IDs
 .SH SEE ALSO
+.BR nice (1),
 .BR getpriority (2),
 .BR setpriority (2)
 .SH BUGS
-- 
2.2.2

