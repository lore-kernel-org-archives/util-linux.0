Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35294 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752819AbdEISK5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 9 May 2017 14:10:57 -0400
Received: by mail-wr0-f194.google.com with SMTP id g12so2130170wrg.2
        for <util-linux@vger.kernel.org>; Tue, 09 May 2017 11:10:57 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/5] lib/mbsedit: fix typo in comment
Date: Tue,  9 May 2017 19:10:48 +0100
Message-Id: <20170509181052.3610-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/mbsedit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/mbsedit.c b/lib/mbsedit.c
index 2f322aacd..d464358fc 100644
--- a/lib/mbsedit.c
+++ b/lib/mbsedit.c
@@ -1,6 +1,6 @@
 /*
  * Very simple multibyte buffer editor. Allows to maintaine the current
- * possition in the string, add and remove chars on the current possition.
+ * position in the string, add and remove chars on the current position.
  *
  * This file may be distributed under the terms of the
  * GNU Lesser General Public License.
-- 
2.12.2

