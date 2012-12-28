Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:58595 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282Ab2L1Vse (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 28 Dec 2012 16:48:34 -0500
Received: by mail-wg0-f43.google.com with SMTP id e12so5007029wge.10
        for <util-linux@vger.kernel.org>; Fri, 28 Dec 2012 13:48:33 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/4] swapon: default to --show if nothing is requested
Date: Fri, 28 Dec 2012 21:23:42 +0000
Message-Id: <1356729823-729-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1356729823-729-1-git-send-email-kerolasa@iki.fi>
References: <1356729823-729-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Proposed-by: Karel Zak <kzak@redhat.com>
References: http://www.spinics.net/lists/util-linux-ng/msg07301.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/swapon.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 176be42..7310767 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -786,7 +786,7 @@ int main(int argc, char *argv[])
 	}
 	argv += optind;
 
-	if (show) {
+	if (show || (!all && !numof_labels() && !numof_uuids() && *argv == NULL)) {
 		if (!ncolumns) {
 			/* default columns */
 			columns[ncolumns++] = COL_PATH;
@@ -799,9 +799,6 @@ int main(int argc, char *argv[])
 		return status;
 	}
 
-	if (!all && !numof_labels() && !numof_uuids() && *argv == NULL)
-		usage(stderr);
-
 	if (ifexists && !all)
 		usage(stderr);
 
-- 
1.8.0.3

