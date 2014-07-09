Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:37227 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755337AbaGIMe7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Jul 2014 08:34:59 -0400
Received: from ipb5.telenor.se (ipb5.telenor.se [195.54.127.168])
	by smtprelay-b21.telenor.se (Postfix) with ESMTP id 29ACDC594
	for <util-linux@vger.kernel.org>; Wed,  9 Jul 2014 14:09:51 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] whereis: fix missing newline on empty results
Date: Wed,  9 Jul 2014 14:09:34 +0200
Message-Id: <1404907774-12731-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Running "whereis foo.bar.quux" previously resulted in
printing the "foo.bar:" pattern prefix without any
newline following it.

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 misc-utils/whereis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index ba83b15..dc7406b 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -430,7 +430,7 @@ static void lookup(const char *pattern, struct wh_dirlist *ls, int want)
 
 	free(wait);
 
-	if ((count && !uflag) || (uflag && count > 1))
+	if (!uflag || (uflag && count > 1))
 		putchar('\n');
 	return;
 }
-- 
2.0.0

