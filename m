Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:42292 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876AbaI1Twc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:52:32 -0400
Received: by mail-wi0-f174.google.com with SMTP id hi2so2025575wib.13
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:52:31 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/23] include: fix compiler warnings
Date: Sun, 28 Sep 2014 20:51:43 +0100
Message-Id: <1411933916-30576-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This change has motivation to make -Wall -pedantic compiler options to
spit a little bit less noise, which with luck will increase change to
notice real issues.

Multiple of these:

warning: ISO C forbids braced-groups within expressions [-Wpedantic]

And nearly 300 times reported:

include/c.h:75:41: warning: struct has no named members [-Wpedantic]
 #define UL_BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/c.h    | 10 +++++-----
 include/list.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/c.h b/include/c.h
index e423e8b..0f6e5b2 100644
--- a/include/c.h
+++ b/include/c.h
@@ -37,7 +37,7 @@
 # define __must_be_array(a) \
 	UL_BUILD_BUG_ON_ZERO(__builtin_types_compatible_p(__typeof__(a), __typeof__(&a[0])))
 
-# define ignore_result(x) ({ \
+# define ignore_result(x) __extension__ ({ \
 	__typeof__(x) __dummy __attribute__((__unused__)) = (x); (void) __dummy; \
 })
 
@@ -72,7 +72,7 @@
  * e.g. in a structure initializer (or wherever else comma expressions
  * aren't permitted).
  */
-#define UL_BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
+#define UL_BUILD_BUG_ON_ZERO(e) __extension__ (sizeof(struct { int:-!!(e); }))
 #define BUILD_BUG_ON_NULL(e) ((void *)sizeof(struct { int:-!!(e); }))
 
 #ifndef ARRAY_SIZE
@@ -92,7 +92,7 @@
 #endif
 
 #ifndef min
-# define min(x, y) ({				\
+# define min(x, y) __extension__ ({		\
 	__typeof__(x) _min1 = (x);		\
 	__typeof__(y) _min2 = (y);		\
 	(void) (&_min1 == &_min2);		\
@@ -100,7 +100,7 @@
 #endif
 
 #ifndef max
-# define max(x, y) ({				\
+# define max(x, y) __extension__ ({		\
 	__typeof__(x) _max1 = (x);		\
 	__typeof__(y) _max2 = (y);		\
 	(void) (&_max1 == &_max2);		\
@@ -112,7 +112,7 @@
 #endif
 
 #ifndef container_of
-#define container_of(ptr, type, member) ({                       \
+#define container_of(ptr, type, member) __extension__ ({	 \
 	const __typeof__( ((type *)0)->member ) *__mptr = (ptr); \
 	(type *)( (char *)__mptr - offsetof(type,member) );})
 #endif
diff --git a/include/list.h b/include/list.h
index cfbdb16..3c08aa5 100644
--- a/include/list.h
+++ b/include/list.h
@@ -166,7 +166,7 @@ _INLINE_ void list_splice(struct list_head *list, struct list_head *head)
  * @type:	the type of the struct this is embedded in.
  * @member:	the name of the list_struct within the struct.
  */
-#define list_entry(ptr, type, member) ({              \
+#define list_entry(ptr, type, member) __extension__ ({              \
 	const typeof( ((type *)0)->member ) *__mptr = (ptr);   \
 	(type *)( (char *)__mptr - offsetof(type,member) );})
 
-- 
2.1.1

