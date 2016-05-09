Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34494 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbcEIV1h (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 9 May 2016 17:27:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id n129so22482201wmn.1
        for <util-linux@vger.kernel.org>; Mon, 09 May 2016 14:27:36 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 01/12] write: remove unused variable
Date: Mon,  9 May 2016 22:27:17 +0100
Message-Id: <1462829248-6935-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
References: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index 14594f5..42f279b 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -73,8 +73,6 @@ static void __attribute__ ((__noreturn__)) done(int);
 int term_chk(char *, int *, time_t *, int);
 int utmp_chk(char *, char *);
 
-static gid_t root_access;
-
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
@@ -122,8 +120,6 @@ int main(int argc, char **argv)
 			usage(stderr);
 		}
 
-	root_access = !getegid();
-
 	/* check that sender has write enabled */
 	if (isatty(fileno(stdin)))
 		myttyfd = fileno(stdin);
-- 
2.8.2

