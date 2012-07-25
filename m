Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34399 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627Ab2GYTQI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:16:08 -0400
Received: by mail-wi0-f170.google.com with SMTP id hq12so4797543wib.1
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:16:08 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 19/19] more: add noreturn function attribute
Date: Wed, 25 Jul 2012 21:15:40 +0200
Message-Id: <1343243745-1172-23-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 5e41a54..58c99cc 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -755,7 +755,8 @@ void chgwinsz(int dummy __attribute__ ((__unused__)))
 ** Clean up terminal state and exit. Also come here if interrupt signal received
 */
 
-void end_it (int dummy __attribute__ ((__unused__)))
+void __attribute__((__noreturn__))
+end_it (int dummy __attribute__ ((__unused__)))
 {
     reset_tty ();
     if (clreol) {
-- 
1.7.11.3

