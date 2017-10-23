Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:53825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932158AbdJWAjo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 22 Oct 2017 20:39:44 -0400
Subject: [PATCH 2/4] lib/timeutils: ISO_8601_BUFSIZ too small
To: Karel Zak <kzak@redhat.com>
References: <ac1afb00-aed1-4eed-aabe-89d26e29ca0d@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <946b185d-2c3e-cb6d-f2ca-4a67274da256@gmx.com>
Date: Sun, 22 Oct 2017 20:39:37 -0400
MIME-Version: 1.0
In-Reply-To: <ac1afb00-aed1-4eed-aabe-89d26e29ca0d@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Although iso-8601 specifies years as 4 digits, it allows
them to be wider.

The current POSIX year width is limited by 'int tm_year'
at 10 digits plus a negative sign.

That, and the possibility of nanosecond time makes the
widest POSIX iso-8601 time 41 characters. Plus the \0
string terminator yields a buffer size of 42.

Before truncated output:
/sbin/hwclock --utc --noadjfile --predict --date '-2147483765 years'
-2147481748-09-25 20:29:45.0000

Patched:
./hwclock --utc --noadjfile --predict --date '-2147483765 years'
-2147481748-09-25 20:17:21.000000-0456

./hwclock --utc --noadjfile --predict --date '-2147483766 years'
hwclock: invalid date '-2147483766 years'

Comparable to coreutils 'date' command:
date -Ins --date '-2147483765 years'
-2147481748-09-25T19:49:31,578899297-0456

date -Ins --date '-2147483766 years'
date: invalid date '-2147483766 years'

The 'date' output illustrates the full 41 character POSIX iso-8601

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 include/timeutils.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/timeutils.h b/include/timeutils.h
index 874f853b7..edd42f7fe 100644
--- a/include/timeutils.h
+++ b/include/timeutils.h
@@ -65,7 +65,7 @@ enum {
 	ISO_8601_GMTIME		= (1 << 7)
 };
 
-#define ISO_8601_BUFSIZ	32
+#define ISO_8601_BUFSIZ	42
 
 int strtimeval_iso(struct timeval *tv, int flags, char *buf, size_t bufsz);
 int strtm_iso(struct tm *tm, int flags, char *buf, size_t bufsz);
