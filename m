Return-Path: util-linux-owner@vger.kernel.org
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:34554 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab2IOG3x (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 15 Sep 2012 02:29:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtteri2.pp.htv.fi (Postfix) with ESMTP id 9A85C19B80C
	for <util-linux@vger.kernel.org>; Sat, 15 Sep 2012 09:29:51 +0300 (EEST)
Received: from smtp5.welho.com ([213.243.153.39])
	by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
	with ESMTP id ikwpFCb1J-XL for <util-linux@vger.kernel.org>;
	Sat, 15 Sep 2012 09:29:51 +0300 (EEST)
Received: from michael.steam.fi.bobcat.mine.nu (cs78200229.pp.htv.fi [62.78.200.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp5.welho.com (Postfix) with ESMTPS id 43ACC5BC002
	for <util-linux@vger.kernel.org>; Sat, 15 Sep 2012 09:29:51 +0300 (EEST)
From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] docs: umount.8 syntax fix.
Date: Sat, 15 Sep 2012 09:29:49 +0300
Message-Id: <1347690590-29482-1-git-send-email-ville.skytta@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 sys-utils/umount.8 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index f0fcd99..b949aeb 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -76,8 +76,8 @@ In case the unmounted device was a loop device, also free this loop
 device.
 .TP
 \fB\-\-fake\fP
-Causes everything to be done except for the actual system call; this
-'fakes' unmounting the filesystem.  It can be used to remove entries from
+Causes everything to be done except for the actual system call; this 'fakes'
+unmounting the filesystem.  It can be used to remove entries from
 .I /etc/mtab
 that were unmounted earlier with the
 .B \-n
-- 
1.7.11.4

