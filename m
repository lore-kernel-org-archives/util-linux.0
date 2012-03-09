Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61168 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758549Ab2CISct (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 9 Mar 2012 13:32:49 -0500
Received: by mail-vw0-f46.google.com with SMTP id ff1so1649153vbb.19
        for <util-linux@vger.kernel.org>; Fri, 09 Mar 2012 10:32:49 -0800 (PST)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 2/2] fstab.5: fix misspelling of deprecated
Date: Fri,  9 Mar 2012 13:32:44 -0500
Message-Id: <1331317964-29267-2-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1331317964-29267-1-git-send-email-dreisner@archlinux.org>
References: <1331317964-29267-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 mount/fstab.5 |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mount/fstab.5 b/mount/fstab.5
index b0cd763..c618947 100644
--- a/mount/fstab.5
+++ b/mount/fstab.5
@@ -167,7 +167,7 @@ support filesystem
 The subtype is defined by '.subtype' suffix.  For
 example 'fuse.sshfs'. It's recommended to use subtype notation rather than add
 any prefix to the first fstab field (for example 'sshfs#example.com' is
-depreacated). 
+deprecated).
 .RE
 
 .B The fourth field
-- 
1.7.9.3

