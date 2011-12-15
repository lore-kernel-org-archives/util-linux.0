Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48629 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756375Ab1LOTC7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 15 Dec 2011 14:02:59 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so2431841eek.19
        for <util-linux@vger.kernel.org>; Thu, 15 Dec 2011 11:02:58 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 04/13] fdisk: drop one parameter from try() function
Date: Thu, 15 Dec 2011 20:02:40 +0100
Message-Id: <1323975769-21929-4-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
References: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 1a4c823..1ecab17 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -2800,15 +2800,13 @@ gpt_warning(char *dev)
 }
 
 static void
-try(char *device, int user_specified) {
+try(char *device)
+{
 	int gb;
 
 	disk_device = device;
 	if (setjmp(listingbuf))
 		return;
-	if (!user_specified)
-		if (is_ide_cdrom_or_tape(device))
-			return;
 	gpt_warning(device);
 	if ((fd = open(disk_device, type_open)) >= 0) {
 		gb = get_boot(try_only);
@@ -2859,7 +2857,7 @@ tryprocpt(void) {
 		if (is_whole_disk(devname)) {
 			char *cn = canonicalize_path(devname);
 			if (cn) {
-				try(cn, 0);
+				try(cn);
 				free(cn);
 			}
 		}
@@ -3079,7 +3077,8 @@ main(int argc, char **argv) {
 			dummy(&k);
 			listing = 1;
 			for (k = optind; k < argc; k++)
-				try(argv[k], 1);
+				if (!is_ide_cdrom_or_tape(argv[k]))
+					try(argv[k]);
 		} else {
 			/* we no longer have default device names */
 			/* but we can use /proc/partitions instead */
-- 
1.7.7

