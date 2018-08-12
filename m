Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44120 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeHLPei (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 12 Aug 2018 11:34:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so11954832wrt.11
        for <util-linux@vger.kernel.org>; Sun, 12 Aug 2018 05:56:38 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] fstrim: use long options in systemd service file
Date: Sun, 12 Aug 2018 13:56:33 +0100
Message-Id: <20180812125633.885-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Long options are more user friendly.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/fstrim.service.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/fstrim.service.in b/sys-utils/fstrim.service.in
index d70367eea..04b1b460b 100644
--- a/sys-utils/fstrim.service.in
+++ b/sys-utils/fstrim.service.in
@@ -3,4 +3,4 @@ Description=Discard unused blocks on filesystems from /etc/fstab
 
 [Service]
 Type=oneshot
-ExecStart=@sbindir@/fstrim -Av
+ExecStart=@sbindir@/fstrim --fstab --verbose
-- 
2.18.0
