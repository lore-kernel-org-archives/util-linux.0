Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:52765 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965454AbcCPI4p (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Mar 2016 04:56:45 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/8] libfdisk: (gpt) reword two error messages with a sense of direction
Date: Wed, 16 Mar 2016 09:55:51 +0100
Message-Id: <1458118555-4691-4-git-send-email-bensberg@justemail.net>
In-Reply-To: <1458118555-4691-1-git-send-email-bensberg@justemail.net>
References: <1458118555-4691-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 libfdisk/src/gpt.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index 2b2f519..39c93bb 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -1745,14 +1745,14 @@ static int gpt_set_partition(struct fdisk_context *cxt, size_t n,
 
 	if (!FDISK_IS_UNDEF(start)) {
 		if (start < le64_to_cpu(gpt->pheader->first_usable_lba)) {
-			fdisk_warnx(cxt, _("The begin of the partition overflows FirstUsableLBA."));
+			fdisk_warnx(cxt, _("The start of the partition understeps FirstUsableLBA."));
 			return -EINVAL;
 		}
 		e->lba_start = cpu_to_le64(start);
 	}
 	if (!FDISK_IS_UNDEF(end)) {
 		if (end > le64_to_cpu(gpt->pheader->last_usable_lba)) {
-			fdisk_warnx(cxt, _("The end of the partition overflows LastUsableLBA."));
+			fdisk_warnx(cxt, _("The end of the partition oversteps LastUsableLBA."));
 			return -EINVAL;
 		}
 		e->lba_end = cpu_to_le64(end);
-- 
1.7.0.4

