Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f54.google.com ([74.125.83.54]:49804 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab3H0SGx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Aug 2013 14:06:53 -0400
Received: by mail-ee0-f54.google.com with SMTP id e53so2409762eek.41
        for <util-linux@vger.kernel.org>; Tue, 27 Aug 2013 11:06:52 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/17] wall: line wrap at column 79 also when line has tab chars
Date: Tue, 27 Aug 2013 19:06:08 +0100
Message-Id: <1377626779-26030-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier tabs caused random ragged right indentation, because the tab
length was assumed to be 1 char which is not the case most of the time.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/wall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/term-utils/wall.c b/term-utils/wall.c
index 451b5d3..fbea7e4 100644
--- a/term-utils/wall.c
+++ b/term-utils/wall.c
@@ -281,6 +281,8 @@ static char *makemsg(char *fname, char **mvec, int mvecsz,
 					putc('\n', fp);
 					cnt = 0;
 				}
+				if (ch == '\t')
+					cnt += (7 - (cnt % 8));
 				if (ch != '\n')
 					carefulputc(ch, fp, '^');
 			}
-- 
1.8.4

