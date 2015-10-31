Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38373 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbbJaTVd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 31 Oct 2015 15:21:33 -0400
Received: by wmeg8 with SMTP id g8so33290543wme.1
        for <util-linux@vger.kernel.org>; Sat, 31 Oct 2015 12:21:32 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 02/12] swapon: fix stat(3) and open(3) race
Date: Sat, 31 Oct 2015 19:21:14 +0000
Message-Id: <1446319284-24778-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
References: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/swapon.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 32a3107..c4d1544 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -475,7 +475,13 @@ static int swapon_checks(const char *special)
 	unsigned long long devsize = 0;
 	int permMask;
 
-	if (stat(special, &st) < 0) {
+	fd = open(special, O_RDONLY);
+	if (fd == -1) {
+		warn(_("cannot open %s"), special);
+		goto err;
+	}
+
+	if (fstat(fd, &st) < 0) {
 		warn(_("stat of %s failed"), special);
 		goto err;
 	}
@@ -500,12 +506,6 @@ static int swapon_checks(const char *special)
 		devsize = st.st_size;
 	}
 
-	fd = open(special, O_RDONLY);
-	if (fd == -1) {
-		warn(_("cannot open %s"), special);
-		goto err;
-	}
-
 	if (S_ISBLK(st.st_mode) && blkdev_get_size(fd, &devsize)) {
 		warnx(_("%s: get size failed"), special);
 		goto err;
-- 
2.6.2

