Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:64736 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754021Ab2FTIcN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 20 Jun 2012 04:32:13 -0400
From: Cong Wang <amwang@redhat.com>
To: util-linux@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Karel Zak <kzak@redhat.com>
Subject: [Patch] lib/sysfs.c: check if cxt->dir_path is NULL in sysfs_readlink()
Date: Wed, 20 Jun 2012 16:32:00 +0800
Message-Id: <1340181120-3457-1-git-send-email-amwang@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Cong Wang <xiyou.wangcong@gmail.com>

cxt->dir_path could be NULL, for example, when sysfs_init() fails,
check this before calling readlink()/readlink_at().

Cc: Karel Zak <kzak@redhat.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

---
diff --git a/lib/sysfs.c b/lib/sysfs.c
index 312191f..b4fb7cd 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -220,6 +220,9 @@ static int sysfs_open(struct sysfs_cxt *cxt, const char *attr)
 ssize_t sysfs_readlink(struct sysfs_cxt *cxt, const char *attr,
 		   char *buf, size_t bufsiz)
 {
+	if (!cxt->dir_path)
+		return -1;
+
 	if (attr)
 		return readlink_at(cxt->dir_fd, cxt->dir_path, attr, buf, bufsiz);
 
