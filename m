Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47344 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756260Ab1LOTC4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 15 Dec 2011 14:02:56 -0500
Received: by eekc4 with SMTP id c4so2431824eek.19
        for <util-linux@vger.kernel.org>; Thu, 15 Dec 2011 11:02:55 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 01/13] fdisk: remove unused 'require' member in enum action
Date: Thu, 15 Dec 2011 20:02:37 +0100
Message-Id: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c |    2 --
 fdisk/fdisk.h |    2 +-
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 00dd706..a6de6e2 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -1179,8 +1179,6 @@ got_dos_table:
 			create_doslabel();
 #endif
 			return 0;
-		case require:
-			return -1;
 		case try_only:
 		        return -1;
 		case create_empty_dos:
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index 81ff5a2..67642cd 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -54,7 +54,7 @@ enum failure {ioctl_error,
 	unable_to_open, unable_to_read, unable_to_seek,
 	unable_to_write};
 
-enum action {fdisk, require, try_only, create_empty_dos, create_empty_sun};
+enum action {fdisk, try_only, create_empty_dos, create_empty_sun};
 
 struct geom {
 	unsigned int heads;
-- 
1.7.7

