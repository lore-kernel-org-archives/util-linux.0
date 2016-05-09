Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35255 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbcEIV1y (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 9 May 2016 17:27:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id e201so22545121wme.2
        for <util-linux@vger.kernel.org>; Mon, 09 May 2016 14:27:54 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 12/12] write: tell when effective gid and tty path group mismatch
Date: Mon,  9 May 2016 22:27:28 +0100
Message-Id: <1462829248-6935-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
References: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
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

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index e3e749e..58d3839 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -113,8 +113,13 @@ static int check_tty(char *tty, int *mesg_allowed, time_t *tty_atime, int shower
 	}
 	if (getuid() == 0)	/* root can always write */
 		*mesg_allowed = 1;
-	else
-		*mesg_allowed = (s.st_mode & S_IWGRP) && (getegid() == s.st_gid);
+	else {
+		if (getegid() != s.st_gid) {
+			warnx(_("effective gid and %s group does not match"), path);
+			return 1;
+		}
+		*mesg_allowed = s.st_mode & S_IWGRP;
+	}
 	if (tty_atime)
 		*tty_atime = s.st_atime;
 	return 0;
-- 
2.8.2

