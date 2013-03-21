Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:61686 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977Ab3CUVrc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 21 Mar 2013 17:47:32 -0400
Received: by mail-wi0-f177.google.com with SMTP id hm14so3659766wib.16
        for <util-linux@vger.kernel.org>; Thu, 21 Mar 2013 14:47:31 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/2] blkid: use xalloc.h when possible
Date: Thu, 21 Mar 2013 21:47:14 +0000
Message-Id: <1363902435-1487-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/blkid.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 78e0a93..fd27da7 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -49,6 +49,7 @@ extern int optind;
 
 #include "closestream.h"
 #include "ttyutils.h"
+#include "xalloc.h"
 
 const char *progname = "blkid";
 
@@ -703,8 +704,8 @@ int main(int argc, char **argv)
 			break;
 		case 'L':
 			eval++;
-			search_value = strdup(optarg);
-			search_type = strdup("LABEL");
+			search_value = xstrdup(optarg);
+			search_type = xstrdup("LABEL");
 			break;
 		case 'n':
 			fltr_type = list_to_types(optarg, &fltr_flag);
@@ -714,8 +715,8 @@ int main(int argc, char **argv)
 			break;
 		case 'U':
 			eval++;
-			search_value = strdup(optarg);
-			search_type = strdup("UUID");
+			search_value = xstrdup(optarg);
+			search_type = xstrdup("UUID");
 			break;
 		case 'i':
 			lowprobe |= LOWPROBE_TOPOLOGY;
-- 
1.8.2

