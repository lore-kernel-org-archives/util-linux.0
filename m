Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:59172 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752094AbdFLIuB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 12 Jun 2017 04:50:01 -0400
Received: from adsiz.fritz.box ([146.52.24.88]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6eTo-1e5gMl2vrg-00wSXu for
 <util-linux@vger.kernel.org>; Mon, 12 Jun 2017 10:49:59 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/6] misc: fix gcc-7 sprintf warnings -Wformat-overflow
Date: Mon, 12 Jun 2017 10:49:56 +0200
Message-Id: <20170612084958.22054-5-sweet_f_a@gmx.de>
In-Reply-To: <20170612084958.22054-1-sweet_f_a@gmx.de>
References: <20170612084958.22054-1-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

../login-utils/last.c: In function ‘main’:
../login-utils/last.c:624:23: warning: ‘%s’ directive writing up to 31 bytes into a region of size 27 [-Wformat-overflow=]
   sprintf(path, "/dev/%s", ut->ut_line);
                       ^~   ~~
../login-utils/last.c:624:3: note: ‘sprintf’ output between 6 and 37 bytes into a destination of size 32
   sprintf(path, "/dev/%s", ut->ut_line);

../libblkid/src/devname.c: In function 'probe_one':
../libblkid/src/devname.c:166:29: warning: '%s' directive writing up to 255 bytes into a region of size 245 [-Wformat-overflow=]
   sprintf(path, "/sys/block/%s/slaves", de->d_name);
                             ^~
../libblkid/src/devname.c:166:3: note: 'sprintf' output between 19 and 274 bytes into a destination of size 256
   sprintf(path, "/sys/block/%s/slaves", de->d_name);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libblkid/src/devname.c | 2 +-
 login-utils/last.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libblkid/src/devname.c b/libblkid/src/devname.c
index ba3c57a41..59029ec06 100644
--- a/libblkid/src/devname.c
+++ b/libblkid/src/devname.c
@@ -152,7 +152,7 @@ static int is_dm_leaf(const char *devname)
 {
 	struct dirent	*de, *d_de;
 	DIR		*dir, *d_dir;
-	char		path[256];
+	char		path[NAME_MAX + 18 + 1];
 	int		ret = 1;
 
 	if ((dir = opendir("/sys/block")) == NULL)
diff --git a/login-utils/last.c b/login-utils/last.c
index f93ec7fbf..c90b574e5 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -598,7 +598,7 @@ static void __attribute__((__noreturn__)) usage(const struct last_control *ctl,
 static int is_phantom(const struct last_control *ctl, struct utmpx *ut)
 {
 	struct passwd *pw;
-	char path[32];
+	char path[sizeof(ut->ut_line) + 16];
 	int ret = 0;
 
 	if (ut->ut_tv.tv_sec < ctl->boot_time.tv_sec)
-- 
2.12.3

