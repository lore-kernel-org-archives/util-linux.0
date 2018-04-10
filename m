Return-Path: util-linux-owner@vger.kernel.org
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58119 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753450AbeDJMgm (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 10 Apr 2018 08:36:42 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 05C22213DC
        for <util-linux@vger.kernel.org>; Tue, 10 Apr 2018 08:36:42 -0400 (EDT)
Received: from apu2 (x4e37ce4a.dyn.telefonica.de [78.55.206.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6EF561040B
        for <util-linux@vger.kernel.org>; Tue, 10 Apr 2018 08:36:41 -0400 (EDT)
From: Patrick Steinhardt <ps@pks.im>
To: util-linux@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/2] rfkill: include <poll.h> instead of <sys/poll.h>
Date: Tue, 10 Apr 2018 13:36:32 +0100
Message-Id: <af6e65d6bc794b0135019e998426b4339b848959.1523363782.git.ps@pks.im>
In-Reply-To: <b96441d34412526f7d55da793c6bb2dd05f152c2.1523363782.git.ps@pks.im>
References: <b96441d34412526f7d55da793c6bb2dd05f152c2.1523363782.git.ps@pks.im>
In-Reply-To: <b96441d34412526f7d55da793c6bb2dd05f152c2.1523363782.git.ps@pks.im>
References: <b96441d34412526f7d55da793c6bb2dd05f152c2.1523363782.git.ps@pks.im>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The POSIX standard states that poll(3P) is being made available by
<poll.h>, not <sys/poll.h>. Most commands already include the correct
header, with the exception of rfkill. Fix that to avoid a warning on
musl-based systems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sys-utils/rfkill.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/rfkill.c b/sys-utils/rfkill.c
index 211316ce7..9c52fac3a 100644
--- a/sys-utils/rfkill.c
+++ b/sys-utils/rfkill.c
@@ -24,7 +24,7 @@
 #include <getopt.h>
 #include <libsmartcols.h>
 #include <linux/rfkill.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <sys/syslog.h>
 #include <sys/time.h>
 
-- 
2.17.0

