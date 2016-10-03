Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([217.72.192.75]:56479 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbcJCUEh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 3 Oct 2016 16:04:37 -0400
Received: from localhost ([79.234.34.66]) by mrelayeu.kundenserver.de
 (mreue101) with ESMTPSA (Nemesis) id 0LqlM2-1bCqqB416w-00eNwl for
 <util-linux@vger.kernel.org>; Mon, 03 Oct 2016 22:04:34 +0200
Date: Mon, 3 Oct 2016 22:05:46 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] rev: Avoid calling free in a signal handler
Message-ID: <20161003200546.GB2287@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

free() is not a safe function for a signal handler. The next
line calls _exit() anyway, so there is no need for resource
management.
---
 text-utils/rev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/text-utils/rev.c b/text-utils/rev.c
index cb38482..ace2cd6 100644
--- a/text-utils/rev.c
+++ b/text-utils/rev.c
@@ -68,7 +68,6 @@ wchar_t *buf;
 
 static void sig_handler(int signo __attribute__ ((__unused__)))
 {
-	free(buf);
 	_exit(EXIT_SUCCESS);
 }
 
-- 
2.10.0

