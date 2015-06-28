Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37282 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbbF1Tne (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Jun 2015 15:43:34 -0400
Received: by wicgi11 with SMTP id gi11so55414990wic.0
        for <util-linux@vger.kernel.org>; Sun, 28 Jun 2015 12:43:33 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 4/7] docs: unify mkswap(8) with swapon(8) about holes warning
Date: Sun, 28 Jun 2015 20:43:22 +0100
Message-Id: <1435520605-4296-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1435520605-4296-1-git-send-email-kerolasa@iki.fi>
References: <1435520605-4296-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkswap.8 | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/disk-utils/mkswap.8 b/disk-utils/mkswap.8
index 0a0b715..815c23d 100644
--- a/disk-utils/mkswap.8
+++ b/disk-utils/mkswap.8
@@ -128,9 +128,19 @@ e.g.\& using a command like
 .RE
 .fi
 
-Note that a swap file must not contain any holes (so, using
+Note that a swap file must not contain any holes.  Using
 .BR cp (1)
-to create the file is not acceptable).
+to create the file is not acceptable.  Neither is use of
+.BR fallocate (1)
+on file systems that support preallocated files, such as
+.BR XFS " or " ext4 ,
+or on copy-on-write filesystems like
+.BR btrfs .
+It is recommended to use
+.BR dd (1)
+and /dev/zero to in these cases.  Please read notes from
+.BR swapon (8)
+before adding a swap file to copy-on-write filesystems.
 
 .SH ENVIRONMENT
 .IP LIBBLKID_DEBUG=all
-- 
2.4.4

