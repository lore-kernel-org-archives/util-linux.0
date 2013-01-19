Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:58158 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755692Ab3ASAJs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:09:48 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so3439354wib.13
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:09:47 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 13/22] dmesg: add boundary check to facility & level array usage
Date: Sat, 19 Jan 2013 00:09:02 +0000
Message-Id: <1358554151-25985-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The dmesg should not crash while --decode'ing message facilities and
levels to readable string even if the values are out of bounds.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index f95db40..ddab9b4 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -803,7 +803,9 @@ static void print_record(struct dmesg_control *ctl,
 	/*
 	 * facility : priority :
 	 */
-	if (ctl->decode && rec->level >= 0 && rec->facility >= 0)
+	if (ctl->decode &&
+	    -1 < rec->level    && rec->level     < (int) ARRAY_SIZE(level_names) &&
+	    -1 < rec->facility && rec->facility  < (int) ARRAY_SIZE(facility_names))
 		printf("%-6s:%-6s: ", facility_names[rec->facility].name,
 				      level_names[rec->level].name);
 
-- 
1.8.1.1

