Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60108 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755136Ab1F1Knh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Jun 2011 06:43:37 -0400
Received: by ewy4 with SMTP id 4so20605ewy.19
        for <util-linux@vger.kernel.org>; Tue, 28 Jun 2011 03:43:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/4] script: include-what-you-use header check
Date: Tue, 28 Jun 2011 12:43:25 +0200
Message-Id: <1309257806-1418-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1309257806-1418-1-git-send-email-kerolasa@iki.fi>
References: <1309257806-1418-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The tool proposed;

script.c should add these lines:

script.c should remove these lines:
- #include <sys/file.h>  // lines 53-53
- #include <sys/types.h>  // lines 48-48
- #include "c.h"  // lines 61-61

and the change nearly did what the tool told. We should keep on
using c.h, not err.h. The config.h is not needed, it's added
automaticly.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 601a91d..39bc5ef 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -45,17 +45,20 @@
 #include <stdlib.h>
 #include <paths.h>
 #include <time.h>
-#include <sys/types.h>
 #include <sys/stat.h>
 #include <termios.h>
 #include <sys/ioctl.h>
 #include <sys/time.h>
-#include <sys/file.h>
 #include <signal.h>
 #include <errno.h>
 #include <string.h>
 #include <getopt.h>
 #include <unistd.h>
+#include <fcntl.h>
+#include <libintl.h>
+#include <limits.h>
+#include <locale.h>
+#include <stddef.h>
 
 #include "nls.h"
 #include "c.h"
-- 
1.7.5.2

