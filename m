Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:53097 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758121Ab2ECTCM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 May 2012 15:02:12 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 12B7F978B8
	for <util-linux@vger.kernel.org>; Thu,  3 May 2012 21:02:12 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 13/15] libuuid: don't exec uuidd
Date: Thu,  3 May 2012 21:01:59 +0200
Message-Id: <1336071721-32492-14-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
References: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Executing the daemon from the shared library is not quite elegant
solution. Drop this functionality and require uuidd (should it be
needed) to be started from the initscript or by socket-activation.

References: http://www.spinics.net/lists/util-linux-ng/msg05967.html

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 libuuid/src/Makefile.am |    1 -
 libuuid/src/gen_uuid.c  |   48 ++--------------------------------------------
 2 files changed, 3 insertions(+), 46 deletions(-)

diff --git a/libuuid/src/Makefile.am b/libuuid/src/Makefile.am
index 1df282e..8e87210 100644
--- a/libuuid/src/Makefile.am
+++ b/libuuid/src/Makefile.am
@@ -26,7 +26,6 @@ libuuid_la_SOURCES = \
 	uuidP.h \
 	uuid_time.c \
 	$(uuidinc_HEADERS) \
-	$(top_srcdir)/lib/fileutils.c \
 	$(top_srcdir)/lib/randutils.c
 
 libuuid_la_DEPENDENCIES = uuid.sym
diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 8c102b1..8ff4129 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -58,7 +58,6 @@
 #ifdef HAVE_SYS_TIME_H
 #include <sys/time.h>
 #endif
-#include <sys/wait.h>
 #include <sys/stat.h>
 #ifdef HAVE_SYS_FILE_H
 #include <sys/file.h>
@@ -87,14 +86,10 @@
 #if defined(__linux__) && defined(HAVE_SYS_SYSCALL_H)
 #include <sys/syscall.h>
 #endif
-#ifdef HAVE_SYS_RESOURCE_H
-#include <sys/resource.h>
-#endif
 
 #include "uuidP.h"
 #include "uuidd.h"
 #include "randutils.h"
-#include "fileutils.h"
 
 #ifdef HAVE_TLS
 #define THREAD_LOCAL static __thread
@@ -365,20 +360,6 @@ static ssize_t read_all(int fd, char *buf, size_t count)
 }
 
 /*
- * Close all file descriptors
- */
-static void close_all_fds(void)
-{
-	int i, max = get_fd_tabsize();
-
-	for (i=0; i < max; i++) {
-		close(i);
-		if (i <= 2)
-			open("/dev/null", O_RDWR);
-	}
-}
-
-/*
  * Try using the uuidd daemon to generate the UUID
  *
  * Returns 0 on success, non-zero on failure.
@@ -391,11 +372,6 @@ static int get_uuid_via_daemon(int op, uuid_t out, int *num)
 	ssize_t ret;
 	int32_t reply_len = 0, expected = 16;
 	struct sockaddr_un srv_addr;
-	struct stat st;
-	pid_t pid;
-	static const char *uuidd_path = UUIDD_PATH;
-	static int access_ret = -2;
-	static int start_attempts = 0;
 
 	if ((s = socket(AF_UNIX, SOCK_STREAM, 0)) < 0)
 		return -1;
@@ -404,27 +380,9 @@ static int get_uuid_via_daemon(int op, uuid_t out, int *num)
 	strcpy(srv_addr.sun_path, UUIDD_SOCKET_PATH);
 
 	if (connect(s, (const struct sockaddr *) &srv_addr,
-		    sizeof(struct sockaddr_un)) < 0) {
-		if (access_ret == -2)
-			access_ret = access(uuidd_path, X_OK);
-		if (access_ret == 0)
-			access_ret = stat(uuidd_path, &st);
-		if (access_ret == 0 && (st.st_mode & (S_ISUID | S_ISGID)) == 0)
-			access_ret = access(UUIDD_DIR, W_OK);
-		if (access_ret == 0 && start_attempts++ < 5) {
-			if ((pid = fork()) == 0) {
-				close_all_fds();
-				execl(uuidd_path, "uuidd", "-qT", "300",
-				      (char *) NULL);
-				exit(EXIT_FAILURE);
-			}
-			(void) waitpid(pid, 0, 0);
-			if (connect(s, (const struct sockaddr *) &srv_addr,
-				    sizeof(struct sockaddr_un)) < 0)
-				goto fail;
-		} else
-			goto fail;
-	}
+		    sizeof(struct sockaddr_un)) < 0)
+		goto fail;
+
 	op_buf[0] = op;
 	op_len = 1;
 	if (op == UUIDD_OP_BULK_TIME_UUID) {
-- 
1.7.7

