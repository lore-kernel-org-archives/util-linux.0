Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34831 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754654AbcKJK7R (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 10 Nov 2016 05:59:17 -0500
Received: by mail-wm0-f66.google.com with SMTP id a20so2340042wme.2
        for <util-linux@vger.kernel.org>; Thu, 10 Nov 2016 02:59:16 -0800 (PST)
Subject: [PATCH 01/12] Fix typo in page cross reference (capabilities(7), not,
 capability(7))
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <bda22bd7-a108-f6c8-04b1-ecab7ba82084@gmail.com>
Cc: mtk.manpages@gmail.com
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <ccd6a4da-efa8-d103-fc4e-c3aab1287f43@gmail.com>
Date: Thu, 10 Nov 2016 11:59:14 +0100
MIME-Version: 1.0
In-Reply-To: <bda22bd7-a108-f6c8-04b1-ecab7ba82084@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 sys-utils/setpriv.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index 4aaaa63..9fec20c 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -150,7 +150,7 @@ restrictions from taking effect.
 .BR su (1),
 .BR runuser (1),
 .BR prctl (2),
-.BR capability (7)
+.BR capabilities (7)
 .SH AUTHOR
 .MT luto@amacapital.net
 Andy Lutomirski
-- 
2.5.5


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
