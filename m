Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f170.google.com ([74.125.82.170]:46920 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbaDOLPn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 15 Apr 2014 07:15:43 -0400
Received: by mail-we0-f170.google.com with SMTP id w61so9445198wes.1
        for <util-linux@vger.kernel.org>; Tue, 15 Apr 2014 04:15:42 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/9] kill: make options --pid and --queue mutually exclusive
Date: Tue, 15 Apr 2014 12:15:27 +0100
Message-Id: <1397560535-14622-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
References: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/kill.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index d461b36..e678661 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -381,6 +381,10 @@ static char **parse_arguments(int argc, char **argv, struct kill_control *ctl)
 			ctl->do_pid = 1;
 			if (ctl->do_kill)
 				errx(EXIT_FAILURE, _("%s and %s are mutually exclusive"), "--pid", "--signal");
+#ifdef HAVE_SIGQUEUE
+			if (ctl->use_sigval)
+				errx(EXIT_FAILURE, _("%s and %s are mutually exclusive"), "--pid", "--queue");
+#endif
 			continue;
 		}
 		if (!strcmp(arg, "-s") || !strcmp(arg, "--signal")) {
@@ -399,6 +403,8 @@ static char **parse_arguments(int argc, char **argv, struct kill_control *ctl)
 		if (!strcmp(arg, "-q") || !strcmp(arg, "--queue")) {
 			if (argc < 2)
 				errx(EXIT_FAILURE, _("option '%s' requires an argument"), arg);
+			if (ctl->do_pid)
+				errx(EXIT_FAILURE, _("%s and %s are mutually exclusive"), "--pid", "--queue");
 			argc--, argv++;
 			arg = *argv;
 			if ((ctl->numsig = arg_to_signum(arg, 0)) < 0)
-- 
1.9.2

