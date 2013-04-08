Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:54027 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935701Ab3DHTdZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Apr 2013 15:33:25 -0400
Received: by mail-wi0-f180.google.com with SMTP id c10so2935887wiw.7
        for <util-linux@vger.kernel.org>; Mon, 08 Apr 2013 12:33:24 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/14] bash-completion: setarch: use correct list for architectures
Date: Mon,  8 Apr 2013 20:32:47 +0100
Message-Id: <1365449579-13238-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
References: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/setarch | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/bash-completion/setarch b/bash-completion/setarch
index 80aabd5..b2c6a07 100644
--- a/bash-completion/setarch
+++ b/bash-completion/setarch
@@ -10,14 +10,7 @@ _setarch_module()
 			;;
 	esac
 	if [ $COMP_CWORD -eq 1 ]; then
-		COMPREPLY=( $(compgen -W "linux32 linux64 ppc32 ppc ppc64
-					  ppc64pseries ppc64iseries i386
-					  i486 i586 i686 athlon x86_64
-					  ia64 parisc32 parisc parisc64
-					  s390 s390x sparc sparc32bash
-					  sparc32 sparc64 mips32 mips
-					  mips64 alpha alphaev5 alphaev56
-					  alphaev6 alphaev67" -- $cur) )
+		COMPREPLY=( $(compgen -W "$(setarch --list)" -- $cur) )
 		return 0
 	fi
 	case $cur in
-- 
1.8.2.1

