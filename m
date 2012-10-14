Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41556 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342Ab2JNUVd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:21:33 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so3908218wgb.1
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:21:33 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/19] agetty: replace usleep with nanosleep
Date: Sun, 14 Oct 2012 21:21:03 +0100
Message-Id: <1350246070-10544-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

POSIX.1-2001 declares usleep is obsolete.

Reference: http://pubs.opengroup.org/onlinepubs/009695399/functions/usleep.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/agetty.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 754a43f..244ea29 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -1383,7 +1383,10 @@ static char *get_logname(struct options *op, struct termios *tp, struct chardata
 
 				/* Do not report trivial like EINTR/EIO errors. */
 				if (errno == EINTR || errno == EAGAIN) {
-					usleep(1000);
+					struct timespec waittime;
+					waittime.tv_sec = 0;
+					waittime.tv_nsec = 1000000;
+					nanosleep(&waittime, NULL);
 					continue;
 				}
 				switch (errno) {
-- 
1.7.12.2

