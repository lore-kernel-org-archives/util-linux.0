Return-Path: util-linux-owner@vger.kernel.org
Received: from vostochny.stro.at ([78.47.22.85]:45481 "EHLO vostochny.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756683Ab2EVOUr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 22 May 2012 10:20:47 -0400
From: maximilian attems <max@stro.at>
To: util-linux@vger.kernel.org
Cc: maximilian attems <max@stro.at>
Subject: [PATCH] include: [c.h] protect container_of
Date: Tue, 22 May 2012 16:20:42 +0200
Message-Id: <1337696442-3344-1-git-send-email-max@stro.at>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

fixes lots of warning noise:
../../../include/c.h:112:0: warning: "container_of" redefined [enabled
by default]
/usr/lib/klibc/include/stddef.h:52:0: note: this is the location of the
previous definition

Signed-off-by: maximilian attems <max@stro.at>
---
 include/c.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/c.h b/include/c.h
index b6d8ced..8c8db73 100644
--- a/include/c.h
+++ b/include/c.h
@@ -109,9 +109,11 @@
 #define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
 #endif
 
+#ifndef container_of
 #define container_of(ptr, type, member) ({                       \
 	const __typeof__( ((type *)0)->member ) *__mptr = (ptr); \
 	(type *)( (char *)__mptr - offsetof(type,member) );})
+#endif
 
 #ifndef HAVE_PROGRAM_INVOCATION_SHORT_NAME
 # ifdef HAVE___PROGNAME
-- 
1.7.10

