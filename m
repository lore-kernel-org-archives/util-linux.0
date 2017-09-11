Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37803 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbdIKT5X (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 11 Sep 2017 15:57:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id f4so7679532wmh.4
        for <util-linux@vger.kernel.org>; Mon, 11 Sep 2017 12:57:22 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/4] logger: fix memory leaks [asan]
Date: Mon, 11 Sep 2017 20:57:16 +0100
Message-Id: <20170911195717.817-3-kerolasa@iki.fi>
In-Reply-To: <20170911195717.817-1-kerolasa@iki.fi>
References: <20170911195717.817-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index f6fb350cc..4eba778b9 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -606,25 +606,30 @@ static char *strdup_structured_data(struct structured_data *sd)
 
 	xasprintf(&res, "[%s %s]", sd->id,
 			(tmp = strv_join(sd->params, " ")));
+	free(sd->id);
+	strv_free(sd->params);
 	free(tmp);
 	return res;
 }
 
 static char *strdup_structured_data_list(struct list_head *ls)
 {
-	struct list_head *p;
+	struct list_head *p, *pnext;
 	char *res = NULL;
 
-	list_for_each(p, ls) {
+	list_for_each_safe(p, pnext, ls) {
 		struct structured_data *sd = list_entry(p, struct structured_data, sds);
 		char *one = strdup_structured_data(sd);
 		char *tmp = res;
 
-		if (!one)
+		if (!one) {
+			free(tmp);
 			continue;
+		}
 		res = strappend(tmp, one);
 		free(tmp);
 		free(one);
+		free(sd);
 	}
 
 	return res;
@@ -979,6 +984,7 @@ static void logger_stdin(struct logger_ctl *ctl)
 		if (c == '\n')	/* discard line terminator */
 			c = getchar();
 	}
+	free(buf);
 }
 
 static void logger_close(const struct logger_ctl *ctl)
-- 
2.14.1

