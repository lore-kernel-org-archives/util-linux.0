Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:57369 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbaGMUZW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Jul 2014 16:25:22 -0400
Received: by mail-wi0-f180.google.com with SMTP id n3so1575386wiv.1
        for <util-linux@vger.kernel.org>; Sun, 13 Jul 2014 13:25:21 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/14] fdformat: match variable and print format types
Date: Sun, 13 Jul 2014 21:24:45 +0100
Message-Id: <1405283093-28182-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
References: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fdformat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/disk-utils/fdformat.c b/disk-utils/fdformat.c
index b50ba30..e6ae8e4 100644
--- a/disk-utils/fdformat.c
+++ b/disk-utils/fdformat.c
@@ -35,7 +35,7 @@ static void format_disk(int ctrl)
 		if (ioctl(ctrl, FDFMTTRK, (long) &descr) < 0)
 			err(EXIT_FAILURE, "ioctl: FDFMTTRK");
 
-		printf("%3d\b\b\b", track);
+		printf("%3ud\b\b\b", track);
 		fflush(stdout);
 		if (param.head == 2) {
 			descr.head = 1;
@@ -63,7 +63,7 @@ static void verify_disk(char *name)
 	for (cyl = 0; cyl < param.track; cyl++) {
 		int read_bytes;
 
-		printf("%3d\b\b\b", cyl);
+		printf("%u3d\b\b\b", cyl);
 		fflush(stdout);
 		read_bytes = read(fd, data, cyl_size);
 		if (read_bytes != cyl_size) {
-- 
2.0.1

