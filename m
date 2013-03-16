Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:39555 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab3CPXki (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Mar 2013 19:40:38 -0400
Received: by mail-wi0-f172.google.com with SMTP id ez12so1587973wid.17
        for <util-linux@vger.kernel.org>; Sat, 16 Mar 2013 16:40:37 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 6/7] whereis: canonicalize files before printing
Date: Sat, 16 Mar 2013 23:40:18 +0000
Message-Id: <1363477219-29245-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1363477219-29245-1-git-send-email-kerolasa@iki.fi>
References: <1363477219-29245-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The whereis gives promise to find files so it seems to be more correct
print symlink destinations than locations of symlinks.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/Makemodule.am |  1 +
 misc-utils/whereis.c     | 20 +++++++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index b77c30a..a615047 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -44,6 +44,7 @@ namei_SOURCES = misc-utils/namei.c lib/strutils.c
 usrbin_exec_PROGRAMS += whereis
 dist_man_MANS += misc-utils/whereis.1
 whereis_SOURCES = misc-utils/whereis.c
+whereis_LDADD = $(LDADD) libcommon.la
 
 if BUILD_LSLOCKS
 usrbin_exec_PROGRAMS += lslocks
diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index 3fad843..5136eff 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -55,6 +55,7 @@
 #include "nls.h"
 #include "c.h"
 #include "closestream.h"
+#include "canonicalize.h"
 
 #define BIN_BIT (1 << 1)
 #define MAN_BIT (1 << 2)
@@ -204,21 +205,26 @@ static void findin(char *dir, char *cp, int *nr_found, char **wait)
 {
 	DIR *dirp;
 	struct dirent *dp;
+	char *full_path, *rl;
 
 	dirp = opendir(dir);
 	if (dirp == NULL)
 		return;
 	while ((dp = readdir(dirp)) != NULL)
 		if (itsit(cp, dp->d_name)) {
+			xasprintf(&full_path, "%s/%s", dir, dp->d_name);
+			rl = canonicalize_path(full_path);
+			free(full_path);
 			if (*(nr_found) == 0)
-				xasprintf(wait, "%s/%s", dir, dp->d_name);
-			else if (*(nr_found) == 1 && *wait != NULL)
-				printf("%s: %s %s/%s", cp, *wait, dir,
-				       dp->d_name);
-			else if (*(nr_found) == 1)
-				printf("%s: %s/%s", cp, dir, dp->d_name);
+				wait = &rl;
+			else if (*(nr_found) == 1 && *wait != NULL) {
+				printf("%s: %s %s", cp, *wait, rl);
+				free(*wait);
+			} else if (*(nr_found) == 1)
+				printf("%s: %s", cp, rl);
 			else
-				printf(" %s/%s", dir, dp->d_name);
+				printf(" %s", rl);
+			free(rl);
 			(*nr_found)++;
 		}
 	closedir(dirp);
-- 
1.8.2

