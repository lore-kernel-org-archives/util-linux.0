Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45965 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930Ab1LKS6K (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 Dec 2011 13:58:10 -0500
Received: by qadc12 with SMTP id c12so1830719qad.19
        for <util-linux@vger.kernel.org>; Sun, 11 Dec 2011 10:58:09 -0800 (PST)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 1/2] findmnt: use warnx for libmnt error callback
Date: Sun, 11 Dec 2011 13:58:04 -0500
Message-Id: <1323629885-17940-2-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1323629885-17940-1-git-send-email-dreisner@archlinux.org>
References: <1323629885-17940-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

libmount doesn't set errno appropriately here:

$ findmnt -s
findmnt: /etc/fstab: parse error at line 20: Success

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 misc-utils/findmnt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 9c2b9fc..4577dc6 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -484,7 +484,7 @@ leave:
 static int parser_errcb(struct libmnt_table *tb __attribute__ ((__unused__)),
 			const char *filename, int line)
 {
-	warn(_("%s: parse error at line %d"), filename, line);
+	warnx(_("%s: parse error at line %d"), filename, line);
 	return 0;
 }
 
-- 
1.7.8

