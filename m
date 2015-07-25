Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:50882 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754961AbbGYPS4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 25 Jul 2015 11:18:56 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/5] cfdisk: spell "label" in lower case
Date: Sat, 25 Jul 2015 17:18:15 +0200
Message-Id: <1437837498-23833-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1437837498-23833-1-git-send-email-bensberg@justemail.net>
References: <1437837498-23833-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

To be less shouty.  It is not an abbreviation like "UUID".

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index ac07bb5..5e46136 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -1338,7 +1338,7 @@ static void extra_prepare_data(struct cfdisk *cf)
 			if (!blkid_probe_lookup_value(pr, "TYPE", &bdata, NULL))
 				extra_insert_pair(l, _("Filesystem:"), bdata);
 			if (!blkid_probe_lookup_value(pr, "LABEL", &bdata, NULL)) {
-				extra_insert_pair(l, _("Filesystem LABEL:"), bdata);
+				extra_insert_pair(l, _("Filesystem label:"), bdata);
 				devlabel = xstrdup(bdata);
 			}
 			if (!blkid_probe_lookup_value(pr, "UUID", &bdata, NULL)) {
-- 
1.7.0.4

