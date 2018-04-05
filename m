Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42829 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeDET5G (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 5 Apr 2018 15:57:06 -0400
Received: by mail-wr0-f193.google.com with SMTP id s18so30319013wrg.9
        for <util-linux@vger.kernel.org>; Thu, 05 Apr 2018 12:57:05 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 4/4] bash-completion: fix typo in blockdev file
Date: Thu,  5 Apr 2018 20:56:56 +0100
Message-Id: <20180405195656.4946-5-kerolasa@iki.fi>
In-Reply-To: <20180405195656.4946-1-kerolasa@iki.fi>
References: <20180405195656.4946-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/blockdev | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bash-completion/blockdev b/bash-completion/blockdev
index 8050c0f83..e7aca26de 100644
--- a/bash-completion/blockdev
+++ b/bash-completion/blockdev
@@ -33,7 +33,7 @@ _blockdev_module()
 			COMPREPLY=( $(compgen -W "bytes" -- $cur) )
 			return 0
 			;;
-		'--setbsz'|'--setfra')
+		'--setra'|'--setfra')
 			COMPREPLY=( $(compgen -W "sectors" -- $cur) )
 			return 0
 			;;
-- 
2.17.0

