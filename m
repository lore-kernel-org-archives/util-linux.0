Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:41205 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761Ab2EMHiB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 May 2012 03:38:01 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 3849C99B23
	for <util-linux@vger.kernel.org>; Sun, 13 May 2012 09:38:00 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] libuuid,uuidd: move read_all to include/readall.h
Date: Sun, 13 May 2012 09:37:56 +0200
Message-Id: <1336894676-25586-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 include/Makefile.am    |    1 +
 include/readall.h      |   33 +++++++++++++++++++++++++++++++++
 libuuid/src/gen_uuid.c |   26 +-------------------------
 misc-utils/uuidd.c     |   25 +------------------------
 4 files changed, 36 insertions(+), 49 deletions(-)
 create mode 100644 include/readall.h

diff --git a/include/Makefile.am b/include/Makefile.am
index f61cb04..6946e68 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -30,6 +30,7 @@ dist_noinst_HEADERS = \
 	pathnames.h \
 	procutils.h \
 	randutils.h \
+	readall.h \
 	rpmatch.h \
 	setproctitle.h \
 	strutils.h \
diff --git a/include/readall.h b/include/readall.h
new file mode 100644
index 0000000..96baaca
--- /dev/null
+++ b/include/readall.h
@@ -0,0 +1,33 @@
+#ifndef UTIL_LINUX_READALL_H
+#define UTIL_LINUX_READALL_H
+
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+
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
+#endif /* UTIL_LINUX_READALL_H */
diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 93d292a..7212692 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -90,6 +90,7 @@
 #include "uuidP.h"
 #include "uuidd.h"
 #include "randutils.h"
+#include "readall.h"
 
 #ifdef HAVE_TLS
 #define THREAD_LOCAL static __thread
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
index eb1ef02..98c740b 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -34,6 +34,7 @@ extern int optind;
 #include "uuid.h"
 #include "uuidd.h"
 #include "writeall.h"
+#include "readall.h"
 #include "c.h"
 #include "closestream.h"
 
@@ -101,30 +102,6 @@ static void create_daemon(void)
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

