Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:63425 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757573Ab3HMPJh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 13 Aug 2013 11:09:37 -0400
From: Bernhard Voelker <mail@bernhard-voelker.de>
To: util-linux@vger.kernel.org
Cc: Bernhard Voelker <mail@bernhard-voelker.de>
Subject: [PATCH] last: mention optional arguments in usage
Date: Tue, 13 Aug 2013 17:09:23 +0200
Message-Id: <1376406563-24198-1-git-send-email-mail@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

* login-utils/last.c (usage): Add '[name...]' to document the optional
username or terminal type argument.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 login-utils/last.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 0f475f2..913637e 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -418,7 +418,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(
-		" %s [options]\n"), program_invocation_short_name);
+		" %s [options] [name...]\n"), program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -<number>            how many lines to show\n"), out);
-- 
1.8.3.1

