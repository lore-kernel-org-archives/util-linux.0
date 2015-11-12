Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:59240
	"EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122AbbKLLg1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 12 Nov 2015 06:36:27 -0500
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Ritesh Raj Sarraf <rrs@debian.org>, Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] bash-completion: fstrim: use mountpoint, not device
Date: Thu, 12 Nov 2015 12:36:03 +0100
Message-Id: <1447328163-5618-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

fstrim takes mountpoint as argument but the bash completion
was completing it to a device node.

Addresses: http://bugs.debian.org/804833
Reported-by: Ritesh Raj Sarraf <rrs@debian.org>
Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 bash-completion/fstrim | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bash-completion/fstrim b/bash-completion/fstrim
index 7d3cde9..726ddd9 100644
--- a/bash-completion/fstrim
+++ b/bash-completion/fstrim
@@ -27,7 +27,7 @@ _fstrim_module()
 			;;
 	esac
 	local MPOINTS
-	MPOINTS=$(findmnt -rno SOURCE | grep ^/dev)
+	MPOINTS=$(findmnt -rno SOURCE,TARGET | awk '/^\/dev/{print $2}')
 	COMPREPLY=( $(compgen -W "$MPOINTS" -- $cur) )
 	return 0
 }
-- 
2.1.4

