Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:64750 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751466AbeAWP7b (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 23 Jan 2018 10:59:31 -0500
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LslCb-1eopcx28ef-012H7L for <util-linux@vger.kernel.org>; Tue, 23 Jan 2018
 16:59:30 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/7] fsck.cramfs: fix error message
Date: Tue, 23 Jan 2018 16:59:25 +0100
Message-Id: <20180123155928.7629-5-sweet_f_a@gmx.de>
In-Reply-To: <20180123155928.7629-1-sweet_f_a@gmx.de>
References: <20180123155928.7629-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

errno is invalid in case that we just read(3) too short.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/fsck.cramfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index 820816b14..2a4f75a8c 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -226,10 +226,15 @@ static void test_crc(int start)
 		    mmap(NULL, super.size, PROT_READ | PROT_WRITE,
 			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 		if (buf != MAP_FAILED) {
+			ssize_t tmp;
 			if (lseek(fd, 0, SEEK_SET) == (off_t) -1)
 				err(FSCK_EX_ERROR, _("seek on %s failed"), filename);
-			if (read(fd, buf, super.size) != (ssize_t) super.size)
+			tmp = read(fd, buf, super.size);
+			if (tmp < 0)
 				err(FSCK_EX_ERROR, _("cannot read %s"), filename);
+			if (tmp != (ssize_t) super.size)
+				errx(FSCK_EX_ERROR, _("failed to read %"PRIu32" bytes from file %s"),
+					super.size, filename);
 		}
 	}
 	if (buf != MAP_FAILED) {
-- 
2.13.6

