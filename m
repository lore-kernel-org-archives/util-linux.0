Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:36777 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbaI1Tw1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:52:27 -0400
Received: by mail-wg0-f43.google.com with SMTP id a1so768963wgh.14
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:52:25 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/23] textual: use manual tail usage() macro
Date: Sun, 28 Sep 2014 20:51:40 +0100
Message-Id: <1411933916-30576-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.bfs.c     | 1 +
 disk-utils/mkfs.c         | 2 +-
 login-utils/lslogins.c    | 2 +-
 misc-utils/getopt.c       | 1 +
 misc-utils/look.c         | 1 +
 misc-utils/namei.c        | 2 +-
 misc-utils/uuidgen.c      | 1 +
 misc-utils/wipefs.c       | 2 +-
 schedutils/chrt.c         | 1 +
 schedutils/taskset.c      | 2 +-
 sys-utils/lscpu.c         | 2 +-
 term-utils/script.c       | 1 +
 term-utils/scriptreplay.c | 1 +
 term-utils/write.c        | 1 +
 text-utils/col.c          | 1 +
 text-utils/colcrt.c       | 1 +
 text-utils/colrm.c        | 1 +
 text-utils/rev.c          | 2 +-
 text-utils/tailf.c        | 1 +
 19 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/disk-utils/mkfs.bfs.c b/disk-utils/mkfs.bfs.c
index 23098e4..c2c2389 100644
--- a/disk-utils/mkfs.bfs.c
+++ b/disk-utils/mkfs.bfs.c
@@ -83,6 +83,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 		       "                     -V as version must be only option\n"
 		       " -h, --help          display this help and exit\n\n"));
 
+	fprintf(out, USAGE_MAN_TAIL("mkfs.bfs(8)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
diff --git a/disk-utils/mkfs.c b/disk-utils/mkfs.c
index 5bdb931..f10ba28 100644
--- a/disk-utils/mkfs.c
+++ b/disk-utils/mkfs.c
@@ -59,7 +59,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 		       "                      -V as --version must be the only option\n"));
 	fprintf(out, _(" -h, --help         display this help text and exit\n"));
 
-	fprintf(out, _("\nFor more information see mkfs(8).\n"));
+	fprintf(out, USAGE_MAN_TAIL("mkfs(8)"));
 
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 9183183..1e0eb5a 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -1216,7 +1216,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		fprintf(out, " %14s  %s\n", coldescs[i].name,
 				_(coldescs[i].help));
 
-	fprintf(out, _("\nFor more details see lslogins(1).\n"));
+	fprintf(out, USAGE_MAN_TAIL("lslogins(1)"));
 
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index 7630173..74793ee 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -333,6 +333,7 @@ static void __attribute__ ((__noreturn__)) print_help(void)
 	fputs(_(" -V, --version                Output version information\n"), stderr);
 	fputc('\n', stderr);
 
+	fprintf(stderr, USAGE_MAN_TAIL("getopt(1)"));
 	exit(PARAMETER_EXIT_CODE);
 }
 
diff --git a/misc-utils/look.c b/misc-utils/look.c
index 502168b..d519cf6 100644
--- a/misc-utils/look.c
+++ b/misc-utils/look.c
@@ -375,5 +375,6 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 		" -V, --version          output version information and exit\n"
 		" -h, --help             display this help and exit\n\n"), out);
 
+	fprintf(out, USAGE_MAN_TAIL("look(1)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
diff --git a/misc-utils/namei.c b/misc-utils/namei.c
index cac0e6c..a4496bc 100644
--- a/misc-utils/namei.c
+++ b/misc-utils/namei.c
@@ -438,7 +438,7 @@ static void usage(int rc)
 		" -n, --nosymlinks    don't follow symlinks\n"
 		" -v, --vertical      vertical align of modes and owners\n"), out);
 
-	fputs(_("\nFor more information see namei(1).\n"), out);
+	fprintf(out, USAGE_MAN_TAIL("namei(1)"));
 	exit(rc);
 }
 
diff --git a/misc-utils/uuidgen.c b/misc-utils/uuidgen.c
index 0c844d2..3883424 100644
--- a/misc-utils/uuidgen.c
+++ b/misc-utils/uuidgen.c
@@ -38,6 +38,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 		" -V, --version    output version information and exit\n"
 		" -h, --help       display this help and exit\n\n"), out);
 
+	fprintf(out, USAGE_MAN_TAIL("uuidgen(1)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
diff --git a/misc-utils/wipefs.c b/misc-utils/wipefs.c
index 58a643e..0671bb4 100644
--- a/misc-utils/wipefs.c
+++ b/misc-utils/wipefs.c
@@ -464,7 +464,7 @@ usage(FILE *out)
 		" -t, --types <list>  limit the set of filesystem, RAIDs or partition tables\n"
 		" -V, --version       output version information and exit\n"), out);
 
