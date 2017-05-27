Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36508 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbdE0SYS (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 27 May 2017 14:24:18 -0400
Received: by mail-wr0-f196.google.com with SMTP id n104so2078375wrb.3
        for <util-linux@vger.kernel.org>; Sat, 27 May 2017 11:24:18 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 4/4] lib/sysfs: fix format overflow
Date: Sat, 27 May 2017 19:24:09 +0100
Message-Id: <20170527182409.13985-4-kerolasa@iki.fi>
In-Reply-To: <20170527182409.13985-1-kerolasa@iki.fi>
References: <20170527182409.13985-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

lib/sysfs.c:343:31: warning: '/start' directive output may be truncated
writing 6 bytes into a region of size between 1 and 256
[-Wformat-truncation=]

lib/sysfs.c:372:32: warning: '/partition' directive output may be truncated
writing 10 bytes into a region of size between 1 and 256
[-Wformat-truncation=]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/sysfs.c b/lib/sysfs.c
index cc290faac..6272b80b4 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -307,7 +307,7 @@ static struct dirent *xreaddir(DIR *dp)
 
 int sysfs_is_partition_dirent(DIR *dir, struct dirent *d, const char *parent_name)
 {
-	char path[256];
+	char path[strlen(d->d_name) + sizeof("/start") + 1];
 
 #ifdef _DIRENT_HAVE_D_TYPE
 	if (d->d_type != DT_DIR &&
@@ -356,7 +356,6 @@ dev_t sysfs_partno_to_devno(struct sysfs_cxt *cxt, int partno)
 {
 	DIR *dir;
 	struct dirent *d;
-	char path[256];
 	dev_t devno = 0;
 
 	dir = sysfs_opendir(cxt, NULL);
@@ -365,6 +364,7 @@ dev_t sysfs_partno_to_devno(struct sysfs_cxt *cxt, int partno)
 
 	while ((d = xreaddir(dir))) {
 		int n, maj, min;
+		char path[strlen(d->d_name) + sizeof("/partition") + 1];
 
 		if (!sysfs_is_partition_dirent(dir, d, NULL))
 			continue;
-- 
2.13.0

