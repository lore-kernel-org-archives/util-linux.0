Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36740 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbbJCSbQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 Oct 2015 14:31:16 -0400
Received: by wicgb1 with SMTP id gb1so70625269wic.1
        for <util-linux@vger.kernel.org>; Sat, 03 Oct 2015 11:31:14 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 4/4] uuidd: fix shadow declaration
Date: Sat,  3 Oct 2015 19:31:07 +0100
Message-Id: <1443897067-6005-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1443897067-6005-1-git-send-email-kerolasa@iki.fi>
References: <1443897067-6005-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

misc-utils/uuidd.c:384:13: warning: declaration of 'ret' shadows a previous
			   local [-Wshadow]
misc-utils/uuidd.c:327:6: note: shadowed declaration is here

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/uuidd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index c897372..2359f98 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -381,15 +381,15 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 
 #ifdef HAVE_LIBSYSTEMD
 	if (uuidd_cxt->no_sock) {
-		const int ret = sd_listen_fds(0);
+		const int r = sd_listen_fds(0);
 
-		if (ret < 0) {
-			errno = ret * -1;
+		if (r < 0) {
+			errno = r * -1;
 			err(EXIT_FAILURE, _("sd_listen_fds() failed"));
-		} else if (ret == 0)
+		} else if (r == 0)
 			errx(EXIT_FAILURE,
 			     _("no file descriptors received, check systemctl status uuidd.socket"));
-		else if (1 < ret)
+		else if (1 < r)
 			errx(EXIT_FAILURE,
 			     _("too many file descriptors received, check uuidd.socket"));
 		s = SD_LISTEN_FDS_START + 0;
-- 
2.6.0

