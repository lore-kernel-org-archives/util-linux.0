Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:49320 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbaK3N6J (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 30 Nov 2014 08:58:09 -0500
Received: by mail-wi0-f174.google.com with SMTP id h11so22172575wiw.13
        for <util-linux@vger.kernel.org>; Sun, 30 Nov 2014 05:58:08 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 04/10] lib: fix crc32 and crc64 interger overflows [AddressSanitizer]
Date: Sun, 30 Nov 2014 13:57:36 +0000
Message-Id: <1417355862-16935-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

lib/crc32.c:111:11: runtime error: unsigned integer overflow: 0 - 1
cannot be represented in type 'size_t' (aka 'unsigned long')

lib/crc64.c:101:12: runtime error: unsigned integer overflow: 0 - 1
cannot be represented in type 'size_t' (aka 'unsigned long')

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/crc32.c | 4 +++-
 lib/crc64.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/crc32.c b/lib/crc32.c
index eaaa06a..be98f1a 100644
--- a/lib/crc32.c
+++ b/lib/crc32.c
@@ -108,8 +108,10 @@ uint32_t crc32(uint32_t seed, const unsigned char *buf, size_t len)
 	uint32_t crc = seed;
 	const unsigned char *p = buf;
 
-	while(len-- > 0)
+	while (len) {
 		crc = crc32_tab[(crc ^ *p++) & 0xff] ^ (crc >> 8);
+		len--;
+	}
 
 	return crc;
 }
diff --git a/lib/crc64.c b/lib/crc64.c
index 091e95d..0be78e6 100644
--- a/lib/crc64.c
+++ b/lib/crc64.c
@@ -98,9 +98,10 @@ uint64_t crc64(uint64_t seed, const unsigned char *data, size_t len)
 {
 	uint64_t crc = seed;
 
-	while (len--) {
+	while (len) {
 		int i = ((int) (crc >> 56) ^ *data++) & 0xFF;
 		crc = crc64_tab[i] ^ (crc << 8);
+		len--;
 	}
 
 	return crc;
-- 
2.1.3

