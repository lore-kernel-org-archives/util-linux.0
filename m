Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:47503 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbaEYK7u (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 25 May 2014 06:59:50 -0400
Received: by mail-wg0-f46.google.com with SMTP id n12so6603605wgh.17
        for <util-linux@vger.kernel.org>; Sun, 25 May 2014 03:59:49 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/4] uuidd: ensure pid file is wrote when it is requested
Date: Sun, 25 May 2014 11:59:37 +0100
Message-Id: <1401015580-27951-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier for example this 'uuidd --pid /dev/full' worked, now error is
printed about truncating not being possible for character device and
assuming someone would write pid to full disk it should not be go by
unnoticed.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/uuidd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index c626105..5730919 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -338,10 +338,12 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 
 		if (pidfile_path) {
 			sprintf(reply_buf, "%8d\n", getpid());
-			ignore_result( ftruncate(fd_pidfile, 0) );
+			if (ftruncate(fd_pidfile, 0))
+				err(EXIT_FAILURE, _("could not truncate file: %s"), pidfile_path);
 			write_all(fd_pidfile, reply_buf, strlen(reply_buf));
 			if (fd_pidfile > 1)
-				close(fd_pidfile); /* Unlock the pid file */
+				if (close_fd(fd_pidfile) != 0) /* Unlock the pid file */
+					err(EXIT_FAILURE, _("write failed: %s"), pidfile_path);
 		}
 
 	}
-- 
1.9.3

