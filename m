Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:62147 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbaI1Tw3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:52:29 -0400
Received: by mail-wg0-f47.google.com with SMTP id b13so767677wgh.30
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:52:28 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/23] textual: use usage() text element macros
Date: Sun, 28 Sep 2014 20:51:41 +0100
Message-Id: <1411933916-30576-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Translating these text elements should happen only once, which is
more likely when the text macros are used properly.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.c         |  5 ++---
 login-utils/chfn.c        |  4 ++--
 misc-utils/getopt.c       | 12 +++++-------
 misc-utils/look.c         |  5 ++---
 misc-utils/namei.c        |  5 ++---
 misc-utils/uuidd.c        |  4 ++--
 misc-utils/uuidgen.c      |  4 ++--
 misc-utils/wipefs.c       |  5 ++---
 sys-utils/hwclock.c       |  4 ++--
 term-utils/script.c       |  4 ++--
 term-utils/scriptreplay.c |  4 ++--
 term-utils/write.c        |  8 ++++----
 text-utils/colrm.c        |  9 +++------
 text-utils/rev.c          |  8 +++-----
 14 files changed, 35 insertions(+), 46 deletions(-)

diff --git a/disk-utils/mkfs.c b/disk-utils/mkfs.c
index f10ba28..dbc938f 100644
--- a/disk-utils/mkfs.c
+++ b/disk-utils/mkfs.c
@@ -44,11 +44,10 @@
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
-	fprintf(out, _("Usage:\n"));
+	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] [-t <type>] [fs-options] <device> [<size>]\n"),
 		     program_invocation_short_name);
-
-	fprintf(out, _("\nOptions:\n"));
+	fputs(USAGE_OPTIONS, out);
 	fprintf(out, _(" -t, --type=<type>  filesystem type; when unspecified, ext2 is used\n"));
 	fprintf(out, _("     fs-options     parameters for the real filesystem builder\n"));
 	fprintf(out, _("     <device>       path to the device to be used\n"));
diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index ca10fbf..25f7e91 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -87,8 +87,8 @@ static void __attribute__((__noreturn__)) usage(FILE *fp)
 	fputs(_(" -p, --office-phone <phone>   office phone number\n"), fp);
 	fputs(_(" -h, --home-phone <phone>     home phone number\n"), fp);
 	fputs(USAGE_SEPARATOR, fp);
