Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f180.google.com ([74.125.82.180]:39707 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab3HQSQo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Aug 2013 14:16:44 -0400
Received: by mail-we0-f180.google.com with SMTP id p61so2660682wes.11
        for <util-linux@vger.kernel.org>; Sat, 17 Aug 2013 11:16:43 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/16] last: remove broken code
Date: Sat, 17 Aug 2013 19:15:16 +0100
Message-Id: <1376763321-22782-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
References: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Comment in the deletion tells everything necessary.

"This doesn't work on modern systems, where only a DNS lookup of the
result from hostname() will get you the domainname.  Remember that
domainname() is the NIS domainname, not DNS.  So basically this whole
piece of code is bullshit."

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index d561e96..63055a7 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -52,7 +52,6 @@
 # define SHUTDOWN_TIME 254
 #endif
 
-#define CHOP_DOMAIN	0	/* Define to chop off local domainname. */
 #define UCHUNKSIZE	16384	/* How much we read at once. */
 
 /* Double linked list of struct utmp's */
@@ -87,10 +86,6 @@ static int domain_len = 16;	/* Default print 16 characters of domain */
 static char **show = NULL;	/* What do they want us to show */
 static char *ufile;		/* Filename of this file */
 static time_t lastdate;		/* Last date we've seen */
-#if CHOP_DOMAIn
-static char hostname[256];	/* For gethostbyname() */
-static char *domainname;	/* Our domainname. */
-#endif
 
 /*
  *	Read one utmp entry, return in new format.
@@ -363,13 +358,6 @@ static int list(struct utmp *p, time_t t, int what)
 	}
 
 	if (showhost) {
-#if CHOP_DOMAIN
-		/*
-		 *	See if this is in our domain.
-		 */
-		if (!usedns && (s = strchr(p->ut_host, '.')) != NULL &&
-		     strcmp(s + 1, domainname) == 0) *s = 0;
-#endif
 		if (!altlist) {
 			len = snprintf(final, sizeof(final),
 				fulltime ?
@@ -600,30 +588,6 @@ int main(int argc, char **argv)
 	 */
 	lastdate = lastdown;
 
-#if CHOP_DOMAIN
-	/*
-	 * Find out domainname.
-	 *
-	 * This doesn't work on modern systems, where only a DNS
-	 * lookup of the result from hostname() will get you the domainname.
-	 * Remember that domainname() is the NIS domainname, not DNS.
-	 * So basically this whole piece of code is bullshit.
-	 */
-	hostname[0] = 0;
-	gethostname(hostname, sizeof(hostname));
-
-	if ((domainname = strchr(hostname, '.')) != NULL)
-		domainname++;
-	if (domainname == NULL || domainname[0] == 0) {
-		hostname[0] = 0;
-		getdomainname(hostname, sizeof(hostname));
-		hostname[sizeof(hostname) - 1] = 0;
-		domainname = hostname;
-
-		if (strcmp(domainname, "(none)") == 0 || domainname[0] == 0)
-			domainname = NULL;
-	}
-#endif
 	/*
 	 * Install signal handlers
 	 */
-- 
1.8.3.4

