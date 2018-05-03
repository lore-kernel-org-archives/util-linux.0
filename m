Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34305 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbeECV6D (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 3 May 2018 17:58:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id a137-v6so4608682wme.1
        for <util-linux@vger.kernel.org>; Thu, 03 May 2018 14:58:02 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/3] lib/canonicalize: fix truncation warning
Date: Thu,  3 May 2018 22:57:57 +0100
Message-Id: <20180503215759.3720-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

lib/canonicalize.c: In function ‘canonicalize_dm_name’:
lib/canonicalize.c:42:45: warning: ‘%s’ directive output may be truncated
writing up to 255 bytes into a region of size 244 [-Wformat-truncation=]
   snprintf(path, sizeof(path), "/dev/mapper/%s", name);

Notice that this warnign fix does not improve code enormously.  The earlier
snprintf() truncation will not happen a bit earlier when fgets() is called.
In that sense this change merely makes one easy to silence warning to
disappear, and therefore improve change of noticing useful messaging as such
crops up.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/canonicalize.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/canonicalize.c b/lib/canonicalize.c
index b600248c7..6cfcf4bca 100644
--- a/lib/canonicalize.c
+++ b/lib/canonicalize.c
@@ -16,6 +16,7 @@
 #include <sys/stat.h>
 
 #include "canonicalize.h"
+#define mapper "/dev/mapper/"
 
 /*
  * Converts private "dm-N" names to "/dev/mapper/<name>"
@@ -27,7 +28,7 @@ char *canonicalize_dm_name(const char *ptname)
 {
 	FILE	*f;
 	size_t	sz;
-	char	path[256], name[256], *res = NULL;
+	char	path[256], name[sizeof(path) - sizeof(mapper)], *res = NULL;
 
 	if (!ptname || !*ptname)
 		return NULL;
@@ -39,7 +40,7 @@ char *canonicalize_dm_name(const char *ptname)
 	/* read "<name>\n" from sysfs */
 	if (fgets(name, sizeof(name), f) && (sz = strlen(name)) > 1) {
 		name[sz - 1] = '\0';
-		snprintf(path, sizeof(path), "/dev/mapper/%s", name);
+		snprintf(path, sizeof(path), mapper "%s", name);
 
 		if (access(path, F_OK) == 0)
 			res = strdup(path);
-- 
2.17.0

