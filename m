Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oa0-f44.google.com ([209.85.219.44]:36574 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbaCHVne (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Mar 2014 16:43:34 -0500
Received: by mail-oa0-f44.google.com with SMTP id n16so5635455oag.31
        for <util-linux@vger.kernel.org>; Sat, 08 Mar 2014 13:43:33 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/5] mcookie: use lib/randutils
Date: Sat,  8 Mar 2014 15:43:26 -0600
Message-Id: <1394315010-22481-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The mcookie should reuse existing code, and there is definitely no need
to prefer /dev/random for this utility.  See reference for explanation
about later statement.

References: http://www.2uo.de/myths-about-urandom/
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/randutils.h      |  1 +
 lib/randutils.c          | 19 ++++++++++++++++
 misc-utils/Makemodule.am |  1 +
 misc-utils/mcookie.1     | 45 +++++++++++++++-----------------------
 misc-utils/mcookie.c     | 57 +++++++++---------------------------------------
 5 files changed, 48 insertions(+), 75 deletions(-)

diff --git a/include/randutils.h b/include/randutils.h
index dec5e35..17e2a02 100644
--- a/include/randutils.h
+++ b/include/randutils.h
@@ -8,5 +8,6 @@
 
 extern int random_get_fd(void);
 extern void random_get_bytes(void *buf, size_t nbytes);
+extern const char *random_tell_source(void);
 
 #endif
diff --git a/lib/randutils.c b/lib/randutils.c
index 68bb0e1..7c49fd7 100644
--- a/lib/randutils.c
+++ b/lib/randutils.c
@@ -108,6 +108,25 @@ void random_get_bytes(void *buf, size_t nbytes)
 	return;
 }
 
+
+/*
+ * Tell source of randomness.
+ */
+const char *random_tell_source(void)
+{
+	const char *random_sources[] = {
+		"/dev/urandom",
+		"/dev/random",
+		"glibc pseudo-random functions"
+	};
+
+	if (!access(random_sources[0], R_OK))
+		return random_sources[0];
+	if (!access(random_sources[1], R_OK))
+		return random_sources[1];
+	return random_sources[2];
+}
+
 #ifdef TEST_PROGRAM
 int main(int argc __attribute__((__unused__)),
          char *argv[] __attribute__((__unused__)))
diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index 05407de..f31e4e1 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -32,6 +32,7 @@ look_SOURCES = misc-utils/look.c
 usrbin_exec_PROGRAMS += mcookie
 dist_man_MANS += misc-utils/mcookie.1
 mcookie_SOURCES = misc-utils/mcookie.c lib/md5.c
+mcookie_LDADD = $(LDADD) libcommon.la
 
 usrbin_exec_PROGRAMS += namei
 dist_man_MANS += misc-utils/namei.1
diff --git a/misc-utils/mcookie.1 b/misc-utils/mcookie.1
index fc7e030..df6137f 100644
--- a/misc-utils/mcookie.1
+++ b/misc-utils/mcookie.1
@@ -1,6 +1,6 @@
 .\" mcookie.1 --
 .\" Public Domain 1995 Rickard E. Faith (faith@cs.unc.edu)
-.TH MCOOKIE 1 "June 2011" "util-linux" "User Commands"
+.TH MCOOKIE 1 "March 2014" "util-linux" "User Commands"
 .SH NAME
 mcookie \- generate magic cookies for xauth
 .SH SYNOPSIS
@@ -15,23 +15,21 @@ xauth add :0 . `mcookie`
 .RE
 .PP
 The "random" number generated is actually the output of the MD5 message
-digest fed with various pieces of random information: the current time, the
-process id, the parent process id, and optionally the contents of an input
-file. and several bytes of information from the first of the following
-devices which is present:
-.IR /dev/random ,
+digest fed with random information from one of the sources
 .IR /dev/urandom ,
-files in
-.IR /proc ,
-.IR /dev/audio .
+.IR /dev/random ,
+or
+.I "glibc pseudo-random functions"
+in this preference order.
 .SH OPTIONS
 .TP
 \fB\-f\fR, \fB\-\-file\fR=\fIFILE\fR
