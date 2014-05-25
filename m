Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f169.google.com ([74.125.82.169]:38742 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbaEYK75 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 25 May 2014 06:59:57 -0400
Received: by mail-we0-f169.google.com with SMTP id u56so6860915wes.14
        for <util-linux@vger.kernel.org>; Sun, 25 May 2014 03:59:56 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/4] uuidd: do not mix signed type and unsigned code
Date: Sun, 25 May 2014 11:59:40 +0100
Message-Id: <1401015580-27951-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1401015580-27951-1-git-send-email-kerolasa@iki.fi>
References: <1401015580-27951-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Both the strtou32_or_err() and alarm() expect timeout to be unsigned.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/uuidd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 1f4a38b..f728e2e 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -59,7 +59,7 @@ extern int optind;
 
 /* server loop control structure */
 struct uuidd_cxt_t {
-	int	timeout;
+	uint32_t	timeout;
 	unsigned int	debug: 1,
 			quiet: 1,
 			no_fork: 1,
@@ -366,7 +366,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 
 	while (1) {
 		fromlen = sizeof(from_addr);
-		if (uuidd_cxt->timeout > 0)
+		if (uuidd_cxt->timeout != 0)
 			alarm(uuidd_cxt->timeout);
 		ns = accept(s, (struct sockaddr *) &from_addr, &fromlen);
 		alarm(0);
-- 
1.9.3

