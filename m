Return-Path: util-linux-owner@vger.kernel.org
Received: from lizzard.sbs.de ([194.138.37.39]:19122 "EHLO lizzard.sbs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755564Ab1KPKLm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Nov 2011 05:11:42 -0500
Received: from mail2.sbs.de (localhost [127.0.0.1])
	by lizzard.sbs.de (8.13.6/8.13.6) with ESMTP id pAG9t507017267
	for <util-linux@vger.kernel.org>; Wed, 16 Nov 2011 10:55:06 +0100
Received: from [149.212.26.78] ([149.212.26.78])
	by mail2.sbs.de (8.13.6/8.13.6) with ESMTP id pAG9t5GO026282
	for <util-linux@vger.kernel.org>; Wed, 16 Nov 2011 10:55:05 +0100
Subject: [PATCH] agetty: map NL to CR-NL on output in initial termios
 settings
From: Dennis Jensen <dennis.h.jensen@siemens.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Nov 2011 10:54:50 +0100
Message-ID: <1321437290.29540.75.camel@djensen-laptop>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This fixes situations where messages "scroll horizontally", making
them unreadable, because agetty has opened and initialized the
terminal.

From: Jacoby Hickerson <hickersonjl@gmail.com>
Signed-off-by: Dennis Jensen <dennis.h.jensen@siemens.com>
---
 term-utils/agetty.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 041e1f7..27edac5 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -1091,7 +1091,8 @@ static void termio_init(struct options *op, struct termios *tp)
 #else
 	tp->c_iflag = 0;
 #endif
-	tp->c_lflag = tp->c_oflag = 0;
+	tp->c_lflag = 0;
+	tp->c_oflag = OPOST | ONLCR;
 
 	if ((op->flags & F_KEEPCFLAGS) == 0)
 		tp->c_cflag = CS8 | HUPCL | CREAD | (tp->c_cflag & CLOCAL);
-- 
1.7.0.4



