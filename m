Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f171.google.com ([74.125.82.171]:35212 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbbBVOnR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:43:17 -0500
Received: by wevl61 with SMTP id l61so9458164wev.2
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:43:16 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 07/12] script: add 'Script started' line always to capture file
Date: Sun, 22 Feb 2015 14:42:44 +0000
Message-Id: <1424616169-693-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
References: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
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
index cd53b06..a7242e7 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -230,6 +230,7 @@ static void do_io(struct script_control *ctl)
 	int ret, i;
 	ssize_t bytes;
 	double oldtime = time(NULL);
+	time_t tvec = time((time_t *)NULL);
 
 	if (ctl->tflg && !ctl->timingfp)
 		ctl->timingfp = fdopen(STDERR_FILENO, "w");
@@ -241,11 +242,8 @@ static void do_io(struct script_control *ctl)
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
2.3.0

