Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38440 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933166AbbHISTU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Aug 2015 14:19:20 -0400
Received: by wibxm9 with SMTP id xm9so123363337wib.1
        for <util-linux@vger.kernel.org>; Sun, 09 Aug 2015 11:19:18 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/3] colcrt: allocate enough space for data moves [afl & asan]
Date: Sun,  9 Aug 2015 19:19:06 +0100
Message-Id: <1439144346-5647-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1439144346-5647-1-git-send-email-kerolasa@iki.fi>
References: <1439144346-5647-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

==2807==ERROR: AddressSanitizer: global-buffer-overflow on address 0x0000013a31f0 at pc 0x0000004e3047 bp 0x7fffcb7df8d0 sp 0x7fffcb7df8c8
READ of size 4 at 0x0000013a31f0 thread T0
    #0 0x4e3046 in move /home/src/util-linux/text-utils/colcrt.c:309:13
    #1 0x4e25b1 in pflush /home/src/util-linux/text-utils/colcrt.c:264:3
    #2 0x4e246d in colcrt /home/src/util-linux/text-utils/colcrt.c:157:4
    #3 0x4e17d4 in main /home/src/util-linux/text-utils/colcrt.c:141:3
    #4 0x7fb0cb2ee60f in __libc_start_main (/usr/lib/libc.so.6+0x2060f)
    #5 0x4362c8 in _start (/home/src/util-linux/colcrt+0x4362c8)

0x0000013a31f0 is located 0 bytes to the right of global variable 'page' defined in 'text-utils/colcrt.c:73:9' (0x1380b40) of size 140976
SUMMARY: AddressSanitizer: global-buffer-overflow /home/src/util-linux/text-utils/colcrt.c:309 move

And another crash:

==4578==ERROR: AddressSanitizer: global-buffer-overflow on address 0x0000013a3d24 at pc 0x0000004e2510 bp 0x7ffc9257b0e0 sp 0x7ffc9257b0d8
READ of size 4 at 0x0000013a3d24 thread T0
    #0 0x4e250f in colcrt /home/src/util-linux/text-utils/colcrt.c:218:8
    #1 0x4e17d4 in main /home/src/util-linux/text-utils/colcrt.c:141:3
    #2 0x7fe0ac94160f in __libc_start_main (/usr/lib/libc.so.6+0x2060f)
    #3 0x4362c8 in _start (/home/src/util-linux/colcrt+0x4362c8)

0x0000013a3d24 is located 8 bytes to the right of global variable 'page' defined in 'text-utils/colcrt.c:73:9' (0x1381240) of size 142044
SUMMARY: AddressSanitizer: global-buffer-overflow /home/src/util-linux/text-utils/colcrt.c:218 colcrt

Reported-by: Alaa Mubaied <alaamubaied@gmail.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/colcrt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/text-utils/colcrt.c b/text-utils/colcrt.c
index 3cf25cb..be7f847 100644
--- a/text-utils/colcrt.c
+++ b/text-utils/colcrt.c
@@ -71,7 +71,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out);
 #define FLUSH_SIZE 62
 #define PAGE_ARRAY_ROWS 267
 #define PAGE_ARRAY_COLS 132
-wchar_t	page[PAGE_ARRAY_ROWS][PAGE_ARRAY_COLS];
+wchar_t	page[PAGE_ARRAY_ROWS + 1][PAGE_ARRAY_COLS + 1];
 
 int	outline = 1;
 int	outcol;
-- 
2.5.0

