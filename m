Return-Path: elseifthen@gmx.com
Subject: [v2 PATCH 2/5] lib/timeutils: ISO_8601_BUFSIZ too small
To: Karel Zak <kzak@redhat.com>
References: <1a28a73d-2e05-7071-479a-af5a18fade3b@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <6fda58f1-77a4-b1fd-58e4-3aedbb88e22e@gmx.com>
Date: Sun, 12 Nov 2017 10:24:28 -0500
MIME-Version: 1.0
In-Reply-To: <1a28a73d-2e05-7071-479a-af5a18fade3b@gmx.com>
Content-Type: text/plain; charset=windows-1252
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
