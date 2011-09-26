Return-Path: dave@gnu.org
Subject: [PATCH 3/5] lomount: rewrite find_unused_loop_devices()
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <1317066156.3401.1.camel@offbook>
References: <1317066156.3401.1.camel@offbook>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 26 Sep 2011 16:50:05 -0300
Message-ID: <1317066605.2896.3.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Mon, 26 Sep 2011 14:57:58 -0300

Use lib/loopdev instead.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 mount/lomount.c |   38 ++++++++++++--------------------------
 1 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/mount/lomount.c b/mount/lomount.c
index 74a8749..781cdd1 100644
--- a/mount/lomount.c
+++ b/mount/lomount.c
@@ -18,6 +18,7 @@
 
 #include "loop.h"
 #include "lomount.h"
+#include "loopdev.h"
 #include "strutils.h"
 #include "nls.h"
 #include "sundries.h"
@@ -699,35 +700,20 @@ loopfile_used_with(char *devname, const char *filename, unsigned long long offse
 
 char *
 find_unused_loop_device (void) {
-	struct looplist ll;
-	char *devname = NULL;
-	int fd;
+	struct loopdev_cxt lc;
+	char *dev;
+	int rc;
 
-	if (looplist_open(&ll, LLFLG_FREEONLY) == -1) {
-		error(_("%s: /dev directory does not exist."), progname);
-		return NULL;
-	}
+	loopcxt_init(&lc, 0);
 
-	if ((fd = looplist_next(&ll)) != -1) {
-		close(fd);
-		devname = xstrdup(ll.name);
-	}
-	looplist_close(&ll);
-	if (devname)
-		return devname;
+	rc = loopcxt_find_unused(&lc);
+	if (rc)
+		err(EXIT_FAILURE, "loopdevs scanning failed");
+	
+	dev = xstrdup(loopcxt_get_device(&lc));
+	loopcxt_deinit(&lc);
 
-	if (!ll.ct_succ && ll.ct_perm)
-		error(_("%s: no permission to look at /dev/loop%s<N>"), progname,
-				(ll.flag & LLFLG_SUBDIR) ? "/" : "");
-	else if (ll.ct_succ)
-		error(_("%s: could not find any free loop device"), progname);
-	else
-		error(_(
-		    "%s: Could not find any loop device. Maybe this kernel "
-		    "does not know\n"
-		    "       about the loop device? (If so, recompile or "
-		    "`modprobe loop'.)"), progname);
-	return NULL;
+	return dev;
 }
 
 /*
-- 
1.7.4.1
