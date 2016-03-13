Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33827 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964AbcCMKbz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Mar 2016 06:31:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id p65so10013356wmp.1
        for <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 03:31:54 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 01/10] logger: fix memory leak [ASAN and valgrind]
Date: Sun, 13 Mar 2016 10:31:40 +0000
Message-Id: <1457865109-2881-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
References: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 7b88b17..1ef12cd 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -341,8 +341,10 @@ static int journald_entry(struct logger_ctl *ctl, FILE *fp)
 	for (lines = 0; /* nothing */ ; lines++) {
 		buf = NULL;
 		sz = getline(&buf, &dummy, fp);
-		if (sz == -1)
+		if (sz == -1) {
+			free(buf);
 			break;
+		}
 		if (0 < sz && buf[sz - 1] == '\n') {
 			sz--;
 			buf[sz] = '\0';
-- 
2.7.2

