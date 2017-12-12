Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752011AbdLLHQs (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 12 Dec 2017 02:16:48 -0500
From: Masatake YAMATO <yamato@redhat.com>
To: util-linux@vger.kernel.org
Cc: yamato@redhat.com
Subject: [PATCH] man: fix a typo in fincore.1
Date: Tue, 12 Dec 2017 16:16:45 +0900
Message-Id: <20171212071645.17676-1-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 misc-utils/fincore.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/fincore.1 b/misc-utils/fincore.1
index 1625bf68d..30e292cc8 100644
--- a/misc-utils/fincore.1
+++ b/misc-utils/fincore.1
@@ -56,7 +56,7 @@ Masatake YAMATO
 .BR getpagesize (2),
 .BR getconf (1)
 .SH AVAILABILITY
-The example command is part of the util-linux package and is available from
+The fincore command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
 Linux Kernel Archive
 .UE .
-- 
2.13.6

