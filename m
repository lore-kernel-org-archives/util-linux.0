Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f179.google.com ([74.125.82.179]:34182 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbaBPXyu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Feb 2014 18:54:50 -0500
Received: by mail-we0-f179.google.com with SMTP id q58so9925397wes.24
        for <util-linux@vger.kernel.org>; Sun, 16 Feb 2014 15:54:49 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 7/9] isosize: move file name printing after error determination
Date: Sun, 16 Feb 2014 23:54:20 +0000
Message-Id: <1392594862-15807-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1392594862-15807-1-git-send-email-kerolasa@iki.fi>
References: <1392594862-15807-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier the filename printing was buffered, and exit at error made output
to appear in front of prompt.  Output below demonstrates the brokenness.

prompt> isosize /etc /
isosize: /etc: might not be an ISO filesystem
isosize: read error on /etc: Is a directory
/etc: prompt>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/isosize.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/disk-utils/isosize.c b/disk-utils/isosize.c
index 4c16ec5..f90029e 100644
--- a/disk-utils/isosize.c
+++ b/disk-utils/isosize.c
@@ -125,7 +125,7 @@ struct iso_primary_descriptor
 	unsigned char unused5			[ISODCL (1396, 2048)];
 };
 
-static void isosize(char *filenamep, int xflag, long divisor)
+static void isosize(int argc, char *filenamep, int xflag, long divisor)
 {
 	int fd, nsecs, ssize;
 	struct iso_primary_descriptor ipd;
@@ -145,6 +145,8 @@ static void isosize(char *filenamep, int xflag, long divisor)
 	/* isonum_723 returns nowadays always 2048 */
 	ssize = isonum_723(ipd.logical_block_size, xflag);
 
+	if (1 < argc)
+		printf("%s: ", filenamep);
 	if (xflag) {
 		printf(_("sector count: %d, sector size: %d\n"), nsecs, ssize);
 	} else {
@@ -220,11 +222,8 @@ int main(int argc, char **argv)
 	if (ct <= 0)
 		usage(stderr);
 
-	for (j = optind; j < argc; j++) {
-		if (ct > 1)
-			printf("%s: ", argv[j]);
-		isosize(argv[j], xflag, divisor);
-	}
+	for (j = optind; j < argc; j++)
+		isosize(ct, argv[j], xflag, divisor);
 
 	return EXIT_SUCCESS;
 }
-- 
1.9.0

