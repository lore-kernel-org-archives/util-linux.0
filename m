Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yh0-f53.google.com ([209.85.213.53]:47762 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578Ab2LZTzm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 26 Dec 2012 14:55:42 -0500
Received: by mail-yh0-f53.google.com with SMTP id q11so1560338yhf.40
        for <util-linux@vger.kernel.org>; Wed, 26 Dec 2012 11:55:41 -0800 (PST)
From: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
Subject: [PATCH 2/2] bitops: support other OS too
Date: Wed, 26 Dec 2012 16:54:25 -0300
Message-Id: <1356551665-574-1-git-send-email-crrodriguez@opensuse.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mike Frysinger pointed that applying:

[PATCH] include/bitops.h: Use the operating system byteswapping
functions

Would cause incompatibilities with non-linux OS, this patch address
the concerns.
---
 configure.ac     |  3 +++
 include/bitops.h | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 9c08fc0..b3c30f5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -191,6 +191,9 @@ AC_CHECK_HEADERS([ \
 	stdint.h \
 	stdio_ext.h \
 	stdlib.h \
+	endian.h \
+	byteswap.h \
+	sys/endian.h \
 	sys/disk.h \
 	sys/disklabel.h \
 	sys/file.h \
diff --git a/include/bitops.h b/include/bitops.h
index 89b418c..ed17ed2 100644
--- a/include/bitops.h
+++ b/include/bitops.h
@@ -8,8 +8,70 @@
  */
 #include <sys/param.h>
 
+#if defined(HAVE_BYTESWAP_H)
 #include <byteswap.h>
-#include <endian.h>
+#else
+#define bswap_16(x) ((((x) & 0x00FF) << 8) | (((x) & 0xFF00) >> 8))
+
+#define bswap_32(x) ((((x) & 0x000000FF) << 24) | (((x) & 0x0000FF00) << 8) | (((x) & 0x00FF0000) >> 8) | (((x) & 0xFF000000) >> 24))
+
+#define bswap_64(x) ((((x) & 0x00000000000000FFULL) << 56) | \
+                     (((x) & 0x000000000000FF00ULL) << 40) | \
+                     (((x) & 0x0000000000FF0000ULL) << 24) | \
+                     (((x) & 0x00000000FF000000ULL) << 8) | \
+                     (((x) & 0x000000FF00000000ULL) >> 8) | \
+                     (((x) & 0x0000FF0000000000ULL) >> 24) | \
+                     (((x) & 0x00FF000000000000ULL) >> 40) | \
+                     (((x) & 0xFF00000000000000ULL) >> 56))
+#endif
+
+
+#if defined(HAVE_ENDIAN_H)
+#  include <endian.h>
+/* BSDs have them here */
+#elif defined(HAVE_SYS_ENDIAN_H)
+#  include <sys/endian.h>
+#endif
+
+#if defined(__OpenBSD__)
+#  include <sys/types.h>
+#  define be16toh(x) betoh16(x)
+#  define be32toh(x) betoh32(x)
+#  define be64toh(x) betoh64(x)
+#endif
+
+/* Still no definitions ? bad OS (windows or others)! */
+#ifndef htobe16
+
+# if !defined(WORDS_BIGENDIAN)
+#  define htobe16(x) bswap_16 (x)
+#  define htole16(x) (x)
+#  define be16toh(x) bswap_16 (x)
+#  define le16toh(x) (x)
+#  define htobe32(x) bswap_32 (x)
+#  define htole32(x) (x)
+#  define be32toh(x) bswap_32 (x)
+#  define le32toh(x) (x)
+#  define htobe64(x) bswap_64 (x)
+#  define htole64(x) (x)
+#  define be64toh(x) bswap_64 (x)
+#  define le64toh(x) (x)
+# else
+#  define htobe16(x) (x)
+#  define htole16(x) bswap_16 (x)
+#  define be16toh(x) (x)
+#  define le16toh(x) bswap_16 (x)
+#  define htobe32(x) (x)
+#  define htole32(x) bswap_32 (x)
+#  define be32toh(x) (x)
+#  define le32toh(x) bswap_32 (x)
+#  define htobe64(x) (x)
+#  define htole64(x) bswap_64 (x)
+#  define be64toh(x) (x)
+#  define le64toh(x) bswap_64 (x)
+# endif
+
+#endif
 
 #ifndef NBBY
 # define NBBY            CHAR_BIT
-- 
1.8.0.2

