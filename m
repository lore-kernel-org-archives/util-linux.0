Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:42909 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab3AVX1p (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jan 2013 18:27:45 -0500
Received: by mail-wg0-f47.google.com with SMTP id dq11so1790891wgb.26
        for <util-linux@vger.kernel.org>; Tue, 22 Jan 2013 15:27:43 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/14] losetup: make usage() translator friendly
Date: Tue, 22 Jan 2013 23:27:09 +0000
Message-Id: <1358897233-6676-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
References: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/losetup.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index 2c81e69..45e46c8 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -360,14 +360,14 @@ static void usage(FILE *out)
 		" -j, --associated <file>       list all devices associated with <file>\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 
-	fputs(_(" -l, --list                    list info about all or specified\n"
-		" -o, --offset <num>            start at offset <num> into file\n"
-		" -O, --output <cols>           specify columns to output for --list\n"
-		"     --sizelimit <num>         device limited to <num> bytes of the file\n"
-		" -P, --partscan                create partitioned loop device\n"
-		" -r, --read-only               setup read-only loop device\n"
-		"     --show                    print device name after setup (with -f)\n"
-		" -v, --verbose                 verbose mode\n"), out);
+	fputs(_(" -l, --list                    list info about all or specified\n"), out);
+	fputs(_(" -o, --offset <num>            start at offset <num> into file\n"), out);
+	fputs(_(" -O, --output <cols>           specify columns to output for --list\n"), out);
+	fputs(_("     --sizelimit <num>         device limited to <num> bytes of the file\n"), out);
+	fputs(_(" -P, --partscan                create partitioned loop device\n"), out);
+	fputs(_(" -r, --read-only               setup read-only loop device\n"), out);
+	fputs(_("     --show                    print device name after setup (with -f)\n"), out);
+	fputs(_(" -v, --verbose                 verbose mode\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
-- 
1.8.1.1

