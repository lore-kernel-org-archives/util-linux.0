Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:51112 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbbBVOop (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:45 -0500
Received: by mail-wg0-f47.google.com with SMTP id x12so21221590wgg.6
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:44 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 27/31] more: fix compiler warnings
Date: Sun, 22 Feb 2015 14:43:23 +0000
Message-Id: <1424616207-747-28-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Later appers when HAVE_WIDECHAR is not true.

warning: switch missing default case [-Wswitch-default]
warning: 'xmbrtowc' defined but not used [-Wunused-function]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/text-utils/more.c b/text-utils/more.c
index 7915e90..8cbc62f 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -306,6 +306,8 @@ static int check_magic(FILE *f, char *fs)
 			printf(_("\n******** %s: Not a text file ********\n\n"),
 			       fs);
 			return 1;
+		default:
+			break;
 		}
 	}
 	fseek(f, 0L, SEEK_SET);	/* rewind() not necessary */
@@ -592,6 +594,7 @@ static void erase_prompt(struct more_control *ctl, int col)
 	ctl->promptlen = 0;
 }
 
+#ifdef HAVE_WIDECHAR
 static UL_ASAN_BLACKLIST size_t xmbrtowc(wchar_t *wc, const char *s, size_t n,
 				  mbstate_t *mbstate)
 {
@@ -600,6 +603,7 @@ static UL_ASAN_BLACKLIST size_t xmbrtowc(wchar_t *wc, const char *s, size_t n,
 		return 1;
 	return mblength;
 }
+#endif
 
 static int would_underline(char *s, int n)
 {
-- 
2.3.0

