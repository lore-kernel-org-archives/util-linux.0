Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32834 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbdCSKR0 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 19 Mar 2017 06:17:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11so9774330wma.0
        for <util-linux@vger.kernel.org>; Sun, 19 Mar 2017 03:17:25 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 4/5] blkid: simplify version option handling
Date: Sun, 19 Mar 2017 10:10:44 +0000
Message-Id: <20170319101045.3018-5-kerolasa@iki.fi>
In-Reply-To: <20170319101045.3018-1-kerolasa@iki.fi>
References: <20170319101045.3018-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/blkid.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index cc29b5c6c..eb2ea0735 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -640,7 +640,6 @@ int main(int argc, char **argv)
 	char **fltr_type = NULL;
 	int fltr_flag = BLKID_FLTR_ONLYIN;
 	unsigned int numdev = 0, numtag = 0;
-	int version = 0;
 	int err = BLKID_EXIT_OTHER;
 	unsigned int i;
 	int output_format = 0;
@@ -757,8 +756,8 @@ int main(int argc, char **argv)
 			break;
 		case 'V':
 		case 'v':
-			version = 1;
-			break;
+			print_version(stdout);
+			goto exit;
 		case 'w':
 			/* ignore - backward compatibility */
 			break;
@@ -778,11 +777,6 @@ int main(int argc, char **argv)
 			devices[numdev++] = argv[optind++];
 	}
 
-	if (version) {
-		print_version(stdout);
-		goto exit;
-	}
-
 	/* convert LABEL/UUID lookup to evaluate request */
 	if (lookup && output_format == OUTPUT_DEVICE_ONLY && search_type &&
 	    (!strcmp(search_type, "LABEL") || !strcmp(search_type, "UUID"))) {
-- 
2.12.0

