Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:61235 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376Ab2JNUVk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:21:40 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2680285wey.19
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:21:40 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 17/19] agetty: replace gethostbyname() with getaddrinfo()
Date: Sun, 14 Oct 2012 21:21:08 +0100
Message-Id: <1350246070-10544-18-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The gethostbyname() is legacy function which may be withdrawn in a
future.

Reference: http://pubs.opengroup.org/onlinepubs/009695399/functions/gethostbyname.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/agetty.8 |  2 +-
 term-utils/agetty.c | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
index e400ec8..e51017d 100644
--- a/term-utils/agetty.8
+++ b/term-utils/agetty.8
@@ -215,7 +215,7 @@ no hostname at all will be shown.
 \-\-long\-hostname
 By default the hostname is only printed until the first dot.  With
 this option enabled, the full qualified hostname by gethostname()
-or if not found by gethostbyname() is shown.
+or if not found by getaddrinfo() is shown.
 .TP
 \-\-version
 Output version information and exit.
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 244ea29..ac7c16c 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -1298,17 +1298,29 @@ static void do_prompt(struct options *op, struct termios *tp)
 		if (!hn)
 			log_err(_("failed to allocate memory: %m"));
 		if (gethostname(hn, sysconf(_SC_HOST_NAME_MAX)) == 0) {
-			struct hostent *ht;
 			char *dot = strchr(hn, '.');
 
 			if ((op->flags & F_LONGHNAME) == 0) {
 				if (dot)
 					*dot = '\0';
 				write_all(STDOUT_FILENO, hn, strlen(hn));
-			} else if (dot == NULL && (ht = gethostbyname(hn)))
-				write_all(STDOUT_FILENO, ht->h_name, strlen(ht->h_name));
-			else
+			} else if (dot == NULL) {
+				struct addrinfo *res, hints;
+				memset(&hints, 0, sizeof(hints));
+				hints.ai_flags = AI_CANONNAME;
+				if (!getaddrinfo(hn, NULL, &hints, &res)) {
+					write_all(STDOUT_FILENO,
+						  res->ai_canonname,
+						  strlen(res->ai_canonname));
+					freeaddrinfo(res);
+				} else {
+					freeaddrinfo(res);
+					goto printhn;
+				}
+			} else {
+ printhn:
 				write_all(STDOUT_FILENO, hn, strlen(hn));
+			}
 			write_all(STDOUT_FILENO, " ", 1);
 		}
 		free(hn);
-- 
1.7.12.2

