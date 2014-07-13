Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:39817 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbaGMUZf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Jul 2014 16:25:35 -0400
Received: by mail-wi0-f174.google.com with SMTP id d1so1582553wiv.1
        for <util-linux@vger.kernel.org>; Sun, 13 Jul 2014 13:25:34 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/14] whereis: avoid printing uninitialized string
Date: Sun, 13 Jul 2014 21:24:50 +0100
Message-Id: <1405283093-28182-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
References: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The patbuf[] needs to be filled before print out.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/whereis.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index ba83b15..5339aba 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -408,13 +408,12 @@ static void lookup(const char *pattern, struct wh_dirlist *ls, int want)
 	int count = 0;
 	char *wait = NULL, *p;
 
-	DBG(printf("lookup dirs for '%s' (%s)", patbuf, pattern));
-
 	/* canonicalize pattern -- remove path suffix etc. */
 	p = strrchr(pattern, '/');
 	p = p ? p + 1 : (char *) pattern;
 	strncpy(patbuf, p, PATH_MAX);
 	patbuf[PATH_MAX - 1] = '\0';
+	DBG(printf("lookup dirs for '%s' (%s)", patbuf, pattern));
 	p = strrchr(patbuf, '.');
 	if (p)
 		*p = '\0';
-- 
2.0.1

