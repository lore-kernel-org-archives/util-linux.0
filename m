Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:56617
	"EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188AbbHYQ1v (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 25 Aug 2015 12:27:51 -0400
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH 2/2] lsblk: fix resource leak [coverity scan]
Date: Tue, 25 Aug 2015 18:27:41 +0200
Message-Id: <1440520061-23922-2-git-send-email-andreas@fatal.se>
In-Reply-To: <1440520061-23922-1-git-send-email-andreas@fatal.se>
References: <1440520061-23922-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 misc-utils/lsblk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 4cfeef8..d1bb13a 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -762,8 +762,10 @@ static char *get_subsystems(struct blkdev_cxt *cxt)
 		size_t sz;
 
 		/* don't create "block:scsi:scsi", but "block:scsi" */
-		if (len && strcmp(res + last, sub) == 0)
+		if (len && strcmp(res + last, sub) == 0) {
+			free(sub);
 			continue;
+		}
 
 		sz = strlen(sub);
 		res = xrealloc(res, len + sz + 2);
-- 
2.1.4

