Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f41.google.com ([74.125.82.41]:49823 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbaK3N6I (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 30 Nov 2014 08:58:08 -0500
Received: by mail-wg0-f41.google.com with SMTP id y19so12118684wgg.0
        for <util-linux@vger.kernel.org>; Sun, 30 Nov 2014 05:58:07 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 03/10] more: fix unsigned integer overflow [AddressSanitizer]
Date: Sun, 30 Nov 2014 13:57:35 +0000
Message-Id: <1417355862-16935-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

text-utils/more.c:1137:20: runtime error: unsigned integer overflow: 0 -
1 cannot be represented in type 'size_t' (aka 'unsigned long')
text-utils/more.c:1139:7: runtime error: unsigned integer overflow: 2 +
18446744073709551615 cannot be represented in type 'unsigned long'

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index a489953..4b03e0d 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1125,14 +1125,14 @@ void prbuf(register char *s, register int n)
 #ifdef HAVE_WIDECHAR
 			{
 				wchar_t wc;
-				size_t mblength;
+				ssize_t mblength;
 				mbstate_t mbstate;
 				memset(&mbstate, '\0', sizeof(mbstate_t));
 				s--;
 				n++;
 				mblength = mbrtowc(&wc, s, n, &mbstate);
-				if (mblength == (size_t)-2
-				    || mblength == (size_t)-1)
+				if (mblength == -2
+				    || mblength == -1)
 					mblength = 1;
 				while (mblength--)
 					putchar(*s++);
-- 
2.1.3

