Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35298 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbaL0RRo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 27 Dec 2014 12:17:44 -0500
Received: by mail-wi0-f169.google.com with SMTP id r20so20760533wiv.2
        for <util-linux@vger.kernel.org>; Sat, 27 Dec 2014 09:17:43 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 19/22] script: add 'Script started' line always to capture file
Date: Sat, 27 Dec 2014 17:17:32 +0000
Message-Id: <1419700655-19107-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1419700655-19107-1-git-send-email-kerolasa@iki.fi>
References: <1419700655-19107-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The scriptreplay(1) will expect the capture file to have a header that is
omited.  Before this change the --quiet option together with timing
caused following replay error.

$ script --quiet --timing=timing
[...]
$ scriptreplay timing typescript
[...]
scriptreplay: unexpected end of file on typescript

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 2def44a..6e11fa3 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -227,6 +227,7 @@ static void do_io(struct script_control *ctl)
 	int ret, i;
 	ssize_t bytes;
 	double oldtime = time(NULL);
+	time_t tvec = time((time_t *)NULL);
 
 	if (ctl->tflg && !ctl->timingfp)
 		ctl->timingfp = fdopen(STDERR_FILENO, "w");
@@ -238,11 +239,8 @@ static void do_io(struct script_control *ctl)
 	pfd[2].fd = ctl->sigfd;
 	pfd[2].events = POLLIN | POLLERR | POLLHUP;
 
-	if (!ctl->qflg) {
-		time_t tvec = time((time_t *)NULL);
-		my_strftime(buf, sizeof buf, "%c\n", localtime(&tvec));
-		fprintf(ctl->typescriptfp, _("Script started on %s"), buf);
-	}
+	my_strftime(buf, sizeof buf, "%c\n", localtime(&tvec));
+	fprintf(ctl->typescriptfp, _("Script started on %s"), buf);
 
 	while (!ctl->die) {
 		/* wait for input or signal */
-- 
2.2.1

