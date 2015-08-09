Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38384 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933143AbbHISTM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Aug 2015 14:19:12 -0400
Received: by wibxm9 with SMTP id xm9so123361382wib.1
        for <util-linux@vger.kernel.org>; Sun, 09 Aug 2015 11:19:11 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/3] colcrt: avoid writing beyond array bound [afl & asan]
Date: Sun,  9 Aug 2015 19:19:05 +0100
Message-Id: <1439144346-5647-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1439144346-5647-1-git-send-email-kerolasa@iki.fi>
References: <1439144346-5647-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

text-utils/colcrt.c:205:10: runtime error: index -1 out of bounds for type 'wchar_t [133]'
SUMMARY: AddressSanitizer: undefined-behavior text-utils/colcrt.c:205
=================================================================
==2357==ERROR: AddressSanitizer: global-buffer-overflow on address 0x0000013811b0 at pc 0x0000004e2514 bp 0x7ffdf6ba4450 sp 0x7ffdf6ba4448
READ of size 4 at 0x0000013811b0 thread T0
    #0 0x4e2513 in colcrt /home/src/util-linux/text-utils/colcrt.c:213:8
    #1 0x4e17d4 in main /home/src/util-linux/text-utils/colcrt.c:139:3
    #2 0x7fb77236960f in __libc_start_main (/usr/lib/libc.so.6+0x2060f)
    #3 0x4362c8 in _start (/home/src/util-linux/colcrt+0x4362c8)

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/colcrt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/text-utils/colcrt.c b/text-utils/colcrt.c
index cf630c4..3cf25cb 100644
--- a/text-utils/colcrt.c
+++ b/text-utils/colcrt.c
@@ -201,6 +201,8 @@ void colcrt(FILE *f) {
 			/* fallthrough */
 		default:
 			w = wcwidth(c);
+			if (w < 0)
+				continue;
 			if (outcol + w > PAGE_ARRAY_COLS) {
 				outcol++;
 				continue;
-- 
2.5.0

