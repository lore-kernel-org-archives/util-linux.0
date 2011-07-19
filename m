Return-Path: dave@gnu.org
Subject: [PATCH] swapon: use xalloc lib
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Jul 2011 19:17:55 -0400
Message-ID: <1311117475.3215.5.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Mon, 18 Jul 2011 00:33:20 -0400

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 mount/swapon.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/mount/swapon.c b/mount/swapon.c
index 49771f5..6dfe4b1 100644
--- a/mount/swapon.c
+++ b/mount/swapon.c
@@ -24,6 +24,7 @@
 #include "swapheader.h"
 #include "mangle.h"
 #include "canonicalize.h"
+#include "xalloc.h"
 #include "c.h"
 
 #define PATH_MKSWAP	"/sbin/mkswap"
@@ -341,10 +342,8 @@ swap_get_header(int fd, int *sig, unsigned int *pagesize)
 	*pagesize = 0;
 	*sig = 0;
 
-	buf = malloc(MAX_PAGESIZE);
-	if (!buf)
-		return NULL;
-
+	buf = xmalloc(MAX_PAGESIZE);
+	
 	datasz = read(fd, buf, MAX_PAGESIZE);
 	if (datasz == (ssize_t) -1)
 		goto err;
@@ -658,16 +657,12 @@ static const char **ulist = NULL;
 static int ulct = 0;
 
 static void addl(const char *label) {
-	llist = (const char **) realloc(llist, (++llct) * sizeof(char *));
-	if (!llist)
-		exit(EXIT_FAILURE);
+	llist = (const char **) xrealloc(llist, (++llct) * sizeof(char *));
 	llist[llct-1] = label;
 }
 
 static void addu(const char *uuid) {
-	ulist = (const char **) realloc(ulist, (++ulct) * sizeof(char *));
-	if (!ulist)
-		exit(EXIT_FAILURE);
+	ulist = (const char **) xrealloc(ulist, (++ulct) * sizeof(char *));
 	ulist[ulct-1] = uuid;
 }
 
-- 
1.7.4.1
