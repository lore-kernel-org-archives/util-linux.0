Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:63170 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751605AbbBAOAs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Feb 2015 09:00:48 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/8] cfdisk: remove the mistaken B from the explanation of size suffixes
Date: Sun,  1 Feb 2015 15:00:06 +0100
Message-Id: <1422799213-16717-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also reword the explanation to be clearer.  It is not necessary to
be complete -- that is what the man page is for.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index 9455910..f1d4745 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -1507,8 +1507,8 @@ static int ui_get_size(struct cfdisk *cf, const char *prompt, uintmax_t *res,
 
 		snprintf(buf, sizeof(buf), "%s", dflt);
 		rc = ui_get_string(cf, prompt,
-				_("May be followed by {M,B,G,T}iB "
-				  "(the \"iB\" is optional) or S for sectors."),
+				_("May be followed by M for MiB, G for GiB, "
+				  "T for TiB, or S for sectors."),
 				buf, sizeof(buf));
 		if (rc == 0) {
 			ui_warnx(_("Please, specify size."));
-- 
1.7.0.4

