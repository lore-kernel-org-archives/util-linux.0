Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f169.google.com ([209.85.212.169]:60422 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701Ab3DMTzp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:55:45 -0400
Received: by mail-wi0-f169.google.com with SMTP id c10so525850wiw.0
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:55:44 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 13/33] pg: check writing to a file was successful
Date: Sat, 13 Apr 2013 20:54:41 +0100
Message-Id: <1365882901-11429-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/pg.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/text-utils/pg.c b/text-utils/pg.c
index c00b737..7ddf96b 100644
--- a/text-utils/pg.c
+++ b/text-utils/pg.c
@@ -1228,7 +1228,14 @@ static void pgfile(FILE *f, const char *name)
 					/* No error check for compat. */
 					fwrite_all(b, sizeof *b, sz, save);
 				}
-				fclose(save);
+				if (close_stream(save) != 0) {
+					cmd.count = errno;
+					mesg(_("write failed"));
+					mesg(": ");
+					mesg(p);
+					mesg(strerror(cmd.count));
+					goto newcmd;
+				}
 				fseeko(fbuf, (off_t)0, SEEK_END);
 				mesg(_("saved"));
 				goto newcmd;
-- 
1.8.2.1

