Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:55313 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbaLNRpV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Dec 2014 12:45:21 -0500
Received: by mail-wi0-f174.google.com with SMTP id h11so6825503wiw.13
        for <util-linux@vger.kernel.org>; Sun, 14 Dec 2014 09:45:20 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 06/16] lslogins: add space to systemd journal header and message
Date: Sun, 14 Dec 2014 17:44:02 +0000
Message-Id: <1418579052-29386-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
References: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This commit changes journal messages in individual user printout the
following way.

Dec 13 16:02:05 systemd[324]:Time has been changed	(old)
Dec 13 16:02:05 systemd[324]: Time has been changed	(new)

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/lslogins.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 4b07636..14a0749 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -1058,7 +1058,7 @@ static void fill_table(const void *u, const VISIT which, const int depth __attri
 static void print_journal_tail(const char *journal_path, uid_t uid, size_t len, int time_mode)
 {
 	sd_journal *j;
-	char *match, *buf;
+	char *match, *timestamp;
 	uint64_t x;
 	time_t t;
 	const char *identifier, *pid, *message;
@@ -1088,21 +1088,18 @@ static void print_journal_tail(const char *journal_path, uid_t uid, size_t len,
 
 		sd_journal_get_realtime_usec(j, &x);
 		t = x / 1000000;
-		buf = make_time(time_mode, t);
-
-		fprintf(stdout, "%s", buf);
-
+		timestamp = make_time(time_mode, t);
+		/* Get rid of journal entry field identifiers */
 		identifier = strchr(identifier, '=') + 1;
-		pid = strchr(pid, '=') + 1		;
+		pid = strchr(pid, '=') + 1;
 		message = strchr(message, '=') + 1;
 
-		fprintf(stdout, " %s", identifier);
-		fprintf(stdout, "[%s]:", pid);
-		fprintf(stdout, "%s\n", message);
+		fprintf(stdout, "%s %s[%s]: %s\n", timestamp, identifier, pid,
+			message);
+		free(timestamp);
 	} while (sd_journal_next(j));
 
 done:
-	free(buf);
 	free(match);
 	sd_journal_flush_matches(j);
 	sd_journal_close(j);
-- 
2.1.3

