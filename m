Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f181.google.com ([209.85.215.181]:33984 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3GGTzc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:55:32 -0400
Received: by mail-ea0-f181.google.com with SMTP id a15so2534363eae.12
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:55:31 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/34] lib/mbsalign: initializations values are never read [clang-analyzer]
Date: Sun,  7 Jul 2013 20:54:27 +0100
Message-Id: <1373226889-3451-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/mbsalign.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/mbsalign.c b/lib/mbsalign.c
index e420fea..89ef032 100644
--- a/lib/mbsalign.c
+++ b/lib/mbsalign.c
@@ -254,8 +254,8 @@ mbsalign_unibyte:
   if (dest_size != 0)
     {
       char *dest_end = dest + dest_size - 1;
-      size_t start_spaces = n_spaces / 2 + n_spaces % 2;
-      size_t end_spaces = n_spaces / 2;
+      size_t start_spaces;
+      size_t end_spaces;
 
       switch (align)
         {
-- 
1.8.3.2

