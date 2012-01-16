Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60187 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab2APFgS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 16 Jan 2012 00:36:18 -0500
Received: by eaac11 with SMTP id c11so88352eaa.19
        for <util-linux@vger.kernel.org>; Sun, 15 Jan 2012 21:36:17 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 2/2] fdisk: fix last sector dialog bug after an incorrect input with suffix
Date: Mon, 16 Jan 2012 06:36:13 +0100
Message-Id: <1326692173-11791-2-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1326692173-11791-1-git-send-email-cosoleto@gmail.com>
References: <1326692173-11791-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If user input in a last sector dialog was out of range and with suffix, and if
this was followed by accepting the default value, then the used last sector was
erroneously default - 1.

Reported-by: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 764798d..cb67fd3 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -1303,6 +1303,7 @@ read_int_with_suffix(unsigned int low, unsigned int dflt, unsigned int high,
 {
 	unsigned int res;
 	int default_ok = 1;
+	int absolute = 0;
 	static char *ms = NULL;
 	static size_t mslen = 0;
 
@@ -1331,9 +1332,9 @@ read_int_with_suffix(unsigned int low, unsigned int dflt, unsigned int high,
 
 		if (*line_ptr == '+' || *line_ptr == '-') {
 			int minus = (*line_ptr == '-');
-			int absolute = 0;
 			int suflen;
 
+			absolute = 0;
 			res = atoi(line_ptr + 1);
 
 			while (isdigit(*++line_ptr))
@@ -1400,8 +1401,6 @@ read_int_with_suffix(unsigned int low, unsigned int dflt, unsigned int high,
 				bytes += unit/2;	/* round */
 				bytes /= unit;
 				res = bytes;
-				if (is_suffix_used)
-					*is_suffix_used = absolute;
 			}
 			if (minus)
 				res = -res;
@@ -1413,13 +1412,17 @@ read_int_with_suffix(unsigned int low, unsigned int dflt, unsigned int high,
 				use_default = 0;
 			}
 		}
-		if (use_default)
-			printf(_("Using default value %u\n"), res = dflt);
+		if (use_default) {
+			printf(_("Using default value %u\n"), dflt);
+			return dflt;
+		}
 		if (res >= low && res <= high)
 			break;
 		else
 			printf(_("Value out of range.\n"));
 	}
+	if (is_suffix_used)
+			*is_suffix_used = absolute > 0;
 	return res;
 }
 
-- 
1.7.7

