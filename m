Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33334 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbdDFVLU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 6 Apr 2017 17:11:20 -0400
Received: by mail-wr0-f195.google.com with SMTP id g19so14817250wrb.0
        for <util-linux@vger.kernel.org>; Thu, 06 Apr 2017 14:11:19 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/2] fincore: fix file descriptor leak
Date: Thu,  6 Apr 2017 22:11:15 +0100
Message-Id: <20170406211116.4543-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/fincore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/misc-utils/fincore.c b/misc-utils/fincore.c
index ffc02fc2c..6a29f375a 100644
--- a/misc-utils/fincore.c
+++ b/misc-utils/fincore.c
@@ -239,6 +239,7 @@ static int fincore_name(struct fincore_control *ctl,
 
 	if (fstat (fd, sb) < 0) {
 		warn(_("failed to do fstat: %s"), name);
+		close (fd);
 		return -errno;
 	}
 
-- 
2.12.2

