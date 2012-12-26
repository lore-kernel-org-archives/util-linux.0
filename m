Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-gg0-f174.google.com ([209.85.161.174]:59134 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab2LZSJi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 26 Dec 2012 13:09:38 -0500
Received: by mail-gg0-f174.google.com with SMTP id k2so1447976ggd.33
        for <util-linux@vger.kernel.org>; Wed, 26 Dec 2012 10:09:37 -0800 (PST)
From: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
Subject: [PATCH] include/bitops.h: Use the operating system byteswapping functions
Date: Wed, 26 Dec 2012 14:38:21 -0300
Message-Id: <1356543501-7033-1-git-send-email-crrodriguez@opensuse.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There is no need to reinvent the wheel.
---
 include/bitops.h | 69 +++++++++++++++-----------------------------------------
 1 file changed, 18 insertions(+), 51 deletions(-)

diff --git a/include/bitops.h b/include/bitops.h
index 81375d0..89b418c 100644
--- a/include/bitops.h
+++ b/include/bitops.h
@@ -8,6 +8,9 @@
  */
 #include <sys/param.h>
 
+#include <byteswap.h>
+#include <endian.h>
+
 #ifndef NBBY
 # define NBBY            CHAR_BIT
 #endif
@@ -22,63 +25,27 @@
 /*
  * Byte swab macros (based on linux/byteorder/swab.h)
  */
-#define swab16(x) \
-	((uint16_t)( \
-		(((uint16_t)(x) & (uint16_t)0x00ffU) << 8) | \
-		(((uint16_t)(x) & (uint16_t)0xff00U) >> 8) ))
-
-#define swab32(x) \
-	((uint32_t)( \
-		(((uint32_t)(x) & (uint32_t)0x000000ffUL) << 24) | \
-		(((uint32_t)(x) & (uint32_t)0x0000ff00UL) <<  8) | \
-		(((uint32_t)(x) & (uint32_t)0x00ff0000UL) >>  8) | \
-		(((uint32_t)(x) & (uint32_t)0xff000000UL) >> 24) ))
-
-#define swab64(x) \
-	((uint64_t)( \
-		(uint64_t)(((uint64_t)(x) & (uint64_t)0x00000000000000ffULL) << 56) | \
-		(uint64_t)(((uint64_t)(x) & (uint64_t)0x000000000000ff00ULL) << 40) | \
-		(uint64_t)(((uint64_t)(x) & (uint64_t)0x0000000000ff0000ULL) << 24) | \
-		(uint64_t)(((uint64_t)(x) & (uint64_t)0x00000000ff000000ULL) <<  8) | \
-	        (uint64_t)(((uint64_t)(x) & (uint64_t)0x000000ff00000000ULL) >>  8) | \
-		(uint64_t)(((uint64_t)(x) & (uint64_t)0x0000ff0000000000ULL) >> 24) | \
-		(uint64_t)(((uint64_t)(x) & (uint64_t)0x00ff000000000000ULL) >> 40) | \
-		(uint64_t)(((uint64_t)(x) & (uint64_t)0xff00000000000000ULL) >> 56) ))
-
-
-#ifdef WORDS_BIGENDIAN
+#define swab16(x) bswap_16(x)
 
-#define cpu_to_le16(x) swab16(x)
-#define cpu_to_le32(x) swab32(x)
-#define cpu_to_le64(x) swab64(x)
-#define cpu_to_be16(x) ((uint16_t)(x))
-#define cpu_to_be32(x) ((uint32_t)(x))
-#define cpu_to_be64(x) ((uint64_t)(x))
+#define swab32(x) bswap_32(x)
 
-#define le16_to_cpu(x) swab16(x)
-#define le32_to_cpu(x) swab32(x)
-#define le64_to_cpu(x) swab64(x)
-#define be16_to_cpu(x) ((uint16_t)(x))
-#define be32_to_cpu(x) ((uint32_t)(x))
-#define be64_to_cpu(x) ((uint64_t)(x))
+#define swab64(x) bswap_64(x)
 
-#else /* !WORDS_BIGENDIAN */
+#define cpu_to_le16(x) htole16(x)
+#define cpu_to_le32(x) htole32(x)
+#define cpu_to_le64(x) htole64(x)
 
-#define cpu_to_le16(x) ((uint16_t)(x))
-#define cpu_to_le32(x) ((uint32_t)(x))
-#define cpu_to_le64(x) ((uint64_t)(x))
-#define cpu_to_be16(x) swab16(x)
-#define cpu_to_be32(x) swab32(x)
-#define cpu_to_be64(x) swab64(x)
+#define cpu_to_be16(x) htobe16(x)
+#define cpu_to_be32(x) htobe32(x)
+#define cpu_to_be64(x) htobe64(x)
 
-#define le16_to_cpu(x) ((uint16_t)(x))
-#define le32_to_cpu(x) ((uint32_t)(x))
-#define le64_to_cpu(x) ((uint64_t)(x))
-#define be16_to_cpu(x) swab16(x)
-#define be32_to_cpu(x) swab32(x)
-#define be64_to_cpu(x) swab64(x)
+#define le16_to_cpu(x) le16toh(x)
+#define le32_to_cpu(x) le32toh(x)
+#define le64_to_cpu(x) le64toh(x)
 
-#endif /* WORDS_BIGENDIAN */
+#define be16_to_cpu(x) be16toh(x)
+#define be32_to_cpu(x) be32toh(x)
+#define be64_to_cpu(x) be64toh(x)
 
 #endif /* BITOPS_H */
 
-- 
1.8.0.2

