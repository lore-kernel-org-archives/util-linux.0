Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35341 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbaK3N6K (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 30 Nov 2014 08:58:10 -0500
Received: by mail-wg0-f42.google.com with SMTP id z12so12089500wgg.1
        for <util-linux@vger.kernel.org>; Sun, 30 Nov 2014 05:58:09 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 05/10] fdisk: (sgi) fix unsigned integer overflow [AddressSanitizer]
Date: Sun, 30 Nov 2014 13:57:37 +0000
Message-Id: <1417355862-16935-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

include/pt-sgi.h:103:7: runtime error: unsigned integer overflow: 0 -
1186450447 cannot be represented in type 'unsigned int'

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/pt-sgi.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/pt-sgi.h b/include/pt-sgi.h
index 15f355b..547b37a 100644
--- a/include/pt-sgi.h
+++ b/include/pt-sgi.h
@@ -99,8 +99,10 @@ static inline uint32_t sgi_pt_checksum(struct sgi_disklabel *label)
 
 	i = sizeof(*label) / sizeof(*ptr);
 
-	while (i--)
+	while (i) {
+		i--;
 		sum -= be32_to_cpu(ptr[i]);
+	}
 
 	return sum;
 }
-- 
2.1.3

