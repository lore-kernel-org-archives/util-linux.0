Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53129 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeECV6E (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 3 May 2018 17:58:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id w194so1230752wmf.2
        for <util-linux@vger.kernel.org>; Thu, 03 May 2018 14:58:04 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/3] zramctl: fix truncation warning
Date: Thu,  3 May 2018 22:57:58 +0100
Message-Id: <20180503215759.3720-2-kerolasa@iki.fi>
In-Reply-To: <20180503215759.3720-1-kerolasa@iki.fi>
References: <20180503215759.3720-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

sys-utils/zramctl.c: In function ‘zram_get_sysfs’:
sys-utils/zramctl.c:220:52: warning: ‘%s’ directive output may be truncated
writing up to 4095 bytes into a region of size 27 [-Wformat-truncation=]
     snprintf(z->devname, sizeof(z->devname), "/dev/%s", name);

As an additional good thing zramctl will no longer allocate 4096 bytes from
stack when just 23 bytes is enough.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/zramctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
index 8da7b2ddb..0dc0947e4 100644
--- a/sys-utils/zramctl.c
+++ b/sys-utils/zramctl.c
@@ -215,7 +215,7 @@ static struct sysfs_cxt *zram_get_sysfs(struct zram *z)
 			return NULL;
 		if (*z->devname != '/') {
 			/* canonicalize the device name according to /sys */
-			char name[PATH_MAX];
+			char name[sizeof(z->devname) - sizeof("/dev/")];
 			if (sysfs_get_devname(&z->sysfs, name, sizeof(name)))
 				snprintf(z->devname, sizeof(z->devname), "/dev/%s", name);
 		}
-- 
2.17.0

