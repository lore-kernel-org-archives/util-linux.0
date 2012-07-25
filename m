Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f42.google.com ([74.125.82.42]:57227 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab2GYTP4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:15:56 -0400
Received: by wgbfm10 with SMTP id fm10so4793723wgb.1
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:15:55 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/19] whereis: fix shadow declaration
Date: Wed, 25 Jul 2012 21:15:27 +0200
Message-Id: <1343243745-1172-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

misc-utils/whereis.c:191:7: warning: declaration of 'dirp' shadows a global declaration [-Wshadow]
misc-utils/whereis.c:134:42: warning: shadowed declaration is here [-Wshadow]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/whereis.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index 6807b8a..6faf262 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -188,7 +188,7 @@ itsit(char *cp, char *dp)
 static void
 findin(char *dir, char *cp)
 {
-	DIR *dirp;
+	DIR *derp;
 	struct dirent *dp;
 	char *d, *dd;
 	size_t l;
@@ -197,17 +197,17 @@ findin(char *dir, char *cp)
 
 	dd = strchr(dir, '*');
 	if (!dd) {
-		dirp = opendir(dir);
-		if (dirp == NULL)
+		derp = opendir(dir);
+		if (derp == NULL)
 			return;
-		while ((dp = readdir(dirp)) != NULL) {
+		while ((dp = readdir(derp)) != NULL) {
 			if (itsit(cp, dp->d_name)) {
 				count++;
 				if (print)
 					printf(" %s/%s", dir, dp->d_name);
 			}
 		}
-		closedir(dirp);
+		closedir(derp);
 		return;
 	}
 
@@ -217,10 +217,10 @@ findin(char *dir, char *cp)
 		strcpy(dirbuf, dir);
 		d = strchr(dirbuf, '*');
 		*d = 0;
-		dirp = opendir(dirbuf);
-		if (dirp == NULL)
+		derp = opendir(dirbuf);
+		if (derp == NULL)
 			return;
-		while ((dp = readdir(dirp)) != NULL) {
+		while ((dp = readdir(derp)) != NULL) {
 			if (!strcmp(dp->d_name, ".") ||
 			    !strcmp(dp->d_name, ".."))
 				continue;
@@ -234,7 +234,7 @@ findin(char *dir, char *cp)
 			strcat(d, dd + 1);
 			findin(dirbuf, cp);
 		}
-		closedir(dirp);
+		closedir(derp);
 	}
 	return;
 
-- 
1.7.11.3

