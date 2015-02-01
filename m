Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:53306 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751605AbbBAOBN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Feb 2015 09:01:13 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/8] cfdisk: make '?' an alias of 'h', to also show the help screen
Date: Sun,  1 Feb 2015 15:00:09 +0100
Message-Id: <1422799213-16717-4-git-send-email-bensberg@justemail.net>
In-Reply-To: <1422799213-16717-1-git-send-email-bensberg@justemail.net>
References: <1422799213-16717-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index eb3141b..8658ff2 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -1924,6 +1924,7 @@ static int main_menu_action(struct cfdisk *cf, int key)
 		ref = 1;
 		break;
 	case 'h': /* Help */
+	case '?':
 		ui_help();
 		ref = 1;
 		break;
-- 
1.7.0.4

