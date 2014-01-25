Return-Path: util-linux-owner@vger.kernel.org
Received: from alerce.vps.bitfolk.com ([85.119.82.134]:45067 "EHLO
	alerce.vps.bitfolk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbaAYTUr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 25 Jan 2014 14:20:47 -0500
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
To: util-linux@vger.kernel.org
Cc: Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH 2/3] fallocate: Hide #ifdef tricks to call fallocate in a function
Date: Sat, 25 Jan 2014 19:17:27 +0000
Message-Id: <1390677448-7173-3-git-send-email-rodrigo@sdfg.com.ar>
In-Reply-To: <1390677448-7173-1-git-send-email-rodrigo@sdfg.com.ar>
References: <1390677448-7173-1-git-send-email-rodrigo@sdfg.com.ar>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Future patches will add more calls to fallocate(), so it will be useful to have
all these tricks inside a function.

The error message when fallocate is not supported is slightly changed: the file
name is not printed as a prefix because is not available in the context of the
function. Also, to only print one of the two possible errors (as happens when
using directly exit()), an else clause was added.

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
---
 sys-utils/fallocate.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index 55e8411..5c66553 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -82,6 +82,30 @@ static loff_t cvtnum(char *s)
 	return x;
 }
 
+static int xfallocate(int fd, int mode, off_t offset, off_t length)
+{
+	int error;
+
+#ifdef HAVE_FALLOCATE
+	error = fallocate(fd, mode, offset, length);
+#else
+	error = syscall(SYS_fallocate, fd, mode, offset, length);
+#endif
+	/*
+	 * EOPNOTSUPP: The FALLOC_FL_KEEP_SIZE is unsupported
+	 * ENOSYS: The filesystem does not support sys_fallocate
+	 */
+	if (error < 0) {
+		if ((mode & FALLOC_FL_KEEP_SIZE) && errno == EOPNOTSUPP) {
+			fputs(_("keep size mode (-n option) unsupported\n"),
+			      stderr);
+		} else {
+			fputs(_("fallocate failed\n"), stderr);
+		}
+	}
+	return error;
+}
+
 int main(int argc, char **argv)
 {
 	char	*fname;
@@ -153,21 +177,10 @@ int main(int argc, char **argv)
 	if (fd < 0)
 		err(EXIT_FAILURE, _("cannot open %s"), fname);
 
-#ifdef HAVE_FALLOCATE
-	error = fallocate(fd, mode, offset, length);
-#else
-	error = syscall(SYS_fallocate, fd, mode, offset, length);
-#endif
-	/*
-	 * EOPNOTSUPP: The FALLOC_FL_KEEP_SIZE is unsupported
-	 * ENOSYS: The filesystem does not support sys_fallocate
-	 */
-	if (error < 0) {
-		if ((mode & FALLOC_FL_KEEP_SIZE) && errno == EOPNOTSUPP)
-			errx(EXIT_FAILURE,
-				_("keep size mode (-n option) unsupported"));
-		err(EXIT_FAILURE, _("%s: fallocate failed"), fname);
-	}
+	error = xfallocate(fd, mode, offset, length);
+
+	if (error < 0)
+		exit(EXIT_FAILURE);
 
 	if (close_fd(fd) != 0)
 		err(EXIT_FAILURE, _("write failed: %s"), fname);
-- 
1.8.5.2

