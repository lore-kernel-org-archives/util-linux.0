Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:56149 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752448AbbFQG2x (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 17 Jun 2015 02:28:53 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] sfdisk: show that the command --verify optionally takes device names
Date: Wed, 17 Jun 2015 08:28:32 +0200
Message-Id: <1434522513-2124-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/sfdisk.8 |    2 +-
 disk-utils/sfdisk.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index 7a89791..91cba72 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -113,7 +113,7 @@ List the sizes of all or the specified devices.
 Print all supported types for the current disk label or the label specified by
 \fB\-\-label\fR.
 .TP
-.BR \-V , " \-\-verify
+.BR \-V , " \-\-verify " [ \fIdevice ...]
 Test whether the partition table and partitions seem correct.
 
 .SH OPTIONS
diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 2c56e34..a126943 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -1413,7 +1413,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	fputs(_(" -l, --list [<dev> ...]            list partitions of each device\n"), out);
 	fputs(_(" -s, --show-size [<dev> ...]       list sizes of all or specified devices\n"), out);
 	fputs(_(" -T, --list-types                  print the recognized types (see -X)\n"), out);
-	fputs(_(" -V, --verify                      test whether partitions seem correct\n"), out);
+	fputs(_(" -V, --verify [<dev> ...]          test whether partitions seem correct\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_(" --part-label <dev> <part> [<str>] print or change partition label\n"), out);
-- 
1.7.0.4

