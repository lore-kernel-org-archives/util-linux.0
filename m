Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33911 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752365AbdDNUj5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 14 Apr 2017 16:39:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id x75so285670wma.1
        for <util-linux@vger.kernel.org>; Fri, 14 Apr 2017 13:39:56 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>, Rui Zhao <renyuneyun@gmail.com>
Subject: [PATCH] scriptreplay: determine if script --quiet was used to create typescript
Date: Fri, 14 Apr 2017 21:39:48 +0100
Message-Id: <20170414203948.12295-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Recent commit that removed header timestamp from typescript output when
--quiet option is defined broke scriptreplay.  Trouble was that scriptreplay
always skipped first line of the typescript.  But --quiet makes that line to
be part of what must be printed by scriptreplay.

Initially I thought it could be possible to determine if first line is
header by searching 'Script started on', but not long later realization that
will be difficult due translations lead to try something else.  If timing
file chunks together make exactly the same size as typescript there is no
header.

Reference: 493548b85d528bb13e72af8240fd997fdbfdd7ea
CC: Rui Zhao (renyuneyun) <renyuneyun@gmail.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/scriptreplay.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/term-utils/scriptreplay.c b/term-utils/scriptreplay.c
index 5fd3ecb16..365b73de4 100644
--- a/term-utils/scriptreplay.c
+++ b/term-utils/scriptreplay.c
@@ -25,6 +25,7 @@
 #include <limits.h>
 #include <math.h>
 #include <sys/select.h>
+#include <sys/stat.h>
 #include <unistd.h>
 #include <getopt.h>
 
@@ -58,6 +59,25 @@ usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
+static int
+sfile_has_header(FILE *sfile, FILE *tfile)
+{
+	double delay;
+	size_t blk, total = 0;
+	char nl;
+	struct stat st;
+
+	if (fstat(fileno(sfile), &st) < 0)
+		return 0;
+	while (fscanf(tfile, "%lf %zu%c\n", &delay, &blk, &nl) == 3)
+		total += blk;
+	fseek(sfile, 0, SEEK_SET);
+	fseek(tfile, 0, SEEK_SET);
+	if ((size_t)st.st_size <= total)
+		return 0;
+	return 1;
+}
+
 static double
 getnum(const char *s)
 {
@@ -199,8 +219,8 @@ main(int argc, char *argv[])
 	if (!sfile)
 		err(EXIT_FAILURE, _("cannot open %s"), sname);
 
-	/* ignore the first typescript line */
-	while((c = fgetc(sfile)) != EOF && c != '\n');
+	if (sfile_has_header(sfile, tfile))
+		 while((c = fgetc(sfile)) != EOF && c != '\n');
 
 	for(line = 1; ; line++) {
 		double delay;
-- 
2.12.2