-	fputs(_(" -u, --help     display this help and exit\n"), fp);
-	fputs(_(" -v, --version  output version information and exit\n"), fp);
+	fputs(USAGE_HELP, fp);
+	fputs(USAGE_VERSION, fp);
 	fprintf(fp, USAGE_MAN_TAIL("chfn(1)"));
 	exit(fp == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index 74793ee..b82b62a 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -311,17 +311,15 @@ static void set_shell(const char *new_shell)
 
 static void __attribute__ ((__noreturn__)) print_help(void)
 {
-	fputs(_("\nUsage:\n"), stderr);
-
+	fputs(USAGE_HEADER, stderr);
 	fprintf(stderr, _(
 		" %1$s optstring parameters\n"
 		" %1$s [options] [--] optstring parameters\n"
 		" %1$s [options] -o|--options optstring [options] [--] parameters\n"),
 		program_invocation_short_name);
 
-	fputs(_("\nOptions:\n"), stderr);
+	fputs(USAGE_OPTIONS, stderr);
 	fputs(_(" -a, --alternative            Allow long options starting with single -\n"), stderr);
-	fputs(_(" -h, --help                   This small usage guide\n"), stderr);
 	fputs(_(" -l, --longoptions <longopts> Long options to be recognized\n"), stderr);
 	fputs(_(" -n, --name <progname>        The name under which errors are reported\n"), stderr);
 	fputs(_(" -o, --options <optstring>    Short options to be recognized\n"), stderr);
@@ -330,9 +328,9 @@ static void __attribute__ ((__noreturn__)) print_help(void)
 	fputs(_(" -s, --shell <shell>          Set shell quoting conventions\n"), stderr);
 	fputs(_(" -T, --test                   Test for getopt(1) version\n"), stderr);
 	fputs(_(" -u, --unquoted               Do not quote the output\n"), stderr);
-	fputs(_(" -V, --version                Output version information\n"), stderr);
-	fputc('\n', stderr);
-
+	fputs(USAGE_SEPARATOR, stderr);
+	fputs(USAGE_HELP, stderr);
+	fputs(USAGE_VERSION, stderr);
 	fprintf(stderr, USAGE_MAN_TAIL("getopt(1)"));
 	exit(PARAMETER_EXIT_CODE);
 }
diff --git a/misc-utils/look.c b/misc-utils/look.c
index d519cf6..51938f2 100644
--- a/misc-utils/look.c
+++ b/misc-utils/look.c
@@ -363,11 +363,10 @@ compare(char *s2, char *s2end) {
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
-	fputs(_("\nUsage:\n"), out),
+	fputs(USAGE_HEADER, out);
 	fprintf(out,
 	      _(" %s [options] string [file]\n"), program_invocation_short_name);
-
-	fputs(_("\nOptions:\n"), out);
+	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --alternative      use alternative dictionary\n"
 		" -d, --alphanum         compare only alphanumeric characters\n"
 		" -f, --ignore-case      ignore case differences when comparing\n"
diff --git a/misc-utils/namei.c b/misc-utils/namei.c
index a4496bc..ff58c9b 100644
--- a/misc-utils/namei.c
+++ b/misc-utils/namei.c
@@ -424,11 +424,10 @@ static void usage(int rc)
 	if (!*p)
 		p = "namei";
 
-	fputs(_("\nUsage:\n"), out);
+	fputs(USAGE_HEADER, out);
 	fprintf(out,
 	      _(" %s [options] <pathname>...\n"), p);
-
-	fputs(_("\nOptions:\n"), out);
+	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -h, --help          displays this help text\n"
 		" -V, --version       output version information and exit\n"
 		" -x, --mountpoints   show mount point directories with a 'D'\n"
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 8909b51..55aac35 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -68,11 +68,11 @@ struct uuidd_cxt_t {
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
-	fputs(_("\nUsage:\n"), out);
+	fputs(USAGE_HEADER, out);
 	fprintf(out,
 	      _(" %s [options]\n"), program_invocation_short_name);
 
-	fputs(_("\nOptions:\n"), out);
+	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -p, --pid <path>        path to pid file\n"
 		" -s, --socket <path>     path to socket\n"
 		" -T, --timeout <sec>     specify inactivity timeout\n"
diff --git a/misc-utils/uuidgen.c b/misc-utils/uuidgen.c
index 3883424..48c6562 100644
--- a/misc-utils/uuidgen.c
+++ b/misc-utils/uuidgen.c
@@ -28,11 +28,11 @@ extern int optind;
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
-	fputs(_("\nUsage:\n"), out);
+	fputs(USAGE_HEADER, out);
 	fprintf(out,
 	      _(" %s [options]\n"), program_invocation_short_name);
 
-	fputs(_("\nOptions:\n"), out);
+	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -r, --random     generate random-based uuid\n"
 		" -t, --time       generate time-based uuid\n"
 		" -V, --version    output version information and exit\n"
diff --git a/misc-utils/wipefs.c b/misc-utils/wipefs.c
index 0671bb4..70c3f23 100644
--- a/misc-utils/wipefs.c
+++ b/misc-utils/wipefs.c
@@ -448,11 +448,10 @@ do_wipe(struct wipe_desc *wp, const char *devname, int flags)
 static void __attribute__((__noreturn__))
 usage(FILE *out)
 {
-	fputs(_("\nUsage:\n"), out);
+	fputs(USAGE_HEADER, out);
 	fprintf(out,
 	      _(" %s [options] <device>\n"), program_invocation_short_name);
-
-	fputs(_("\nOptions:\n"), out);
+	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --all           wipe all magic strings (BE CAREFUL!)\n"
 		" -b, --backup        create a signature backup in $HOME\n"
 		" -f, --force         force erasure\n"
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 9151d24..493ee88 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1563,7 +1563,7 @@ static void usage(const char *fmt, ...)
 
 	usageto = fmt ? stderr : stdout;
 
-	fputs(_("\nUsage:\n"), usageto);
+	fputs(USAGE_HEADER, usageto);
 	fputs(_(" hwclock [function] [option...]\n"), usageto);
 
 	fputs(_("\nFunctions:\n"), usageto);
@@ -1584,7 +1584,7 @@ static void usage(const char *fmt, ...)
 	fputs(_("     --predict        predict RTC reading at time given with --date\n"
 		" -V, --version        display version information and exit\n"), usageto);
 
-	fputs(_("\nOptions:\n"), usageto);
+	fputs(USAGE_OPTIONS, usageto);
 	fputs(_(" -u, --utc            the hardware clock is kept in UTC\n"
 		"     --localtime      the hardware clock is kept in local time\n"), usageto);
 #ifdef __linux__
diff --git a/term-utils/script.c b/term-utils/script.c
index d2b8974..7d3787e 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -138,11 +138,11 @@ die_if_link(char *fn) {
 static void __attribute__((__noreturn__))
 usage(FILE *out)
 {
-	fputs(_("\nUsage:\n"), out);
+	fputs(USAGE_HEADER, out);
 	fprintf(out,
 	      _(" %s [options] [file]\n"), program_invocation_short_name);
 
-	fputs(_("\nOptions:\n"), out);
+	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --append            append the output\n"
 		" -c, --command <command> run command rather than interactive shell\n"
 		" -e, --return            return exit code of the child process\n"
diff --git a/term-utils/scriptreplay.c b/term-utils/scriptreplay.c
index 7ac50d8..fb5ded3 100644
--- a/term-utils/scriptreplay.c
+++ b/term-utils/scriptreplay.c
@@ -37,12 +37,12 @@
 static void __attribute__((__noreturn__))
 usage(FILE *out)
 {
-	fputs(_("\nUsage:\n"), out);
+	fputs(USAGE_HEADER, out);
 	fprintf(out,
 	      _(" %s [-t] timingfile [typescript] [divisor]\n"),
 	      program_invocation_short_name);
 
-	fputs(_("\nOptions:\n"), out);
+	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -t, --timing <file>     script timing output file\n"
 		" -s, --typescript <file> script terminal session output file\n"
 		" -d, --divisor <num>     speed up or slow down execution with time divisor\n"
diff --git a/term-utils/write.c b/term-utils/write.c
index e64bb43..ca40354 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -77,14 +77,14 @@ static gid_t root_access;
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
-	fputs(_("\nUsage:\n"), out);
+	fputs(USAGE_HEADER, out);
 	fprintf(out,
 	      _(" %s [options] <user> [<ttyname>]\n"),
 	      program_invocation_short_name);
 
-	fputs(_("\nOptions:\n"), out);
-	fputs(_(" -V, --version    output version information and exit\n"
-		" -h, --help       display this help and exit\n\n"), out);
+	fputs(USAGE_OPTIONS, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
 
 	fprintf(out, USAGE_MAN_TAIL("write(1)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
diff --git a/text-utils/colrm.c b/text-utils/colrm.c
index f67524a..4264fe6 100644
--- a/text-utils/colrm.c
+++ b/text-utils/colrm.c
@@ -59,14 +59,11 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fprintf(out, _("\nUsage:\n"
 		       " %s [startcol [endcol]]\n"),
 		       program_invocation_short_name);
-
-	fprintf(out, _("\nOptions:\n"
-		       " -V, --version   output version information and exit\n"
-		       " -h, --help      display this help and exit\n\n"));
-
+	fputs(USAGE_OPTIONS, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
 	fprintf(out, _("%s reads from standard input and writes to standard output\n\n"),
 		       program_invocation_short_name);
-
 	fprintf(out, USAGE_MAN_TAIL("colrm(1)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
diff --git a/text-utils/rev.c b/text-utils/rev.c
index 60ad752..bda31d2 100644
--- a/text-utils/rev.c
+++ b/text-utils/rev.c
@@ -76,11 +76,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out, _("Usage: %s [options] [file ...]\n"),
 		program_invocation_short_name);
-
-	fprintf(out, _("\nOptions:\n"
-		       " -V, --version   output version information and exit\n"
-		       " -h, --help      display this help and exit\n"));
-
+	fputs(USAGE_OPTIONS, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
 	fprintf(out, USAGE_MAN_TAIL("rev(1)"));
 
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
-- 
2.1.1

