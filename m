Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34071 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249AbcGCVYW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Jul 2016 17:24:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id 187so17569893wmz.1
        for <util-linux@vger.kernel.org>; Sun, 03 Jul 2016 14:24:21 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 13/15] write: tell when effective gid and tty path group mismatch
Date: Sun,  3 Jul 2016 22:23:56 +0100
Message-Id: <20160703212358.1218-14-kerolasa@iki.fi>
In-Reply-To: <20160703212358.1218-1-kerolasa@iki.fi>
References: <20160703212358.1218-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Most commonly this error happens when write(1) executable does not have
correct group ownership and setgid bit.  The earlier message was unclear
what exactly was wrong.

$ mesg
is y
$ write testuser
write: you have write permission turned off

Alternatively the 'getegid() == s.st_gid' could be considered unnecessary.
Afterall if to write to destination tty is denied that does not go unnoticed
at thet time when tty is opened.

Reviewed-by: Benno Schulenberg <bensberg@justemail.net>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index 4300489..7aae796 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -113,8 +113,13 @@ static int check_tty(char *tty, int *tty_writeable, time_t *tty_atime, int showe
 	}
 	if (getuid() == 0)	/* root can always write */
 		*tty_writeable = 1;
-	else
-		*tty_writeable = (s.st_mode & S_IWGRP) && (getegid() == s.st_gid);
+	else {
+		if (getegid() != s.st_gid) {
+			warnx(_("effective gid does not match group of %s"), path);
+			return 1;
+		}
+		*tty_writeable = s.st_mode & S_IWGRP;
+	}
 	if (tty_atime)
 		*tty_atime = s.st_atime;
 	return 0;
-- 
2.9.0

