Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f49.google.com ([209.85.215.49]:59186 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbaHUSDP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 21 Aug 2014 14:03:15 -0400
Received: by mail-la0-f49.google.com with SMTP id hz20so8726783lab.8
        for <util-linux@vger.kernel.org>; Thu, 21 Aug 2014 11:03:12 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] mountpoint: symlinks are not mount points
Date: Thu, 21 Aug 2014 21:03:10 +0300
Message-Id: <1408644191-13523-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Another small change on top of Daves earlier mountpoint(1) correction. 
Now when mount points are not restricted to directories it is reasonable
not to follow symlinks.  Notice that this is not a regression from Daves
change but something the command has always done.

--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Thu, 21 Aug 2014 20:16:30 +0300
Subject: [PATCH] mountpoint: symlinks are not mount points

Earlier the mountpoint(1) followed symlinks, claiming they were mount
points when they only referred one.

$ ls -l /tmp/this-is-symlink
lrwxrwxrwx 1 kerolasa kerolasa 1 Aug 21 19:54 /tmp/this-is-symlink -> /
$ mountpoint /tmp/this-is-symlink
/tmp/this-is-symlink is a mountpoint

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/mountpoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/mountpoint.c b/sys-utils/mountpoint.c
index 3919ab7..11a611f 100644
--- a/sys-utils/mountpoint.c
+++ b/sys-utils/mountpoint.c
@@ -182,7 +182,7 @@ int main(int argc, char **argv)
 
 	spec = argv[optind++];
 
-	if (stat(spec, &st)) {
+	if (lstat(spec, &st)) {
 		if (!quiet)
 			err(EXIT_FAILURE, "%s", spec);
 		return EXIT_FAILURE;
@@ -192,7 +192,7 @@ int main(int argc, char **argv)
 	else {
 		dev_t src;
 
-		if ( dir_to_device(spec, &src)) {
+		if (dir_to_device(spec, &src) || S_ISLNK(st.st_mode)) {
 			if (!quiet)
 				printf(_("%s is not a mountpoint\n"), spec);
 			return EXIT_FAILURE;
-- 
2.1.0

