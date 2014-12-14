Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:53939 "EHLO
	cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751138AbaLNTqH (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 14 Dec 2014 14:46:07 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 8/8] sfdisk: in the usage text show -v for --version instead of -V
Date: Sun, 14 Dec 2014 20:45:33 +0100
Message-Id: <1418586333-5342-8-git-send-email-bensberg@justemail.net>
In-Reply-To: <1418586333-5342-1-git-send-email-bensberg@justemail.net>
References: <1418586333-5342-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In sfdisk -V is taken by --verify.  Use for the description of --version
the same indentation as for --help, not that of the other options.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/sfdisk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index cff8664..73a1331 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -1348,7 +1348,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
-	fputs(USAGE_VERSION, out);
+	fputs(_(" -v, --version  output version information and exit\n"), out);
 
 	list_available_columns(out);
 
-- 
1.7.0.4

