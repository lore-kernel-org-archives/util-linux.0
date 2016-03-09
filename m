Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:52190 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753165AbcCIKzc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Mar 2016 05:55:32 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/3] blkdiscard: slice up the recently changed usage text
Date: Wed,  9 Mar 2016 11:55:01 +0100
Message-Id: <1457520901-4133-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1457520901-4133-1-git-send-email-bensberg@justemail.net>
References: <1457520901-4133-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/blkdiscard.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/sys-utils/blkdiscard.c b/sys-utils/blkdiscard.c
index ff2cee3..c83e12f 100644
--- a/sys-utils/blkdiscard.c
+++ b/sys-utils/blkdiscard.c
@@ -87,16 +87,17 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_("Discard the content of sectors on a device.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -o, --offset <num>  offset in bytes to discard from\n"
-		" -l, --length <num>  length of bytes to discard from the offset\n"
-		" -p, --step <num>    size of the discard iterations within the offset\n"
-		" -s, --secure        perform secure discard\n"
-		" -z, --zeroout       zero-fill rather than discard\n"
-		" -v, --verbose       print aligned length and offset\n"),
-		out);
+	fputs(_(" -o, --offset <num>  offset in bytes to discard from\n"), out);
+	fputs(_(" -l, --length <num>  length of bytes to discard from the offset\n"), out);
+	fputs(_(" -p, --step <num>    size of the discard iterations within the offset\n"), out);
+	fputs(_(" -s, --secure        perform secure discard\n"), out);
+	fputs(_(" -z, --zeroout       zero-fill rather than discard\n"), out);
+	fputs(_(" -v, --verbose       print aligned length and offset\n"), out);
+
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
+
 	fprintf(out, USAGE_MAN_TAIL("blkdiscard(8)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
-- 
1.7.0.4

