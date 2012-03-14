Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:19505 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932382Ab2CNJDi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 14 Mar 2012 05:03:38 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2E93bI9006913
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Wed, 14 Mar 2012 05:03:37 -0400
From: harald@redhat.com
To: util-linux@vger.kernel.org
Cc: Harald Hoyer <harald@redhat.com>
Subject: [PATCH] setsid: add option "-c" to set the controlling terminal
Date: Wed, 14 Mar 2012 10:03:08 +0100
Message-Id: <1331715788-8573-1-git-send-email-harald@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Harald Hoyer <harald@redhat.com>

---
 sys-utils/setsid.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/sys-utils/setsid.c b/sys-utils/setsid.c
index efd20e6..a4b494e 100644
--- a/sys-utils/setsid.c
+++ b/sys-utils/setsid.c
@@ -15,6 +15,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <termio.h>
 
 #include "c.h"
 #include "nls.h"
@@ -25,6 +26,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fprintf(out, _(" %s [options] <program> [arguments ...]\n"),
 		program_invocation_short_name);
 	fprintf(out, USAGE_OPTIONS);
+	fprintf(out, _(
+		" -c, --ctty \tset the controlling terminal\n"
+		));
 	fprintf(out, USAGE_HELP);
 	fprintf(out, USAGE_VERSION);
 	fprintf(out, USAGE_MAN_TAIL("setsid(1)"));
@@ -34,7 +38,10 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 int main(int argc, char **argv)
 {
 	int ch;
+	int ctty = 0;
+
 	static const struct option longopts[] = {
+		{"ctty", no_argument, NULL, 'c'},
 		{"version", no_argument, NULL, 'V'},
 		{"help", no_argument, NULL, 'h'},
 		{NULL, 0, NULL, 0}
@@ -44,11 +51,14 @@ int main(int argc, char **argv)
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 
-	while ((ch = getopt_long(argc, argv, "+Vh", longopts, NULL)) != -1)
+	while ((ch = getopt_long(argc, argv, "+Vhc", longopts, NULL)) != -1)
 		switch (ch) {
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
+		case 'c':
+			ctty=1;
+			break;
 		case 'h':
 			usage(stdout);
 		default:
@@ -74,6 +84,10 @@ int main(int argc, char **argv)
 		/* cannot happen */
 		err(EXIT_FAILURE, _("setsid failed"));
 
-	execvp(argv[1], argv + 1);
+	if (ctty) {
+		if (ioctl (0, TIOCSCTTY, 1))
+			warn(_("failed to set the controlling terminal"));
+	}
+	execvp(argv[optind], argv + optind + 1);
 	err(EXIT_FAILURE, _("execvp failed"));
 }
-- 
1.7.9.3

