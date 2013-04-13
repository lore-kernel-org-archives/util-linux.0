Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f179.google.com ([74.125.82.179]:60167 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab3DMT4k (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:56:40 -0400
Received: by mail-we0-f179.google.com with SMTP id p43so2818562wea.24
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:56:39 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 33/33] wall: check writing to a file descriptor was successful
Date: Sat, 13 Apr 2013 20:55:01 +0100
Message-Id: <1365882901-11429-34-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/ttymsg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/term-utils/ttymsg.c b/term-utils/ttymsg.c
index 66b61b4..d610826 100644
--- a/term-utils/ttymsg.c
+++ b/term-utils/ttymsg.c
@@ -169,7 +169,8 @@ ttymsg(struct iovec *iov, size_t iovcnt, char *line, int tmout) {
 		 */
 		if (errno == ENODEV || errno == EIO)
 			break;
-		(void) close(fd);
+		if (close_fd(fd) != 0)
+			warn(_("write failed: %s"), device);
 		if (forked)
 			_exit(EXIT_FAILURE);
 		if (strlen(strerror(errno)) > 1000)
@@ -184,7 +185,6 @@ ttymsg(struct iovec *iov, size_t iovcnt, char *line, int tmout) {
 		return (errbuf);
 	}
 
-	(void) close(fd);
 	if (forked)
 		_exit(EXIT_SUCCESS);
 	return (NULL);
-- 
1.8.2.1

