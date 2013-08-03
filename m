Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f180.google.com ([74.125.82.180]:53298 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307Ab3HCXPa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 Aug 2013 19:15:30 -0400
Received: by mail-we0-f180.google.com with SMTP id p61so1511947wes.11
        for <util-linux@vger.kernel.org>; Sat, 03 Aug 2013 16:15:29 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/3] more: make output redirection more efficient
Date: Sun,  4 Aug 2013 00:15:20 +0100
Message-Id: <1375571721-30008-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1375571721-30008-1-git-send-email-kerolasa@iki.fi>
References: <1375571721-30008-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Especially with large inputs the change improves performance
considerably.

old> time more /boot/vmlinuz >/dev/null
real    0m0.224s

new> more /boot/vmlinuz >/dev/null
real    0m0.009s

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index ac35acc..598e048 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -780,10 +780,11 @@ void __attribute__((__noreturn__)) end_it(int dummy __attribute__((__unused__)))
 
 void copy_file(register FILE *f)
 {
-	register int c;
+	char buf[BUFSIZ];
+	size_t sz;
 
-	while ((c = getc(f)) != EOF)
-		putchar(c);
+	while ((sz = fread(&buf, sizeof(char), sizeof(buf), f)) > 0)
+		fwrite(&buf, sizeof(char), sz, stdout);
 }
 
 #define ringbell()	putcerr('\007')
-- 
1.8.3.4

