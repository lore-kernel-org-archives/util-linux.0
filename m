Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f50.google.com ([74.125.83.50]:35631 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096Ab3GGTzI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:55:08 -0400
Received: by mail-ee0-f50.google.com with SMTP id d49so2355612eek.23
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:55:07 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/34] hexdump: use unlocked io, and avoid use of printf()
Date: Sun,  7 Jul 2013 20:54:19 +0100
Message-Id: <1373226889-3451-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This makes common cases about 35-50% quicker.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/display.c   | 11 ++++++-----
 text-utils/hexsyntax.c |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/text-utils/display.c b/text-utils/display.c
index 41ddd8d..21a59c2 100644
--- a/text-utils/display.c
+++ b/text-utils/display.c
@@ -39,6 +39,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include "unlocked-io.h"
 #include "hexdump.h"
 #include "xalloc.h"
 #include "c.h"
@@ -110,13 +111,13 @@ print(PR *pr, unsigned char *bp) {
 		break;
 	    }
 	case F_P:
-		(void)printf(pr->fmt, isprint(*bp) ? *bp : '.');
+		putchar(isprint(*bp) ? *bp : '.');
 		break;
 	case F_STR:
 		(void)printf(pr->fmt, (char *)bp);
 		break;
 	case F_TEXT:
-		(void)printf("%s", pr->fmt);
+		fputs(pr->fmt, stdout);
 		break;
 	case F_U:
 		conv_u(pr, bp);
@@ -213,7 +214,7 @@ void display(void)
 				(void)printf(pr->fmt, (int64_t)eaddress);
 				break;
 			case F_TEXT:
-				(void)printf("%s", pr->fmt);
+				fputs(pr->fmt, stdout);
 				break;
 			}
 	}
@@ -250,7 +251,7 @@ get(void)
 			if (!need && vflag != ALL &&
 			    !memcmp(curp, savp, nread)) {
 				if (vflag != DUP)
-					(void)printf("*\n");
+					fputs("*\n", stdout);
 				return(NULL);
 			}
 			if (need > 0)
@@ -281,7 +282,7 @@ get(void)
 				return(curp);
 			}
 			if (vflag == WAIT)
-				(void)printf("*\n");
+				fputs("*\n", stdout);
 			vflag = DUP;
 			address += blocksize;
 			need = blocksize;
diff --git a/text-utils/hexsyntax.c b/text-utils/hexsyntax.c
index 2910ca5..a97ce11 100644
--- a/text-utils/hexsyntax.c
+++ b/text-utils/hexsyntax.c
@@ -43,6 +43,7 @@
 #include <err.h>
 #include <limits.h>
 #include <getopt.h>
+#include "unlocked-io.h"
 #include "hexdump.h"
 #include "nls.h"
 #include "strutils.h"
-- 
1.8.3.2

