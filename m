Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:55197 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758909AbbBHUWH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Feb 2015 15:22:07 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/4] textual: sort the options in the usage text of sfdisk alphabetically
Date: Sun,  8 Feb 2015 21:21:31 +0100
Message-Id: <1423426891-1887-4-git-send-email-bensberg@justemail.net>
In-Reply-To: <1423426891-1887-1-git-send-email-bensberg@justemail.net>
References: <1423426891-1887-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/sfdisk.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 6bcb140..b10c004 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -1336,20 +1336,20 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -A, --append              append partitions to existing partition table\n"), out);
-	fputs(_("     --bytes               print SIZE in bytes rather than in human readable format\n"), out);
 	fputs(_(" -b, --backup              backup partition table sectors (see -O)\n"), out);
+	fputs(_("     --bytes               print SIZE in bytes rather than in human readable format\n"), out);
 	fputs(_(" -f, --force               disable all consistency checking\n"), out);
-	fputs(_(" -o, --output <list>       output columns\n"), out);
-	fputs(_(" -O, --backup-file <path>  override default backup file name\n"), out);
 	fputs(_(" -N, --partno <num>        specify partition number\n"), out);
-	fputs(_(" -X, --label <name>        specify label type (dos, gpt, ...)\n"), out);
-	fputs(_(" -Y, --label-nested <name> specify nested label type (dos, bsd)\n"), out);
-	fputs(_(" -q, --quiet               suppress extra info messages\n"), out);
 	fputs(_(" -n, --no-act              do everything except write to device\n"), out);
 	fputs(_("     --no-reread           do not check whether the device is in use\n"), out);
+	fputs(_(" -O, --backup-file <path>  override default backup file name\n"), out);
+	fputs(_(" -o, --output <list>       output columns\n"), out);
+	fputs(_(" -q, --quiet               suppress extra info messages\n"), out);
+	fputs(_(" -X, --label <name>        specify label type (dos, gpt, ...)\n"), out);
+	fputs(_(" -Y, --label-nested <name> specify nested label type (dos, bsd)\n"), out);
 	fputs(USAGE_SEPARATOR, out);
-	fputs(_(" -u, --unit S              deprecated, only sector unit is supported\n"), out);
 	fputs(_(" -L, --Linux               deprecated, only for backward compatibility\n"), out);
+	fputs(_(" -u, --unit S              deprecated, only sector unit is supported\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
-- 
1.7.0.4

