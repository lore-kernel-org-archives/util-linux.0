Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:61429 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933165AbcCQJkZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 05:40:25 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/5] fdisk: fix the grammar of an option description
Date: Thu, 17 Mar 2016 10:39:14 +0100
Message-Id: <1458207554-2405-5-git-send-email-bensberg@justemail.net>
In-Reply-To: <1458207554-2405-1-git-send-email-bensberg@justemail.net>
References: <1458207554-2405-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/fdisk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/disk-utils/fdisk.c b/disk-utils/fdisk.c
index 3f8769d..558d780 100644
--- a/disk-utils/fdisk.c
+++ b/disk-utils/fdisk.c
@@ -729,7 +729,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -b, --sector-size <size>      physical and logical sector size\n"), out);
-	fputs(_(" -B, --protect-boot            don't erase bootbits when create a new label\n"), out);
+	fputs(_(" -B, --protect-boot            don't erase bootbits when creating a new label\n"), out);
 	fputs(_(" -c, --compatibility[=<mode>]  mode is 'dos' or 'nondos' (default)\n"), out);
 	fputs(_(" -L, --color[=<when>]          colorize output (auto, always or never)\n"), out);
 	fprintf(out,
-- 
1.7.0.4