-Use file as a macig cookie seed. When file is defined as `-' character
-input is read from stdin.
+Use additional file as a macig cookie random seed.  When file is defined
+as '-' character input is read from stdin.
 .TP
 \fB\-v\fR, \fB\-\-verbose\fR
-Explain what is being done.
+Inform where randomness originated, with amount of entropy read from each
+source.
 .TP
 \fB\-V\fR, \fB\-\-version\fR
 Display version information and exit.
@@ -39,27 +37,18 @@ Display version information and exit.
 \fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
 .SH BUGS
-The entropy in the generated 128-bit is probably quite small (and,
-therefore, vulnerable to attack) unless a non-pseudorandom number generator
-is used (e.g.,
-.I /dev/random
-under Linux).
-.PP
-It is assumed that none of the devices opened will block.
+It is assumed that none of the randomness sources will block.
 .SH FILES
-.I /dev/random
-.br
 .I /dev/urandom
 .br
-.I /dev/audio
-.br
-.I /proc/stat
-.br
-.I /proc/loadavg
+.I /dev/random
 .SH "SEE ALSO"
 .BR X (1),
 .BR xauth (1),
-.BR md5sum (1)
+.BR md5sum (1),
+.BR rand (3)
 .SH AVAILABILITY
 The mcookie command is part of the util-linux package and is available from
-ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
+.UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .
diff --git a/misc-utils/mcookie.c b/misc-utils/mcookie.c
index d7af3c2..63eeb5b 100644
--- a/misc-utils/mcookie.c
+++ b/misc-utils/mcookie.c
@@ -22,6 +22,7 @@
 #include "md5.h"
 #include "nls.h"
 #include "closestream.h"
+#include "randutils.h"
 
 #include <fcntl.h>
 #include <getopt.h>
@@ -31,21 +32,11 @@
 #include <sys/time.h>
 #include <unistd.h>
 
-#define BUFFERSIZE	4096
-
-struct rngs {
-	const char *path;
-	int minlength, maxlength;
-} rngs[] = {
-	{"/dev/random",		16, 16},  /* 16 bytes = 128 bits suffice */
-	{"/proc/interrupts",	 0,  0},
-	{"/proc/slabinfo",	 0,  0},
-	{"/proc/stat",		 0,  0},
-	{"/dev/urandom",	32, 64},
+enum {
+	BUFFERSIZE = 4096,
+	RAND_BYTES = 128
 };
 
-#define RNGS (sizeof(rngs)/sizeof(struct rngs))
-
 /* The basic function to hash a file */
 static off_t hash_file(struct MD5Context *ctx, int fd)
 {
@@ -83,15 +74,11 @@ int main(int argc, char **argv)
 	size_t i;
 	struct MD5Context ctx;
 	unsigned char digest[MD5LENGTH];
-	unsigned char buf[BUFFERSIZE];
+	unsigned char buf[RAND_BYTES];
 	int fd;
 	int c;
-	pid_t pid;
 	char *file = NULL;
 	int verbose = 0;
-	int r;
-	struct timeval tv;
-	struct timezone tz;
 
 	static const struct option longopts[] = {
 		{"file", required_argument, NULL, 'f'},
@@ -125,13 +112,6 @@ int main(int argc, char **argv)
 		}
 
 	MD5Init(&ctx);
-	gettimeofday(&tv, &tz);
-	MD5Update(&ctx, (unsigned char *) &tv, sizeof(tv));
-
-	pid = getppid();
-	MD5Update(&ctx, (unsigned char *) &pid, sizeof(pid));
-	pid = getpid();
-	MD5Update(&ctx, (unsigned char *) &pid, sizeof(pid));
 
 	if (file) {
 		int count = 0;
@@ -158,28 +138,11 @@ int main(int argc, char **argv)
 		}
 	}
 
-	for (i = 0; i < RNGS; i++) {
-		if ((fd = open(rngs[i].path, O_RDONLY | O_NONBLOCK)) >= 0) {
-			int count = sizeof(buf);
-
-			if (rngs[i].maxlength && count > rngs[i].maxlength)
-				count = rngs[i].maxlength;
-			r = read(fd, buf, count);
-			if (r > 0)
-				MD5Update(&ctx, buf, r);
-			else
-				r = 0;
-			close(fd);
-			if (verbose)
-				fprintf(stderr,
-					P_("Got %d byte from %s\n",
-					   "Got %d bytes from %s\n", r),
-					r, rngs[i].path);
-			if (rngs[i].minlength && r >= rngs[i].minlength)
-				break;
-		} else if (verbose)
-			warn(_("cannot open %s"), rngs[i].path);
-	}
+	random_get_bytes(&buf, RAND_BYTES);
+	MD5Update(&ctx, buf, RAND_BYTES);
+	if (verbose)
+		fprintf(stderr,
+			_("Got %d bytes from %s\n"), RAND_BYTES, random_tell_source());
 
 	MD5Final(digest, &ctx);
 	for (i = 0; i < MD5LENGTH; i++)
-- 
1.9.0

