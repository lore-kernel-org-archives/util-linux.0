Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:57053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751308AbdFZSaB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 26 Jun 2017 14:30:01 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: J William Piggott <elseifthen@gmx.com>
Subject: [PATCH 6/6] misc: update --help content again
Date: Mon, 26 Jun 2017 20:29:52 +0200
Message-Id: <20170626182952.15988-7-sweet_f_a@gmx.de>
In-Reply-To: <20170626182952.15988-1-sweet_f_a@gmx.de>
References: <20170626182952.15988-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

We change

 -h, --help     display this help and exit
 -V, --version  output version information and exit

to

 -h, --help     display this help
 -V, --version  print version

Some thoughts about this:

  * use "display" for --help because it matches better if we
    would add pager support (like git --help)
  * "print" for --version to be different
  * "this" for --help is important to make clear that running
    --help would not give you any better information than the
    one you see already
  * remove "information and exit" because it's bloat for the
    short-help, everybody knows what it does if it exists

In the manpages we should use the old, longer but more correct
descriptions, inclusive a reminder if --help/--version are only
working when used as the only option. Note the term "version
information" indicates that we don't only print a single version
number.

CC: J William Piggott <elseifthen@gmx.com>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 include/c.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/c.h b/include/c.h
index ce5551535..be7e6fd53 100644
--- a/include/c.h
+++ b/include/c.h
@@ -316,8 +316,8 @@ static inline int xusleep(useconds_t usec)
 #define USAGE_COLUMNS    _("\nAvailable output columns:\n")
 #define USAGE_SEPARATOR    "\n"
 
-#define USAGE_HELP_TXT    _("display this help and exit")
-#define USAGE_VERSION_TXT _("output version information and exit")
+#define USAGE_HELP_TXT    _("display this help")
+#define USAGE_VERSION_TXT _("print version")
 
 #define PRINT_USAGE_HELP(marg_dsc) \
 	printf( \
-- 
2.12.3

