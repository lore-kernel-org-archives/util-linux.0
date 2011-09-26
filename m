Return-Path: dave@gnu.org
Subject: [PATCH 4/5] mount: remove is_loop_device()
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <1317066156.3401.1.camel@offbook>
References: <1317066156.3401.1.camel@offbook>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 26 Sep 2011 16:50:08 -0300
Message-ID: <1317066608.2896.4.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Mon, 26 Sep 2011 14:59:07 -0300

We can use lib/loopdev.c's is_loopdev() instead; this affects umount as well as losetup.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 mount/lomount.c |   11 +----------
 mount/lomount.h |    1 -
 mount/umount.c  |    3 ++-
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/mount/lomount.c b/mount/lomount.c
index 781cdd1..9605bd1 100644
--- a/mount/lomount.c
+++ b/mount/lomount.c
@@ -137,15 +137,6 @@ char *loopdev_get_loopfile(const char *device)
 	return res;
 }
 
-int
-is_loop_device (const char *device) {
-	struct stat st;
-
-	return (stat(device, &st) == 0 &&
-		S_ISBLK(st.st_mode) &&
-		major(st.st_rdev) == LOOPMAJOR);
-}
-
 static int
 is_loop_used(int fd)
 {
@@ -683,7 +674,7 @@ loopfile_used_with(char *devname, const char *filename, unsigned long long offse
 	struct stat statbuf;
 	int fd, ret;
 
-	if (!is_loop_device(devname))
+	if (!is_loopdev(devname))
 		return 0;
 
 	if (stat(filename, &statbuf) == -1)
diff --git a/mount/lomount.h b/mount/lomount.h
index 4acc371..eae12d9 100644
--- a/mount/lomount.h
+++ b/mount/lomount.h
@@ -4,7 +4,6 @@
 extern int set_loop(const char *, const char *, unsigned long long, unsigned long long,
 		    const char *, int, int *);
 extern int del_loop(const char *);
-extern int is_loop_device(const char *);
 extern int is_loop_autoclear(const char *device);
 extern char * find_unused_loop_device(void);
 
diff --git a/mount/umount.c b/mount/umount.c
index 5000aa5..efd3a4e 100644
--- a/mount/umount.c
+++ b/mount/umount.c
@@ -22,6 +22,7 @@
 #include "env.h"
 #include "nls.h"
 #include "strutils.h"
+#include "loopdev.h"
 
 #if defined(MNT_FORCE)
 /* Interesting ... it seems libc knows about MNT_FORCE and presumably
@@ -301,7 +302,7 @@ umount_one (const char *spec, const char *node, const char *type,
 	 * Ignore the option "-d" for non-loop devices and loop devices with
 	 * LO_FLAGS_AUTOCLEAR flag.
 	 */
-	if (delloop && is_loop_device(spec))
+	if (delloop && is_loopdev(spec))
 		myloop = 1;
 
 	if (restricted) {
-- 
1.7.4.1
