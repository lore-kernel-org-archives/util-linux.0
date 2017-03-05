Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34004 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbdCEUws (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Mar 2017 15:52:48 -0500
Received: by mail-wm0-f65.google.com with SMTP id u132so2862000wmg.1
        for <util-linux@vger.kernel.org>; Sun, 05 Mar 2017 12:52:47 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 09/13] include: fix compiler warning
Date: Sun,  5 Mar 2017 20:52:28 +0000
Message-Id: <20170305205232.24030-10-kerolasa@iki.fi>
In-Reply-To: <20170305205232.24030-1-kerolasa@iki.fi>
References: <20170305205232.24030-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

./include/optutils.h:12:18: warning: null pointer dereference [-Wnull-dereference]
  for (o = opts; o->name; o++)
                 ~^~~~~~
In file included from libfdisk/src/dos.c:12:0:
./include/pt-mbr.h:25:47: warning: potential null pointer dereference [-Wnull-dereference]
  return p[0] | (p[1] << 8) | (p[2] << 16) | (p[3] << 24);
         ~^~~

Well these should be impossible, so add assert() to catch possible bugs.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/optutils.h | 3 +++
 include/pt-mbr.h   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/optutils.h b/include/optutils.h
index 99ad7e4b4..325cb8812 100644
--- a/include/optutils.h
+++ b/include/optutils.h
@@ -1,6 +1,8 @@
 #ifndef UTIL_LINUX_OPTUTILS_H
 #define UTIL_LINUX_OPTUTILS_H
 
+#include <assert.h>
+
 #include "c.h"
 #include "nls.h"
 
@@ -8,6 +10,7 @@ static inline const char *option_to_longopt(int c, const struct option *opts)
 {
 	const struct option *o;
 
+	assert(!(opts == NULL));
 	for (o = opts; o->name; o++)
 		if (o->val == c)
 			return o->name;
diff --git a/include/pt-mbr.h b/include/pt-mbr.h
index 90be95b1f..177cc7474 100644
--- a/include/pt-mbr.h
+++ b/include/pt-mbr.h
@@ -1,6 +1,8 @@
 #ifndef UTIL_LINUX_PT_MBR_H
 #define UTIL_LINUX_PT_MBR_H
 
+#include <assert.h>
+
 struct dos_partition {
 	unsigned char boot_ind;		/* 0x80 - active */
 	unsigned char bh, bs, bc;	/* begin CHS */
@@ -27,6 +29,7 @@ static inline unsigned int __dos_assemble_4le(const unsigned char *p)
 
 static inline void __dos_store_4le(unsigned char *p, unsigned int val)
 {
+	assert(!(p == NULL));
 	p[0] = (val & 0xff);
 	p[1] = ((val >> 8) & 0xff);
 	p[2] = ((val >> 16) & 0xff);
-- 
2.12.0