-	fprintf(out, _("\nFor more information see wipefs(8).\n"));
+	fprintf(out, USAGE_MAN_TAIL("wipefs(8)"));
 
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index df115aa..7988b2a 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -86,6 +86,7 @@ static void __attribute__((__noreturn__)) show_usage(int rc)
 	"  -v | --verbose       display status information\n"
 	"  -V | --version       output version information\n\n"));
 
+	fprintf(out, USAGE_MAN_TAIL("chrt(1)"));
 	exit(rc);
 }
 
diff --git a/schedutils/taskset.c b/schedutils/taskset.c
index 4cda2eb..1bf1291 100644
--- a/schedutils/taskset.c
+++ b/schedutils/taskset.c
@@ -72,7 +72,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		"    e.g. 0-31:2 is equivalent to mask 0x55555555\n"),
 		program_invocation_short_name);
 
-	fprintf(out, _("\nFor more information see taskset(1).\n"));
+	fprintf(out, USAGE_MAN_TAIL("taskset(1)"));
 
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 8ae7028..ef59410 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1646,7 +1646,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	for (i = 0; i < ARRAY_SIZE(coldescs); i++)
 		fprintf(out, " %13s  %s\n", coldescs[i].name, _(coldescs[i].help));
 
-	fprintf(out, _("\nFor more details see lscpu(1).\n"));
+	fprintf(out, USAGE_MAN_TAIL("lscpu(1)"));
 
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
diff --git a/term-utils/script.c b/term-utils/script.c
index ad16e74..d2b8974 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -153,6 +153,7 @@ usage(FILE *out)
 		" -V, --version           output version information and exit\n"
 		" -h, --help              display this help and exit\n\n"), out);
 
+	fprintf(out, USAGE_MAN_TAIL("script(1)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
diff --git a/term-utils/scriptreplay.c b/term-utils/scriptreplay.c
index 8e0cb97..7ac50d8 100644
--- a/term-utils/scriptreplay.c
+++ b/term-utils/scriptreplay.c
@@ -50,6 +50,7 @@ usage(FILE *out)
 		" -V, --version           output version information and exit\n"
 		" -h, --help              display this help and exit\n\n"), out);
 
+	fprintf(out, USAGE_MAN_TAIL("scriptreplay(1)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
diff --git a/term-utils/write.c b/term-utils/write.c
index 4d217c4..e64bb43 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -86,6 +86,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(_(" -V, --version    output version information and exit\n"
 		" -h, --help       display this help and exit\n\n"), out);
 
+	fprintf(out, USAGE_MAN_TAIL("write(1)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
diff --git a/text-utils/col.c b/text-utils/col.c
index 9b2f570..1218f25 100644
--- a/text-utils/col.c
+++ b/text-utils/col.c
@@ -145,6 +145,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		"%s reads from standard input and writes to standard output\n\n"),
 		program_invocation_short_name);
 
+	fprintf(out, USAGE_MAN_TAIL("col(1)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
diff --git a/text-utils/colcrt.c b/text-utils/colcrt.c
index a5d5977..c39c8b6 100644
--- a/text-utils/colcrt.c
+++ b/text-utils/colcrt.c
@@ -319,5 +319,6 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 		  " -V, --version         output version information and exit\n"
 		  " -h, --help            display this help and exit\n\n"));
 
+	fprintf(out, USAGE_MAN_TAIL("colcrt(1)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
diff --git a/text-utils/colrm.c b/text-utils/colrm.c
index 111033d..f67524a 100644
--- a/text-utils/colrm.c
+++ b/text-utils/colrm.c
@@ -67,6 +67,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fprintf(out, _("%s reads from standard input and writes to standard output\n\n"),
 		       program_invocation_short_name);
 
+	fprintf(out, USAGE_MAN_TAIL("colrm(1)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
diff --git a/text-utils/rev.c b/text-utils/rev.c
index a661f0a..60ad752 100644
--- a/text-utils/rev.c
+++ b/text-utils/rev.c
@@ -81,7 +81,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 		       " -V, --version   output version information and exit\n"
 		       " -h, --help      display this help and exit\n"));
 
-	fprintf(out, _("\nFor more information see rev(1).\n"));
+	fprintf(out, USAGE_MAN_TAIL("rev(1)"));
 
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
diff --git a/text-utils/tailf.c b/text-utils/tailf.c
index 94f999e..bd38da2 100644
--- a/text-utils/tailf.c
+++ b/text-utils/tailf.c
@@ -205,6 +205,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 		" -V, --version       output version information and exit\n"
 		" -h, --help          display this help and exit\n\n"));
 
+	fprintf(out, USAGE_MAN_TAIL("tailf(1)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-- 
2.1.1

