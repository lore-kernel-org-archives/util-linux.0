Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41695 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757512Ab2CETjY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Mar 2012 14:39:24 -0500
Received: by mail-ee0-f46.google.com with SMTP id c41so1625459eek.19
        for <util-linux@vger.kernel.org>; Mon, 05 Mar 2012 11:39:24 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/17] lib: add fileutils function collection
Date: Mon,  5 Mar 2012 20:38:46 +0100
Message-Id: <1330976334-10751-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
References: <20120305123847.GD486@x2.net.home>
 <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The fileutils contains xmkstemp function will create temporary file
safe and reusable manner.

Reference: http://www.dwheeler.com/secure-programs/Secure-Programs-HOWTO.html#TEMPORARY-FILES
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/Makefile.am |    5 +++--
 include/fileutils.h |    6 ++++++
 lib/Makefile.am     |    2 ++
 lib/fileutils.c     |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 2 deletions(-)
 create mode 100644 include/fileutils.h
 create mode 100644 lib/fileutils.c

diff --git a/include/Makefile.am b/include/Makefile.am
index 4f5453f..5e4e54e 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -11,6 +11,7 @@ dist_noinst_HEADERS = \
 	crc32.h \
 	env.h \
 	exitcodes.h \
+	fileutils.h \
 	fsprobe.h \
 	ismounted.h \
 	linux_reboot.h \
@@ -38,5 +39,5 @@ dist_noinst_HEADERS = \
 	wholedisk.h \
 	widechar.h \
 	writeall.h \
-	xgetpass.h \
-	xalloc.h
+	xalloc.h \
+	xgetpass.h
diff --git a/include/fileutils.h b/include/fileutils.h
new file mode 100644
index 0000000..27b5661
--- /dev/null
+++ b/include/fileutils.h
@@ -0,0 +1,6 @@
+#ifndef UTIL_LINUX_FILEUTILS
+#define UTIL_LINUX_FILEUTILS
+
+extern FILE * xmkstemp(char **tmpname);
+
+#endif
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 19a00f5..c34481d 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -6,6 +6,7 @@ noinst_PROGRAMS = \
 	test_at \
 	test_blkdev \
 	test_canonicalize \
+	test_fileutils \
 	test_ismounted \
 	test_mangle \
 	test_procutils \
@@ -45,6 +46,7 @@ test_loopdev_SOURCES = \
 test_loopdev_CFLAGS = -DTEST_PROGRAM_LOOPDEV
 endif
 
+test_fileutils_SOURCES = fileutils.c
 test_tt_SOURCES = tt.c $(top_srcdir)/lib/mbsalign.c
 
 test_canonicalize_SOURCES = canonicalize.c
diff --git a/lib/fileutils.c b/lib/fileutils.c
new file mode 100644
index 0000000..b3b7438
--- /dev/null
+++ b/lib/fileutils.c
@@ -0,0 +1,55 @@
+/*
+ * Copyright (C) 2012 Sami Kerola <kerolasa@iki.fi>
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "c.h"
+#include "pathnames.h"
+
+/* Create open temporary file in safe way.  Please notice that the
+ * file permissions are -rw------- by default. */
+FILE *xmkstemp(char **tmpname)
+{
+	char *localtmp;
+	char *tmpenv;
+	mode_t old_mode;
+	int fd;
+	FILE *ret;
+
+	tmpenv = getenv("TMPDIR");
+	if (tmpenv)
+		asprintf(&localtmp, "%s/%s.XXXXXX", tmpenv,
+			 program_invocation_short_name);
+	else
+		asprintf(&localtmp, "%s/%s.XXXXXX", _PATH_TMP,
+			 program_invocation_short_name);
+	old_mode = umask(077);
+	fd = mkstemp(localtmp);
+	umask(old_mode);
+	if (fd == -1)
+		goto err;
+	if (!(ret = fdopen(fd, "w+")))
+		goto err;
+	*tmpname = localtmp;
+	return ret;
+ err:
+	close(fd);
+	return NULL;
+}
+
+#ifdef TEST_PROGRAM
+int main(void)
+{
+	FILE *f;
+	char *tmpname;
+	f = xmkstemp(&tmpname);
+	unlink(tmpname);
+	free(tmpname);
+	fclose(f);
+	return EXIT_FAILURE;
+}
+#endif
-- 
1.7.9.2

