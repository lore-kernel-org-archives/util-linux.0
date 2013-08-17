Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:49283 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab3HQSQk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Aug 2013 14:16:40 -0400
Received: by mail-wg0-f47.google.com with SMTP id j13so2417177wgh.14
        for <util-linux@vger.kernel.org>; Sat, 17 Aug 2013 11:16:39 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/16] last: prefer enum rather than #definition list
Date: Sat, 17 Aug 2013 19:15:15 +0100
Message-Id: <1376763321-22782-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
References: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Incremental number lists are more hard to get wrong with enum, and they
are nicer to debug as for example gdb is aware of these symbolic names.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 276d13a..d561e96 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -64,13 +64,15 @@ struct utmplist {
 struct utmplist *utmplist = NULL;
 
 /* Types of listing */
-#define R_CRASH		1 /* No logout record, system boot in between */
-#define R_DOWN		2 /* System brought down in decent way */
-#define R_NORMAL	3 /* Normal */
-#define R_NOW		4 /* Still logged in */
-#define R_REBOOT	5 /* Reboot record. */
-#define R_PHANTOM	6 /* No logout record but session is stale. */
-#define R_TIMECHANGE	7 /* NEW_TIME or OLD_TIME */
+enum {
+	R_CRASH = 1,	/* No logout record, system boot in between */
+	R_DOWN,		/* System brought down in decent way */
+	R_NORMAL,	/* Normal */
+	R_NOW,		/* Still logged in */
+	R_REBOOT,	/* Reboot record. */
+	R_PHANTOM,	/* No logout record but session is stale. */
+	R_TIMECHANGE	/* NEW_TIME or OLD_TIME */
+};
 
 /* Global variables */
 static unsigned int maxrecs = 0; /* Maximum number of records to list. */
-- 
1.8.3.4

