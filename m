Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:63323 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab2GYTP5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:15:57 -0400
Received: by mail-we0-f174.google.com with SMTP id x8so794233wey.19
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:15:56 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/19] eject: fix shadow declaration
Date: Wed, 25 Jul 2012 21:15:28 +0200
Message-Id: <1343243745-1172-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

sys-utils/eject.c:529:11: warning: declaration of 'str' shadows a previous local [-Wshadow]
sys-utils/eject.c:506:9: warning: shadowed declaration is here [-Wshadow]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/eject.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index c8bb6a8..08af08e 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -526,7 +526,6 @@ static int read_speed(const char *devname)
 		} else {
 			if (strncmp(line, "drive speed:", 12) == 0) {
 				int i;
-				char *str;
 
 				str = strtok(&line[12], "\t ");
 				for (i = 1; i < drive_number; i++)
-- 
1.7.11.3

