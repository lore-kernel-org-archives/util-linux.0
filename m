Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbhh.dreamhost.com ([208.97.132.177]:39849 "EHLO
	homiemail-a38.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751724Ab1LTNmM (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 20 Dec 2011 08:42:12 -0500
Subject: [PATCH 3/5] sfdisk: do not depend on arch for packed attribute
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 20 Dec 2011 14:42:05 +0100
Message-ID: <1324388525.3316.9.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

The packed gcc function attribute is moved to c.h and the arch-specific checks are removed
since there is no harm in other platforms having the attribute, it will just make no difference.
---
 fdisk/sfdisk.c |    9 ---------
 include/c.h    |    3 +++
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index 979eadc..fdc63d6 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -115,15 +115,6 @@ error(char *s, ...) {
 }
 
 /*
- * arm needs PACKED - use it everywhere?
- */
-#if defined(__GNUC__) && (defined(__arm__) || defined(__alpha__))
-#define PACKED __attribute__ ((packed))
-#else
-#define PACKED
-#endif
-
-/*
  *  A. About seeking
  */
 
diff --git a/include/c.h b/include/c.h
index 073615e..26582e4 100644
--- a/include/c.h
+++ b/include/c.h
@@ -39,10 +39,13 @@
 	__typeof__(x) __dummy __attribute__((__unused__)) = (x); (void) __dummy; \
 })
 
+# define PACKED __attribute__ ((packed))
+
 #else /* !__GNUC__ */
 # define __must_be_array(a)	0
 # define __attribute__(_arg_)
 # define ignore_result(x) ((void) (x))
+# define PACKED
 #endif /* !__GNUC__ */
 
 /*
-- 
1.7.4.1




