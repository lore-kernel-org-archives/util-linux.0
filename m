Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:58709 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab3HQSRE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Aug 2013 14:17:04 -0400
Received: by mail-we0-f174.google.com with SMTP id q54so554637wes.33
        for <util-linux@vger.kernel.org>; Sat, 17 Aug 2013 11:17:03 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 15/16] last: allow --file to be defined multiple times
Date: Sat, 17 Aug 2013 19:15:20 +0100
Message-Id: <1376763321-22782-16-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
References: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is useful when an admin is trying to find something, and has to
process all available data.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.1 |   4 ++
 login-utils/last.c | 204 +++++++++++++++++++++++++++++------------------------
 2 files changed, 117 insertions(+), 91 deletions(-)

diff --git a/login-utils/last.1 b/login-utils/last.1
index c7d2aa6..321604d 100644
--- a/login-utils/last.1
+++ b/login-utils/last.1
@@ -76,6 +76,10 @@ Tell
 .B last
 to use a specific file instead of
 .BR /var/log/wtmp .
+The
+.BI \-\-file " file"
+can be specified multiple times, and all of the defined files will be
+processed.
 .TP
 \fB\-\fInumber\fR
 .TQ
diff --git a/login-utils/last.c b/login-utils/last.c
index 713719d..9f12772 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -477,7 +477,7 @@ static time_t parsetm(char *ts)
 	return tm;
 }
 
-int main(int argc, char **argv)
+static void process_wtmp_file(char *ufile, int lastb, int extended, time_t until)
 {
 	FILE *fp;		/* Filepointer of wtmp file */
 
@@ -495,95 +495,6 @@ int main(int argc, char **argv)
 	struct stat st;		/* To stat the [uw]tmp file */
 	int quit = 0;		/* Flag */
 	int down = 0;		/* Down flag */
-	int lastb = 0;		/* Is this 'lastb' ? */
-	int extended = 0;	/* Lots of info. */
-	char *altufile = NULL;	/* Alternate wtmp */
-
-	time_t until = 0;	/* at what time to stop parsing the file */
-
-	static const struct option long_opts[] = {
-	      { "limit",	required_argument, NULL, 'n' },
-	      { "help",	no_argument,       NULL, 'h' },
-	      { "file",       required_argument, NULL, 'f' },
-	      { "nohostname", no_argument,       NULL, 'R' },
-	      { "version",    no_argument,       NULL, 'V' },
-	      { "hostlast",   no_argument,       NULL, 'a' },
-	      { "until",      required_argument, NULL, 't' },
-	      { "system",     no_argument,       NULL, 'x' },
-	      { "dns",        no_argument,       NULL, 'd' },
-	      { "ip",         no_argument,       NULL, 'i' },
-	      { "fulltimes",  no_argument,       NULL, 'F' },
-	      { "fullnames",  no_argument,       NULL, 'w' },
-	      { NULL, 0, NULL, 0 }
-	};
-
-	setlocale(LC_ALL, "");
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	textdomain(PACKAGE);
-	atexit(close_stdout);
-
-	while ((c = getopt_long(argc, argv,
-			"hVf:n:RxadFit:0123456789w", long_opts, NULL)) != -1) {
-		switch(c) {
-		case 'h':
-			usage(stdout);
-			break;
-		case 'V':
-			printf(UTIL_LINUX_VERSION);
-			return EXIT_SUCCESS;
-		case 'R':
-			showhost = 0;
-			break;
-		case 'x':
-			extended = 1;
-			break;
-		case 'n':
-			maxrecs = strtos32_or_err(optarg, _("failed to parse number"));
-			break;
-		case 'f':
-			altufile = xstrdup(optarg);
-			break;
-		case 'd':
-			usedns++;
-			break;
-		case 'i':
-			useip++;
-			break;
-		case 'a':
-			altlist++;
-			break;
-		case 'F':
-			fulltime++;
-			break;
-		case 't':
-			until = parsetm(optarg);
-			if (until == (time_t) -1)
-				errx(EXIT_FAILURE, _("invalid time value \"%s\""), optarg);
-			break;
-		case 'w':
-			if (UT_NAMESIZE > name_len)
-				name_len = UT_NAMESIZE;
-			if (UT_HOSTSIZE > domain_len)
-				domain_len = UT_HOSTSIZE;
-			break;
-		case '0': case '1': case '2': case '3': case '4':
-		case '5': case '6': case '7': case '8': case '9':
-			maxrecs = 10 * maxrecs + c - '0';
-			break;
-		default:
-			usage(stderr);
-			break;
-		}
-	}
-
-	if (optind < argc)
-		show = argv + optind;
-
-	/*
-	 * Which file do we want to read?
-	 */
-	lastb = !strcmp(program_invocation_short_name, "lastb");
-	ufile = altufile ? altufile : lastb ? _PATH_BTMP : _PATH_WTMP;
 
 	time(&lastdown);
 	lastrch = lastdown;
@@ -807,6 +718,7 @@ int main(int argc, char **argv)
 			down = 0;
 		}
 	}
