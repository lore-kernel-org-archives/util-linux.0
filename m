Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37776 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbaJOVTo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 15 Oct 2014 17:19:44 -0400
Received: by mail-wi0-f174.google.com with SMTP id h11so11139107wiw.13
        for <util-linux@vger.kernel.org>; Wed, 15 Oct 2014 14:19:43 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/4] setterm: fix dubious one-bit signed bitfield [smatch scan]
Date: Wed, 15 Oct 2014 22:19:26 +0100
Message-Id: <1413407968-2289-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1413407968-2289-1-git-send-email-kerolasa@iki.fi>
References: <1413407968-2289-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

term-utils/setterm.c:165:24: error: dubious one-bit signed bitfield

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index f21466e..fefb0a9 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -162,9 +162,10 @@ struct setterm_control {
 	/* colors */
 	int opt_fo_color:4, opt_ba_color:4, opt_ul_color:4, opt_hb_color:4;
 	/* boolean options */
-	int opt_cu_on:1, opt_li_on:1, opt_bo_on:1, opt_hb_on:1, opt_bl_on:1,
-	    opt_re_on:1, opt_un_on:1, opt_rep_on:1, opt_appck_on:1,
-	    opt_invsc_on:1, opt_msg_on:1, opt_cl_all:1, vcterm:1;
+	unsigned int opt_cu_on:1, opt_li_on:1, opt_bo_on:1, opt_hb_on:1,
+	    opt_bl_on:1, opt_re_on:1, opt_un_on:1, opt_rep_on:1,
+	    opt_appck_on:1, opt_invsc_on:1, opt_msg_on:1, opt_cl_all:1,
+	    vcterm:1;
 	/* Option flags.  Set when an option is invoked. */
 	uint64_t opt_term:1, opt_reset:1, opt_initialize:1, opt_cursor:1,
 	    opt_linewrap:1, opt_default:1, opt_foreground:1,
-- 
2.1.2

