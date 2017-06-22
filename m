Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:53207 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751154AbdFVChv (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Jun 2017 22:37:51 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbxQO-1e74Ar1hCO-00jFrU for
 <util-linux@vger.kernel.org>; Thu, 22 Jun 2017 04:37:49 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 12/13] mkfs.cramfs: add --help and --version
Date: Thu, 22 Jun 2017 04:37:45 +0200
Message-Id: <1498099066-24235-13-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
References: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Note, we were already using errtryhelp() without providing
a --help option.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/mkfs.cramfs.8 |  8 ++++----
 disk-utils/mkfs.cramfs.c | 33 +++++++++++++++++++++++----------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/disk-utils/mkfs.cramfs.8 b/disk-utils/mkfs.cramfs.8
index c2e843a..9701e10 100644
--- a/disk-utils/mkfs.cramfs.8
+++ b/disk-utils/mkfs.cramfs.8
@@ -64,11 +64,11 @@ sorting.
 \fB\-z\fR
 Make explicit holes.  Use of this option will require 2.3.39 kernel, or newer.
 .TP
-\fB\-V\fR
-Display version information and exit.
+\fB\-h\fR, \fB\-\-help\fR
+Display help text and exit.
 .TP
-\fB\-h\fR
-Display help and exit.
+\fB\-V\fR, \fB\-\-version\fR
+Display version information and exit.
 .SH "EXIT STATUS"
 .RS
 .PD 0
diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index 041c6d7..ed4b927 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -122,12 +122,9 @@ struct entry {
 #define CRAMFS_GID_WIDTH 8
 #define CRAMFS_OFFSET_WIDTH 26
 
-/* Input status of 0 to print help and exit without an error. */
-static void __attribute__((__noreturn__))
-usage(int status) {
-	FILE *stream = status ? stderr : stdout;
-
-	fprintf(stream,
+static void __attribute__((__noreturn__)) usage(void)
+{
+	printf(
 		_("usage: %s [-h] [-v] [-b blksize] [-e edition] [-N endian] [-i file] "
 		  "[-n name] dirname outfile\n"
 		  " -h         print this help\n"
@@ -147,7 +144,11 @@ usage(int status) {
 		  " outfile    output file\n"),
 		program_invocation_short_name, PAD_SIZE);
 
-	exit(status);
+	fputs(USAGE_SEPARATOR, stdout);
+	fputs(USAGE_HELP, stdout);
+	fputs(USAGE_VERSION, stdout);
+	printf(USAGE_MAN_TAIL("mkfs.cramfs(8)"));
+	exit(MKFS_EX_OK);
 }
 
 static char *
@@ -717,11 +718,21 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
+	if (argc > 1) {
+		/* first arg may be one of our standard longopts */
+		if (!strcmp(argv[1], "--help"))
+			usage();
+		if (!strcmp(argv[1], "--version")) {
+			printf(UTIL_LINUX_VERSION);
+			exit(EXIT_SUCCESS);
+		}
+	}
+
 	/* command line options */
 	while ((c = getopt(argc, argv, "hb:Ee:i:n:N:psVvz")) != EOF) {
 		switch (c) {
 		case 'h':
-			usage(MKFS_EX_OK);
+			usage();
 		case 'b':
 			blksize = strtou32_or_err(optarg, _("invalid blocksize argument"));
 			break;
@@ -773,8 +784,10 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if ((argc - optind) != 2)
-		usage(MKFS_EX_USAGE);
+	if ((argc - optind) != 2) {
+		warnx(_("bad usage"));
+		errtryhelp(MKFS_EX_USAGE);
+	}
 	dirname = argv[optind];
 	outfile = argv[optind + 1];
 
-- 
1.8.5.6

