Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37422 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbbJaTVh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 31 Oct 2015 15:21:37 -0400
Received: by wicfv8 with SMTP id fv8so28974836wic.0
        for <util-linux@vger.kernel.org>; Sat, 31 Oct 2015 12:21:36 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 05/12] script, hwclock: check file exist with access(3) rather than stat(3)
Date: Sat, 31 Oct 2015 19:21:17 +0000
Message-Id: <1446319284-24778-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
References: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/hwclock.c | 5 +----
 term-utils/script.c | 3 +--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 4b201d7..0d11061 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -258,15 +258,12 @@ hw_clock_is_utc(const bool utc, const bool local_opt,
 static int read_adjtime(struct adjtime *adjtime_p)
 {
 	FILE *adjfile;
-	int rc;			/* local return code */
-	struct stat statbuf;	/* We don't even use the contents of this. */
 	char line1[81];		/* String: first line of adjtime file */
 	char line2[81];		/* String: second line of adjtime file */
 	char line3[81];		/* String: third line of adjtime file */
 	long timeval;
 
-	rc = stat(adj_file_name, &statbuf);
-	if (rc < 0 && errno == ENOENT) {
+	if (access(adj_file_name, R_OK) != 0) {
 		/* He doesn't have a adjtime file, so we'll use defaults. */
 		adjtime_p->drift_factor = 0;
 		adjtime_p->last_adj_time = 0;
diff --git a/term-utils/script.c b/term-utils/script.c
index b6227c0..e247c83 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -609,7 +609,6 @@ static void getmaster(struct script_control *ctl)
 	}
 #else
 	char *pty, *bank, *cp;
-	struct stat stb;
 
 	ctl->isterm = isatty(STDIN_FILENO);
 
@@ -617,7 +616,7 @@ static void getmaster(struct script_control *ctl)
 	for (bank = "pqrs"; *bank; bank++) {
 		ctl->line[strlen("/dev/pty")] = *bank;
 		*pty = '0';
-		if (stat(ctl->line, &stb) < 0)
+		if (access(ctl->line, F_OK) != 0)
 			break;
 		for (cp = "0123456789abcdef"; *cp; cp++) {
 			*pty = *cp;
-- 
2.6.2

