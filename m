Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49778 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416Ab2JCWOa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 3 Oct 2012 18:14:30 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so3231268wib.1
        for <util-linux@vger.kernel.org>; Wed, 03 Oct 2012 15:14:29 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] mkfs.minix: check numeric user inputs
Date: Wed,  3 Oct 2012 23:14:26 +0100
Message-Id: <1349302466-14523-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.minix.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index b8b4e87..58b16fc 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -680,14 +680,12 @@ int main(int argc, char ** argv) {
 		case 'c':
 			check=1; break;
 		case 'i':
-			req_nr_inodes = (unsigned long) atol(optarg);
+			req_nr_inodes = strtoul_or_err(optarg, _("failed to parse argument"));
 			break;
 		case 'l':
 			listfile = optarg; break;
 		case 'n':
-			i = strtoul(optarg,&tmp,0);
-			if (*tmp)
-				usage();
+			i = strtoul_or_err(optarg, _("failed to parse argument"));
 			if (i == 14)
 				magic = MINIX_SUPER_MAGIC;
 			else if (i == 30)
@@ -719,13 +717,8 @@ int main(int argc, char ** argv) {
 		argc--;
 		argv++;
 	}
-	if (argc > 0) {
-		BLOCKS = strtol(argv[0],&tmp,0);
-		if (*tmp) {
-			printf(_("strtol error: number of blocks not specified"));
-			usage();
-		}
-	}
+	if (argc > 0)
+		BLOCKS = strtoul_or_err(argv[0], _("failed to parse number of blocks"));
 
 	if (!device_name) {
 		usage();
-- 
1.7.12.2

