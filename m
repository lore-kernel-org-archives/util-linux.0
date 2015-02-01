Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34067 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865AbbBAWmI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Feb 2015 17:42:08 -0500
Received: by mail-wi0-f175.google.com with SMTP id fb4so13103206wid.2
        for <util-linux@vger.kernel.org>; Sun, 01 Feb 2015 14:42:06 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/2] more: fix get_line() indentation
Date: Sun,  1 Feb 2015 22:41:54 +0000
Message-Id: <1422830524-4483-1-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1422649129.1189198.221115417.2D352E5C@webmail.messagingengine.com>
References: <1422649129.1189198.221115417.2D352E5C@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 72 +++++++++++++++++++++++++++----------------------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 75426e9..15ebb91 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -997,47 +997,45 @@ int get_line(register FILE *f, int *length)
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
+			}
+		}
 #endif	/* HAVE_WIDECHAR */
-			{
-				if (isprint(c))
-					column++;
-				else {
-					column -= 4;
-					if (column < 0)
-						column = 0;
-				}
+		else {
+			if (isprint(c))
+				column++;
+			else {
+				column -= 4;
+				if (column < 0)
+					column = 0;
 			}
 		}
-
 		if (column >= Mcol && fold_opt)
 			break;
 #ifdef HAVE_WIDECHAR
-- 
2.2.2

