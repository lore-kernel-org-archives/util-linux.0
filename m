Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f44.google.com ([209.85.215.44]:37094 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288Ab3BQBho (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Feb 2013 20:37:44 -0500
Received: by mail-la0-f44.google.com with SMTP id eb20so4512431lab.3
        for <util-linux@vger.kernel.org>; Sat, 16 Feb 2013 17:37:43 -0800 (PST)
From: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>
To: util-linux@vger.kernel.org
Cc: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>
Subject: [PATCH] libblkid: Make use of isalnum()
Date: Sun, 17 Feb 2013 03:37:32 +0200
Message-Id: <1361065052-18695-1-git-send-email-zeeshanak@gnome.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>

---
 libblkid/src/encode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/libblkid/src/encode.c b/libblkid/src/encode.c
index ff57be4..e96e0e2 100644
--- a/libblkid/src/encode.c
+++ b/libblkid/src/encode.c
@@ -181,9 +181,7 @@ static int replace_whitespace(const char *str, char *to, size_t len)
 
 static int is_whitelisted(char c, const char *white)
 {
-	if ((c >= '0' && c <= '9') ||
-	    (c >= 'A' && c <= 'Z') ||
-	    (c >= 'a' && c <= 'z') ||
+	if (isalnum (c) ||
 	    strchr("#+-.:=@_", c) != NULL ||
 	    (white != NULL && strchr(white, c) != NULL))
 		return 1;
-- 
1.8.1.2

