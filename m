Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp2.ono.com ([62.42.230.179]:33897 "EHLO smtp2.ono.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746AbbFFETl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 6 Jun 2015 00:19:41 -0400
From: Guillem Jover <guillem@hadrons.org>
To: util-linux@vger.kernel.org
Cc: Steven Chamberlain <steven@pyro.eu.org>
Subject: [PATCH 1/3] lib/fileutils: Add new dup_fd_cloexec function
Date: Sat,  6 Jun 2015 06:19:05 +0200
Message-Id: <1433564347-9515-2-git-send-email-guillem@hadrons.org>
In-Reply-To: <1433564347-9515-1-git-send-email-guillem@hadrons.org>
References: <1433564347-9515-1-git-send-email-guillem@hadrons.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This function duplicates and marks a file descriptor as close-on-exec.
Takes care of build and run-time support for the fcntl F_DUPFD_CLOEXEC
command, and other errors.

Signed-off-by: Guillem Jover <guillem@hadrons.org>
---
 include/fileutils.h |  1 +
 lib/fileutils.c     | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/fileutils.h b/include/fileutils.h
index 3353f69..e0e2ece 100644
--- a/include/fileutils.h
+++ b/include/fileutils.h
@@ -25,6 +25,7 @@ static inline FILE *xfmkstemp(char **tmpname, char *dir)
 	return ret;
 }
 
+extern int dup_fd_cloexec(int oldfd, int lowfd);
 extern int get_fd_tabsize(void);
 
 extern int mkdir_p(const char *path, mode_t mode);
diff --git a/lib/fileutils.c b/lib/fileutils.c
index bffa8ff..81b38ad 100644
--- a/lib/fileutils.c
+++ b/lib/fileutils.c
@@ -50,6 +50,36 @@ int xmkstemp(char **tmpname, char *dir)
 	return fd;
 }
 
+int dup_fd_cloexec(int oldfd, int lowfd)
+{
+	int fd, flags, errno_save;
+
+#ifdef F_DUPFD_CLOEXEC
+	fd = fcntl(oldfd, F_DUPFD_CLOEXEC, lowfd);
+	if (fd >= 0)
+		return fd;
+#endif
+
+	fd = dup(oldfd);
+	if (fd < 0)
+		return fd;
+
+	flags = fcntl(fd, F_GETFD);
+	if (flags < 0)
+		goto unwind;
+	if (fcntl(fd, F_SETFD, flags | FD_CLOEXEC) < 0)
+		goto unwind;
+
+	return fd;
+
+unwind:
+	errno_save = errno;
+	close(fd);
+	errno = errno_save;
+
+	return -1;
+}
+
 /*
  * portable getdtablesize()
  */
-- 
2.2.1.209.g41e5f3a

