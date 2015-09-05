Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37182 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbbIES4r (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 5 Sep 2015 14:56:47 -0400
Received: by wicfx3 with SMTP id fx3so46497750wic.0
        for <util-linux@vger.kernel.org>; Sat, 05 Sep 2015 11:56:45 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] uuidd: improve socket activation error messaging
Date: Sat,  5 Sep 2015 19:56:36 +0100
Message-Id: <1441479396-23140-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Tell more exactly what is wrong and how, and give hint how to recover
when possible.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/uuidd.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 1cbdeef..9d6d08d 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -360,9 +360,17 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 
 #ifdef HAVE_LIBSYSTEMD
 	if (uuidd_cxt->no_sock) {
-		if (sd_listen_fds(0) != 1)
-			errx(EXIT_FAILURE, _("no or too many file descriptors received"));
-
+		const int ret = sd_listen_fds(0);
+
+		if (ret < 0) {
+			errno = ret * -1;
+			err(EXIT_FAILURE, _("sd_listen_fds() failed"));
+		} else if (ret == 0)
+			errx(EXIT_FAILURE,
+			     _("no file descriptors received, check systemctl status uuidd.socket"));
+		else if (1 < ret)
+			errx(EXIT_FAILURE,
+			     _("too many file descriptors received, check uuidd.socket"));
 		s = SD_LISTEN_FDS_START + 0;
 	}
 #endif
-- 
2.5.1

