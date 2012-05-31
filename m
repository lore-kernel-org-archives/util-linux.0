Return-Path: util-linux-owner@vger.kernel.org
Received: from vostochny.stro.at ([78.47.22.85]:56370 "EHLO vostochny.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522Ab2EaRk5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 31 May 2012 13:40:57 -0400
From: maximilian attems <max@stro.at>
To: util-linux@vger.kernel.org
Cc: maximilian attems <max@stro.at>
Subject: [PATCH] lib/strutils: circumvent missing localeconv()
Date: Thu, 31 May 2012 19:40:49 +0200
Message-Id: <1338486050-7490-1-git-send-email-max@stro.at>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add stub too nls.h, include it instead of locale.h.
Code in strutils handles already returned NULL.

Signed-off-by: maximilian attems <max@stro.at>
---
 include/nls.h  |    6 ++++++
 lib/strutils.c |    2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/nls.h b/include/nls.h
index 9a9311b..3eabfe6 100644
--- a/include/nls.h
+++ b/include/nls.h
@@ -12,6 +12,12 @@ int main(int argc, char *argv[]);
 #else
 # undef setlocale
 # define setlocale(Category, Locale) /* empty */
+struct lconv
+{
+	char *decimal_point;
+};
+# undef localeconv
+# define localeconv() NULL
 #endif
 
 #ifdef ENABLE_NLS
diff --git a/lib/strutils.c b/lib/strutils.c
index 6bdc01d..036ae06 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -9,10 +9,10 @@
 #include <ctype.h>
 #include <errno.h>
 #include <sys/stat.h>
-#include <locale.h>
 #include <string.h>
 
 #include "c.h"
+#include "nls.h"
 #include "strutils.h"
 #include "bitops.h"
 
-- 
1.7.10

