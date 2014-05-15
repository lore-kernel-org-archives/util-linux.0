Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:50565 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbaEOMM6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 15 May 2014 08:12:58 -0400
Received: by mail-ee0-f46.google.com with SMTP id t10so583308eei.5
        for <util-linux@vger.kernel.org>; Thu, 15 May 2014 05:12:57 -0700 (PDT)
Message-ID: <5374AF46.4080708@gmail.com>
Date: Thu, 15 May 2014 14:12:54 +0200
From: =?ISO-8859-15?Q?Stephan_M=FCller?= <fruktopus@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH] fix tiny typo in man mount
Content-Type: text/plain; charset=ISO-8859-15
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

adjust command to use /dev/loop3 as described in text

Signed-off-by: Stephan Mueller <fruktopus@gmail.com>
---

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 489079d..be3c393 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -2843,7 +2843,7 @@ One further possible type is a mount via the loop
device. For example,
 the command
 .RS
 .sp
-.B "mount /tmp/disk.img /mnt \-t vfat \-o loop=/dev/loop"
+.B "mount /tmp/disk.img /mnt \-t vfat \-o loop=/dev/loop3"
 .sp
 .RE
 will set up the loop device

