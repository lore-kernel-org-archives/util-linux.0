Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:60250 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757413Ab2EWUgD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 23 May 2012 16:36:03 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 3/3] logger: mark decode/pencode as static
Date: Wed, 23 May 2012 16:36:00 -0400
Message-Id: <1337805360-16469-3-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1337805360-16469-1-git-send-email-dreisner@archlinux.org>
References: <1337805360-16469-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Move these functions to the top of the file where they can be marked
static and the prototypes can be removed.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 misc-utils/logger.c |   84 +++++++++++++++++++++++----------------------------
 1 file changed, 37 insertions(+), 47 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index a187227..fda22d8 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -58,12 +58,46 @@
 #define	SYSLOG_NAMES
 #include <syslog.h>
 
-int	decode (char *, CODE *);
-int	pencode (char *);
-
 static int optd = 0;
 static uint16_t udpport = 514;
 
+static int decode(char *name, CODE *codetab)
+{
+	register CODE *c;
+
+	if (isdigit(*name))
+		return (atoi(name));
+
+	for (c = codetab; c->c_name; c++)
+		if (!strcasecmp(name, c->c_name))
+			return (c->c_val);
+
+	return -1;
+}
+
+static int pencode(char *s)
+{
+	char *save;
+	int fac, lev;
+
+	for (save = s; *s && *s != '.'; ++s);
+	if (*s) {
+		*s = '\0';
+		fac = decode(save, facilitynames);
+		if (fac < 0)
+			errx(EXIT_FAILURE, _("unknown facility name: %s."), save);
+		*s++ = '.';
+	}
+	else {
+		fac = LOG_USER;
+		s = save;
+	}
+	lev = decode(s, prioritynames);
+	if (lev < 0)
+		errx(EXIT_FAILURE, _("unknown priority name: %s."), save);
+	return ((lev & LOG_PRIMASK) | (fac & LOG_FACMASK));
+}
+
 static int
 myopenlog(const char *sock) {
        int fd;
@@ -302,47 +336,3 @@ main(int argc, char **argv) {
 
 	return EXIT_SUCCESS;
 }
-
-/*
- *  Decode a symbolic name to a numeric value
- */
-int
-pencode(char *s)
-{
-	char *save;
-	int fac, lev;
-
-	for (save = s; *s && *s != '.'; ++s);
-	if (*s) {
-		*s = '\0';
-		fac = decode(save, facilitynames);
-		if (fac < 0)
-			errx(EXIT_FAILURE,
-			    _("unknown facility name: %s."), save);
-		*s++ = '.';
-	}
-	else {
-		fac = LOG_USER;
-		s = save;
-	}
-	lev = decode(s, prioritynames);
-	if (lev < 0)
-		errx(EXIT_FAILURE,
-		    _("unknown priority name: %s."), save);
-	return ((lev & LOG_PRIMASK) | (fac & LOG_FACMASK));
-}
-
-int
-decode(char *name, CODE *codetab)
-{
-	register CODE *c;
-
-	if (isdigit(*name))
-		return (atoi(name));
-
-	for (c = codetab; c->c_name; c++)
-		if (!strcasecmp(name, c->c_name))
-			return (c->c_val);
-
-	return (-1);
-}
-- 
1.7.10.2

