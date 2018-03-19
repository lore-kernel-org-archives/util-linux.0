Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38510 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752603AbeCSKbf (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 19 Mar 2018 06:31:35 -0400
Received: by mail-wr0-f193.google.com with SMTP id l8so18006150wrg.5
        for <util-linux@vger.kernel.org>; Mon, 19 Mar 2018 03:31:35 -0700 (PDT)
From: Carlo Caione <carlo@caione.org>
To: util-linux@vger.kernel.org, linux@endlessm.com
Cc: Carlo Caione <carlo@endlessm.com>
Subject: [PATCH] lib/randutils: Do not block on getrandom()
Date: Mon, 19 Mar 2018 10:31:07 +0000
Message-Id: <20180319103107.14517-1-carlo@caione.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Carlo Caione <carlo@endlessm.com>

In Endless we have hit a problem when using 'sfdisk' on the really first
boot to automatically expand the rootfs partition. On this platform
'sfdisk' is blocking on getrandom() because not enough random bytes are
available. This is an ARM platform without a hwrng.

We fix this passing GRND_NONBLOCK to getrandom(). 'sfdisk' will use the
best entropy it has available and fallback only as necessary.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 lib/randutils.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/randutils.c b/lib/randutils.c
index e1c4059e1..02c3d9eb0 100644
--- a/lib/randutils.c
+++ b/lib/randutils.c
@@ -36,6 +36,8 @@
 
 #if !defined(HAVE_GETRANDOM) && defined(SYS_getrandom)
 /* libc without function, but we have syscal */
+#define GRND_NONBLOCK 0x01
+#define GRND_RANDOM 0x02
 static int getrandom(void *buf, size_t buflen, unsigned int flags)
 {
 	return (syscall(SYS_getrandom, buf, buflen, flags));
@@ -104,13 +106,15 @@ void random_get_bytes(void *buf, size_t nbytes)
 		int x;
 
 		errno = 0;
-		x = getrandom(cp, n, 0);
+		x = getrandom(cp, n, GRND_NONBLOCK);
 		if (x > 0) {			/* success */
 		       n -= x;
 		       cp += x;
 		       lose_counter = 0;
 		} else if (errno == ENOSYS)	/* kernel without getrandom() */
 			break;
+		else if (errno == EAGAIN)
+			break;
 		else if (lose_counter++ > 16)	/* entropy problem? */
 			break;
 	}
-- 
2.14.1

