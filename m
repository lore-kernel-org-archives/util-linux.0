Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f53.google.com ([74.125.82.53]:58029 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313Ab3IHQJT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Sep 2013 12:09:19 -0400
Received: by mail-wg0-f53.google.com with SMTP id x12so2117996wgg.20
        for <util-linux@vger.kernel.org>; Sun, 08 Sep 2013 09:09:18 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/4] last: fix memory leak
Date: Sun,  8 Sep 2013 17:09:06 +0100
Message-Id: <1378656549-3729-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/login-utils/last.c b/login-utils/last.c
index eb64bde..bc1b4ce 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -819,6 +819,10 @@ static void process_wtmp_file(const struct last_control *ctl)
 
 	printf(_("\n%s begins %s"), basename(ctl->altv[ctl->alti]), ctime(&begintime));
 	fclose(fp);
+	for (p = utmplist; p; p = next) {
+		next = p->next;
+		free(p);
+	}
 }
 
 int main(int argc, char **argv)
-- 
1.8.4

