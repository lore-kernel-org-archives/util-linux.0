Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f169.google.com ([209.85.212.169]:50627 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839Ab3FBRvj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Jun 2013 13:51:39 -0400
Received: by mail-wi0-f169.google.com with SMTP id hn14so2122915wib.4
        for <util-linux@vger.kernel.org>; Sun, 02 Jun 2013 10:51:38 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/19] docs: add lscpu max mhz to manual and bash completion
Date: Sun,  2 Jun 2013 18:51:09 +0100
Message-Id: <1370195485-27907-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
References: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/lscpu | 3 ++-
 sys-utils/lscpu.1     | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/bash-completion/lscpu b/bash-completion/lscpu
index bce07c4..2736742 100644
--- a/bash-completion/lscpu
+++ b/bash-completion/lscpu
@@ -17,7 +17,8 @@ _lscpu_module()
 				POLARIZATION,
 				ADDRESS,
 				CONFIGURED,
-				ONLINE,"
+				ONLINE,
+				MMHZ"
 			compopt -o nospace
 			COMPREPLY=( $(compgen -W "$OPTS" -- $cur) )
 			return 0
diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index f747a35..19c964a 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -76,6 +76,11 @@ The workload is concentrated on few CPUs.
 For vertical polarization, the column also shows the degree of concentration,
 high, medium, or low.  This column contains data only if your hardware system
 and hypervisor support CPU polarization.
+.TP
+.B MMHZ
+Maximum megaherz value for the cpu.  Useful when lscpu is used as hardware
+inventory infomation gathering tool.  Notice that the megahertz value is
+dynamic, and driven by CPU governor depending on current resource need.
 .RE
 .SH OPTIONS
 .TP
-- 
1.8.3

