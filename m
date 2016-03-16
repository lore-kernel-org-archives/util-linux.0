Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:53583 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966045AbcCPI5Z (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Mar 2016 04:57:25 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 8/8] dmesg: improve grammar and consistency of usage text
Date: Wed, 16 Mar 2016 09:55:55 +0100
Message-Id: <1458118555-4691-8-git-send-email-bensberg@justemail.net>
In-Reply-To: <1458118555-4691-1-git-send-email-bensberg@justemail.net>
References: <1458118555-4691-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/dmesg.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 0bf77af..99cf26e 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -289,9 +289,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -x, --decode                decode facility and level to readable string\n"), out);
 	fputs(_(" -d, --show-delta            show time delta between printed messages\n"), out);
 	fputs(_(" -e, --reltime               show local time and time delta in readable format\n"), out);
-	fputs(_(" -T, --ctime                 show human readable timestamp (may be inaccurate!)\n"), out);
-	fputs(_(" -t, --notime                don't print messages timestamp\n"), out);
-	fputs(_("     --time-format <format>  show time stamp using format:\n"
+	fputs(_(" -T, --ctime                 show human-readable timestamp (may be inaccurate!)\n"), out);
+	fputs(_(" -t, --notime                don't show any timestamp with messages\n"), out);
+	fputs(_("     --time-format <format>  show timestamp using the given format:\n"
 		"                               [delta|reltime|ctime|notime|iso]\n"
 		"Suspending/resume will make ctime and iso timestamps inaccurate.\n"), out);
 	fputs(USAGE_SEPARATOR, out);
-- 
1.7.0.4

