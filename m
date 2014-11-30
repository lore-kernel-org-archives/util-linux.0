Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49375 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbaK3N5y (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 30 Nov 2014 08:57:54 -0500
Received: by mail-wi0-f172.google.com with SMTP id n3so22164969wiv.11
        for <util-linux@vger.kernel.org>; Sun, 30 Nov 2014 05:57:53 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 01/10] lib/mbalign: fix unsigned integer overflow [AddressSanitizer]
Date: Sun, 30 Nov 2014 13:57:33 +0000
Message-Id: <1417355862-16935-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This error was reported 155 times.

lib/mbsalign.c:322:18: runtime error: unsigned integer overflow: 0 - 1
cannot be represented in type 'size_t' (aka 'unsigned long')

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/mbsalign.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/mbsalign.c b/lib/mbsalign.c
index b307d19..052fec6 100644
--- a/lib/mbsalign.c
+++ b/lib/mbsalign.c
@@ -319,7 +319,7 @@ mbs_align_pad (char *dest, const char* dest_end, size_t n_spaces)
 {
   /* FIXME: Should we pad with "figure space" (\u2007)
      if non ascii data present?  */
-  while (n_spaces-- && (dest < dest_end))
+  for (/* nothing */; n_spaces && (dest < dest_end); n_spaces--)
     *dest++ = ' ';
   *dest = '\0';
   return dest;
-- 
2.1.3

