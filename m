Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34855 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbbF1Tnd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Jun 2015 15:43:33 -0400
Received: by wiga1 with SMTP id a1so54693394wig.0
        for <util-linux@vger.kernel.org>; Sun, 28 Jun 2015 12:43:32 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/7] cal: fix memory leaks [valgrind]
Date: Sun, 28 Jun 2015 20:43:21 +0100
Message-Id: <1435520605-4296-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1435520605-4296-1-git-send-email-kerolasa@iki.fi>
References: <1435520605-4296-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 548e567..a39c0cd 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -518,6 +518,9 @@ int main(int argc, char **argv)
 	else
 		monthly(&ctl);
 
+#if defined(HAVE_LIBNCURSES) || defined(HAVE_LIBNCURSESW) || defined(HAVE_LIBTERMCAP)
+        del_curterm(cur_term);
+#endif
 	return EXIT_SUCCESS;
 }
 
-- 
2.4.4

