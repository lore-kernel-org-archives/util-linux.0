Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33760 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab3HQSRM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Aug 2013 14:17:12 -0400
Received: by mail-wi0-f175.google.com with SMTP id hq12so1857726wib.2
        for <util-linux@vger.kernel.org>; Sat, 17 Aug 2013 11:17:10 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 16/16] last: add --present option
Date: Sat, 17 Aug 2013 19:15:21 +0100
Message-Id: <1376763321-22782-17-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
References: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The --present option will allow user to easily determine who where logged
in at a given time.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 9f12772..616be97 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -250,7 +250,7 @@ static int dns_lookup(char *result, int size, int useip, int32_t *a)
 /*
  *	Show one line of information on screen
  */
-static int list(struct utmp *p, time_t t, int what)
+static int list(struct utmp *p, time_t t, int what, time_t present)
 {
 	time_t		secs, tmp;
 	struct tm	*tm;
@@ -292,6 +292,8 @@ static int list(struct utmp *p, time_t t, int what)
 	 *	Calculate times
 	 */
 	tmp = (time_t)p->ut_time;
+	if (present && (present < tmp || 0 == t || t < present))
+		return 0;
 	if (fulltime) {
 		tm = localtime(&tmp);
 		strftime(logintime, sizeof(logintime), "%Y-%m-%dT%H:%M:%S%z", tm);
@@ -426,6 +428,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -n, --limit <number> how many lines to show\n"), out);
 	fputs(_(" -R, --nohostname     don't display the hostname field\n"), out);
 	fputs(_(" -t, --until <YYYYMMDDHHMMSS>  display the state of the specified time\n"), out);
+	fputs(_(" -p, --present <YYYYMMDDHHMMSS>  display who where present at the specified time\n"), out);
 	fputs(_(" -w, --fullnames      display full user and domain names\n"), out);
 	fputs(_(" -x, --system         display system shutdown entries and run level changes\n"), out);
 
@@ -477,7 +480,8 @@ static time_t parsetm(char *ts)
 	return tm;
 }
 
-static void process_wtmp_file(char *ufile, int lastb, int extended, time_t until)
+static void process_wtmp_file(char *ufile, int lastb, int extended,
+			      time_t until, time_t present)
 {
 	FILE *fp;		/* Filepointer of wtmp file */
 
@@ -552,7 +556,7 @@ static void process_wtmp_file(char *ufile, int lastb, int extended, time_t until
 		lastdate = ut.ut_time;
 
 		if (lastb) {
-			quit = list(&ut, ut.ut_time, R_NORMAL);
+			quit = list(&ut, ut.ut_time, R_NORMAL, present);
 			continue;
 		}
 
@@ -600,7 +604,7 @@ static void process_wtmp_file(char *ufile, int lastb, int extended, time_t until
 		case SHUTDOWN_TIME:
 			if (extended) {
 				strcpy(ut.ut_line, "system down");
-				quit = list(&ut, lastboot, R_NORMAL);
+				quit = list(&ut, lastboot, R_NORMAL, present);
 			}
 			lastdown = lastrch = ut.ut_time;
 			down = 1;
@@ -611,12 +615,12 @@ static void process_wtmp_file(char *ufile, int lastb, int extended, time_t until
 				strcpy(ut.ut_line,
 				ut.ut_type == NEW_TIME ? "new time" :
 					"old time");
-				quit = list(&ut, lastdown, R_TIMECHANGE);
+				quit = list(&ut, lastdown, R_TIMECHANGE, present);
 			}
 			break;
 		case BOOT_TIME:
 			strcpy(ut.ut_line, "system boot");
-			quit = list(&ut, lastdown, R_REBOOT);
+			quit = list(&ut, lastdown, R_REBOOT, present);
 			lastboot = ut.ut_time;
 			down = 1;
 			break;
@@ -624,7 +628,7 @@ static void process_wtmp_file(char *ufile, int lastb, int extended, time_t until
 			x = ut.ut_pid & 255;
 			if (extended) {
 				sprintf(ut.ut_line, "(to lvl %c)", x);
-				quit = list(&ut, lastrch, R_NORMAL);
+				quit = list(&ut, lastrch, R_NORMAL, present);
 			}
 			if (x == '0' || x == '6') {
 				lastdown = ut.ut_time;
@@ -648,7 +652,7 @@ static void process_wtmp_file(char *ufile, int lastb, int extended, time_t until
 					/* Show it */
 					if (c == 0) {
 						quit = list(&ut, p->ut.ut_time,
-							R_NORMAL);
+							R_NORMAL, present);
 						c = 1;
 					}
 					if (p->next) p->next->prev = p->prev;
@@ -673,7 +677,7 @@ static void process_wtmp_file(char *ufile, int lastb, int extended, time_t until
 						c = R_PHANTOM;
 				} else
 					c = whydown;
-				quit = list(&ut, lastboot, c);
+				quit = list(&ut, lastboot, c, present);
 			}
 			/* FALLTHRU */
 
@@ -741,6 +745,7 @@ int main(int argc, char **argv)
 	int extended = 0;	/* Lots of info. */
 
 	time_t until = 0;	/* at what time to stop parsing the file */
+	time_t present = 0;	/* who where present at time_t */
 
 	static const struct option long_opts[] = {
 	      { "limit",	required_argument, NULL, 'n' },
@@ -750,6 +755,7 @@ int main(int argc, char **argv)
 	      { "version",    no_argument,       NULL, 'V' },
 	      { "hostlast",   no_argument,       NULL, 'a' },
 	      { "until",      required_argument, NULL, 't' },
+	      { "present",    required_argument, NULL, 'p' },
 	      { "system",     no_argument,       NULL, 'x' },
 	      { "dns",        no_argument,       NULL, 'd' },
 	      { "ip",         no_argument,       NULL, 'i' },
@@ -764,7 +770,7 @@ int main(int argc, char **argv)
 	atexit(close_stdout);
 
 	while ((c = getopt_long(argc, argv,
-			"hVf:n:RxadFit:0123456789w", long_opts, NULL)) != -1) {
+			"hVf:n:RxadFit:p:0123456789w", long_opts, NULL)) != -1) {
 		switch(c) {
 		case 'h':
 			usage(stdout);
@@ -798,6 +804,11 @@ int main(int argc, char **argv)
 		case 'F':
 			fulltime++;
 			break;
+		case 'p':
+			present = parsetm(optarg);
+			if (present == (time_t) -1)
+				errx(EXIT_FAILURE, _("invalid time value \"%s\""), optarg);
+			break;
 		case 't':
 			until = parsetm(optarg);
 			if (until == (time_t) -1)
@@ -836,7 +847,7 @@ int main(int argc, char **argv)
 	}
 
 	for (i = 0; i < altc; i++) {
-		process_wtmp_file(altv[i], lastb, extended, until);
+		process_wtmp_file(altv[i], lastb, extended, until, present);
 		free(altv[i]);
 	}
 	free(altv);
-- 
1.8.3.4

