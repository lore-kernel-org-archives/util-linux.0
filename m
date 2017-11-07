Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:48578 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932631AbdKGNjR (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 7 Nov 2017 08:39:17 -0500
Received: by mail-wm0-f65.google.com with SMTP id p75so3808481wmg.3
        for <util-linux@vger.kernel.org>; Tue, 07 Nov 2017 05:39:17 -0800 (PST)
From: Luca Ceresoli <lucaceresoli77@gmail.com>
To: util-linux@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH] md5: declare byteReverse as static
Date: Tue,  7 Nov 2017 14:39:09 +0100
Message-Id: <1510061949-9661-1-git-send-email-lucaceresoli77@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Luca Ceresoli <luca@lucaceresoli.net>

byteReverse() is an internal function in md5.c, and is not exposed via
any header file, but it is not declared as static. This is a problem
with the md5.c file since it is copied more or less verbatim in other
programs (fontconfig and pjsip among others), causing a link error
when linking two of them together.

Fixes link failures such as:
  http://autobuild.buildroot.net/results/419ab2c0e034cc68991281c51caa8271b0fadbab/build-end.log

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 lib/md5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/md5.c b/lib/md5.c
index 488d16ef69b4..282e2d22af25 100644
--- a/lib/md5.c
+++ b/lib/md5.c
@@ -21,13 +21,13 @@
 #if !defined(WORDS_BIGENDIAN)
 #define byteReverse(buf, len)	/* Nothing */
 #else
-void byteReverse(unsigned char *buf, unsigned longs);
+static void byteReverse(unsigned char *buf, unsigned longs);
 
 #ifndef ASM_MD5
 /*
  * Note: this code is harmless on little-endian machines.
  */
-void byteReverse(unsigned char *buf, unsigned longs)
+static void byteReverse(unsigned char *buf, unsigned longs)
 {
     uint32_t t;
     do {
-- 
2.7.4

