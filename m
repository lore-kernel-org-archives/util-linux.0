Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:64529 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754954AbbGYPSd (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 25 Jul 2015 11:18:33 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/5] cfdisk: allow an uppercase X to toggle the extra info
Date: Sat, 25 Jul 2015 17:18:14 +0200
Message-Id: <1437837498-23833-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

To make true the help text line that says that all commands
can be entered with either upper or lower case.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index 11a087e..ac07bb5 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -2519,6 +2519,7 @@ static int ui_run(struct cfdisk *cf)
 		case '\r':
 			rc = main_menu_action(cf, 0);
 			break;
+		case 'X':
 		case 'x': /* Extra */
 			toggle_show_extra(cf);
 			break;
-- 
1.7.0.4

