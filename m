Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54135 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbeBRUWH (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 18 Feb 2018 15:22:07 -0500
Received: by mail-wm0-f68.google.com with SMTP id t74so11661102wme.3
        for <util-linux@vger.kernel.org>; Sun, 18 Feb 2018 12:22:07 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] bash-completion: update zramctl algorithms list
Date: Sun, 18 Feb 2018 20:22:01 +0000
Message-Id: <20180218202201.3090-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reference: a3612b81fe0c172bc4fe7e2cf468f195bd785222.
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/zramctl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bash-completion/zramctl b/bash-completion/zramctl
index 672d8102a..31e3c76a6 100644
--- a/bash-completion/zramctl
+++ b/bash-completion/zramctl
@@ -6,7 +6,7 @@ _zramctl_module()
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
 		'-a'|'--algorithm')
-			COMPREPLY=( $(compgen -W "lzo lz4" -- $cur) )
+			COMPREPLY=( $(compgen -W "lzo lz4 lz4hc deflate 842" -- $cur) )
 			return 0
 			;;
 		'-o'|'--output')
-- 
2.16.2

