Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:65112 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbaLNRou (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Dec 2014 12:44:50 -0500
Received: by mail-wg0-f48.google.com with SMTP id y19so12891780wgg.35
        for <util-linux@vger.kernel.org>; Sun, 14 Dec 2014 09:44:49 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 02/16] lslogins: make journald last logs time stamps to honor --time-format
Date: Sun, 14 Dec 2014 17:43:58 +0000
Message-Id: <1418579052-29386-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
References: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This makes by default the last logs to have year in output when necessary.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/lslogins.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index f050595..85fd7c8 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -1055,7 +1055,7 @@ static void fill_table(const void *u, const VISIT which, const int depth __attri
 	return;
 }
 #ifdef HAVE_LIBSYSTEMD
-static void print_journal_tail(const char *journal_path, uid_t uid, size_t len)
+static void print_journal_tail(const char *journal_path, uid_t uid, size_t len, int time_mode)
 {
 	sd_journal *j;
 	char *match, *buf;
@@ -1069,7 +1069,6 @@ static void print_journal_tail(const char *journal_path, uid_t uid, size_t len)
 	else
 		sd_journal_open(&j, SD_JOURNAL_LOCAL_ONLY);
 
-	buf = xmalloc(sizeof(char) * 16);
 	xasprintf(&match, "_UID=%d", uid);
 
 	sd_journal_add_match(j, match, 0);
@@ -1089,7 +1088,7 @@ static void print_journal_tail(const char *journal_path, uid_t uid, size_t len)
 
 		sd_journal_get_realtime_usec(j, &x);
 		t = x / 1000000;
-		strftime(buf, 16, "%b %d %H:%M:%S", localtime(&t));
+		buf = make_time(time_mode, t);
 
 		fprintf(stdout, "%s", buf);
 
@@ -1148,7 +1147,7 @@ static int print_user_table(struct lslogins_control *ctl)
 		print_pretty(tb);
 #ifdef HAVE_LIBSYSTEMD
 		fprintf(stdout, _("\nLast logs:\n"));
-		print_journal_tail(ctl->journal_path, ctl->uid, 3);
+		print_journal_tail(ctl->journal_path, ctl->uid, 3, ctl->time_mode);
 		fputc('\n', stdout);
 #endif
 	} else
-- 
2.1.3

