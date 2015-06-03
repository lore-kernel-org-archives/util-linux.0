Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:48134
	"EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbbFCQcS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 3 Jun 2015 12:32:18 -0400
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: 786554@bugs.debian.org, Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] man: fix nolazytime typo in mount(8)
Date: Wed,  3 Jun 2015 18:32:09 +0200
Message-Id: <1433349129-5460-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Avoids double negation...

Addresses: http://bugs.debian.org/786554
Reported-by: Felix Zielcke <fzielcke@z-51.de>
Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 sys-utils/mount.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index a4ff749..2783923 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -1067,7 +1067,7 @@ or
 .sp
 .TP
 .B nolazytime
-Do not use the nolazytime feature.
+Do not use the lazytime feature.
 .TP
 .B suid
 Allow set-user-identifier or set-group-identifier bits to take
-- 
2.1.4

