Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:56247 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753658AbaIVUP4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Sep 2014 16:15:56 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 02/10] textual: "ambivalent" applies to intentions, "ambiguous" to results
Date: Mon, 22 Sep 2014 22:15:32 +0200
Message-Id: <1411416940-3249-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
References: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 lib/swapprober.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/swapprober.c b/lib/swapprober.c
index 39697c5..5a4b112 100644
--- a/lib/swapprober.c
+++ b/lib/swapprober.c
@@ -29,7 +29,7 @@ blkid_probe get_swap_prober(const char *devname)
 	if (rc == -1)
 		warn(_("%s: unable to probe device"), devname);
 	else if (rc == -2)
-		warnx(_("%s: ambivalent probing result, use wipefs(8)"), devname);
+		warnx(_("%s: ambiguous probing result; use wipefs(8)"), devname);
 	else if (rc == 1)
 		warnx(_("%s: not a valid swap partition"), devname);
 
-- 
1.7.0.4

