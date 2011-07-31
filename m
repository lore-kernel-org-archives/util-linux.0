Return-Path: util-linux-owner@vger.kernel.org
Received: from vostochny.stro.at ([78.47.22.85]:37131 "EHLO vostochny.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829Ab1GaKqk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 31 Jul 2011 06:46:40 -0400
From: maximilian attems <max@stro.at>
To: util-linux@vger.kernel.org
Cc: maximilian attems <max@stro.at>
Subject: [PATCH 2/3] c.h: Include stdlib.h unconditionaly
Date: Sun, 31 Jul 2011 12:47:20 +0200
Message-Id: <1312109241-13590-2-git-send-email-max@stro.at>
In-Reply-To: <1312109241-13590-1-git-send-email-max@stro.at>
References: <1312109241-13590-1-git-send-email-max@stro.at>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

No point in hiding it down in an ifdef maze,
as it may get used by exit(3).

Signed-off-by: maximilian attems <max@stro.at>
---
 include/c.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/c.h b/include/c.h
index 79581ae..a9cd1f3 100644
--- a/include/c.h
+++ b/include/c.h
@@ -9,6 +9,7 @@
 #include <stdint.h>
 #include <stdio.h>
 #include <stdarg.h>
+#include <stdlib.h>
 #include <string.h>
 #include <errno.h>
 
@@ -109,7 +110,6 @@ extern char *__progname;
 #  define program_invocation_short_name __progname
 # else
 #  ifdef HAVE_GETEXECNAME
-#   include <stdlib.h>
 #   define program_invocation_short_name \
 		prog_inv_sh_nm_from_file(getexecname(), 0)
 #  else
-- 
1.7.5.4

