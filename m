Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:51103 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965454AbcCPI4z (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Mar 2016 04:56:55 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/8] logger: correct the grammar of an error message
Date: Wed, 16 Mar 2016 09:55:52 +0100
Message-Id: <1458118555-4691-5-git-send-email-bensberg@justemail.net>
In-Reply-To: <1458118555-4691-1-git-send-email-bensberg@justemail.net>
References: <1458118555-4691-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 misc-utils/logger.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 1ef12cd..b7b08eb 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -572,7 +572,7 @@ static void add_structured_data_param(struct list_head *ls, const char *param)
 	struct structured_data *sd;
 
 	if (list_empty(ls))
-		errx(EXIT_FAILURE, _("--sd-id no specified for --sd-param %s"), param);
+		errx(EXIT_FAILURE, _("--sd-id was not specified for --sd-param %s"), param);
 
 	assert(param);
 
-- 
1.7.0.4

