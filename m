Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:63180 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935672Ab3DHTeD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Apr 2013 15:34:03 -0400
Received: by mail-wi0-f172.google.com with SMTP id hr17so2949130wib.5
        for <util-linux@vger.kernel.org>; Mon, 08 Apr 2013 12:34:01 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/14] docs: mount.8: make propagation flags adjustable [checkmans.sh]
Date: Mon,  8 Apr 2013 20:32:54 +0100
Message-Id: <1365449579-13238-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
References: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/mount.8 | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 4538605..72f0f0b 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -506,7 +506,14 @@ after previous successful mount operation. Note that this use case is not
 atomic. The propagation flags is possible to specify in
 .BR fstab (5)
 as mount options
-(private,slave,shared,unbindable,rprivate,rslave,rshared,runbindable).
+.RI ( private ,
+.IR slave ,
+.IR shared ,
+.IR unbindable ,
+.IR rprivate ,
+.IR rslave ,
+.IR rshared ,
+.IR runbindable ).
 
 For example
 .RS
-- 
1.8.2.1

