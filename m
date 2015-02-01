Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:51203 "EHLO
	cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751605AbbBAOBT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Feb 2015 09:01:19 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/8] lib/strutils: accept not just 'B' but also lowercase 'b' in a size suffix
Date: Sun,  1 Feb 2015 15:00:10 +0100
Message-Id: <1422799213-16717-5-git-send-email-bensberg@justemail.net>
In-Reply-To: <1422799213-16717-1-git-send-email-bensberg@justemail.net>
References: <1422799213-16717-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Just line 'M' and 'm' are accepted for mega, 'G' and 'g' for giga,
'S' and 's' for sectors, and so on.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 lib/strutils.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/strutils.c b/lib/strutils.c
index 9fe9481..c4f9600 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -101,9 +101,9 @@ int parse_size(const char *str, uintmax_t *res, int *power)
 	 * Check size suffixes
 	 */
 check_suffix:
-	if (*(p + 1) == 'i' && *(p + 2) == 'B' && !*(p + 3))
+	if (*(p + 1) == 'i' && (*(p + 2) == 'B' || *(p + 2) == 'b') && !*(p + 3))
 		base = 1024;			/* XiB, 2^N */
-	else if (*(p + 1) == 'B' && !*(p + 2))
+	else if ((*(p + 1) == 'B' || *(p + 1) == 'b') && !*(p + 2))
 		base = 1000;			/* XB, 10^N */
 	else if (*(p + 1)) {
 		struct lconv const *l = localeconv();
-- 
1.7.0.4

