Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48599 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964951Ab2B1Qp1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Feb 2012 11:45:27 -0500
Received: by mail-vx0-f174.google.com with SMTP id p1so2644946vcq.19
        for <util-linux@vger.kernel.org>; Tue, 28 Feb 2012 08:45:27 -0800 (PST)
MIME-Version: 1.0
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 01/13] fstab.5: fix misspelling of deprecated
Date: Tue, 28 Feb 2012 11:45:09 -0500
Message-Id: <1330447521-886-2-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
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
1.7.9.2

