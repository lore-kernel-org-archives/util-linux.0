Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:55387 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758338Ab2EOItO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 May 2012 04:49:14 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 0D7DB8FD0F
	for <util-linux@vger.kernel.org>; Tue, 15 May 2012 10:49:14 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 2/4] libuuid,uuidd: move read_all to include/all-io.h
Date: Tue, 15 May 2012 10:49:02 +0200
Message-Id: <1337071744-7056-2-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1337071744-7056-1-git-send-email-petr.uzel@suse.cz>
References: <1337071744-7056-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 include/all-io.h       |   25 +++++++++++++++++++++++++
 libuuid/src/gen_uuid.c |   26 +-------------------------
 misc-utils/uuidd.c     |   24 ------------------------
 3 files changed, 26 insertions(+), 49 deletions(-)

diff --git a/include/all-io.h b/include/all-io.h
index 4d1ae1e..b79d702 100644
--- a/include/all-io.h
+++ b/include/all-io.h
@@ -44,4 +44,29 @@ static inline int fwrite_all(const void *ptr, size_t size,
 	return 0;
 }
 
+static inline ssize_t read_all(int fd, char *buf, size_t count)
+{
+	ssize_t ret;
+	ssize_t c = 0;
+	int tries = 0;
+
+	memset(buf, 0, count);
+	while (count > 0) {
+		ret = read(fd, buf, count);
+		if (ret <= 0) {
+			if ((errno == EAGAIN || errno == EINTR || ret == 0) &&
+			    (tries++ < 5))
+				continue;
+			return c ? c : -1;
+		}
+		if (ret > 0)
+			tries = 0;
+		count -= ret;
+		buf += ret;
+		c += ret;
+	}
+	return c;
+}
+
+
 #endif /* UTIL_LINUX_ALL_IO_H */
diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 93d292a..9d5575b 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -87,6 +87,7 @@
 #include <sys/syscall.h>
 #endif
 
+#include "all-io.h"
 #include "uuidP.h"
 #include "uuidd.h"
 #include "randutils.h"
@@ -334,31 +335,6 @@ try_again:
 }
 
 #if defined(HAVE_UUIDD) && defined(HAVE_SYS_UN_H)
-/* used in get_uuid_via_daemon() only */
-static ssize_t read_all(int fd, char *buf, size_t count)
-{
-	ssize_t ret;
-	ssize_t c = 0;
-	int tries = 0;
-
-	memset(buf, 0, count);
-	while (count > 0) {
-		ret = read(fd, buf, count);
-		if (ret <= 0) {
-			if ((errno == EAGAIN || errno == EINTR || ret == 0) &&
-			    (tries++ < 5))
-				continue;
-			return c ? c : -1;
-		}
-		if (ret > 0)
-			tries = 0;
-		count -= ret;
-		buf += ret;
-		c += ret;
-	}
-	return c;
-}
-
 /*
  * Try using the uuidd daemon to generate the UUID
  *
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 65ee55a..3dde49e 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -101,30 +101,6 @@ static void create_daemon(void)
 		err(EXIT_FAILURE, "setreuid");
 }
 
-static ssize_t read_all(int fd, char *buf, size_t count)
-{
-	ssize_t ret;
-	ssize_t c = 0;
-	int tries = 0;
-
-	memset(buf, 0, count);
-	while (count > 0) {
-		ret = read(fd, buf, count);
-		if (ret <= 0) {
-			if ((errno == EAGAIN || errno == EINTR || ret == 0) &&
-			    (tries++ < 5))
-				continue;
-			return c ? c : -1;
-		}
-		if (ret > 0)
-			tries = 0;
-		count -= ret;
-		buf += ret;
-		c += ret;
-	}
-	return c;
-}
-
 static const char *cleanup_pidfile, *cleanup_socket;
 
 static void terminate_intr(int signo CODE_ATTR((unused)))
-- 
1.7.7

