Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48629 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759351Ab1LOTDH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 15 Dec 2011 14:03:07 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so2431841eek.19
        for <util-linux@vger.kernel.org>; Thu, 15 Dec 2011 11:03:06 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 10/13] fdisk: avoid an intermediate variable in command_prompt()
Date: Thu, 15 Dec 2011 20:02:46 +0100
Message-Id: <1323975769-21929-10-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
References: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 53eed25..acf0e67 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -1635,6 +1635,9 @@ static void dos_delete_partition(int i)
 static void
 delete_partition(int i)
 {
+	if (i < 0)
+		return;
+
 	if (warn_geometry())
 		return;		/* C/H/S not set */
 
@@ -2869,7 +2872,7 @@ unknown_command(int c) {
 
 static void command_prompt(void)
 {
-	int c, j;
+	int c;
 
 	if (disklabel == OSF_LABEL) {
 		putchar('\n');
@@ -2921,9 +2924,7 @@ static void command_prompt(void)
 				unknown_command(c);
 			break;
 		case 'd':
-			j = get_existing_partition(1, partitions);
-			if (j >= 0)
-				delete_partition(j);
+			delete_partition(get_existing_partition(1, partitions));
 			break;
 		case 'i':
 			if (disklabel == SGI_LABEL)
-- 
1.7.7

