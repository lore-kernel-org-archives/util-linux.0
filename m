Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f41.google.com ([74.125.83.41]:58923 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764AbaCCVMH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 3 Mar 2014 16:12:07 -0500
Received: by mail-ee0-f41.google.com with SMTP id t10so1930832eei.28
        for <util-linux@vger.kernel.org>; Mon, 03 Mar 2014 13:12:06 -0800 (PST)
From: =?UTF-8?q?Maciej=20Ma=C5=82ecki?= <me@mmalecki.com>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Maciej=20Ma=C5=82ecki?= <me@mmalecki.com>
Subject: [PATCH v2 3/3] fdisk: retry opening device in read-only mode
Date: Mon,  3 Mar 2014 22:14:07 +0100
Message-Id: <1393881247-17092-3-git-send-email-me@mmalecki.com>
In-Reply-To: <1393881247-17092-1-git-send-email-me@mmalecki.com>
References: <1393471600-17777-1-git-send-email-me@mmalecki.com>
 <1393881247-17092-1-git-send-email-me@mmalecki.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Print a warning if opening in write mode fails.
---
 fdisks/fdisk.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index 7afd642..1c7b1f7 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -538,8 +538,16 @@ int main(int argc, char **argv)
 		fdisk_info(cxt, _("Changes will remain in memory only, until you decide to write them.\n"
 				  "Be careful before using the write command.\n"));
 
-		if (fdisk_context_assign_device(cxt, argv[optind], 0) != 0)
-			err(EXIT_FAILURE, _("cannot open %s"), argv[optind]);
+		if (fdisk_context_assign_device(cxt, argv[optind], 0) != 0) {
+			if (fdisk_context_assign_device(cxt, argv[optind], 1) != 0)
+				err(EXIT_FAILURE, _("cannot open %s"), argv[optind]);
+
+			fdisk_warnx(cxt, _(
+				  "Opening device in write mode failed, device "
+				  "is open in read-only mode.\nfdisk won't be "
+				  "able to write changes."));
+			assert(cxt->readonly);
+		}
 
 		fflush(stdout);
 
-- 
1.9.0

