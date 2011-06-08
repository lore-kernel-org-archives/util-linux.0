Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60681 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763Ab1FHWxo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 8 Jun 2011 18:53:44 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so829962iwn.19
        for <util-linux@vger.kernel.org>; Wed, 08 Jun 2011 15:53:44 -0700 (PDT)
From: Josiah Worcester <josiahw@gmail.com>
To: util-linux@vger.kernel.org
Cc: Josiah Worcester <josiahw@gmail.com>
Subject: [PATCH 4/6] lib/tt.c: Fix mbs_width macro for systems without WIDECHAR
Date: Wed,  8 Jun 2011 16:52:46 -0600
Message-Id: <1307573568-23643-5-git-send-email-josiahw@gmail.com>
In-Reply-To: <1307573568-23643-1-git-send-email-josiahw@gmail.com>
References: <1307573568-23643-1-git-send-email-josiahw@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Josiah Worcester <josiahw@gmail.com>
---
 lib/tt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/tt.c b/lib/tt.c
index 7cbbce3..1929a48 100644
--- a/lib/tt.c
+++ b/lib/tt.c
@@ -52,7 +52,7 @@ static const struct tt_symbols utf8_tt_symbols = {
 };
 
 #else /* !HAVE_WIDECHAR */
-# define mbs_width       strlen(_s)
+# define mbs_width(_s)       strlen(_s)
 #endif /* !HAVE_WIDECHAR */
 
 #define is_last_column(_tb, _cl) \
-- 
1.7.5.3

