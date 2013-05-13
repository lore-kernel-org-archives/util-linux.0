Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp3-g21.free.fr ([212.27.42.3]:43244 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753554Ab3EMOw6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 May 2013 10:52:58 -0400
From: Gilles Espinasse <g.esp@free.fr>
To: util-linux@vger.kernel.org
Cc: Gilles Espinasse <g.esp@free.fr>
Subject: [PATCH] util-linux: tests new warning fix
Date: Mon, 13 May 2013 16:52:28 +0200
Message-Id: <1368456748-12202-1-git-send-email-g.esp@free.fr>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

2.23 added -Wstrict-prototypes check. Fix make check showing
CC tests/helpers/test_md5.o
tests/helpers/test_md5.c:8: warning: function declaration isn't a prototype

Signed-off-by: Gilles Espinasse <g.esp@free.fr>
---
 tests/helpers/test_md5.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tests/helpers/test_md5.c b/tests/helpers/test_md5.c
index 0f37afd..44f6a93 100644
--- a/tests/helpers/test_md5.c
+++ b/tests/helpers/test_md5.c
@@ -4,7 +4,7 @@
 
 #include "md5.h"
 
-int main()
+int main(void)
 {
 	int i, ret;
 	struct MD5Context ctx;
-- 
1.7.2.5

