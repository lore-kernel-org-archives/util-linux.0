Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:59544 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbbA3IyO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 30 Jan 2015 03:54:14 -0500
Received: by mail-wg0-f44.google.com with SMTP id z12so25663184wgg.3
        for <util-linux@vger.kernel.org>; Fri, 30 Jan 2015 00:54:13 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] more: fix control character display bug
Date: Fri, 30 Jan 2015 09:54:10 +0100
Message-Id: <1422608050-28600-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This removes isprint(c) column++ from get_line() that made underlining,
bold, and other control characters to cause more display to wrap lines
incorrectly.  Easiest way to see the difference is to run following
before and after compiling this change.

PAGER=./more man man

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 59 +++++++++++++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 94b0455..a8e9254 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -997,41 +997,36 @@ int get_line(register FILE *f, int *length)
 		} else if (c == EOF) {
 			*length = p - Line;
 			return (column);
-		} else {
+		}
 #ifdef HAVE_WIDECHAR
-			if (fold_opt && MB_CUR_MAX > 1) {
-				memset(mbc, '\0', MB_LEN_MAX);
-				mbc_pos = 0;
-				mbc[mbc_pos++] = c;
-				state_bak = state;
-
-				mblength = mbrtowc(&wc, mbc, mbc_pos, &state);
-				/* The value of mblength is always less than 2 here. */
-				switch (mblength) {
-				case (size_t)-2:
-					p--;
-					file_pos_bak = Ftell(f) - 1;
-					state = state_bak;
-					use_mbc_buffer_flag = 1;
-					break;
-
-				case (size_t)-1:
-					state = state_bak;
-					column++;
-					break;
-
-				default:
-					wc_width = wcwidth(wc);
-					if (wc_width > 0)
-						column += wc_width;
-				}
-			} else
-#endif	/* HAVE_WIDECHAR */
-			{
-				if (isprint(c))
-					column++;
+		else if (fold_opt && MB_CUR_MAX > 1) {
+			memset(mbc, '\0', MB_LEN_MAX);
+			mbc_pos = 0;
+			mbc[mbc_pos++] = c;
+			state_bak = state;
+
+			mblength = mbrtowc(&wc, mbc, mbc_pos, &state);
+			/* The value of mblength is always less than 2 here. */
+			switch (mblength) {
+			case (size_t)-2:
+				p--;
+				file_pos_bak = Ftell(f) - 1;
+				state = state_bak;
+				use_mbc_buffer_flag = 1;
+				break;
+
+			case (size_t)-1:
+				state = state_bak;
+				column++;
+				break;
+
+			default:
+				wc_width = wcwidth(wc);
+				if (wc_width > 0)
+					column += wc_width;
 			}
 		}
+#endif	/* HAVE_WIDECHAR */
 
 		if (column >= Mcol && fold_opt)
 			break;
-- 
2.2.2

