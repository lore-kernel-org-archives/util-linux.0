Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34708 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbdFHTwX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 8 Jun 2017 15:52:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id 70so8886754wme.1
        for <util-linux@vger.kernel.org>; Thu, 08 Jun 2017 12:52:22 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 02/11] line: do not print new line if nothing else was printed
Date: Thu,  8 Jun 2017 20:52:06 +0100
Message-Id: <20170608195215.1702-3-kerolasa@iki.fi>
In-Reply-To: <20170608195215.1702-1-kerolasa@iki.fi>
References: <20170608195215.1702-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier the following printed stray new line.

$ printf "" | ./line

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/line.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/text-utils/line.c b/text-utils/line.c
index 486e5dd31..ae10809c2 100644
--- a/text-utils/line.c
+++ b/text-utils/line.c
@@ -42,7 +42,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 int main(int argc, char **argv)
 {
 	wint_t c;
-	int opt;
+	int opt, print_nl = 0;
 	int status = EXIT_SUCCESS;
 
 	static const struct option longopts[] = {
@@ -77,8 +77,10 @@ int main(int argc, char **argv)
 		if (c == '\n')
 			break;
 		putwchar(c);
+		print_nl = 1;
 	}
-	putwchar(L'\n');
+	if (print_nl)
+		putwchar(L'\n');
 
 	return status;
 }
-- 
2.13.1

