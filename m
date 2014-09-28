Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:40841 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbaI1TwU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:52:20 -0400
Received: by mail-wg0-f46.google.com with SMTP id k14so1864070wgh.17
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:52:19 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/23] textual: use version printing macro everywhere
Date: Sun, 28 Sep 2014 20:51:39 +0100
Message-Id: <1411933916-30576-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Only mount, umount, and blkid remains not using the macro because they
are print also library references.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/cfdisk.c       | 3 +--
 disk-utils/mkfs.minix.c   | 2 +-
 schedutils/chrt.c         | 3 +--
 schedutils/taskset.c      | 3 +--
 sys-utils/chcpu.c         | 3 +--
 sys-utils/dmesg.c         | 3 +--
 sys-utils/hwclock.c       | 2 +-
 sys-utils/lscpu.c         | 3 +--
 sys-utils/rtcwake.c       | 3 +--
 sys-utils/tunelp.c        | 3 +--
 term-utils/agetty.c       | 3 +--
 term-utils/script.c       | 3 +--
 term-utils/scriptreplay.c | 3 +--
 term-utils/write.c        | 4 +---
 text-utils/col.c          | 3 +--
 text-utils/colcrt.c       | 4 +---
 text-utils/colrm.c        | 4 +---
 text-utils/column.c       | 5 ++---
 text-utils/rev.c          | 3 +--
 text-utils/tailf.c        | 3 +--
 text-utils/ul.c           | 3 +--
 21 files changed, 22 insertions(+), 44 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index ef4e3ff..fabc397 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -2057,8 +2057,7 @@ int main(int argc, char *argv[])
 						_("unsupported color mode"));
 			break;
 		case 'V':
