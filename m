Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41462 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752929AbeDET5D (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 5 Apr 2018 15:57:03 -0400
Received: by mail-wr0-f195.google.com with SMTP id s12so19752737wrc.8
        for <util-linux@vger.kernel.org>; Thu, 05 Apr 2018 12:57:02 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/4] bash-completion: do not print eject --cdspeed error messages
Date: Thu,  5 Apr 2018 20:56:54 +0100
Message-Id: <20180405195656.4946-3-kerolasa@iki.fi>
In-Reply-To: <20180405195656.4946-1-kerolasa@iki.fi>
References: <20180405195656.4946-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Bash completion is proposing --cdspeed option argument from 'eject
--listspeed /dev/cdrom' output.  Nowadays it is common not to have such
device, and this results to an unwanted error message to stderr merely
messing up command line.  Lets stop that.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/eject | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bash-completion/eject b/bash-completion/eject
index 123829ea2..327ef1b71 100644
--- a/bash-completion/eject
+++ b/bash-completion/eject
@@ -15,7 +15,7 @@ _eject_module()
 			return 0
 			;;
 		'-x'|'--cdspeed')
-			COMPREPLY=( $(compgen -W "$($1 -X)" -- $cur) )
+			COMPREPLY=( $(compgen -W "$(eject --listspeed 2>/dev/null)" -- $cur) )
 			return 0
 			;;
 		'-h'|'--help'|'-V'|'--version')
-- 
2.17.0

