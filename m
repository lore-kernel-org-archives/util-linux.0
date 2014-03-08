Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oa0-f41.google.com ([209.85.219.41]:57932 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbaCHVni (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Mar 2014 16:43:38 -0500
Received: by mail-oa0-f41.google.com with SMTP id j17so5662603oag.14
        for <util-linux@vger.kernel.org>; Sat, 08 Mar 2014 13:43:37 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/5] mcookie: use control structure, and fix usage()
Date: Sat,  8 Mar 2014 15:43:29 -0600
Message-Id: <1394315010-22481-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1394315010-22481-1-git-send-email-kerolasa@iki.fi>
References: <1394315010-22481-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/mcookie.c | 95 +++++++++++++++++++++++++++-------------------------
 1 file changed, 49 insertions(+), 46 deletions(-)

diff --git a/misc-utils/mcookie.c b/misc-utils/mcookie.c
index 9167440..31f33e4 100644
--- a/misc-utils/mcookie.c
+++ b/misc-utils/mcookie.c
@@ -38,78 +38,82 @@ enum {
 	RAND_BYTES = 128
 };
 
+struct mcookie_control {
+	struct MD5Context ctx;
+	char **files;
+	int nfiles;
+	int fd;
+	unsigned int
+		verbose:1;
+};
+
 /* The basic function to hash a file */
-static size_t hash_file(struct MD5Context *ctx, int fd)
+static size_t hash_file(struct mcookie_control *ctl)
 {
 	size_t count = 0;
 	ssize_t r;
 	unsigned char buf[BUFFERSIZE];
 
-	while ((r = read(fd, buf, sizeof(buf))) > 0) {
-		MD5Update(ctx, buf, r);
+	while ((r = read(ctl->fd, buf, sizeof(buf))) > 0) {
+		MD5Update(&(ctl->ctx), buf, r);
 		count += r;
 	}
 	/* Separate files with a null byte */
 	buf[0] = '\0';
-	MD5Update(ctx, buf, 1);
+	MD5Update(&(ctl->ctx), buf, 1);
 	return count;
 }
 
 static void __attribute__((__noreturn__)) usage(FILE * out)
 {
-	fputs(_("\nUsage:\n"), out);
-	fprintf(out,
-	      _(" %s [options]\n"), program_invocation_short_name);
-
-	fputs(_("\nOptions:\n"), out);
-	fputs(_(" -f, --file <file> use file as a cookie seed\n"
-		" -v, --verbose     explain what is being done\n"
-		" -V, --version     output version information and exit\n"
-		" -h, --help        display this help and exit\n\n"), out);
-
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(" %s [options]\n"), program_invocation_short_name);
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -f, --file <file>     use file as a cookie seed\n"), out);
+	fputs(_(" -v, --verbose         explain what is being done\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("mcookie(1)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-static void randomness_from_files(char **files, int nfiles,
-				  struct MD5Context *ctx, int verbose)
+static void randomness_from_files(struct mcookie_control *ctl)
 {
-	int fd, i;
+	int i;
 	size_t count = 0;
 
-	for (i = 0; i < nfiles; i++) {
-		if (files[i][0] == '-' && !files[i][1])
-			fd = STDIN_FILENO;
+	for (i = 0; i < ctl->nfiles; i++) {
+		if (ctl->files[i][0] == '-' && !ctl->files[i][1])
+			ctl->fd = STDIN_FILENO;
 		else
-			fd = open(files[i], O_RDONLY);
+			ctl->fd = open(ctl->files[i], O_RDONLY);
 
-		if (fd < 0) {
-			warn(_("cannot open %s"), files[i]);
+		if (ctl->fd < 0) {
+			warn(_("cannot open %s"), ctl->files[i]);
 		} else {
-			count = hash_file(ctx, fd);
-			if (verbose)
+			count = hash_file(ctl);
+			if (ctl->verbose)
 				fprintf(stderr,
 					P_("Got %zu byte from %s\n",
 					   "Got %zu bytes from %s\n", count),
-					count, files[i]);
+					count, ctl->files[i]);
 
-			if (fd != STDIN_FILENO)
-				if (close(fd))
+			if (ctl->fd != STDIN_FILENO)
+				if (close(ctl->fd))
 					err(EXIT_FAILURE,
-					    _("closing %s failed"), files[i]);
+					    _("closing %s failed"), ctl->files[i]);
 		}
 	}
 }
 
 int main(int argc, char **argv)
 {
+	struct mcookie_control ctl;
 	size_t i;
-	struct MD5Context ctx;
 	unsigned char digest[MD5LENGTH];
 	unsigned char buf[RAND_BYTES];
-	char **files = NULL;
-	int nfiles;
 	int c;
-	int verbose = 0;
 
 	static const struct option longopts[] = {
 		{"file", required_argument, NULL, 'f'},
@@ -124,22 +128,21 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	MD5Init(&ctx);
+	memset(&ctl, 0, sizeof(ctl));
+	MD5Init(&(ctl.ctx));
 
-	if (2 < argc) {
-		files = xmalloc(sizeof(char *) * argc);
-		nfiles = 0;
-	}
+	if (2 < argc)
+		ctl.files = xmalloc(sizeof(char *) * argc);
 
 	while ((c =
 		getopt_long(argc, argv, "f:vVh", longopts, NULL)) != -1)
 		switch (c) {
 		case 'v':
-			verbose = 1;
+			ctl.verbose = 1;
 			break;
 		case 'f':
-			files[nfiles] = optarg;
-			nfiles++;
+			ctl.files[ctl.nfiles] = optarg;
+			ctl.nfiles++;
 			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
@@ -150,16 +153,16 @@ int main(int argc, char **argv)
 			usage(stderr);
 		}
 
-	randomness_from_files(files, nfiles, &ctx, verbose);
-	free(files);
+	randomness_from_files(&ctl);
+	free(ctl.files);
 
 	random_get_bytes(&buf, RAND_BYTES);
-	MD5Update(&ctx, buf, RAND_BYTES);
-	if (verbose)
+	MD5Update(&(ctl.ctx), buf, RAND_BYTES);
+	if (ctl.verbose)
 		fprintf(stderr,
 			_("Got %d bytes from %s\n"), RAND_BYTES, random_tell_source());
 
-	MD5Final(digest, &ctx);
+	MD5Final(digest, &(ctl.ctx));
 	for (i = 0; i < MD5LENGTH; i++)
 		printf("%02x", digest[i]);
 	putchar('\n');
-- 
1.9.0

