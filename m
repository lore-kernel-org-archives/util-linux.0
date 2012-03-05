Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41695 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757512Ab2CETj1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Mar 2012 14:39:27 -0500
Received: by mail-ee0-f46.google.com with SMTP id c41so1625459eek.19
        for <util-linux@vger.kernel.org>; Mon, 05 Mar 2012 11:39:26 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/17] wall: use xmkstemp for temporary file
Date: Mon,  5 Mar 2012 20:38:47 +0100
Message-Id: <1330976334-10751-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
References: <20120305123847.GD486@x2.net.home>
 <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/Makefile.am |    2 +-
 term-utils/wall.c      |   19 +++++--------------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/term-utils/Makefile.am b/term-utils/Makefile.am
index 49ad5ff..378676f 100644
--- a/term-utils/Makefile.am
+++ b/term-utils/Makefile.am
@@ -51,7 +51,7 @@ endif
 
 if BUILD_WALL
 usrbin_exec_PROGRAMS += wall
-wall_SOURCES = wall.c ttymsg.c ttymsg.h $(top_srcdir)/lib/strutils.c
+wall_SOURCES = wall.c ttymsg.c ttymsg.h $(top_srcdir)/lib/strutils.c $(top_srcdir)/lib/fileutils.c
 dist_man_MANS += wall.1
 wall_CFLAGS = $(SUID_CFLAGS) $(AM_CFLAGS)
 wall_LDFLAGS = $(SUID_LDFLAGS) $(AM_LDFLAGS)
diff --git a/term-utils/wall.c b/term-utils/wall.c
index 7089826..b9f5321 100644
--- a/term-utils/wall.c
+++ b/term-utils/wall.c
@@ -66,6 +66,7 @@
 #include "pathnames.h"
 #include "carefulputc.h"
 #include "c.h"
+#include "fileutils.h"
 
 #define	IGNOREUSER	"sleeper"
 #define WRITE_TIME_OUT	300		/* in seconds */
@@ -188,24 +189,15 @@ makemsg(char *fname, size_t *mbufsize, int print_banner)
 	struct stat sbuf;
 	time_t now;
 	FILE *fp;
-	int fd;
-	char *p, *whom, *where, *hostname, *lbuf, *tmpname, *tmpenv, *mbuf;
+	char *p, *whom, *where, *hostname, *lbuf, *tmpname, *mbuf;
 	long line_max;
 
 	hostname = xmalloc(sysconf(_SC_HOST_NAME_MAX) + 1);
 	line_max = sysconf(_SC_LINE_MAX);
 	lbuf = xmalloc(line_max);
 
-	tmpname = xmalloc(PATH_MAX);
-	tmpenv = getenv("TMPDIR");
-	if ((tmpenv))
-		snprintf(tmpname, PATH_MAX, "%s/%s.XXXXXX", tmpenv,
-			program_invocation_short_name);
-	else
-		snprintf(tmpname, PATH_MAX, "%s/%s.XXXXXX", _PATH_TMP,
-			program_invocation_short_name);
-	if (!(fd = mkstemp(tmpname)) || !(fp = fdopen(fd, "r+")))
-		err(EXIT_FAILURE, _("can't open temporary file %s"), tmpname);
+	if ((fp = xmkstemp(&tmpname)) == NULL)
+		err(EXIT_FAILURE, _("can't open temporary file"));
 	unlink(tmpname);
 	free(tmpname);
 
@@ -280,7 +272,7 @@ makemsg(char *fname, size_t *mbufsize, int print_banner)
 	free(lbuf);
 	rewind(fp);
 
-	if (fstat(fd, &sbuf))
+	if (fstat(fileno(fp), &sbuf))
 		err(EXIT_FAILURE, _("fstat failed"));
 
 	*mbufsize = (size_t) sbuf.st_size;
@@ -289,7 +281,6 @@ makemsg(char *fname, size_t *mbufsize, int print_banner)
 	if (fread(mbuf, 1, *mbufsize, fp) != *mbufsize)
 		err(EXIT_FAILURE, _("fread failed"));
 
-	close(fd);
 	fclose(fp);
 	return mbuf;
 }
-- 
1.7.9.2

