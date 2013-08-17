Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:54545 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab3HQSQ4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Aug 2013 14:16:56 -0400
Received: by mail-we0-f174.google.com with SMTP id q54so2578383wes.5
        for <util-linux@vger.kernel.org>; Sat, 17 Aug 2013 11:16:56 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 14/16] last: global variables are initialize automatically to zero
Date: Sat, 17 Aug 2013 19:15:19 +0100
Message-Id: <1376763321-22782-15-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
References: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 24a752c..713719d 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -74,13 +74,13 @@ enum {
 };
 
 /* Global variables */
-static unsigned int maxrecs = 0; /* Maximum number of records to list. */
-static unsigned int recsdone = 0; /* Number of records listed */
+static unsigned int maxrecs;	/* Maximum number of records to list. */
+static unsigned int recsdone;	/* Number of records listed */
 static int showhost = 1;	/* Show hostname too? */
-static int altlist = 0;		/* Show hostname at the end. */
-static int usedns = 0;		/* Use DNS to lookup the hostname. */
-static int useip = 0;		/* Print IP address in number format */
-static int fulltime = 0;	/* Print full dates and times */
+static int altlist;		/* Show hostname at the end. */
+static int usedns;		/* Use DNS to lookup the hostname. */
+static int useip;		/* Print IP address in number format */
+static int fulltime;		/* Print full dates and times */
 static int name_len = 8;	/* Default print 8 characters of name */
 static int domain_len = 16;	/* Default print 16 characters of domain */
 static char **show = NULL;	/* What do they want us to show */
-- 
1.8.3.4

