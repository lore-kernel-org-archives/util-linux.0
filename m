Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f181.google.com ([209.85.214.181]:43958 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbaCHVnj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Mar 2014 16:43:39 -0500
Received: by mail-ob0-f181.google.com with SMTP id wp4so5513409obc.40
        for <util-linux@vger.kernel.org>; Sat, 08 Mar 2014 13:43:39 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 5/5] mcookie: add --max-size option
Date: Sat,  8 Mar 2014 15:43:30 -0600
Message-Id: <1394315010-22481-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1394315010-22481-1-git-send-email-kerolasa@iki.fi>
References: <1394315010-22481-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Just in case someone wants to add entropy from device with invocation
demonstrated below.

$ mcookie --file /dev/urandom --max-size 64k

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/mcookie.1 | 15 +++++++++++++++
 misc-utils/mcookie.c | 29 ++++++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/misc-utils/mcookie.1 b/misc-utils/mcookie.1
index df6137f..1b6ac76 100644
--- a/misc-utils/mcookie.1
+++ b/misc-utils/mcookie.1
@@ -27,6 +27,21 @@ in this preference order.
 Use additional file as a macig cookie random seed.  When file is defined
 as '-' character input is read from stdin.
 .TP
+\fB\-m\fR, \fB\-\-max\-size\fR=\fInumber\fR
+Read form
+.I FILE
+only
+.I number
+of bytes.  This option is meant to be used when reading additional
+randomness from a device.
+.IP
+The
+.I number
+argument may be followed by the multiplicative suffixes KiB=1024,
+MiB=1024*1024, and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is
+optional, e.g., "K" has the same meaning as "KiB") or the suffixes
+KB=1000, MB=1000*1000, and so on for GB, TB, PB, EB, ZB and YB.
+.TP
 \fB\-v\fR, \fB\-\-verbose\fR
 Inform where randomness originated, with amount of entropy read from each
 source.
diff --git a/misc-utils/mcookie.c b/misc-utils/mcookie.c
index 31f33e4..caa1b8f 100644
--- a/misc-utils/mcookie.c
+++ b/misc-utils/mcookie.c
@@ -23,6 +23,7 @@
 #include "nls.h"
 #include "closestream.h"
 #include "randutils.h"
+#include "strutils.h"
 #include "xalloc.h"
 
 #include <fcntl.h>
@@ -43,6 +44,7 @@ struct mcookie_control {
 	char **files;
 	int nfiles;
 	int fd;
+	uint64_t maxsz;
 	unsigned int
 		verbose:1;
 };
@@ -50,11 +52,22 @@ struct mcookie_control {
 /* The basic function to hash a file */
 static size_t hash_file(struct mcookie_control *ctl)
 {
-	size_t count = 0;
-	ssize_t r;
+	size_t count = 0, read_sz;
+	ssize_t r = 1;
 	unsigned char buf[BUFFERSIZE];
-
-	while ((r = read(ctl->fd, buf, sizeof(buf))) > 0) {
+	int stop = 0;
+
+	read_sz = sizeof(buf);
+	while (!stop) {
+		if (ctl->maxsz) {
+			if (ctl->maxsz <= read_sz) {
+				read_sz = ctl->maxsz;
+				stop = 1;
+			} else
+				ctl->maxsz -= read_sz;
+		}
+		if ((r = read(ctl->fd, buf, read_sz)) == 0)
+			break;
 		MD5Update(&(ctl->ctx), buf, r);
 		count += r;
 	}
@@ -70,6 +83,7 @@ static void __attribute__((__noreturn__)) usage(FILE * out)
 	fprintf(out, _(" %s [options]\n"), program_invocation_short_name);
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -f, --file <file>     use file as a cookie seed\n"), out);
+	fputs(_(" -m, --max-size <num>  limit how much is read from seed files\n"), out);
 	fputs(_(" -v, --verbose         explain what is being done\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
@@ -117,6 +131,7 @@ int main(int argc, char **argv)
 
 	static const struct option longopts[] = {
 		{"file", required_argument, NULL, 'f'},
+		{"max-size", required_argument, NULL, 'm'},
 		{"verbose", no_argument, NULL, 'v'},
 		{"version", no_argument, NULL, 'V'},
 		{"help", no_argument, NULL, 'h'},
@@ -135,7 +150,7 @@ int main(int argc, char **argv)
 		ctl.files = xmalloc(sizeof(char *) * argc);
 
 	while ((c =
-		getopt_long(argc, argv, "f:vVh", longopts, NULL)) != -1)
+		getopt_long(argc, argv, "f:m:vVh", longopts, NULL)) != -1)
 		switch (c) {
 		case 'v':
 			ctl.verbose = 1;
@@ -144,6 +159,10 @@ int main(int argc, char **argv)
 			ctl.files[ctl.nfiles] = optarg;
 			ctl.nfiles++;
 			break;
+		case 'm':
+			ctl.maxsz = strtosize_or_err(optarg,
+						     _("failed to parse length"));
+			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
-- 
1.9.0

