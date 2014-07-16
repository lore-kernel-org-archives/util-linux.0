Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38081 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbaGPUzY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 16 Jul 2014 16:55:24 -0400
Received: by mail-wi0-f179.google.com with SMTP id f8so2013267wiw.12
        for <util-linux@vger.kernel.org>; Wed, 16 Jul 2014 13:55:23 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/3] fstrim: avoid TOCTOU race
Date: Wed, 16 Jul 2014 21:54:58 +0100
Message-Id: <1405544098-1740-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1405544098-1740-1-git-send-email-kerolasa@iki.fi>
References: <1405544098-1740-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/fstrim.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sys-utils/fstrim.c b/sys-utils/fstrim.c
index d52d831..5a238c7 100644
--- a/sys-utils/fstrim.c
+++ b/sys-utils/fstrim.c
@@ -67,7 +67,12 @@ static int fstrim_filesystem(const char *path, struct fstrim_range *rangetpl,
 	/* kernel modifies the range */
 	memcpy(&range, rangetpl, sizeof(range));
 
-	if (stat(path, &sb) == -1) {
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		warn(_("cannot open %s"), path);
+		return -1;
+	}
+	if (fstat(fd, &sb) == -1) {
 		warn(_("stat failed %s"), path);
 		return -1;
 	}
@@ -75,12 +80,6 @@ static int fstrim_filesystem(const char *path, struct fstrim_range *rangetpl,
 		warnx(_("%s: not a directory"), path);
 		return -1;
 	}
-
-	fd = open(path, O_RDONLY);
-	if (fd < 0) {
-		warn(_("cannot open %s"), path);
-		return -1;
-	}
 	errno = 0;
 	if (ioctl(fd, FITRIM, &range)) {
 		int rc = errno == EOPNOTSUPP || errno == ENOTTY ? 1 : -1;
-- 
2.0.1

