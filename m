Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f182.google.com ([74.125.82.182]:59312 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310AbaDLK2w (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 12 Apr 2014 06:28:52 -0400
Received: by mail-we0-f182.google.com with SMTP id p61so6280915wes.41
        for <util-linux@vger.kernel.org>; Sat, 12 Apr 2014 03:28:51 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/7] kill: make options --pid and --queue mutually exclusive
Date: Sat, 12 Apr 2014 11:28:38 +0100
Message-Id: <1397298524-3364-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1397298524-3364-1-git-send-email-kerolasa@iki.fi>
References: <1397298524-3364-1-git-send-email-kerolasa@iki.fi>
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

