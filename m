Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:45414
        "EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbdG0VAU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 27 Jul 2017 17:00:20 -0400
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] fstab(5): mention how tabs are escaped
Date: Thu, 27 Jul 2017 23:00:15 +0200
Message-Id: <1501189215-22318-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Someone requested explicitly mentioning how tabs are escaped,
in addition to the already existing spaces example.

Addresses: https://bugs.debian.org/580047
Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 sys-utils/fstab.5 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sys-utils/fstab.5 b/sys-utils/fstab.5
index 07d028765..a9e9f8c54 100644
--- a/sys-utils/fstab.5
+++ b/sys-utils/fstab.5
@@ -116,7 +116,8 @@ lower case characters.
 .RS
 This field describes the mount point (target) for the filesystem.  For swap partitions, this
 field should be specified as `none'. If the name of the mount point
-contains spaces these can be escaped as `\\040'.
+contains spaces or tabs these can be escaped as `\\040' and '\\011'
+respectively.
 .RE
 
 .B The third field
-- 
2.11.0

