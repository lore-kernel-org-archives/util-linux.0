Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:60549 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753658AbaIVUP6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Sep 2014 16:15:58 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 03/10] textual: use a somewhat clearer and more standard failure message
Date: Mon, 22 Sep 2014 22:15:33 +0200
Message-Id: <1411416940-3249-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
References: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 login-utils/newgrp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/login-utils/newgrp.c b/login-utils/newgrp.c
index 9c0f8f5..23904fe 100644
--- a/login-utils/newgrp.c
+++ b/login-utils/newgrp.c
@@ -63,7 +63,7 @@ static char *xgetpass(FILE *input, const char *prompt)
 		if (tcsetattr(fd, TCSANOW, &saved))
 			err(EXIT_FAILURE, _("could not set terminal attributes"));
 	if (len < 0)
-		err(EXIT_FAILURE, _("could not getline"));
+		err(EXIT_FAILURE, _("getline() failed"));
 	if (0 < len && *(pass + len - 1) == '\n')
 		*(pass + len - 1) = '\0';
 	return pass;
-- 
1.7.0.4

