Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:51671 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbaG0TBh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Jul 2014 15:01:37 -0400
Received: by mail-wi0-f179.google.com with SMTP id f8so3343665wiw.12
        for <util-linux@vger.kernel.org>; Sun, 27 Jul 2014 12:01:36 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] wall: wrap message header when it exceeds 79 characters
Date: Sun, 27 Jul 2014 20:01:06 +0100
Message-Id: <1406487666-19466-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Header truncation started to happen more often after commit
d81c30553f4fb49173d38f69edff4b0b67a18b65 that made the header to be
longer.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/wall.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/term-utils/wall.c b/term-utils/wall.c
index 598e9f2..acada29 100644
--- a/term-utils/wall.c
+++ b/term-utils/wall.c
@@ -202,6 +202,8 @@ static char *makemsg(char *fname, char **mvec, int mvecsz,
 		char *whom, *where, *date;
 		struct passwd *pw;
 		time_t now;
+		ssize_t len;
+		int i;
 
 		if (!(whom = getlogin()) || !*whom)
 			whom = (pw = getpwuid(getuid())) ? pw->pw_name : "???";
@@ -232,7 +234,10 @@ static char *makemsg(char *fname, char **mvec, int mvecsz,
 		fprintf(fp, "\r%*s\r\n", TERM_WIDTH, " ");
 		sprintf(lbuf, _("Broadcast message from %s@%s (%s) (%s):"),
 			      whom, hostname, where, date);
-		fprintf(fp, "%-*.*s\007\007\r\n", TERM_WIDTH, TERM_WIDTH, lbuf);
+		len = strlen(lbuf);
+		for (i = 0; 0 < len; i++)
+			len -= fprintf(fp, "%-*.*s\007\007\r\n", TERM_WIDTH, TERM_WIDTH,
+				       lbuf + (i * TERM_WIDTH)) + 4;
 		free(hostname);
 		free(date);
 	}
-- 
2.0.3

