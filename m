Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63508 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697Ab1JIDbk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Oct 2011 23:31:40 -0400
Received: by vws1 with SMTP id 1so3945851vws.19
        for <util-linux@vger.kernel.org>; Sat, 08 Oct 2011 20:31:39 -0700 (PDT)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 1/2] mountpoint: return dev_t from dir_to_device
Date: Sat,  8 Oct 2011 23:31:50 -0400
Message-Id: <1318131111-30395-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The string returned from this function was never of much use other than
to stat the path when the user requested a major:minor pair beyond the
true/false exit. Save some processing and directly returning the dev_t
on success, and an impossible value on failure.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 sys-utils/mountpoint.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/sys-utils/mountpoint.c b/sys-utils/mountpoint.c
index f668368..065d96b 100644
--- a/sys-utils/mountpoint.c
+++ b/sys-utils/mountpoint.c
@@ -40,18 +40,18 @@
 
 static int quiet;
 
-static char *dir_to_device(const char *spec)
+static dev_t dir_to_device(const char *spec)
 {
 	struct libmnt_table *tb = mnt_new_table_from_file("/proc/self/mountinfo");
 	struct libmnt_fs *fs;
-	char *res = NULL;
+	dev_t res = (dev_t)-1;
 
 	if (!tb)
-		return NULL;
+		return (dev_t)-1;
 
 	fs = mnt_table_find_target(tb, spec, MNT_ITER_BACKWARD);
 	if (fs && mnt_fs_get_target(fs))
-		res = xstrdup(mnt_fs_get_source(fs));
+		res = mnt_fs_get_devno(fs);
 
 	mnt_free_table(tb);
 	return res;
@@ -146,7 +146,7 @@ int main(int argc, char **argv)
 	if (dev_devno)
 		rc = print_devno(spec, &st);
 	else {
-		char *src;
+		dev_t src;
 
 		if (!S_ISDIR(st.st_mode)) {
 			if (!quiet)
@@ -154,16 +154,15 @@ int main(int argc, char **argv)
 			return EXIT_FAILURE;
 		}
 		src = dir_to_device(spec);
-		if (!src) {
+		if (src == (dev_t)-1) {
 			if (!quiet)
 				printf(_("%s is not a mountpoint\n"), spec);
 			return EXIT_FAILURE;
 		}
 		if (fs_devno)
-			rc = print_devno(src, NULL);
+			printf("%u:%u\n", major(src), minor(src));
 		else if (!quiet)
 			printf(_("%s is a mountpoint\n"), spec);
-		free(src);
 	}
 
 	return rc ? EXIT_FAILURE : EXIT_SUCCESS;
-- 
1.7.7

