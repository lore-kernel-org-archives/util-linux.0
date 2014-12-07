Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38846 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087AbaLGKOG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Dec 2014 05:14:06 -0500
Received: by mail-wi0-f172.google.com with SMTP id n3so2287559wiv.17
        for <util-linux@vger.kernel.org>; Sun, 07 Dec 2014 02:14:04 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>,
        Frodo Looijaard <frodo@frodo.looijaard.name>
Subject: [PATCH 03/11] getopt: make nonoptions optstring comment correct
Date: Sun,  7 Dec 2014 10:13:47 +0000
Message-Id: <1417947235-24229-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
References: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>From manual page: 'If the first character of optstring is '-', then each
nonoption argv-element is handled as if it were the argument of an option
with character code 1.'

Reference: http://man7.org/linux/man-pages/man3/getopt.3.html
CC: Frodo Looijaard <frodo@frodo.looijaard.name>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/getopt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index c087e4a..d7918b1 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -67,8 +67,8 @@
 #include "nls.h"
 #include "xalloc.h"
 
-/* NON_OPT is the code that is returned when a non-option is found in '+'
- * mode */
+/* NON_OPT is the code that is returned getopt(3) when a non-option is
+ * found in 'char optstring[]="-abc...";', e.g., it begins by '-' */
 #define NON_OPT 1
 /* LONG_OPT is the code that is returned when a long option is found. */
 #define LONG_OPT 0
-- 
2.1.3

