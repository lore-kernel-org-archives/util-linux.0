Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36187 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbcGQNAe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Jul 2016 09:00:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id x83so8717704wma.3
        for <util-linux@vger.kernel.org>; Sun, 17 Jul 2016 06:00:33 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 06/13] logger: simplify if clause [oclint]
Date: Sun, 17 Jul 2016 14:00:08 +0100
Message-Id: <20160717130015.31760-7-kerolasa@iki.fi>
In-Reply-To: <20160717130015.31760-1-kerolasa@iki.fi>
References: <20160717130015.31760-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This has effect of collapsing rather long indentation block, so commit
separately.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 9f2940c..8a1f7d6 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -927,32 +927,32 @@ static void logger_stdin(struct logger_ctl *ctl)
 	c = getchar();
 	while (c != EOF) {
 		i = 0;
-		if (ctl->prio_prefix) {
-			if (c == '<') {
-				pri = 0;
+		if (ctl->prio_prefix && c == '<') {
+			pri = 0;
+			buf[i++] = c;
+			while (isdigit(c = getchar()) && pri <= 191) {
+				buf[i++] = c;
+				pri = pri * 10 + c - '0';
+			}
+			if (c != EOF && c != '\n')
 				buf[i++] = c;
-				while (isdigit(c = getchar()) && pri <= 191) {
-					buf[i++] = c;
-					pri = pri * 10 + c - '0';
-				}
-				if (c != EOF && c != '\n')
-					buf[i++] = c;
-				if (c == '>' && 0 <= pri && pri <= 191) { /* valid RFC PRI values */
-					i = 0;
-					if (pri < 8)
-						pri |= 8; /* kern facility is forbidden */
-					ctl->pri = pri;
-				} else
-					ctl->pri = default_priority;
-
-				if (ctl->pri != last_pri) {
-					has_header = 0;
-					max_usrmsg_size = ctl->max_message_size - strlen(ctl->hdr);
-					last_pri = ctl->pri;
-				}
-				if (c != EOF && c != '\n')
-					c = getchar();
+			if (c == '>' && 0 <= pri && pri <= 191) {
+				/* valid RFC PRI values */
+				i = 0;
+				if (pri < 8)	/* kern facility is forbidden */
+					pri |= 8;
+				ctl->pri = pri;
+			} else
+				ctl->pri = default_priority;
+
+			if (ctl->pri != last_pri) {
+				has_header = 0;
+				max_usrmsg_size =
+				    ctl->max_message_size - strlen(ctl->hdr);
+				last_pri = ctl->pri;
 			}
+			if (c != EOF && c != '\n')
+				c = getchar();
 		}
 
 		while (c != EOF && c != '\n' && i < max_usrmsg_size) {
-- 
2.9.0

