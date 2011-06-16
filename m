Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor.suse.de ([195.135.220.2]:54842 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502Ab1FPN7m (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 16 Jun 2011 09:59:42 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id D803B94393
	for <util-linux@vger.kernel.org>; Thu, 16 Jun 2011 15:59:40 +0200 (CEST)
From: Ludwig Nussel <ludwig.nussel@suse.de>
To: util-linux@vger.kernel.org
Cc: Ludwig Nussel <ludwig.nussel@suse.de>
Subject: [PATCH 1/4] uuidgen: fail if uuidd isn't running
Date: Thu, 16 Jun 2011 15:59:36 +0200
Message-Id: <1308232779-21018-1-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

time bases uuids are not safe if uuidd is not running.
Add option --force to generate a uuid in this case nevertheless.
---
 misc-utils/uuidgen.c |   51 ++++++++++++++++++++++++++++++++++---------------
 1 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/misc-utils/uuidgen.c b/misc-utils/uuidgen.c
index 3cf6ec9..b83b124 100644
--- a/misc-utils/uuidgen.c
+++ b/misc-utils/uuidgen.c
@@ -10,34 +10,43 @@
  */
 
 #include <stdio.h>
-#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
-#endif
-#ifdef HAVE_GETOPT_H
 #include <getopt.h>
-#else
-extern int getopt(int argc, char * const argv[], const char *optstring);
-extern char *optarg;
-extern int optind;
-#endif
 
 #include "uuid.h"
 #include "nls.h"
+#include "c.h"
 
 #define DO_TYPE_TIME	1
 #define DO_TYPE_RANDOM	2
 
-static void usage(const char *progname)
+static const struct option long_options[] = {
+	{ "time",      0, NULL, 't' },
+	{ "random",    0, NULL, 'r' },
+	{ "force",     0, NULL, 128 },
+	{ "help",      0, NULL, 'h' },
+	{ 0, 0, 0, 0 }
+};
+
+static void usage(int ex)
 {
-	fprintf(stderr, _("Usage: %s [-r] [-t]\n"), progname);
-	exit(1);
+	printf(_("Usage: %s [options]\n"
+		"  -r, --random     Generate a random-based UUID\n"
+		"  -t, --time       Generate a time-based UUID\n"
+		"      --force      print uuid even if it's potentially weak\n"
+		"  -h, --help       Display this text\n"),
+		program_invocation_short_name);
+	exit(ex);
 }
 
+
+
 int
 main (int argc, char *argv[])
 {
 	int    c;
 	int    do_type = 0;
+	int    force = 0;
 	char   str[37];
 	uuid_t uu;
 
@@ -45,21 +54,31 @@ main (int argc, char *argv[])
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 
-	while ((c = getopt (argc, argv, "tr")) != EOF)
+	while ((c = getopt_long(argc, argv, "rth", long_options, NULL)) != EOF ) {
 		switch (c) {
-		case 't':
-			do_type = DO_TYPE_TIME;
+		case 'h':
+			usage(0);
 			break;
 		case 'r':
 			do_type = DO_TYPE_RANDOM;
 			break;
+		case 't':
+			do_type = DO_TYPE_TIME;
+			break;
+		case 128:
+			force = 1;
+			break;
 		default:
-			usage(argv[0]);
+			usage(1);
 		}
+	}
 
 	switch (do_type) {
 	case DO_TYPE_TIME:
-		uuid_generate_time(uu);
+		if (uuid_generate_time_safe(uu) && !force) {
+			fprintf(stderr, _("uuidd not running or not operational.\n"));
+			exit(1);
+		}
 		break;
 	case DO_TYPE_RANDOM:
 		uuid_generate_random(uu);
-- 
1.7.3.4

