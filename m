Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:52662 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbaD0UGW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Apr 2014 16:06:22 -0400
Received: by mail-wg0-f47.google.com with SMTP id n12so2369351wgh.30
        for <util-linux@vger.kernel.org>; Sun, 27 Apr 2014 13:06:21 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/12] lib/timeutils: fix memory leak
Date: Sun, 27 Apr 2014 21:05:37 +0100
Message-Id: <1398629138-31718-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/timeutils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/timeutils.c b/lib/timeutils.c
index c1b632e..d542c2f 100644
--- a/lib/timeutils.c
+++ b/lib/timeutils.c
@@ -239,6 +239,7 @@ int parse_timestamp(const char *t, usec_t *usec)
 			return -ENOMEM;
 
 		r = parse_sec(z, &minus);
+		free(z);
 		if (r < 0)
 			return r;
 
-- 
1.9.2

