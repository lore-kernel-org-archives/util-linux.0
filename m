Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:60704 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758233AbbBHUVg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Feb 2015 15:21:36 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/4] cfdisk: do not startle the user with a false message when --zero is used
Date: Sun,  8 Feb 2015 21:21:28 +0100
Message-Id: <1423426891-1887-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index d4e533f..79bbbd5 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -1774,8 +1774,9 @@ static int ui_create_label(struct cfdisk *cf)
 	}
 
 	erase();
-	ui_center(ui_lines - 4,
-		_("Device does not contain a recognized partition table."));
+	if (!cf->zero_start)
+		ui_center(ui_lines - 4,
+			_("Device does not contain a recognized partition table."));
 	ui_center(ui_lines - 3,
 		_("Select a type to create a new label or press 'L' to load script file."));
 
-- 
1.7.0.4

