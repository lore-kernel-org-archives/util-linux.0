Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f181.google.com ([209.85.215.181]:43036 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab3H0SH2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Aug 2013 14:07:28 -0400
Received: by mail-ea0-f181.google.com with SMTP id d10so2435395eaj.40
        for <util-linux@vger.kernel.org>; Tue, 27 Aug 2013 11:07:27 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 16/17] last: add --time-format with iso-8601 format
Date: Tue, 27 Aug 2013 19:06:18 +0100
Message-Id: <1377626779-26030-16-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The ISO-8601 format makes consuming time stamps easy with various
parsers.  The format includes time zone information which is crucial when
an investigator is trying to make sense outputs collected from systems
all a across planet.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 134 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 111 insertions(+), 23 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 2f01321..4733c64 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -61,6 +61,10 @@
 # define LAST_DOMAIN_LEN 16
 #endif
 
+#ifndef LAST_TIMESTAMP_LEN
+# define LAST_TIMESTAMP_LEN 32
+#endif
+
 #define UCHUNKSIZE	16384	/* How much we read at once. */
 
 struct last_control {
@@ -85,6 +89,7 @@ struct last_control {
 	time_t since;		/* at what time to start displaying the file */
 	time_t until;		/* at what time to stop displaying the file */
 	time_t present;		/* who where present at time_t */
+	unsigned int time_fmt;	/* time format */
 };
 
 /* Double linked list of struct utmp's */
@@ -106,10 +111,43 @@ enum {
 	R_TIMECHANGE	/* NEW_TIME or OLD_TIME */
 };
 
+enum {
+	LAST_TIMEFTM_NONE = 0,
+	LAST_TIMEFTM_SHORT_CTIME,
+	LAST_TIMEFTM_FULL_CTIME,
+	LAST_TIMEFTM_ISO8601
+};
+
+struct last_timefmt_lens {
+	int in;
+	int out;
+};
+
+static struct last_timefmt_lens tftl[] = {
+	[LAST_TIMEFTM_NONE] 	   = {0, 0},
+	[LAST_TIMEFTM_SHORT_CTIME] = {16, 7},
+	[LAST_TIMEFTM_FULL_CTIME]  = {24, 26},
+	[LAST_TIMEFTM_ISO8601]	   = {24, 26}
+};
+
 /* Global variables */
 static unsigned int recsdone;	/* Number of records listed */
 static time_t lastdate;		/* Last date we've seen */
 
+/* --time-format=option parser */
+static int which_time_format(const char *optarg)
+{
+	if (!strcmp(optarg, "notime"))
+		return LAST_TIMEFTM_NONE;
+	if (!strcmp(optarg, "short"))
+		return LAST_TIMEFTM_SHORT_CTIME;
+	if (!strcmp(optarg, "full"))
+		return LAST_TIMEFTM_FULL_CTIME;
+	if (!strcmp(optarg, "iso"))
+		return LAST_TIMEFTM_ISO8601;
+	errx(EXIT_FAILURE, _("unknown time format: %s"), optarg);
+}
+
 /*
  *	Read one utmp entry, return in new format.
  *	Automatically reposition file pointer.
@@ -271,15 +309,54 @@ static int dns_lookup(char *result, int size, int useip, int32_t *a)
 	return getnameinfo(sa, salen, result, size, NULL, 0, flags);
 }
 
+static int time_formatter(const struct last_control *ctl, char *dst,
+			  size_t dlen, time_t *when, int pos)
+{
+	struct tm *tm;
+	int ret = 0;
+
+	switch (ctl->time_fmt) {
+	case LAST_TIMEFTM_NONE:
+		*dst = 0;
+		break;
+	case LAST_TIMEFTM_SHORT_CTIME:
+		if (pos == 0)
+			ret = sprintf(dst, "%s", ctime(when));
+		else {
+			tm = localtime(when);
+			if (!strftime(dst, dlen, "- %H:%M", tm))
+				ret = -1;
+		}
+		break;
+	case LAST_TIMEFTM_FULL_CTIME:
+		if (pos == 0)
+			ret = sprintf(dst, "%s", ctime(when));
+		else
+			ret = sprintf(dst, "- %s", ctime(when));
+		break;
+	case LAST_TIMEFTM_ISO8601:
+		tm = localtime(when);
+		if (pos == 0) {
+			if (!strftime(dst, dlen, "%Y-%m-%dT%H:%M:%S%z", tm))
+				ret = -1;
+		} else if (!strftime(dst, dlen, "- %Y-%m-%dT%H:%M:%S%z", tm))
+			ret = -1;
+		break;
+	default:
+		abort();
+	}
+	return ret;
+}
+
 /*
  *	Show one line of information on screen
  */
 static int list(const struct last_control *ctl, struct utmp *p, time_t t, int what)
 {
 	time_t		secs, tmp;
-	char		logintime[32];
-	char		logouttime[32];
-	char		length[32];
+	char		logintime[LAST_TIMESTAMP_LEN];
+	char		logouttime[LAST_TIMESTAMP_LEN];
+	char		length[LAST_TIMESTAMP_LEN];
 	char		final[512];
 	char		utline[UT_LINESIZE+1];
 	char		domain[256];
@@ -319,14 +396,10 @@ static int list(const struct last_control *ctl, struct utmp *p, time_t t, int wh
 	if (ctl->present && (ctl->present < tmp || (0 < t && t < ctl->present)))
 		return 0;
 
-	strcpy(logintime, ctime(&tmp));
-	if (ctl->fulltime)
-		sprintf(logouttime, "- %s", ctime(&t));
-	else {
-		logintime[16] = 0;
-		sprintf(logouttime, "- %s", ctime(&t) + 11);
-		logouttime[7] = 0;
-	}
+	if (time_formatter(ctl, &logintime[0], sizeof(logintime), &tmp, 0) < 0 ||
+	    time_formatter(ctl, &logouttime[0], sizeof(logouttime), &t, 1) < 0)
+		errx(EXIT_FAILURE, _("preallocation size exceeded"));
+
 	secs = t - p->ut_time;
 	mins  = (secs / 60) % 60;
 	hours = (secs / 3600) % 24;
@@ -389,26 +462,27 @@ static int list(const struct last_control *ctl, struct utmp *p, time_t t, int wh
 	if (ctl->showhost) {
 		if (!ctl->altlist) {
 			len = snprintf(final, sizeof(final),
-				ctl->fulltime ?
-				"%-8.*s %-12.12s %-16.*s %-24.24s %-26.26s %-12.12s\n" :
-				"%-8.*s %-12.12s %-16.*s %-16.16s %-7.7s %-12.12s\n",
+				"%-8.*s %-12.12s %-16.*s %-*.*s %-*.*s %-12.12s\n",
 				ctl->name_len, p->ut_name, utline,
-				ctl->domain_len, domain, logintime, logouttime, length);
+				ctl->domain_len, domain,
+				tftl[ctl->time_fmt].in, tftl[ctl->time_fmt].in, logintime,
+				tftl[ctl->time_fmt].out, tftl[ctl->time_fmt].out, logouttime,
+				length);
 		} else {
 			len = snprintf(final, sizeof(final),
-				ctl->fulltime ?
-				"%-8.*s %-12.12s %-24.24s %-26.26s %-12.12s %s\n" :
-				"%-8.*s %-12.12s %-16.16s %-7.7s %-12.12s %s\n",
+				"%-8.*s %-12.12s %-*.*s %-*.*s %-12.12s %s\n",
 				ctl->name_len, p->ut_name, utline,
-				logintime, logouttime, length, domain);
+				tftl[ctl->time_fmt].in, tftl[ctl->time_fmt].in, logintime,
+				tftl[ctl->time_fmt].out, tftl[ctl->time_fmt].out, logouttime,
+				length, domain);
 		}
 	} else
 		len = snprintf(final, sizeof(final),
-			ctl->fulltime ?
-			"%-8.*s %-12.12s %-24.24s %-26.26s %-12.12s\n" :
-			"%-8.*s %-12.12s %-16.16s %-7.7s %-12.12s\n",
+			"%-8.*s %-12.12s %-*.*s %-*.*s %-12.12s\n",
 			ctl->name_len, p->ut_name, utline,
-			logintime, logouttime, length);
+			tftl[ctl->time_fmt].in, tftl[ctl->time_fmt].in, logintime,
+			tftl[ctl->time_fmt].out, tftl[ctl->time_fmt].out, logouttime,
+			length);
 
 #if defined(__GLIBC__)
 #  if (__GLIBC__ == 2) && (__GLIBC_MINOR__ == 0)
@@ -454,6 +528,8 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -p, --present <time> display who where present at the specified time\n"), out);
 	fputs(_(" -w, --fullnames      display full user and domain names\n"), out);
 	fputs(_(" -x, --system         display system shutdown entries and run level changes\n"), out);
+	fputs(_("     --time-format <format>  show time stamp using format:\n"), out);
+	fputs(_("                               [notime|short|full|iso]\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
@@ -757,6 +833,10 @@ int main(int argc, char **argv)
 	int c;
 	usec_t p;
 
+	enum {
+		OPT_TIME_FORMAT = CHAR_MAX + 1
+	};
+
 	static const struct option long_opts[] = {
 	      { "limit",	required_argument, NULL, 'n' },
 	      { "help",	no_argument,       NULL, 'h' },
@@ -772,6 +852,7 @@ int main(int argc, char **argv)
 	      { "ip",         no_argument,       NULL, 'i' },
 	      { "fulltimes",  no_argument,       NULL, 'F' },
 	      { "fullnames",  no_argument,       NULL, 'w' },
+	      { "time-format", required_argument, NULL, OPT_TIME_FORMAT },
 	      { NULL, 0, NULL, 0 }
 	};
 
@@ -779,6 +860,7 @@ int main(int argc, char **argv)
 	ctl.showhost = TRUE;
 	ctl.name_len = LAST_LOGIN_LEN;
 	ctl.domain_len = LAST_DOMAIN_LEN;
+	ctl.time_fmt = LAST_TIMEFTM_SHORT_CTIME;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -819,6 +901,7 @@ int main(int argc, char **argv)
 			break;
 		case 'F':
 			ctl.fulltime = TRUE;
+			ctl.time_fmt = LAST_TIMEFTM_FULL_CTIME;
 			break;
 		case 'p':
 			ctl.present = parsetm(optarg);
@@ -854,6 +937,11 @@ int main(int argc, char **argv)
 		case '5': case '6': case '7': case '8': case '9':
 			ctl.maxrecs = 10 * ctl.maxrecs + c - '0';
 			break;
+		case OPT_TIME_FORMAT:
+			ctl.time_fmt = which_time_format(optarg);
+			if (ctl.time_fmt == LAST_TIMEFTM_ISO8601)
+				ctl.fulltime = TRUE;
+			break;
 		default:
 			usage(stderr);
 			break;
-- 
1.8.4

