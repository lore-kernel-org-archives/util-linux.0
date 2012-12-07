Return-Path: util-linux-owner@vger.kernel.org
Received: from charybdis-ext.suse.de ([195.135.221.2]:57588 "EHLO g231.suse.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753188Ab2LGIWG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 7 Dec 2012 03:22:06 -0500
From: Werner Fink <werner@suse.de>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Werner Fink <werner@suse.de>
Subject: [PATCH 2/5] sulogin: make usleep() workaround work
Date: Fri,  7 Dec 2012 09:00:55 +0100
Message-Id: <1354867258-14206-2-git-send-email-werner@suse.de>
In-Reply-To: <1354867258-14206-1-git-send-email-werner@suse.de>
References: <1354867258-14206-1-git-send-email-werner@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Simply fix a compile problem found during debugging console.c

Signed-off-by: Werner Fink <werner@suse.de>
---
 include/c.h |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git include/c.h include/c.h
index 1107287..ec1020e 100644
--- include/c.h
+++ include/c.h
@@ -19,6 +19,10 @@
 # include <err.h>
 #endif
 
+#ifndef HAVE_USLEEP
+# include <time.h>
+#endif
+
 /*
  * Compiler specific stuff
  */
@@ -246,13 +250,13 @@ static inline size_t get_hostname_max(void)
  * This function is marked obsolete in POSIX.1-2001 and removed in
  * POSIX.1-2008. It is replaced with nanosleep().
  */
-static inline usleep(useconds_t usec)
+static inline int usleep(useconds_t usec)
 {
 	struct timespec waittime = {
 		.tv_sec   =  usec / 1000000L,
 		.tv_nsec  = (usec % 1000000L) * 1000
-	}
-	nanosleep(&waittime, NULL);
+	};
+	return nanosleep(&waittime, NULL);
 }
 #endif
 
-- 
1.7.10.4

