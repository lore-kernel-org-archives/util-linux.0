Return-Path: dave@gnu.org
Subject: [PATCH 5/5] lomount: rewrite del_loop()
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <1317066156.3401.1.camel@offbook>
References: <1317066156.3401.1.camel@offbook>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 26 Sep 2011 16:50:10 -0300
Message-ID: <1317066610.2896.5.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Mon, 26 Sep 2011 16:33:51 -0300

Use lib/loopdev's for this.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 mount/lomount.c |   33 ++++++++++++++-------------------
 1 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/mount/lomount.c b/mount/lomount.c
index 9605bd1..55fb7ba 100644
--- a/mount/lomount.c
+++ b/mount/lomount.c
@@ -918,27 +918,22 @@ set_loop(const char *device, const char *file, unsigned long long offset,
 
 int
 del_loop (const char *device) {
-	int fd, errsv;
+	struct loopdev_cxt lc;
+	int rc;
 
-	if ((fd = open (device, O_RDONLY)) < 0) {
-		errsv = errno;
-		goto error;
-	}
-	if (ioctl (fd, LOOP_CLR_FD, 0) < 0) {
-		errsv = errno;
-		goto error;
-	}
-	close (fd);
-	if (verbose > 1)
-		printf(_("del_loop(%s): success\n"), device);
-	return 0;
+	loopcxt_init(&lc, 0);
+	rc = loopcxt_set_device(&lc, device);
+	if (rc)
+		err(EXIT_FAILURE, "failed to set device: %s", device);
 
-error:
-	fprintf(stderr, _("loop: can't delete device %s: %s\n"),
-		 device, strerror(errsv));
-	if (fd >= 0)
-		close(fd);
-	return 1;
+	rc = loopcxt_delete_device(&lc);
+	if (rc)
+		warnx(_("loop: can't delete device %s"), device);
+	if (verbose && !rc)
+		printf(_("del_loop(%s): success\n"), device);
+	
+	loopcxt_deinit(&lc);
+	return rc;
 }
 
 #else /* no LOOP_SET_FD defined */
-- 
1.7.4.1
