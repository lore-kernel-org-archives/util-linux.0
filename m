Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:65105 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbaIGMnb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Sep 2014 08:43:31 -0400
Received: by mail-we0-f173.google.com with SMTP id u56so329590wes.18
        for <util-linux@vger.kernel.org>; Sun, 07 Sep 2014 05:43:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/17] zramctl: fix two format string warnings
Date: Sun,  7 Sep 2014 13:42:56 +0100
Message-Id: <1410093785-17537-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Both warnings were similar.

sys-utils/zramctl.c:527:23: warning: format string is not a string
literal (potentially insecure) [-Wformat-security]
                                err(EXIT_FAILURE, zram->devname);

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/zramctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
index 961dba1..786be06 100644
--- a/sys-utils/zramctl.c
+++ b/sys-utils/zramctl.c
@@ -524,7 +524,7 @@ int main(int argc, char **argv)
 		if (optind < argc) {
 			zram = new_zram(argv[optind++]);
 			if (!zram_exist(zram))
-				err(EXIT_FAILURE, zram->devname);
+				err(EXIT_FAILURE, "%s", zram->devname);
 		}
 		status(zram);
 		free_zram(zram);
@@ -560,7 +560,7 @@ int main(int argc, char **argv)
 		else {
 			zram = new_zram(argv[optind]);
 			if (!zram_exist(zram))
-				err(EXIT_FAILURE, zram->devname);
+				err(EXIT_FAILURE, "%s", zram->devname);
 		}
 
 		if (zram_set_u64parm(zram, "reset", 1))
-- 
2.1.0

