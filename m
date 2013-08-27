Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f42.google.com ([74.125.83.42]:58692 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab3H0SHO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Aug 2013 14:07:14 -0400
Received: by mail-ee0-f42.google.com with SMTP id b45so2442256eek.29
        for <util-linux@vger.kernel.org>; Tue, 27 Aug 2013 11:07:13 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/17] last: add --since time spec option
Date: Tue, 27 Aug 2013 19:06:14 +0100
Message-Id: <1377626779-26030-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The --since and --until options are companions often needed together.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index df78436..c23469e 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -426,8 +426,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -i, --ip             display IP numbers in numbers-and-dots notation\n"), out);
 	fputs(_(" -n, --limit <number> how many lines to show\n"), out);
 	fputs(_(" -R, --nohostname     don't display the hostname field\n"), out);
-	fputs(_(" -t, --until <YYYYMMDDHHMMSS>  display the state of the specified time\n"), out);
-	fputs(_(" -p, --present <YYYYMMDDHHMMSS>  display who where present at the specified time\n"), out);
+	fputs(_(" -s, --since <time>   display the lines since the specified time\n"), out);
+	fputs(_(" -t, --until <time>   display the lines until the specified time\n"), out);
+	fputs(_(" -p, --present <time> display who where present at the specified time\n"), out);
 	fputs(_(" -w, --fullnames      display full user and domain names\n"), out);
 	fputs(_(" -x, --system         display system shutdown entries and run level changes\n"), out);
 
@@ -480,7 +481,7 @@ static time_t parsetm(char *ts)
 }
 
 static void process_wtmp_file(char *ufile, int lastb, int extended,
-			      time_t until, time_t present)
+			      time_t since, time_t until, time_t present)
 {
 	FILE *fp;		/* Filepointer of wtmp file */
 
@@ -549,6 +550,9 @@ static void process_wtmp_file(char *ufile, int lastb, int extended,
 		if (uread(fp, &ut, &quit) != 1)
 			break;
 
+		if (since && ut.ut_time < since)
+			continue;
+
 		if (until && until < ut.ut_time)
 			continue;
 
@@ -734,7 +738,8 @@ int main(int argc, char **argv)
 	int lastb = 0;		/* Is this 'lastb' ? */
 	int extended = 0;	/* Lots of info. */
 
-	time_t until = 0;	/* at what time to stop parsing the file */
+	time_t since = 0;	/* at what time to start displaying the file */
+	time_t until = 0;	/* at what time to stop displaying the file */
 	time_t present = 0;	/* who where present at time_t */
 	usec_t p;
 
@@ -745,6 +750,7 @@ int main(int argc, char **argv)
 	      { "nohostname", no_argument,       NULL, 'R' },
 	      { "version",    no_argument,       NULL, 'V' },
 	      { "hostlast",   no_argument,       NULL, 'a' },
+	      { "since",      required_argument, NULL, 's' },
 	      { "until",      required_argument, NULL, 't' },
 	      { "present",    required_argument, NULL, 'p' },
 	      { "system",     no_argument,       NULL, 'x' },
@@ -761,7 +767,7 @@ int main(int argc, char **argv)
 	atexit(close_stdout);
 
 	while ((c = getopt_long(argc, argv,
-			"hVf:n:RxadFit:p:0123456789w", long_opts, NULL)) != -1) {
+			"hVf:n:RxadFit:p:s:0123456789w", long_opts, NULL)) != -1) {
 		switch(c) {
 		case 'h':
 			usage(stdout);
@@ -803,6 +809,14 @@ int main(int argc, char **argv)
 				errx(EXIT_FAILURE, _("invalid time value \"%s\""), optarg);
 			present = (time_t) (p / 1000000);
 			break;
+		case 's':
+			since = parsetm(optarg);
+			if (since != (time_t) -1)
+				break;
+			if (parse_timestamp(optarg, &p) < 0)
+				errx(EXIT_FAILURE, _("invalid time value \"%s\""), optarg);
+			since = (time_t) (p / 1000000);
+			break;
 		case 't':
 			until = parsetm(optarg);
 			if (until != (time_t) -1)
@@ -844,7 +858,7 @@ int main(int argc, char **argv)
 	}
 
 	for (i = 0; i < altc; i++) {
-		process_wtmp_file(altv[i], lastb, extended, until, present);
+		process_wtmp_file(altv[i], lastb, extended, since, until, present);
 		free(altv[i]);
 	}
 	free(altv);
-- 
1.8.4