+	fclose(fp);
 
 	printf(_("\n%s begins "), basename(ufile));
 	if (fulltime) {
@@ -817,6 +729,116 @@ int main(int argc, char **argv)
 		puts(t);
 	} else
 		fputs(ctime(&begintime), stdout);
-	fclose(fp);
+
+}
+
+int main(int argc, char **argv)
+{
+	int c, i;		/* Scratch */
+	char **altv = NULL;	/* Alternate wtmp files */
+	int altc = 0;		/* Number of alternative files */
+	int lastb = 0;		/* Is this 'lastb' ? */
+	int extended = 0;	/* Lots of info. */
+
+	time_t until = 0;	/* at what time to stop parsing the file */
+
+	static const struct option long_opts[] = {
+	      { "limit",	required_argument, NULL, 'n' },
+	      { "help",	no_argument,       NULL, 'h' },
+	      { "file",       required_argument, NULL, 'f' },
+	      { "nohostname", no_argument,       NULL, 'R' },
+	      { "version",    no_argument,       NULL, 'V' },
+	      { "hostlast",   no_argument,       NULL, 'a' },
+	      { "until",      required_argument, NULL, 't' },
+	      { "system",     no_argument,       NULL, 'x' },
+	      { "dns",        no_argument,       NULL, 'd' },
+	      { "ip",         no_argument,       NULL, 'i' },
+	      { "fulltimes",  no_argument,       NULL, 'F' },
+	      { "fullnames",  no_argument,       NULL, 'w' },
+	      { NULL, 0, NULL, 0 }
+	};
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	while ((c = getopt_long(argc, argv,
+			"hVf:n:RxadFit:0123456789w", long_opts, NULL)) != -1) {
+		switch(c) {
+		case 'h':
+			usage(stdout);
+			break;
+		case 'V':
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
+		case 'R':
+			showhost = 0;
+			break;
+		case 'x':
+			extended = 1;
+			break;
+		case 'n':
+			maxrecs = strtos32_or_err(optarg, _("failed to parse number"));
+			break;
+		case 'f':
+			if (!altv)
+				altv = xmalloc(sizeof(char *) * argc);
+			altv[altc++] = xstrdup(optarg);
+			break;
+		case 'd':
+			usedns++;
+			break;
+		case 'i':
+			useip++;
+			break;
+		case 'a':
+			altlist++;
+			break;
+		case 'F':
+			fulltime++;
+			break;
+		case 't':
+			until = parsetm(optarg);
+			if (until == (time_t) -1)
+				errx(EXIT_FAILURE, _("invalid time value \"%s\""), optarg);
+			break;
+		case 'w':
+			if (UT_NAMESIZE > name_len)
+				name_len = UT_NAMESIZE;
+			if (UT_HOSTSIZE > domain_len)
+				domain_len = UT_HOSTSIZE;
+			break;
+		case '0': case '1': case '2': case '3': case '4':
+		case '5': case '6': case '7': case '8': case '9':
+			maxrecs = 10 * maxrecs + c - '0';
+			break;
+		default:
+			usage(stderr);
+			break;
+		}
+	}
+
+	if (optind < argc)
+		show = argv + optind;
+
+	/*
+	 * Which file do we want to read?
+	 */
+	lastb = !strcmp(program_invocation_short_name, "lastb");
+	if (!altc) {
+		altv = xmalloc(sizeof(char *));
+		if (lastb)
+			altv[0] = xstrdup(_PATH_BTMP);
+		else
+			altv[0] = xstrdup(_PATH_WTMP);
+		altc++;
+	}
+
+	for (i = 0; i < altc; i++) {
+		process_wtmp_file(altv[i], lastb, extended, until);
+		free(altv[i]);
+	}
+	free(altv);
 	return EXIT_SUCCESS;
 }
-- 
1.8.3.4