-			printf(_("%s from %s\n"), program_invocation_short_name,
-						  PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
 		case 'z':
 			cf->zero_start = 1;
diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 2dafc86..81b7ae3 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -665,7 +665,7 @@ int main(int argc, char ** argv) {
 
 	if (argc == 2 &&
 	    (!strcmp(argv[1], "-V") || !strcmp(argv[1], "--version"))) {
-		printf(_("%s (%s)\n"), program_name, PACKAGE_STRING);
+		printf(UTIL_LINUX_VERSION);
 		exit(MKFS_EX_OK);
 	}
 
diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index fec26fd..df115aa 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -261,8 +261,7 @@ int main(int argc, char **argv)
 			verbose = 1;
 			break;
 		case 'V':
-			printf(_("%s from %s\n"), program_invocation_short_name,
-			       PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
 		case 'h':
 			ret = EXIT_SUCCESS;
diff --git a/schedutils/taskset.c b/schedutils/taskset.c
index 6ebca06..4cda2eb 100644
--- a/schedutils/taskset.c
+++ b/schedutils/taskset.c
@@ -162,8 +162,7 @@ int main(int argc, char **argv)
 			ts.use_list = 1;
 			break;
 		case 'V':
-			printf(_("%s from %s\n"), program_invocation_short_name,
-			       PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
 		case 'h':
 			usage(stdout);
diff --git a/sys-utils/chcpu.c b/sys-utils/chcpu.c
index ada0eaa..aba9d6b 100644
--- a/sys-utils/chcpu.c
+++ b/sys-utils/chcpu.c
@@ -327,8 +327,7 @@ int main(int argc, char *argv[])
 			cmd = CMD_CPU_RESCAN;
 			break;
 		case 'V':
-			printf(_("%s from %s\n"), program_invocation_short_name,
-			       PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
 		default:
 			usage(stderr);
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index f95609f..53ac228 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -1332,8 +1332,7 @@ int main(int argc, char *argv[])
 				setbit(ctl.facilities, n);
 			break;
 		case 'V':
-			printf(_("%s from %s\n"), program_invocation_short_name,
-						  PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
 		case 'w':
 			ctl.follow = 1;
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index d0d422d..9151d24 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1543,7 +1543,7 @@ static int compare_clock (const bool utc, const bool local_opt)
 
 static void out_version(void)
 {
-	printf(_("%s from %s\n"), program_invocation_short_name, PACKAGE_STRING);
+	printf(UTIL_LINUX_VERSION);
 }
 
 /*
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 8827424..8ae7028 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1724,8 +1724,7 @@ int main(int argc, char *argv[])
 			mod->hex = 1;
 			break;
 		case 'V':
-			printf(_("%s from %s\n"), program_invocation_short_name,
-			       PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
 		default:
 			usage(stderr);
diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index 51ffb3c..e1cd41d 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -471,8 +471,7 @@ int main(int argc, char **argv)
 			break;
 
 		case 'V':
-			printf(_("%s from %s\n"),
-			       program_invocation_short_name, PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			exit(EXIT_SUCCESS);
 
 		case 'h':
diff --git a/sys-utils/tunelp.c b/sys-utils/tunelp.c
index 7beb8a7..08cef5c 100644
--- a/sys-utils/tunelp.c
+++ b/sys-utils/tunelp.c
@@ -255,8 +255,7 @@ int main(int argc, char **argv)
 #endif
 		case 'v':
 		case 'V':
-			printf(_("%s from %s\n"),
-			       program_invocation_short_name, PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
 		default:
 			print_usage(stderr);
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index a7044f0..5901228 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -770,8 +770,7 @@ static void parse_args(int argc, char **argv, struct options *op)
 			reload_agettys();
 			exit(EXIT_SUCCESS);
 		case VERSION_OPTION:
-			printf(_("%s from %s\n"), program_invocation_short_name,
-			       PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			exit(EXIT_SUCCESS);
 		case HELP_OPTION:
 			usage(stdout);
diff --git a/term-utils/script.c b/term-utils/script.c
index b9f8738..ad16e74 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -217,8 +217,7 @@ main(int argc, char **argv) {
 			tflg = 1;
 			break;
 		case 'V':
-			printf(_("%s from %s\n"), program_invocation_short_name,
-						  PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			exit(EXIT_SUCCESS);
 			break;
 		case 'h':
diff --git a/term-utils/scriptreplay.c b/term-utils/scriptreplay.c
index ecea592..8e0cb97 100644
--- a/term-utils/scriptreplay.c
+++ b/term-utils/scriptreplay.c
@@ -174,8 +174,7 @@ main(int argc, char *argv[])
 			maxdelay = getnum(optarg);
 			break;
 		case 'V':
-			printf(_("%s from %s\n"), program_invocation_short_name,
-						  PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			exit(EXIT_SUCCESS);
 		case 'h':
 			usage(stdout);
diff --git a/term-utils/write.c b/term-utils/write.c
index 146f4ba..4d217c4 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -110,9 +110,7 @@ int main(int argc, char **argv)
 	while ((c = getopt_long(argc, argv, "Vh", longopts, NULL)) != -1)
 		switch (c) {
 		case 'V':
-			printf(_("%s from %s\n"),
-			       program_invocation_short_name,
-			       PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
 		case 'h':
 			usage(stdout);
diff --git a/text-utils/col.c b/text-utils/col.c
index 997f87b..9b2f570 100644
--- a/text-utils/col.c
+++ b/text-utils/col.c
@@ -214,8 +214,7 @@ int main(int argc, char **argv)
 			compress_spaces = 0;
 			break;
 		case 'V':
-			printf(_("%s from %s\n"), program_invocation_short_name,
-						  PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
 		case 'H':
 			usage(stdout);
diff --git a/text-utils/colcrt.c b/text-utils/colcrt.c
index 6c7f636..a5d5977 100644
--- a/text-utils/colcrt.c
+++ b/text-utils/colcrt.c
@@ -115,9 +115,7 @@ int main(int argc, char **argv) {
 				printall = 1;
 				break;
 			case 'V':
-				printf(_("%s from %s\n"),
-					program_invocation_short_name,
-					PACKAGE_STRING);
+				printf(UTIL_LINUX_VERSION);
 				return EXIT_SUCCESS;
 			case 'h':
 				usage(stdout);
diff --git a/text-utils/colrm.c b/text-utils/colrm.c
index 454085e..111033d 100644
--- a/text-utils/colrm.c
+++ b/text-utils/colrm.c
@@ -171,9 +171,7 @@ int main(int argc, char **argv)
 			    NULL)) != -1)
 		switch (opt) {
 		case 'V':
-			printf(_("%s from %s\n"),
-			       program_invocation_short_name,
-			       PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
 		case 'h':
 			usage(stdout);
diff --git a/text-utils/column.c b/text-utils/column.c
index 0ee5a9e..e583dba 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -149,9 +149,8 @@ int main(int argc, char **argv)
 			usage(EXIT_SUCCESS);
 			break;
 		case 'V':
-			printf(_("%s from %s\n"), program_invocation_short_name,
-				 PACKAGE_STRING);
-				 return EXIT_SUCCESS;
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
 		case 'c':
 			termwidth = strtou32_or_err(optarg, _("invalid columns argument"));
 			break;
diff --git a/text-utils/rev.c b/text-utils/rev.c
index f1341cb..a661f0a 100644
--- a/text-utils/rev.c
+++ b/text-utils/rev.c
@@ -121,8 +121,7 @@ int main(int argc, char *argv[])
 	while ((ch = getopt_long(argc, argv, "Vh", longopts, NULL)) != -1)
 		switch(ch) {
 		case 'V':
-			printf(_("%s from %s\n"), program_invocation_short_name,
-						  PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			exit(EXIT_SUCCESS);
 		case 'h':
 			usage(stdout);
diff --git a/text-utils/tailf.c b/text-utils/tailf.c
index d2366a6..94f999e 100644
--- a/text-utils/tailf.c
+++ b/text-utils/tailf.c
@@ -261,8 +261,7 @@ int main(int argc, char **argv)
 					_("failed to parse number of lines"));
 			break;
 		case 'V':
-			printf(_("%s from %s\n"), program_invocation_short_name,
-						  PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			exit(EXIT_SUCCESS);
 		case 'h':
 			usage(stdout);
diff --git a/text-utils/ul.c b/text-utils/ul.c
index b3b3dc3..054f7b9 100644
--- a/text-utils/ul.c
+++ b/text-utils/ul.c
@@ -193,8 +193,7 @@ int main(int argc, char **argv)
 			iflag = 1;
 			break;
 		case 'V':
-			printf(_("%s from %s\n"), program_invocation_short_name,
-						  PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
 		case 'h':
 			usage(stdout);
-- 
2.1.1

