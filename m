Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f53.google.com ([74.125.82.53]:45577 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197AbbBVOoO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:14 -0500
Received: by mail-wg0-f53.google.com with SMTP id a1so21138504wgh.12
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:13 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 10/31] more: avoid long else segment in prbuf()
Date: Sun, 22 Feb 2015 14:43:06 +0000
Message-Id: <1424616207-747-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The if segment can be ended to 'continue' to allow nicer indentation.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 90 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 46 insertions(+), 44 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 651a34e..c8b28a1 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -601,56 +601,58 @@ static int wouldul(char *s, int n)
 /* Print a buffer of n characters */
 static void prbuf(struct more_control *ctl, char *s, int n)
 {
-	char c;	/* next output character */
-	int state;	/* next output char's UL state */
+	char c;			/* next output character */
+	int state;		/* next output char's UL state */
 
-	while (--n >= 0)
-		if (!ctl->ul_opt)
+	while (--n >= 0) {
+		if (!ctl->ul_opt) {
 			putchar(*s++);
-		else {
-			if (*s == ' ' && ctl->pstate == 0 && ctl->ulglitch
-			    && wouldul(s + 1, n - 1)) {
-				s++;
-				continue;
-			}
-			if ((state = wouldul(s, n)) != 0) {
-				c = (*s == '_') ? s[2] : *s;
-				n -= 2;
-				s += 3;
-			} else
-				c = *s++;
-			if (state != ctl->pstate) {
-				if (c == ' ' && state == 0 && ctl->ulglitch
-				    && wouldul(s, n - 1))
-					state = 1;
-				else
-					my_putstring(state ? ctl->ULenter : ctl->ULexit);
-			}
-			if (c != ' ' || ctl->pstate == 0 || state != 0
-			    || ctl->ulglitch == 0)
+			continue;
+		}
+		if (*s == ' ' && ctl->pstate == 0 && ctl->ulglitch
+		    && wouldul(s + 1, n - 1)) {
+			s++;
+			continue;
+		}
+		if ((state = wouldul(s, n)) != 0) {
+			c = (*s == '_') ? s[2] : *s;
+			n -= 2;
+			s += 3;
+		} else
+			c = *s++;
+		if (state != ctl->pstate) {
+			if (c == ' ' && state == 0 && ctl->ulglitch
+			    && wouldul(s, n - 1))
+				state = 1;
+			else
+				my_putstring(state ? ctl->ULenter : ctl->
+					     ULexit);
+		}
+		if (c != ' ' || ctl->pstate == 0 || state != 0
+		    || ctl->ulglitch == 0)
 #ifdef HAVE_WIDECHAR
-			{
-				wchar_t wc;
-				size_t mblength;
-				mbstate_t mbstate;
-
-				memset(&mbstate, 0, sizeof mbstate);
-				s--;
-				n++;
-				mblength = xmbrtowc(&wc, s, n, &mbstate);
-				while (mblength--)
-					putchar(*s++);
-				n += mblength;
-			}
+		{
+			wchar_t wc;
+			size_t mblength;
+			mbstate_t mbstate;
+
+			memset(&mbstate, 0, sizeof mbstate);
+			s--;
+			n++;
+			mblength = xmbrtowc(&wc, s, n, &mbstate);
+			while (mblength--)
+				putchar(*s++);
+			n += mblength;
+		}
 #else
-				putchar(c);
+			putchar(c);
 #endif				/* HAVE_WIDECHAR */
-			if (state && *ctl->chUL) {
-				fputs(ctl->chBS, stdout);
-				my_putstring(ctl->chUL);
-			}
-			ctl->pstate = state;
+		if (state && *ctl->chUL) {
+			fputs(ctl->chBS, stdout);
+			my_putstring(ctl->chUL);
 		}
+		ctl->pstate = state;
+	}
 }
 
 /* Erase the current line entirely */
-- 
2.3.0

