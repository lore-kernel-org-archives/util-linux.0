Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:62722 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbbBVOmj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:39 -0500
Received: by mail-wi0-f173.google.com with SMTP id bs8so11854047wib.0
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:38 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 10/13] bash-completion: add freeze mode to rtcwake
Date: Sun, 22 Feb 2015 14:42:16 +0000
Message-Id: <1424616139-638-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Missed when commit ece44f19f423408f576f348fed2845c876d72c6e added support
to freeze.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/rtcwake | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bash-completion/rtcwake b/bash-completion/rtcwake
index 51566a2..70ae743 100644
--- a/bash-completion/rtcwake
+++ b/bash-completion/rtcwake
@@ -12,7 +12,7 @@ _rtcwake_module()
 			return 0
 			;;
 		'-m'|'--mode')
-			COMPREPLY=( $(compgen -W "standby mem disk off no on disable show" -- $cur) )
+			COMPREPLY=( $(compgen -W "standby freeze mem disk off no on disable show" -- $cur) )
 			return 0
 			;;
 		'-s'|'--seconds')
-- 
2.3.0

