Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:40927 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab3IJTvV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 10 Sep 2013 15:51:21 -0400
Received: by mail-wg0-f45.google.com with SMTP id y10so7070383wgg.0
        for <util-linux@vger.kernel.org>; Tue, 10 Sep 2013 12:51:20 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/2] rev: fix new line regression
Date: Tue, 10 Sep 2013 20:51:14 +0100
Message-Id: <1378842674-456-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1378842674-456-1-git-send-email-kerolasa@iki.fi>
References: <1378842674-456-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Commit 4b4eb34004378fe70259acd8f2f859e7b5cc3726 made output incorrect for
input lines that does not have new line.  For example

$ printf "a b c\n1 2 3" | rev
c b a
 2 13

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/rev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/text-utils/rev.c b/text-utils/rev.c
index 85e1630..f1341cb 100644
--- a/text-utils/rev.c
+++ b/text-utils/rev.c
@@ -163,7 +163,9 @@ int main(int argc, char *argv[])
 
 				len = wcslen(buf);
 			}
-			reverse_str(buf, len - 1);
+			if (buf[len - 1] == '\n')
+				buf[len--] = '\0';
+			reverse_str(buf, len);
 			fputws(buf, stdout);
 		}
 		if (ferror(fp)) {
-- 
1.8.4

