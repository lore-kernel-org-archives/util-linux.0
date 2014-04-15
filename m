Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:61139 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbaDOLPq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 15 Apr 2014 07:15:46 -0400
Received: by mail-we0-f174.google.com with SMTP id t60so9146430wes.5
        for <util-linux@vger.kernel.org>; Tue, 15 Apr 2014 04:15:45 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/9] kill: remove unnecessary indirection
Date: Tue, 15 Apr 2014 12:15:28 +0100
Message-Id: <1397560535-14622-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
References: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
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

