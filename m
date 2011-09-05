Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ww0-f42.google.com ([74.125.82.42]:41927 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686Ab1IEUDB (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Sep 2011 16:03:01 -0400
Received: by wwe5 with SMTP id 5so222840wwe.1
        for <util-linux@vger.kernel.org>; Mon, 05 Sep 2011 13:03:00 -0700 (PDT)
From: Peter Korsgaard <jacmet@sunsite.dk>
To: util-linux@vger.kernel.org, kerolasa@iki.fi
Cc: Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATCH] script.c: drop libintl.h include
Date: Mon,  5 Sep 2011 22:02:55 +0200
Message-Id: <1315252976-4394-1-git-send-email-jacmet@sunsite.dk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Commit 8fb810ff26 (script: include-what-you-use header check) added a
<libintl.h> #include, which isn't needed as nls.h includes it (if
enabled) - But worse, breaks the build for systems without libintl.h
(like some uClibc configurations).

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 term-utils/script.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index d96ca2f..f708e91 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -55,7 +55,6 @@
 #include <getopt.h>
 #include <unistd.h>
 #include <fcntl.h>
-#include <libintl.h>
 #include <limits.h>
 #include <locale.h>
 #include <stddef.h>
-- 
1.7.5.4

