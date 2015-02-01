Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:63359 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751605AbbBAOBB (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Feb 2015 09:01:01 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/8] cfdisk: improve wording and consistency of the size warnings
Date: Sun,  1 Feb 2015 15:00:07 +0100
Message-Id: <1422799213-16717-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1422799213-16717-1-git-send-email-bensberg@justemail.net>
References: <1422799213-16717-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index f1d4745..f414f55 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -1533,7 +1533,7 @@ static int ui_get_size(struct cfdisk *cf, const char *prompt, uintmax_t *res,
 			if (insec)
 				user *= fdisk_get_sector_size(cf->cxt);
 			if (user < low) {
-				ui_warnx(_("Minimal size is %ju"), low);
+				ui_warnx(_("Minimum size is %ju bytes."), low);
 				rc = -ERANGE;
 			}
 			if (user > up && pwr && user < up + (1ULL << pwr * 10))
@@ -1542,7 +1542,7 @@ static int ui_get_size(struct cfdisk *cf, const char *prompt, uintmax_t *res,
 				user = up;
 
 			if (user > up) {
-				ui_warnx(_("Maximal size is %ju bytes."), up);
+				ui_warnx(_("Maximum size is %ju bytes."), up);
 				rc = -ERANGE;
 			}
 			if (rc == 0 && insec && expsize)
-- 
1.7.0.4

