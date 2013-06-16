Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f176.google.com ([74.125.82.176]:58560 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755360Ab3FPSyw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Jun 2013 14:54:52 -0400
Received: by mail-we0-f176.google.com with SMTP id t56so1724760wes.7
        for <util-linux@vger.kernel.org>; Sun, 16 Jun 2013 11:54:51 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 15/15] hexdump: use simple printing functions when possible
Date: Sun, 16 Jun 2013 19:53:56 +0100
Message-Id: <1371408836-16663-16-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This makes common cases 35-50% quicker.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/display.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/text-utils/display.c b/text-utils/display.c
index 41ddd8d..7698965 100644
--- a/text-utils/display.c
+++ b/text-utils/display.c
@@ -110,13 +110,13 @@ print(PR *pr, unsigned char *bp) {
 		break;
 	    }
 	case F_P:
-		(void)printf(pr->fmt, isprint(*bp) ? *bp : '.');
+		putchar_unlocked(isprint(*bp) ? *bp : '.');
 		break;
 	case F_STR:
 		(void)printf(pr->fmt, (char *)bp);
 		break;
 	case F_TEXT:
-		(void)printf("%s", pr->fmt);
+		fputs_unlocked(pr->fmt, stdout);
 		break;
 	case F_U:
 		conv_u(pr, bp);
@@ -213,7 +213,7 @@ void display(void)
 				(void)printf(pr->fmt, (int64_t)eaddress);
 				break;
 			case F_TEXT:
-				(void)printf("%s", pr->fmt);
+				fputs_unlocked(pr->fmt, stdout);
 				break;
 			}
 	}
@@ -250,7 +250,7 @@ get(void)
 			if (!need && vflag != ALL &&
 			    !memcmp(curp, savp, nread)) {
 				if (vflag != DUP)
-					(void)printf("*\n");
+					fputs_unlocked("*\n", stdout);
 				return(NULL);
 			}
 			if (need > 0)
@@ -281,7 +281,7 @@ get(void)
 				return(curp);
 			}
 			if (vflag == WAIT)
-				(void)printf("*\n");
+				fputs_unlocked("*\n", stdout);
 			vflag = DUP;
 			address += blocksize;
 			need = blocksize;
-- 
1.8.3.1

