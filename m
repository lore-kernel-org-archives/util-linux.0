Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:41409 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756020AbaDLK2y (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 12 Apr 2014 06:28:54 -0400
Received: by mail-wi0-f171.google.com with SMTP id q5so2125757wiv.16
        for <util-linux@vger.kernel.org>; Sat, 12 Apr 2014 03:28:53 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/7] kill: remove unnecessary indirection
Date: Sat, 12 Apr 2014 11:28:39 +0100
Message-Id: <1397298524-3364-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1397298524-3364-1-git-send-email-kerolasa@iki.fi>
References: <1397298524-3364-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/kill.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index e678661..9566f14 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -434,8 +434,6 @@ static char **parse_arguments(int argc, char **argv, struct kill_control *ctl)
 	}
 	if (!*argv)
 		errx(EXIT_FAILURE, _("not enough arguments"));
-	if (ctl->do_pid)
-		ctl->numsig = -1;
 	return argv;
 }
 
@@ -444,7 +442,7 @@ static int kill_verbose(const struct kill_control *ctl)
 {
 	int rc = 0;
 
-	if (ctl->numsig < 0) {
+	if (ctl->do_pid) {
 		printf("%ld\n", (long) ctl->pid);
 		return 0;
 	}
-- 
1.9.2

