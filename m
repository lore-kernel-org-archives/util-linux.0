Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f49.google.com ([209.85.218.49]:32811 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbcGNHQf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 14 Jul 2016 03:16:35 -0400
Received: by mail-oi0-f49.google.com with SMTP id j185so98907593oih.0
        for <util-linux@vger.kernel.org>; Thu, 14 Jul 2016 00:16:34 -0700 (PDT)
MIME-Version: 1.0
From: Allon Mureinik <amureini@redhat.com>
Date: Thu, 14 Jul 2016 10:16:33 +0300
Message-ID: <CADgXf3xQ4BWV9biePfvtPW=ERK6eMzWTwjm2zr1kATX-j2JybA@mail.gmail.com>
Subject: [PATCH] Improve blkdiscard man page
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>From cf44055e61be0b7a4af470a3d6d57f27989d03f0 Mon Sep 17 00:00:00 2001
From: Allon Mureinik <amureini@redhat.com>
Date: Thu, 14 Jul 2016 10:01:29 +0300
Subject: [PATCH] Improve blkdiscard man page

Improve the grammar and phrasing of the --verbose option and how it
interacts with the --step option.

Signed-off-by: Allon Mureinik <amureini@redhat.com>
---
 sys-utils/blkdiscard.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/blkdiscard.8 b/sys-utils/blkdiscard.8
index 71180e9..da3d6cb 100644
--- a/sys-utils/blkdiscard.8
+++ b/sys-utils/blkdiscard.8
@@ -65,7 +65,7 @@ Display the aligned values of
 .I offset
 and
 .IR length .
-If the option \fB\-\-step\fR specified than it prints discard
progress every second.
+If the \fB\-\-step\fR option is specified, it prints the discard
progress every second.
 .TP
 .BR \-V , " \-\-version"
 Display version information and exit.
-- 
2.7.4
