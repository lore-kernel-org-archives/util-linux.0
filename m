Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32929 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbdDKKBL (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 11 Apr 2017 06:01:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id o81so13926242wmb.0
        for <util-linux@vger.kernel.org>; Tue, 11 Apr 2017 03:01:10 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] bash-completion: update hwclock
Date: Tue, 11 Apr 2017 11:01:06 +0100
Message-Id: <20170411100106.7053-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add --udate-drift [1], remove --badyear [2], and use the same argument
for --date as in manual page[3].

Commit [1]: f276d71a3ef6a65299deb5e14a188e0a786ecebd
Commit [2]: f6374e1fb33d5ca726b72212b787e11fea78c0ca
Commit [3]: cc5ec6936ea3c218b3e8c46880659db5ee01329f
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/hwclock | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bash-completion/hwclock b/bash-completion/hwclock
index 89b17bd07..b90f00c0c 100644
--- a/bash-completion/hwclock
+++ b/bash-completion/hwclock
@@ -12,7 +12,7 @@ _hwclock_module()
 			return 0
 			;;
 		'--date')
-			COMPREPLY=( $(compgen -W "date" -- $cur) )
+			COMPREPLY=( $(compgen -W "time" -- $cur) )
 			return 0
 			;;
 		'--epoch')
@@ -40,9 +40,9 @@ _hwclock_module()
 				--localtime
 				--rtc
 				--directisa
-				--badyear
 				--date
 				--epoch
+				--update-drift
 				--noadjfile
 				--adjfile
 				--test
-- 
2.12.2

