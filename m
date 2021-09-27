Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE3DC433F5
	for <util-linux@archiver.kernel.org>; Mon, 27 Sep 2021 07:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFAB560F94
	for <util-linux@archiver.kernel.org>; Mon, 27 Sep 2021 07:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhI0HMX (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Sep 2021 03:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbhI0HMW (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 27 Sep 2021 03:12:22 -0400
Received: from mail.namespace.at (mail.namespace.at [IPv6:2a01:190:1801:100::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A36C061570
        for <util-linux@vger.kernel.org>; Mon, 27 Sep 2021 00:10:45 -0700 (PDT)
From:   Chris Hofstaedtler <zeha@debian.org>
To:     util-linux@vger.kernel.org
Cc:     Eduard Bloch <blade@debian.org>
Subject: [PATCH] Let user choose larger buffers for IO reading
Date:   Mon, 27 Sep 2021 09:07:23 +0200
Message-Id: <20210927070723.76950-1-zeha@debian.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Eduard Bloch <blade@debian.org>

Simultaneous reading of multiple files through a small one-page buffer
is slow with classic HDDs. Let the user improve it by chosing buffers of
several mebibytes if needed.

Signed-off-by: Eduard Bloch <blade@debian.org>
---
 misc-utils/hardlink.1.adoc |  6 +++++
 misc-utils/hardlink.c      | 50 ++++++++++++++++++++++++++++++++------
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/misc-utils/hardlink.1.adoc b/misc-utils/hardlink.1.adoc
index 1fab77d71..107cd6997 100644
--- a/misc-utils/hardlink.1.adoc
+++ b/misc-utils/hardlink.1.adoc
@@ -71,6 +71,12 @@ A regular expression to include files. If the option *--exclude* has been given,
 *-s*, *--minimum-size* _size_::
 The minimum size to consider. By default this is 1, so empty files will not be linked. The _size_ argument may be followed by the multiplicative suffixes KiB (=1024), MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is optional, e.g., "K" has the same meaning as "KiB").
 
+*-S*, *--buffer-size* _size_::
+The size of read buffer used when comparing file contents (default: 8KiB). This
+costs some additional memory but potentially reduces the amount of seek
+operations and therefore improve performance, especially with mechanic disk
+drives. Optional factor suffixes are supported, like with the *-s* option. This is mostly efficient with other filters (i.e. with *-f* or *-X*) and can be less efficient with *-top* options.
+
 == ARGUMENTS
 
 *hardlink* takes one or more directories which will be searched for files to be linked.
diff --git a/misc-utils/hardlink.c b/misc-utils/hardlink.c
index 29c8509e3..aeb486ce5 100644
--- a/misc-utils/hardlink.c
+++ b/misc-utils/hardlink.c
@@ -91,6 +91,10 @@ enum log_level {
 	JLOG_VERBOSE2
 };
 
+#ifndef DEF_SCAN_BUF_SIZE
+#define DEF_SCAN_BUF_SIZE 8192
+#endif
+
 /**
  * struct statistic - Statistics about the file
  * @started: Whether we are post command-line processing
@@ -144,6 +148,7 @@ static struct options {
 	unsigned int keep_oldest:1;
 	unsigned int dry_run:1;
 	uintmax_t min_size;
+	size_t buf_size;
 } opts = {
 	/* default setting */
 	.respect_mode = TRUE,
@@ -151,7 +156,8 @@ static struct options {
 	.respect_time = TRUE,
 	.respect_xattrs = FALSE,
 	.keep_oldest = FALSE,
-	.min_size = 1
+	.min_size = 1,
+  .buf_size = DEF_SCAN_BUF_SIZE
 };
 
 /*
@@ -163,6 +169,12 @@ static struct options {
 static void *files;
 static void *files_by_ino;
 
+/*
+ * Temporary buffers for reading file contents
+ */
+char *buf_a = NULL;
+char *buf_b = NULL;
+
 /*
  * last_signal
  *
@@ -523,8 +535,6 @@ static int file_contents_equal(const struct file *a, const struct file *b)
 {
 	FILE *fa = NULL;
 	FILE *fb = NULL;
-	char buf_a[8192];
-	char buf_b[8192];
 	int cmp = 0;		/* zero => equal */
 	off_t off = 0;		/* current offset */
 
@@ -550,11 +560,11 @@ static int file_contents_equal(const struct file *a, const struct file *b)
 		size_t ca;
 		size_t cb;
 
-		ca = fread(buf_a, 1, sizeof(buf_a), fa);
+		ca = fread(buf_a, 1, opts.buf_size, fa);
 		if (ca < sizeof(buf_a) && ferror(fa))
 			goto err;
 
-		cb = fread(buf_b, 1, sizeof(buf_b), fb);
+		cb = fread(buf_b, 1, opts.buf_size, fb);
 		if (cb < sizeof(buf_b) && ferror(fb))
 			goto err;
 
@@ -889,7 +899,8 @@ static void __attribute__((__noreturn__)) usage(void)
 		"                              (lower precedence than minimize/maximize)\n"), out);
 	fputs(_(" -x, --exclude <regex>      regular expression to exclude files\n"), out);
 	fputs(_(" -i, --include <regex>      regular expression to include files/dirs\n"), out);
-	fputs(_(" -s, --minimum-size <size>  minimum size for files.\n"), out);
+	fputs(_(" -s, --minimum-size=<size>  minimum size for files.\n"), out);
+        fputs(_(" -S, --buffer-size=<size>   Buffer size for file reading (speedup, using more RAM)\n"), out);
 	fputs(_(" -c, --content              compare only file contents, same as -pot\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
@@ -923,6 +934,20 @@ static void register_regex(struct regex_link **pregs, const char *regex)
 	link->next = *pregs; *pregs = link;
 }
 
+static int init_buffers(size_t bufsize)
+{
+	buf_a = malloc(bufsize);
+	buf_b = malloc(bufsize);
+	// report non-zero if any failed
+	return (NULL == buf_a || NULL == buf_b);
+}
+
+static void deinit_buffers(void)
+{
+	free(buf_a);
+	free(buf_b);
+}
+
 /**
  * parse_options - Parse the command line options
  * @argc: Number of options
@@ -930,7 +955,7 @@ static void register_regex(struct regex_link **pregs, const char *regex)
  */
 static int parse_options(int argc, char *argv[])
 {
-	static const char optstr[] = "VhvnfpotXcmMOx:i:s:q";
+	static const char optstr[] = "VhvnfpotXcmMOx:i:s:S:q";
 	static const struct option long_options[] = {
 		{"version", no_argument, NULL, 'V'},
 		{"help", no_argument, NULL, 'h'},
@@ -947,6 +972,7 @@ static int parse_options(int argc, char *argv[])
 		{"exclude", required_argument, NULL, 'x'},
 		{"include", required_argument, NULL, 'i'},
 		{"minimum-size", required_argument, NULL, 's'},
+		{"buffer-size", required_argument, NULL, 'S'},
 		{"content", no_argument, NULL, 'c'},
 		{"quiet", no_argument, NULL, 'q'},
 		{NULL, 0, NULL, 0}
@@ -1012,6 +1038,9 @@ static int parse_options(int argc, char *argv[])
 		case 's':
 			opts.min_size = strtosize_or_err(optarg, _("failed to parse size"));
 			break;
+		case 'S':
+			opts.buf_size = strtosize_or_err(optarg, _("failed to parse size"));
+			break;
 		case 'h':
 			usage();
 		case 'V':
@@ -1068,6 +1097,10 @@ int main(int argc, char *argv[])
 		errx(EXIT_FAILURE, _("no directory or file specified"));
 
 	gettime_monotonic(&stats.start_time);
+
+	if (init_buffers(opts.buf_size) != 0)
+		err(EXIT_FAILURE, _("failed to allocate buffer memory"));
+
 	stats.started = TRUE;
 
 	for (; optind < argc; optind++) {
@@ -1076,5 +1109,8 @@ int main(int argc, char *argv[])
 	}
 
 	twalk(files, visitor);
+
+	deinit_buffers();
+
 	return 0;
 }
-- 
2.33.0

