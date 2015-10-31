Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37820 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbbJaTVr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 31 Oct 2015 15:21:47 -0400
Received: by wmff134 with SMTP id f134so33208505wmf.0
        for <util-linux@vger.kernel.org>; Sat, 31 Oct 2015 12:21:46 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 12/12] fdformat: fix block device open race
Date: Sat, 31 Oct 2015 19:21:24 +0000
Message-Id: <1446319284-24778-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
References: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This fix makes fdformat also to detect if block device is busy, and warn if
the device is misaligned.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fdformat.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/disk-utils/fdformat.c b/disk-utils/fdformat.c
index e7d43da..086ad55 100644
--- a/disk-utils/fdformat.c
+++ b/disk-utils/fdformat.c
@@ -216,17 +216,14 @@ int main(int argc, char **argv)
 
 	if (argc < 1)
 		usage(stderr);
-	if (stat(argv[0], &st) < 0)
+	ctrl = open_blkdev_or_file(argv[0], O_RDWR);
+	if (ctrl < 0)
+		err(EXIT_FAILURE, _("cannot open %s"), argv[0]);
+	if (fstat(ctrl, &st) < 0)
 		err(EXIT_FAILURE, _("stat of %s failed"), argv[0]);
 	if (!S_ISBLK(st.st_mode))
 		/* do not test major - perhaps this was an USB floppy */
 		errx(EXIT_FAILURE, _("%s: not a block device"), argv[0]);
-	if (access(argv[0], W_OK) < 0)
-		err(EXIT_FAILURE, _("cannot access file %s"), argv[0]);
-
-	ctrl = open(argv[0], O_RDWR);
-	if (ctrl < 0)
-		err(EXIT_FAILURE, _("cannot open %s"), argv[0]);
 	if (ioctl(ctrl, FDGETPRM, (long) &param) < 0)
 		err(EXIT_FAILURE, _("could not determine current format type"));
 
-- 
2.6.2

