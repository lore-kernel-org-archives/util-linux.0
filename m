Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33445 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030Ab1I1O0V (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 28 Sep 2011 10:26:21 -0400
Received: by mail-ey0-f174.google.com with SMTP id 28so5673890eya.19
        for <util-linux@vger.kernel.org>; Wed, 28 Sep 2011 07:26:20 -0700 (PDT)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 3/3] ipcrm: fix wrong subject in error messages for -m, -q, -s id options
Date: Wed, 28 Sep 2011 16:25:31 +0200
Message-Id: <1317219931-20496-3-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1317219931-20496-1-git-send-email-cosoleto@gmail.com>
References: <1317219931-20496-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This makes error messages print 'id' instead of 'key' using id options.

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 sys-utils/ipcrm.c |   23 ++++++++---------------
 1 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index f6482ab..6f74107 100644
--- a/sys-utils/ipcrm.c
+++ b/sys-utils/ipcrm.c
@@ -323,52 +323,45 @@ int main(int argc, char **argv)
 		return EXIT_SUCCESS;
 
 	/* process new syntax to conform with SYSV ipcrm */
-	for (id = -1;
-	    (c = getopt_long(argc, argv, "q:m:s:Q:M:S:a::vhV", longopts, NULL)) != -1;
-	    id = -1) {
+	while((c = getopt_long(argc, argv, "q:m:s:Q:M:S:a::vhV", longopts, NULL)) != -1) {
+		iskey = 0;
 		switch (c) {
 		case 'M':
-			iskey = 0;
+			iskey = 1;
 			id = key_to_id(SHM, optarg);
 			if (id < 0) {
 				ret++;
 				break;
 			}
 		case 'm':
-			if (id < 0) {
-				iskey = 1;
+			if (!iskey)
 				id = strtoll_or_err(optarg, _("failed to parse argument"));
-			}
 			if (remove_id(SHM, iskey, id))
 				ret++;
 			break;
 		case 'Q':
-			iskey = 0;
+			iskey = 1;
 			id = key_to_id(MSG, optarg);
 			if (id < 0) {
 				ret++;
 				break;
 			}
 		case 'q':
-			if (id < 0) {
-				iskey = 1;
+			if (!iskey)
 				id = strtoll_or_err(optarg, _("failed to parse argument"));
-			}
 			if (remove_id(MSG, iskey, id))
 				ret++;
 			break;
 		case 'S':
-			iskey = 0;
+			iskey = 1;
 			id = key_to_id(SEM, optarg);
 			if (id < 0) {
 				ret++;
 				break;
 			}
 		case 's':
-			if (id < 0) {
-				iskey = 1;
+			if (!iskey)
 				id = strtoll_or_err(optarg, _("failed to parse argument"));
-			}
 			if (remove_id(SEM, iskey, id))
 				ret++;
 			break;
-- 
1.7.3.4

