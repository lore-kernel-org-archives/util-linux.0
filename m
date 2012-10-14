Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41556 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269Ab2JNUV3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:21:29 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so3908218wgb.1
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:21:28 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/19] include/all-io: replace usleep with nanosleep
Date: Sun, 14 Oct 2012 21:21:00 +0100
Message-Id: <1350246070-10544-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

POSIX.1-2001 declares usleep is obsolete.

Reference: http://pubs.opengroup.org/onlinepubs/009695399/functions/usleep.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/all-io.h | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/all-io.h b/include/all-io.h
index 38a760f..ed4f879 100644
--- a/include/all-io.h
+++ b/include/all-io.h
@@ -4,6 +4,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <errno.h>
+#include <time.h>
 
 static inline int write_all(int fd, const void *buf, size_t count)
 {
@@ -18,8 +19,12 @@ static inline int write_all(int fd, const void *buf, size_t count)
 				buf = (void *) ((char *) buf + tmp);
 		} else if (errno != EINTR && errno != EAGAIN)
 			return -1;
-		if (errno == EAGAIN)	/* Try later, *sigh* */
-			usleep(10000);
+		if (errno == EAGAIN) {	/* Try later, *sigh* */
+			struct timespec waittime;
+			waittime.tv_sec = 0;
+			waittime.tv_nsec = 10000000;
+			nanosleep(&waittime, NULL);
+		}
 	}
 	return 0;
 }
@@ -38,8 +43,12 @@ static inline int fwrite_all(const void *ptr, size_t size,
 				ptr = (void *) ((char *) ptr + (tmp * size));
 		} else if (errno != EINTR && errno != EAGAIN)
 			return -1;
-		if (errno == EAGAIN)	/* Try later, *sigh* */
-			usleep(10000);
+		if (errno == EAGAIN) {	/* Try later, *sigh* */
+			struct timespec waittime;
+			waittime.tv_sec = 0;
+			waittime.tv_nsec = 10000000;
+			nanosleep(&waittime, NULL);
+		}
 	}
 	return 0;
 }
-- 
1.7.12.2

