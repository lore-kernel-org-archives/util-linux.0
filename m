Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:34664 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753780AbcHBSnp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Aug 2016 14:43:45 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C33E8AAD1
	for <util-linux@vger.kernel.org>; Tue,  2 Aug 2016 17:57:56 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 4/8] loopdev: Implememt loopcxt_set_status()
Message-ID: <c1d3919b-5f70-da6b-5a09-c968c517d4cc@suse.cz>
Date: Tue, 2 Aug 2016 19:57:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Implement stand-alone loopcxt_set_status(). It allows manipulation with some
loop device parameters even if it is initialized.

Its function is limited by the kernel implementation, and only a small subset of
changes is allowed.

For more see linux/drivers/block/loop.c:loop_set_status()

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 include/loopdev.h |  1 +
 lib/loopdev.c     | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/loopdev.h b/include/loopdev.h
index 706388e..c331b59 100644
--- a/include/loopdev.h
+++ b/include/loopdev.h
@@ -164,6 +164,7 @@ extern int loopcxt_deinit_iterator(struct loopdev_cxt *lc);
 extern int loopcxt_next(struct loopdev_cxt *lc);
 
 extern int loopcxt_setup_device(struct loopdev_cxt *lc);
+extern int loopcxt_set_status(struct loopdev_cxt *lc);
 extern int loopcxt_delete_device(struct loopdev_cxt *lc);
 extern int loopcxt_set_capacity(struct loopdev_cxt *lc);
 extern int loopcxt_set_dio(struct loopdev_cxt *lc, unsigned long use_dio);
diff --git a/lib/loopdev.c b/lib/loopdev.c
index 4606003..b20a9c2 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -1206,7 +1206,7 @@ static int loopcxt_check_size(struct loopdev_cxt *lc, int file_fd)
 }
 
 /*
- * @cl: context
+ * @lc: context
  *
  * Associate the current device (see loopcxt_{set,get}_device()) with
  * a file (see loopcxt_set_backing_file()).
@@ -1330,6 +1330,40 @@ err:
 	return rc;
 }
 
+/*
+ * @lc: context
+ *
+ * Update status of the current device (see loopcxt_{set,get}_device()).
+ *
+ * Note that once initialized, kernel accepts only selected changes:
+ * LO_FLAGS_AUTOCLEAR and LO_FLAGS_PARTSCAN
+ * For more see linux/drivers/block/loop.c:loop_set_status()
+ *
+ * Returns: <0 on error, 0 on success.
+ */
+int loopcxt_set_status(struct loopdev_cxt *lc)
+{
+	int dev_fd, rc = -1;
+
+	errno = 0;
+	dev_fd = loopcxt_get_fd(lc);
+
+	if (dev_fd < 0) {
+		rc = -errno;
+		return rc;
+	}
+	DBG(SETUP, ul_debugobj(lc, "device open: OK"));
+
+	if (ioctl(dev_fd, LOOP_SET_STATUS64, &lc->info)) {
+		rc = -errno;
+		DBG(SETUP, ul_debugobj(lc, "LOOP_SET_STATUS64 failed: %m"));
+		return rc;
+	}
+
+	DBG(SETUP, ul_debugobj(lc, "LOOP_SET_STATUS64: OK"));
+	return 0;
+}
+
 int loopcxt_set_capacity(struct loopdev_cxt *lc)
 {
 	int fd = loopcxt_get_fd(lc);
-- 
2.9.2

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
