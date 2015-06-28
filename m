Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34850 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbbF1Tnc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Jun 2015 15:43:32 -0400
Received: by wiga1 with SMTP id a1so54693214wig.0
        for <util-linux@vger.kernel.org>; Sun, 28 Jun 2015 12:43:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/7] zramctl: add link to kernel documentation
Date: Sun, 28 Jun 2015 20:43:20 +0100
Message-Id: <1435520605-4296-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1435520605-4296-1-git-send-email-kerolasa@iki.fi>
References: <1435520605-4296-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The manual page does lacks explanation how to create zram with modprobe.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/zramctl.8 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sys-utils/zramctl.8 b/sys-utils/zramctl.8
index 6f82ccf..8949e7e 100644
--- a/sys-utils/zramctl.8
+++ b/sys-utils/zramctl.8
@@ -109,6 +109,10 @@ and use it as swap device.
 # swapoff /dev/zram0
 # zramctl --reset /dev/zram0
 .fi
+.SH SEE ALSO
+.UR http://git.\:kernel.\:org\:/cgit\:/linux\:/kernel\:/git\:/torvalds\:/linux.git\:/tree\:/Documentation\:/blockdev\:/zram.txt
+Linux kernel documentation
+.UE .
 .SH AUTHORS
 .nf
 Timofey Titovets <nefelim4ag@gmail.com>
-- 
2.4.4

