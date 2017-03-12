Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.133]:57784 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933935AbdCLQsr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 12 Mar 2017 12:48:47 -0400
Received: from localhost ([91.7.170.176]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPSA (Nemesis) id
 0Lxrpw-1c8Qi80Z5o-015K2b for <util-linux@vger.kernel.org>; Sun, 12 Mar 2017
 17:48:44 +0100
Date: Sun, 12 Mar 2017 17:48:44 +0100
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] libblkid: Fix blkid.conf parsing
Message-ID: <20170312164844.GA28165@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The SEND_UEVENT=yes|no line is not properly parsed, because the offset
jumps one byte too far behind the equal sign. Therefore, every
configuration that contains the line "SEND_UEVENT=yes" still does not
send an uevent.

The fix is simple: adjust the offset to be "12" instead of "13".
---
 libblkid/src/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libblkid/src/config.c b/libblkid/src/config.c
index 1822f1c67..52f159d87 100644
--- a/libblkid/src/config.c
+++ b/libblkid/src/config.c
@@ -88,7 +88,7 @@ static int parse_next(FILE *fd, struct blkid_config *conf)
 	} while (*s == '\0' || *s == '#');
 
 	if (!strncmp(s, "SEND_UEVENT=", 12)) {
-		s += 13;
+		s += 12;
 		if (*s && !strcasecmp(s, "yes"))
 			conf->uevent = TRUE;
 		else if (*s)
-- 
2.12.0

