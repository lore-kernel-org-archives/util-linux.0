Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36595 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbbCOMzL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 Mar 2015 08:55:11 -0400
Received: by wibg7 with SMTP id g7so18647662wib.1
        for <util-linux@vger.kernel.org>; Sun, 15 Mar 2015 05:55:10 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 5/8] logger: fix rfc5424 format crash
Date: Sun, 15 Mar 2015 12:54:51 +0000
Message-Id: <1426424094-25451-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
References: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

$ logger --rfc5424=notq message
Segmentation fault (core dumped)

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 838d225..b007377 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -476,7 +476,8 @@ static void syslog_rfc5424_header(struct logger_ctl *const ctl)
 #endif
 			xasprintf(&structured_data,
 				 "[timeQuality tzKnown=\"1\" isSynced=\"0\"]");
-	}
+	} else
+		structured_data = xstrdup("");
 
 	xasprintf(&ctl->hdr, "<%d>1 %s %s %s %s %s %s ",
 		ctl->pri,
-- 
2.3.2

