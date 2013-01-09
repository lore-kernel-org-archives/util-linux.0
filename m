Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:59662 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106Ab3AIThM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Jan 2013 14:37:12 -0500
Received: by mail-wi0-f178.google.com with SMTP id hn3so763686wib.11
        for <util-linux@vger.kernel.org>; Wed, 09 Jan 2013 11:37:11 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/4] include: add missing values to sysfs_cxt initializer definition
Date: Wed,  9 Jan 2013 19:36:56 +0000
Message-Id: <1357760216-4068-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1357760216-4068-1-git-send-email-kerolasa@iki.fi>
References: <1357760216-4068-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/sysfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sysfs.h b/include/sysfs.h
index 4f9c46b..739f9de 100644
--- a/include/sysfs.h
+++ b/include/sysfs.h
@@ -30,7 +30,7 @@ struct sysfs_cxt {
 	unsigned int	has_hctl : 1;
 };
 
-#define UL_SYSFSCXT_EMPTY { 0, -1, NULL, NULL }
+#define UL_SYSFSCXT_EMPTY { 0, -1, NULL, NULL, 0, 0, 0, 0, 0 }
 
 extern char *sysfs_devno_attribute_path(dev_t devno, char *buf,
                                  size_t bufsiz, const char *attr);
-- 
1.8.1

