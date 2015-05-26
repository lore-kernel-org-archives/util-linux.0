Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:52784 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753928AbbEZP7a (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 26 May 2015 11:59:30 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 52930AD21
	for <util-linux@vger.kernel.org>; Tue, 26 May 2015 15:59:29 +0000 (UTC)
Message-ID: <55649861.7030501@suse.cz>
Date: Tue, 26 May 2015 17:59:29 +0200
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH] Use predictable /dev/mapper partition names for /dev/dm-N
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It is impossible to predict /dev/dm-N partition names. Use predictable
and better readable /dev/mapper names instead.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 libfdisk/src/utils.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/libfdisk/src/utils.c b/libfdisk/src/utils.c
index 4789dbd..569ee50 100644
--- a/libfdisk/src/utils.c
+++ b/libfdisk/src/utils.c
@@ -1,6 +1,7 @@
 
 #include "fdiskP.h"
 #include "pathnames.h"
+#include "canonicalize.h"
 
 #include <ctype.h>
 
@@ -115,6 +116,7 @@ char *fdisk_partname(const char *dev, size_t partno)
 {
 	char *res = NULL;
 	const char *p = "";
+	char *dev_mapped = NULL;
 	int w = 0;
 
 	if (!dev || !*dev) {
@@ -123,6 +125,13 @@ char *fdisk_partname(const char *dev, size_t partno)
 		return NULL;
 	}
 
+	/* It is impossible to predict /dev/dm-N partition names. */
+	if (strncmp(dev, "/dev/dm-", sizeof("/dev/dm-") - 1) == 0) {
+		dev_mapped = canonicalize_dm_name (dev + 5);
+		if (dev_mapped)
+			dev = dev_mapped;
+	}
+
 	w = strlen(dev);
 	if (isdigit(dev[w - 1]))
 #ifdef __GNU__
@@ -147,10 +156,13 @@ char *fdisk_partname(const char *dev, size_t partno)
 	       p = "-part";
 	}
 
-	if (asprintf(&res, "%.*s%s%zu", w, dev, p, partno) > 0)
-		return res;
+	if (asprintf(&res, "%.*s%s%zu", w, dev, p, partno) <= 0)
+		res = NULL;
+
+	if (dev_mapped)
+		free(dev_mapped);
 
-	return NULL;
+	return res;
 }
 
 #ifdef TEST_PROGRAM
-- 
2.4.1
-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
