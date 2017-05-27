Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35468 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbdE0SYQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 27 May 2017 14:24:16 -0400
Received: by mail-wm0-f44.google.com with SMTP id b84so16364493wmh.0
        for <util-linux@vger.kernel.org>; Sat, 27 May 2017 11:24:16 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/4] libblkid: fix format overflow
Date: Sat, 27 May 2017 19:24:07 +0100
Message-Id: <20170527182409.13985-2-kerolasa@iki.fi>
In-Reply-To: <20170527182409.13985-1-kerolasa@iki.fi>
References: <20170527182409.13985-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

libblkid/src/devname.c:166:29: warning: '%s' directive writing up to 255
bytes into a region of size 245 [-Wformat-overflow=]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libblkid/src/devname.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libblkid/src/devname.c b/libblkid/src/devname.c
index ba3c57a41..4ee6e3119 100644
--- a/libblkid/src/devname.c
+++ b/libblkid/src/devname.c
@@ -152,12 +152,13 @@ static int is_dm_leaf(const char *devname)
 {
 	struct dirent	*de, *d_de;
 	DIR		*dir, *d_dir;
-	char		path[256];
 	int		ret = 1;
 
 	if ((dir = opendir("/sys/block")) == NULL)
 		return 0;
 	while ((de = readdir(dir)) != NULL) {
+		char path[strlen(de->d_name) + sizeof("/sys/block//slaves") + 1];
+
 		if (!strcmp(de->d_name, ".") || !strcmp(de->d_name, "..") ||
 		    !strcmp(de->d_name, devname) ||
 		    strncmp(de->d_name, "dm-", 3) ||
-- 
2.13.0

