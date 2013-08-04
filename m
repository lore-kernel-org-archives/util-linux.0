Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f54.google.com ([74.125.82.54]:37469 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156Ab3HDJ74 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 4 Aug 2013 05:59:56 -0400
Received: by mail-wg0-f54.google.com with SMTP id e12so548320wgh.21
        for <util-linux@vger.kernel.org>; Sun, 04 Aug 2013 02:59:55 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] mkswap: add run time warning when maximum number of pages is exceeded
Date: Sun,  4 Aug 2013 10:59:50 +0100
Message-Id: <1375610390-3590-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The commit f1477c4 mentioned in manual page swap header has a hard limit
for usable page count, which user will very likely miss unless there is a
run time warning.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkswap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index 71503f4..16e7b1e 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -556,6 +556,9 @@ main(int argc, char **argv) {
 			(long)(MIN_GOODPAGES * pagesize/1024));
 		usage(stderr);
 	}
+	if (UINT_MAX < PAGES)
+		warnx(_("warning: swap area exceeds greatest number of supported pages by %llu"),
+			PAGES - UINT_MAX);
 
 #ifdef __linux__
 	if (get_linux_version() >= KERNEL_VERSION(2,3,4))
-- 
1.8.3.4

