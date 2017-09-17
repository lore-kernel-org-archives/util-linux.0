Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38343 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbdIQStH (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 17 Sep 2017 14:49:07 -0400
Received: by mail-wr0-f195.google.com with SMTP id p37so3928258wrb.5
        for <util-linux@vger.kernel.org>; Sun, 17 Sep 2017 11:49:06 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/3] docs: remove repeated word from mount(8) man page
Date: Sun, 17 Sep 2017 19:49:00 +0100
Message-Id: <20170917184902.1218-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/mount.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 52c8bdab3..4f9500593 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -1715,7 +1715,7 @@ local time.
 Set offset for conversion of timestamps from local time used by FAT to UTC.
 I.e.,
 .I minutes
-minutes will be subtracted from each timestamp to convert it to UTC used
+will be subtracted from each timestamp to convert it to UTC used
 internally by Linux.  This is useful when the time zone set in the kernel via
 .BR settimeofday (2)
 is not the time zone used by the filesystem.  Note
-- 
2.14.1

