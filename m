Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36489 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbcEIV1v (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 9 May 2016 17:27:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id w143so22500765wmw.3
        for <util-linux@vger.kernel.org>; Mon, 09 May 2016 14:27:51 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 10/12] write: make timestamp to be obviously just a clock time
Date: Mon,  9 May 2016 22:27:26 +0100
Message-Id: <1462829248-6935-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
References: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Just by looking the code one will have hard time knowing that a slice of
ctime() from characters 11 to 16 is HH:MM time format.  Use of strftime()
tells exactly what one can expect without additional comments.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index 403d4a7..b10c129 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -239,9 +239,10 @@ static void write_line(char *s)
  */
 static void do_write(const struct write_control *ctl)
 {
-	char *login, *pwuid, *time_stamp;
+	char *login, *pwuid, time_stamp[6];
 	struct passwd *pwd;
 	time_t now;
+	struct tm *tm;
 	char path[PATH_MAX], *host, line[512];
 	struct sigaction sigact;
 
@@ -265,21 +266,21 @@ static void do_write(const struct write_control *ctl)
 	sigaction(SIGINT, &sigact, NULL);
 	sigaction(SIGHUP, &sigact, NULL);
 
-	/* print greeting */
 	host = xgethostname();
 	if (!host)
 		host = xstrdup("???");
 
-	now = time((time_t *) NULL);
-	time_stamp = ctime(&now);
-	time_stamp[16] = '\0';
-	printf("\r\n\007\007\007");
+	now = time((time_t *)NULL);
+	tm = localtime(&now);
+	strftime(time_stamp, sizeof(time_stamp), "%H:%M", tm);
+	/* print greeting */
+	printf("\r\n\a\a\a");
 	if (strcmp(login, pwuid))
 		printf(_("Message from %s@%s (as %s) on %s at %s ..."),
-		       login, host, pwuid, ctl->src_tty, time_stamp + 11);
+		       login, host, pwuid, ctl->src_tty, time_stamp);
 	else
 		printf(_("Message from %s@%s on %s at %s ..."),
-		       login, host, ctl->src_tty, time_stamp + 11);
+		       login, host, ctl->src_tty, time_stamp);
 	free(host);
 	printf("\r\n");
 
-- 
2.8.2

