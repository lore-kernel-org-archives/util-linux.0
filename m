Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.17.24]:49380 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938791AbcIHTTE (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 8 Sep 2016 15:19:04 -0400
Received: from localhost ([79.234.34.60]) by mrelayeu.kundenserver.de
 (mreue103) with ESMTPSA (Nemesis) id 0Lp9KG-1b5QeG0QHE-00eprw for
 <util-linux@vger.kernel.org>; Thu, 08 Sep 2016 21:19:00 +0200
Date: Thu, 8 Sep 2016 21:19:22 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] text-utils/ul: Fix buffer overflow
Message-ID: <20160908191922.GA18991@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The text-utility ul can run into a buffer overflow on very long lines.
See this proof of concept how to reproduce the issue:

$ dd if=/dev/zero bs=1M count=10 | tr '\000' '\041' > poc.txt
$ echo -ne '\xe\x5f\x8\x5f\x61\x2\xf\x5f\x8\x5f' | dd of=poc.txt conv=notrunc
$ ul -i poc.txt > /dev/null # output would take ages
Segmentation fault
$ _

The problem manifests by using alloca with "maxcol", which can be as
large as INT_MAX, based on the input line.

A very long line (> 8 MB) with modes must be supplied to ul, as seen in
my proof of concept byte sequence above.

It is rather easy to fix this issue: allocate space on the heap instead.
maxcol could overflow here, but in that case no system will have enough
space to handle the request, properly ending ul through an err() call.


Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
---
 text-utils/ul.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/text-utils/ul.c b/text-utils/ul.c
index 6721974..3fd0b6a 100644
--- a/text-utils/ul.c
+++ b/text-utils/ul.c
@@ -402,11 +402,7 @@ static void flushln(void)
 static void overstrike(void)
 {
 	register int i;
-#ifdef __GNUC__
-	register wchar_t *lbuf = __builtin_alloca((maxcol + 1) * sizeof(wchar_t));
-#else
-	wchar_t lbuf[BUFSIZ];
-#endif
+	register wchar_t *lbuf = xmalloc((maxcol + 1) * sizeof(wchar_t));
 	register wchar_t *cp = lbuf;
 	int hadbold=0;
 
@@ -439,16 +435,13 @@ static void overstrike(void)
 		for (cp = lbuf; *cp; cp++)
 			putwchar(*cp == '_' ? ' ' : *cp);
 	}
+	free(lbuf);
 }
 
 static void iattr(void)
 {
 	register int i;
-#ifdef __GNUC__
-	register wchar_t *lbuf = __builtin_alloca((maxcol+1)*sizeof(wchar_t));
-#else
-	wchar_t lbuf[BUFSIZ];
-#endif
+	register wchar_t *lbuf = xmalloc((maxcol + 1) * sizeof(wchar_t));
 	register wchar_t *cp = lbuf;
 
 	for (i = 0; i < maxcol; i++)
@@ -465,6 +458,7 @@ static void iattr(void)
 		*cp = 0;
 	fputws(lbuf, stdout);
 	putwchar('\n');
+	free(lbuf);
 }
 
 static void initbuf(void)
-- 
2.10.0

