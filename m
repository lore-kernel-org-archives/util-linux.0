Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32818 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754745AbcKJK7n (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 10 Nov 2016 05:59:43 -0500
Received: by mail-wm0-f67.google.com with SMTP id u144so2346796wmu.0
        for <util-linux@vger.kernel.org>; Thu, 10 Nov 2016 02:59:42 -0800 (PST)
Subject: [PATCH 05/12] Fix section number in lockf() page xref
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <404e11c0-9f88-b460-7398-d00585a9bf16@gmail.com>
Cc: mtk.manpages@gmail.com
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <4545fcaf-2621-ac58-6bd3-05f0f4271d7d@gmail.com>
Date: Thu, 10 Nov 2016 11:59:40 +0100
MIME-Version: 1.0
In-Reply-To: <404e11c0-9f88-b460-7398-d00585a9bf16@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

lockf() is in section 3, not 2.

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 misc-utils/lslocks.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/lslocks.8 b/misc-utils/lslocks.8
index 2be0a28..dd34ccd 100644
--- a/misc-utils/lslocks.8
+++ b/misc-utils/lslocks.8
@@ -90,7 +90,7 @@ Davidlohr Bueso <dave@gnu.org>
 .SH "SEE ALSO"
 .BR flock (1),
 .BR fcntl (2),
-.BR lockf (2)
+.BR lockf (3)
 
 .SH AVAILABILITY
 The lslocks command is part of the util-linux package and is available from
-- 
2.5.5

