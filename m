Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:49560 "EHLO
	cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754883AbbGYPTG (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 25 Jul 2015 11:19:06 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/5] cfdisk: bring the hint line closer to the menu line
Date: Sat, 25 Jul 2015 17:18:16 +0200
Message-Id: <1437837498-23833-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1437837498-23833-1-git-send-email-bensberg@justemail.net>
References: <1437837498-23833-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

To make it clearer that they belong together.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index 5e46136..ddec7f4 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -94,7 +94,7 @@
 #define MENU_H_POSTSTR_SZ	(sizeof(MENU_H_POSTSTR) - 1)
 
 #define TABLE_START_LINE	4
-#define MENU_START_LINE		(ui_lines - 5)
+#define MENU_START_LINE		(ui_lines - 3)
 #define INFO_LINE		(ui_lines - 2)
 #define WARN_LINE		INFO_LINE
 #define HINT_LINE		(ui_lines - 1)
-- 
1.7.0.4

