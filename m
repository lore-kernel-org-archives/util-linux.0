Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:63634 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbaGZPJW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 26 Jul 2014 11:09:22 -0400
Received: by mail-we0-f173.google.com with SMTP id q58so5571537wes.32
        for <util-linux@vger.kernel.org>; Sat, 26 Jul 2014 08:09:20 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] logger: improve readablity of pencode() function
Date: Sat, 26 Jul 2014 16:09:12 +0100
Message-Id: <1406387352-32044-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1406387352-32044-1-git-send-email-kerolasa@iki.fi>
References: <1406387352-32044-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 7239cc5..afd9371 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -144,24 +144,22 @@ static int decode(char *name, CODE *codetab)
 
 static int pencode(char *s)
 {
-	char *save;
-	int fac, lev;
-
-	for (save = s; *s && *s != '.'; ++s);
-	if (*s) {
-		*s = '\0';
-		fac = decode(save, facilitynames);
-		if (fac < 0)
-			errx(EXIT_FAILURE, _("unknown facility name: %s"), save);
-		*s++ = '.';
-	} else {
-		fac = LOG_USER;
-		s = save;
-	}
-	lev = decode(s, prioritynames);
-	if (lev < 0)
-		errx(EXIT_FAILURE, _("unknown priority name: %s"), save);
-	return ((lev & LOG_PRIMASK) | (fac & LOG_FACMASK));
+	int facility, level;
+	char *separator;
+
+	separator = strchr(s, '.');
+	if (separator) {
+		*separator = '\0';
+		facility = decode(s, facilitynames);
+		if (facility < 0)
+			errx(EXIT_FAILURE, _("unknown facility name: %s"), s);
+		s = ++separator;
+	} else
+		facility = LOG_USER;
+	level = decode(s, prioritynames);
+	if (level < 0)
+		errx(EXIT_FAILURE, _("unknown priority name: %s"), s);
+	return ((level & LOG_PRIMASK) | (facility & LOG_FACMASK));
 }
 
 static int unix_socket(const char *path, const int socket_type)
-- 
2.0.3

