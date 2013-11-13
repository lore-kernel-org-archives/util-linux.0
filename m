Return-Path: util-linux-owner@vger.kernel.org
Received: from rrcs-67-78-168-186.se.biz.rr.com ([67.78.168.186]:41208 "EHLO
	iriserv.iradimed.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755676Ab3KMPTF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 13 Nov 2013 10:19:05 -0500
From: Phillip Susi <psusi@ubuntu.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] Correct mount man page default iso9660 permission
Date: Wed, 13 Nov 2013 10:19:04 -0500
Message-Id: <1384355944-27258-1-git-send-email-psusi@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The mount man page said the default permissions are read for
everyone, but it is in fact, read and execute.

Signed-off-by: Phillip Susi <psusi@ubuntu.com>
---
 sys-utils/mount.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 371f1a1..9b9a9db 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -1980,7 +1980,7 @@ but also apply Acorn extensions if present.
 .TP
 .BI mode= value
 For non-Rock Ridge volumes, give all files the indicated mode.
-(Default: read permission for everybody.)
+(Default: read and execute permission for everybody.)
 Since Linux 2.1.37 one no longer needs to specify the mode in
 decimal. (Octal is indicated by a leading 0.)
 .TP
-- 
1.8.3.2

