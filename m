Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32972 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755262AbcKJK74 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 10 Nov 2016 05:59:56 -0500
Received: by mail-wm0-f68.google.com with SMTP id u144so2347795wmu.0
        for <util-linux@vger.kernel.org>; Thu, 10 Nov 2016 02:59:55 -0800 (PST)
Subject: [PATCH 08/12] Replace reference to sigvec(2) with sigaction(2)
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <404e11c0-9f88-b460-7398-d00585a9bf16@gmail.com>
Cc: mtk.manpages@gmail.com
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <22456ae2-1acd-3cb3-72eb-026adb039997@gmail.com>
Date: Thu, 10 Nov 2016 11:59:53 +0100
MIME-Version: 1.0
In-Reply-To: <404e11c0-9f88-b460-7398-d00585a9bf16@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The sigvec(3) (not sigvec(2)) page documents ancient BSD APIs.
The right page to cross reference here is sigaction(2),
which documents the modern POSIX APIs.

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 misc-utils/kill.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/kill.1 b/misc-utils/kill.1
index d0626bf..d638ead 100644
--- a/misc-utils/kill.1
+++ b/misc-utils/kill.1
@@ -145,7 +145,7 @@ partial success (when more than one process specified)
 .SH SEE ALSO
 .BR bash (1),
 .BR tcsh (1),
-.BR sigvec (2),
+.BR sigaction (2),
 .BR kill (2),
 .BR signal (7)
 
-- 
2.5.5

