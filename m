Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:32882 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934085AbaEKT07 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 May 2014 15:26:59 -0400
Received: by mail-wi0-f179.google.com with SMTP id bs8so3507508wib.0
        for <util-linux@vger.kernel.org>; Sun, 11 May 2014 12:26:58 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/12] blkid: remove unused variable
Date: Sun, 11 May 2014 20:26:40 +0100
Message-Id: <1399836409-7769-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
References: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/blkid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index b3eade5..0d0ea6a 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -366,7 +366,7 @@ static void print_tags(blkid_dev dev, char *show[], int output)
 
 static int append_str(char **res, size_t *sz, const char *a, const char *b)
 {
-	char *str = *res;
+	char *str;
 	size_t asz = a ? strlen(a) : 0;
 	size_t bsz = b ? strlen(b) : 0;
 	size_t len = *sz + asz + bsz;
@@ -374,7 +374,7 @@ static int append_str(char **res, size_t *sz, const char *a, const char *b)
 	if (!len)
 		return -1;
 
-	*res = str = xrealloc(str, len + 1);
+	str = xrealloc(str, len + 1);
 	str += *sz;
 
 	if (a) {
-- 
1.9.2

