Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35006 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099AbbJML3X (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 13 Oct 2015 07:29:23 -0400
Received: by wicge5 with SMTP id ge5so186603638wic.0
        for <util-linux@vger.kernel.org>; Tue, 13 Oct 2015 04:29:22 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/8] last: display input file in usage() according to command name
Date: Tue, 13 Oct 2015 12:29:07 +0100
Message-Id: <1444735754-18976-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1444735754-18976-1-git-send-email-kerolasa@iki.fi>
References: <1444735754-18976-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Default depends on whether the executable is called 'lastb' or something
else.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 8d82c10..dbfa8ae 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -543,7 +543,7 @@ static int list(const struct last_control *ctl, struct utmp *p, time_t logout_ti
 }
 
 
-static void __attribute__((__noreturn__)) usage(FILE *out)
+static void __attribute__((__noreturn__)) usage(const struct last_control *ctl, FILE *out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(
@@ -557,7 +557,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -a, --hostlast       display hostnames in the last column\n"), out);
 	fputs(_(" -d, --dns            translate the IP number back into a hostname\n"), out);
 	fprintf(out,
-	      _(" -f, --file <file>    use a specific file instead of %s\n"), _PATH_WTMP);
+	      _(" -f, --file <file>    use a specific file instead of %s\n"), ctl->lastb ? _PATH_BTMP : _PATH_WTMP);
 	fputs(_(" -F, --fulltimes      print full login and logout times and dates\n"), out);
 	fputs(_(" -i, --ip             display IP numbers in numbers-and-dots notation\n"), out);
 	fputs(_(" -n, --limit <number> how many lines to show\n"), out);
@@ -911,7 +911,10 @@ int main(int argc, char **argv)
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 	atexit(close_stdout);
-
+	/*
+	 * Which file do we want to read?
+	 */
+	ctl.lastb = strcmp(program_invocation_short_name, "lastb") == 0 ? 1 : 0;
 	while ((c = getopt_long(argc, argv,
 			"hVf:n:RxadFit:p:s:0123456789w", long_opts, NULL)) != -1) {
 
@@ -919,7 +922,7 @@ int main(int argc, char **argv)
 
 		switch(c) {
 		case 'h':
-			usage(stdout);
+			usage(&ctl, stdout);
 			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
@@ -979,7 +982,7 @@ int main(int argc, char **argv)
 			ctl.time_fmt = which_time_format(optarg);
 			break;
 		default:
-			usage(stderr);
+			usage(&ctl, stderr);
 			break;
 		}
 	}
@@ -987,10 +990,6 @@ int main(int argc, char **argv)
 	if (optind < argc)
 		ctl.show = argv + optind;
 
-	/*
-	 * Which file do we want to read?
-	 */
-	ctl.lastb = strcmp(program_invocation_short_name, "lastb") == 0 ? 1 : 0;
 	if (!files) {
 		files = xmalloc(sizeof(char *));
 		files[nfiles++] = xstrdup(ctl.lastb ? _PATH_BTMP : _PATH_WTMP);
-- 
2.6.1

