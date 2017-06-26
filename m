Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:53787 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751308AbdFZSaA (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 26 Jun 2017 14:30:00 -0400
Received: from adsiz.fritz.box ([146.52.24.88]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MW9TR-1dEFBI27A1-00XM7T for
 <util-linux@vger.kernel.org>; Mon, 26 Jun 2017 20:29:53 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/6] misc: revert to the old USAGE_HELP strings
Date: Mon, 26 Jun 2017 20:29:47 +0200
Message-Id: <20170626182952.15988-2-sweet_f_a@gmx.de>
In-Reply-To: <20170626182952.15988-1-sweet_f_a@gmx.de>
References: <20170626182952.15988-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This reverts the include/c.h part of cc7cb070.

As discussed on ml. Our current strings are imported from
coreutils and not too bad. Also the old strings are still
hardcoded at many places.

So let's revert the change, then consolidate these strings
really everywhere and then think again whether and how we
should change them.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 include/c.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/c.h b/include/c.h
index 3e5b87d3f..fe46b8c2d 100644
--- a/include/c.h
+++ b/include/c.h
@@ -315,8 +315,8 @@ static inline int xusleep(useconds_t usec)
 #define USAGE_COMMANDS   _("\nCommands:\n")
 #define USAGE_COLUMNS    _("\nAvailable output columns:\n")
 #define USAGE_SEPARATOR    "\n"
-#define USAGE_HELP       _(" -h, --help     display help information and exit\n")
-#define USAGE_VERSION    _(" -V, --version  display version information and exit\n")
+#define USAGE_HELP       _(" -h, --help     display this help and exit\n")
+#define USAGE_VERSION    _(" -V, --version  output version information and exit\n")
 #define USAGE_MAN_TAIL(_man)   _("\nFor more details see %s.\n"), _man
 
 #define UTIL_LINUX_VERSION _("%s from %s\n"), program_invocation_short_name, PACKAGE_STRING
-- 
2.12.3

