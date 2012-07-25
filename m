Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34399 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab2GYTPz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:15:55 -0400
Received: by wibhq12 with SMTP id hq12so4797543wib.1
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:15:54 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/19] blkid: fix shadow declaration
Date: Wed, 25 Jul 2012 21:15:25 +0200
Message-Id: <1343243745-1172-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

misc-utils/blkid.c:402:15: warning: declaration of 'usage' shadows a global declaration [-Wshadow]
misc-utils/blkid.c:63:13: warning: shadowed declaration is here [-Wshadow]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/blkid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 579ad27..920f639 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -399,17 +399,17 @@ static int print_udev_ambivalent(blkid_probe pr)
 	int count = 0, rc = -1;
 
 	while (!blkid_do_probe(pr)) {
-		const char *usage = NULL, *type = NULL, *version = NULL;
+		const char *usage_txt = NULL, *type = NULL, *version = NULL;
 		char enc[256];
 
-		blkid_probe_lookup_value(pr, "USAGE", &usage, NULL);
+		blkid_probe_lookup_value(pr, "USAGE", &usage_txt, NULL);
 		blkid_probe_lookup_value(pr, "TYPE", &type, NULL);
 		blkid_probe_lookup_value(pr, "VERSION", &version, NULL);
 
-		if (!usage || !type)
+		if (!usage_txt || !type)
 			continue;
 
-		blkid_encode_string(usage, enc, sizeof(enc));
+		blkid_encode_string(usage_txt, enc, sizeof(enc));
 		if (append_str(&val, &valsz, enc, ":"))
 			goto done;
 
-- 
1.7.11.3

