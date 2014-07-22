Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36909 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757054AbaGVWB5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jul 2014 18:01:57 -0400
Received: by mail-wi0-f171.google.com with SMTP id hi2so6802655wib.4
        for <util-linux@vger.kernel.org>; Tue, 22 Jul 2014 15:01:55 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/10] logger: make --stderr print remote server messages
Date: Tue, 22 Jul 2014 23:00:59 +0100
Message-Id: <1406066459-4816-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
References: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Users wish to see the message should include also remote messages, not
only the one sent to locally via libc function.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 5c75d71..55c7cef 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -317,6 +317,8 @@ static void syslog_rfc3164(struct logger_ctl *ctl, char *msg)
 		 ctl->pri, tp, cp, pid, msg);
 	if (write_all(ctl->fd, buf, strlen(buf) + 1) < 0)
 		warn(_("write failed"));
+	if (ctl->logflags & LOG_PERROR)
+		fprintf(stderr, "%s\n", buf);
 }
 
 static void syslog_rfc5424(struct logger_ctl *ctl, char *msg)
@@ -374,6 +376,8 @@ static void syslog_rfc5424(struct logger_ctl *ctl, char *msg)
 	if (write_all(ctl->fd, buf, strlen(buf) + 1) < 0)
 		warn(_("write failed"));
 	free(hostname);
+	if (ctl->logflags & LOG_PERROR)
+		fprintf(stderr, "%s\n", buf);
 	free(buf);
 }
 
-- 
2.0.2

