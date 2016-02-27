Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:44208 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756363AbcB0QPG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 27 Feb 2016 11:15:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1aZhWK-0008D9-H6
	for util-linux@vger.kernel.org; Sat, 27 Feb 2016 17:15:04 +0100
Received: from ppp37-190-56-35.pppoe.spdop.ru ([37.190.56.35])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sat, 27 Feb 2016 17:15:04 +0100
Received: from yumkam by ppp37-190-56-35.pppoe.spdop.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sat, 27 Feb 2016 17:15:04 +0100
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: [PATCH 2/3] lib/sysfs.c sys-utils/lsns.c: fix error return
Date: Sat, 27 Feb 2016 19:14:44 +0300
Message-ID: <m3mvqmm8p7.fsf@gmail.com>
References: <m3r3fymc4d.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/x-diff
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>From a2c1a0e50581b4b8ff315d052f3b5f1654c024f8 Mon Sep 17 00:00:00 2001
From: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Date: Sat, 27 Feb 2016 19:02:49 +0300
Subject: [PATCH 2/3] lib/sysfs.c sys-utils/lsns.c: fix error return

If non-negative value returned, errno could be unset (especially 0).
---
Note: likely impossible to trigger, so this only fixes "formal correctness"

 lib/sysfs.c      | 2 +-
 sys-utils/lsns.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/sysfs.c b/lib/sysfs.c
index 53aba3a..9d76148 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -464,7 +464,7 @@ int sysfs_write_u64(struct sysfs_cxt *cxt, const char *attr, uint64_t num)
 
 	len = snprintf(buf, sizeof(buf), "%" PRIu64, num);
 	if (len < 0 || (size_t) len + 1 > sizeof(buf))
-		rc = -errno;
+		rc = len < 0 ? -errno : -E2BIG;
 	else
 		rc = write_all(fd, buf, len);
 
diff --git a/sys-utils/lsns.c b/sys-utils/lsns.c
index 7b8f17d..3bfc6ac 100644
--- a/sys-utils/lsns.c
+++ b/sys-utils/lsns.c
@@ -255,7 +255,7 @@ static int read_process(struct lsns *ls, pid_t pid)
 	}
 	rc = fscanf(f, "%d %*s %c %d*[^\n]", &p->pid, &p->state, &p->ppid);
 	if (rc != 3) {
-		rc = -errno;
+		rc = rc < 0 ? -errno : -EINVAL;
 		goto done;
 	}
 	rc = 0;
-- 
2.1.4


