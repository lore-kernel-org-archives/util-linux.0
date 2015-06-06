Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp2.ono.com ([62.42.230.179]:27541 "EHLO smtp2.ono.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbbFFETn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 6 Jun 2015 00:19:43 -0400
From: Guillem Jover <guillem@hadrons.org>
To: util-linux@vger.kernel.org
Cc: Steven Chamberlain <steven@pyro.eu.org>
Subject: [PATCH 2/3] lib/sysfs: Use dup_fd_cloexec instead of direct call to fcntl
Date: Sat,  6 Jun 2015 06:19:06 +0200
Message-Id: <1433564347-9515-3-git-send-email-guillem@hadrons.org>
In-Reply-To: <1433564347-9515-1-git-send-email-guillem@hadrons.org>
References: <1433564347-9515-1-git-send-email-guillem@hadrons.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Guillem Jover <guillem@hadrons.org>
---
 lib/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sysfs.c b/lib/sysfs.c
index 07b6b56..caf89bf 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -267,7 +267,7 @@ DIR *sysfs_opendir(struct sysfs_cxt *cxt, const char *attr)
 		 * -- we cannot use cxt->sysfs_fd directly, because closedir()
 		 * will close this our persistent file descriptor.
 		 */
-		fd = fcntl(cxt->dir_fd, F_DUPFD_CLOEXEC, STDERR_FILENO + 1);
+		fd = dup_fd_cloexec(cxt->dir_fd, STDERR_FILENO + 1);
 
 	if (fd < 0)
 		return NULL;
-- 
2.2.1.209.g41e5f3a

