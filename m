Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33252 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311AbbGSUTQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 19 Jul 2015 16:19:16 -0400
Received: by wicmv11 with SMTP id mv11so1147642wic.0
        for <util-linux@vger.kernel.org>; Sun, 19 Jul 2015 13:19:15 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] logger: do not exit when socket errors are not enforced
Date: Sun, 19 Jul 2015 21:19:12 +0100
Message-Id: <1437337152-947-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The libc openlog(3) does not have error detection whether unix socket
could be opened.  As a side effect that made it possible to use logger
even if syslogd was not running.  Of course user message in these cases
were lost.  This change makes the logger do behave similar way again, so
that sysvinit scripts can successfully pipe messages to logger when ever.

Addresses: https://bugs.debian.org/787864
Addresses: https://bugs.debian.org/790875
Reported-by: Andreas Beckmann <anbe@debian.org>
Reported-by: Andreas Henriksson <andreas@fatal.se>
Tested-by: Robie Basak <robie.basak@ubuntu.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 8908dfc..9947b75 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -242,9 +242,10 @@ static int unix_socket(struct logger_ctl *ctl, const char *path, const int socke
 		if (ctl->unix_socket_errors)
 			err(EXIT_FAILURE, _("socket %s"), path);
 		else
-			/* See --socket-errors manual page entry for
-			 * explanation of this strange exit.  */
-			exit(EXIT_SUCCESS);
+			/* openlog(3) compatibility, socket errors are
+			 * not reported, but ignored silently */
+			ctl->noact = 1;
+			return -1;
 	}
 	return fd;
 }
@@ -685,7 +686,7 @@ static void logger_stdin(struct logger_ctl *ctl)
 
 static void logger_close(const struct logger_ctl *ctl)
 {
-	if (close(ctl->fd) != 0)
+	if (ctl->fd != -1 && close(ctl->fd) != 0)
 		err(EXIT_FAILURE, _("close failed"));
 	free(ctl->hdr);
 }
-- 
2.4.6

