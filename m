Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:49380 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758233AbbBHUVq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Feb 2015 15:21:46 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/4] cfdisk: also recognize a lowercase 'l' for loading a script file
Date: Sun,  8 Feb 2015 21:21:29 +0100
Message-Id: <1423426891-1887-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1423426891-1887-1-git-send-email-bensberg@justemail.net>
References: <1423426891-1887-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index 79bbbd5..c861bc0 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -1806,6 +1806,7 @@ static int ui_create_label(struct cfdisk *cf)
 		case 'q':
 		case 'Q':
 			goto done;
+		case 'l':
 		case 'L':
 			ui_clean_hint();
 			ui_clean_info();
-- 
1.7.0.4

