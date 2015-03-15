Return-Path: util-linux-owner@vger.kernel.org
Received: from thewalter.net ([94.75.203.101]:63474 "EHLO thewalter.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752136AbbCONam (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 15 Mar 2015 09:30:42 -0400
From: Stef Walter <stefw@redhat.com>
To: util-linux@vger.kernel.org
Cc: Stef Walter <stef@thewalter.net>
Subject: [PATCH] logger: Fix use of errno after strtol() without zeroing first
Date: Sun, 15 Mar 2015 14:23:32 +0100
Message-Id: <1426425812-24033-1-git-send-email-stefw@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Stef Walter <stef@thewalter.net>

https://bugzilla.redhat.com/show_bug.cgi?id=1202104
---
 misc-utils/logger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index ab734dd..9613b95 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -127,6 +127,7 @@ static int decode(const char *name, CODE *codetab)
 		int num;
 		char *end = NULL;
 
+		errno = 0;
 		num = strtol(name, &end, 10);
 		if (errno || name == end || (end && *end))
 			return -1;
-- 
2.1.0

