Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f48.google.com ([74.125.83.48]:57075 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756032Ab3H2SGj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 29 Aug 2013 14:06:39 -0400
Received: by mail-ee0-f48.google.com with SMTP id l10so417168eei.21
        for <util-linux@vger.kernel.org>; Thu, 29 Aug 2013 11:06:38 -0700 (PDT)
Date: Thu, 29 Aug 2013 19:06:33 +0100
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 15/17] last: use configuration struct
Message-ID: <20130829180631.GC28314@gmail.com>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
 <1377626779-26030-15-git-send-email-kerolasa@iki.fi>
 <20130829101519.GE24438@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130829101519.GE24438@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Aug 29, 2013 at 12:15:19PM +0200, Karel Zak wrote:
> On Tue, Aug 27, 2013 at 07:06:17PM +0100, Sami Kerola wrote:
> > +	struct last_control ctl;
> > +	int c;
> >  	usec_t p;
> >  
> >  	static const struct option long_opts[] = {
> > @@ -761,6 +775,11 @@ int main(int argc, char **argv)
> >  	      { NULL, 0, NULL, 0 }
> >  	};
> >  
> > +	memset(&ctl, 0, sizeof(struct last_control));
> > +	ctl.showhost = TRUE;
> > +	ctl.name_len = LAST_LOGIN_LEN;
> > +	ctl.domain_len = LAST_DOMAIN_LEN;
> > +
> 
>   struct last_control ctl = {
>          .showhost = TRUE,
>          .name_len = LAST_LOGIN_LEN,
>          .domain_len = LAST_DOMAIN_LEN
>   };
> 
>  is good enough, memset() is unnecessary.

Good point.  Thank you for reminding what the what C99 says about struct
initialization.

http://c0x.coding-guidelines.com/6.7.8.html#1695


>From 74b90f9b404e048ac17c88b24405cdbdcaf56727 Mon Sep 17 00:00:00 2001
From: Sami Kerola <kerolasa@iki.fi>
Date: Tue, 27 Aug 2013 13:15:08 +0100
Subject: [PATCH 17/26] last: use configuration struct
Organization: Lastminute.com

This allows reducing global variables and will minimize number of
arguments for functions making code a little bit easier to read, and
maintain.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 211 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 113 insertions(+), 98 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 3cbfa06..84ae264 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -53,8 +53,40 @@
 # define SHUTDOWN_TIME 254
 #endif
 
+#ifndef LAST_LOGIN_LEN
+# define LAST_LOGIN_LEN 8
+#endif
+
+#ifndef LAST_DOMAIN_LEN
+# define LAST_DOMAIN_LEN 16
+#endif
+
 #define UCHUNKSIZE	16384	/* How much we read at once. */
 
+struct last_control {
+	char lastb;		/* Is this command 'lastb' */
+	char extended;		/* Lots of info */
+	char showhost;		/* Show hostname */
+	char altlist;		/* Hostname at the end */
+	char usedns;		/* Use DNS to lookup the hostname */
+	char useip;		/* Print IP address in number format */
+	char fulltime;		/* Print full dates and times */
+
+	unsigned int name_len;	/* Number of login name characters to print */
+	unsigned int domain_len; /* Number of domain name characters to print */
+	unsigned int maxrecs;	/* Maximum number of records to list */
+
+	char **show;		/* Match search list */
+
+	char **altv;		/* Alternate wtmp files */
+	unsigned int altc;	/* Number of alternative files */
+	unsigned int alti;	/* Index number of the alternative file */
+
+	time_t since;		/* at what time to start displaying the file */
+	time_t until;		/* at what time to stop displaying the file */
+	time_t present;		/* who where present at time_t */
+};
+
 /* Double linked list of struct utmp's */
 struct utmplist {
 	struct utmp ut;
@@ -75,24 +107,15 @@ enum {
 };
 
 /* Global variables */
-static unsigned int maxrecs;	/* Maximum number of records to list. */
 static unsigned int recsdone;	/* Number of records listed */
-static int showhost = 1;	/* Show hostname too? */
-static int altlist;		/* Show hostname at the end. */
-static int usedns;		/* Use DNS to lookup the hostname. */
-static int useip;		/* Print IP address in number format */
-static int fulltime;		/* Print full dates and times */
-static int name_len = 8;	/* Default print 8 characters of name */
-static int domain_len = 16;	/* Default print 16 characters of domain */
-static char **show = NULL;	/* What do they want us to show */
-static char *ufile;		/* Filename of this file */
 static time_t lastdate;		/* Last date we've seen */
 
 /*
  *	Read one utmp entry, return in new format.
  *	Automatically reposition file pointer.
  */
-static int uread(FILE *fp, struct utmp *u, int *quit)
+static int uread(const struct last_control *ctl, FILE *fp, struct utmp *u,
+		 int *quit)
 {
 	static int utsize;
 	static char buf[UCHUNKSIZE];
@@ -119,12 +142,12 @@ static int uread(FILE *fp, struct utmp *u, int *quit)
 			return 0;
 		o = ((fpos - 1) / UCHUNKSIZE) * UCHUNKSIZE;
 		if (fseeko(fp, o, SEEK_SET) < 0) {
-			warn(_("seek failed: %s"), ufile);
+			warn(_("seek failed: %s"), ctl->altv[ctl->alti]);
 			return 0;
 		}
 		bpos = (int)(fpos - o);
 		if (fread(buf, bpos, 1, fp) != 1) {
-			warn(_("read failed: %s"), ufile);
+			warn(_("read failed: %s"), ctl->altv[ctl->alti]);
 			return 0;
 		}
 		fpos = o;
@@ -153,7 +176,7 @@ static int uread(FILE *fp, struct utmp *u, int *quit)
 	 */
 	memcpy(tmp + (-bpos), buf, utsize + bpos);
 	if (fseeko(fp, fpos, SEEK_SET) < 0) {
-		warn(_("seek failed: %s"), ufile);
+		warn(_("seek failed: %s"), ctl->altv[ctl->alti]);
 		return 0;
 	}
 
@@ -161,7 +184,7 @@ static int uread(FILE *fp, struct utmp *u, int *quit)
 	 *	Read another UCHUNKSIZE bytes.
 	 */
 	if (fread(buf, UCHUNKSIZE, 1, fp) != 1) {
-		warn(_("read failed: %s"), ufile);
+		warn(_("read failed: %s"), ctl->altv[ctl->alti]);
 		return 0;
 	}
 
@@ -251,7 +274,7 @@ static int dns_lookup(char *result, int size, int useip, int32_t *a)
 /*
  *	Show one line of information on screen
  */
-static int list(struct utmp *p, time_t t, int what, time_t present)
+static int list(const struct last_control *ctl, struct utmp *p, time_t t, int what)
 {
 	time_t		secs, tmp;
 	char		logintime[32];
@@ -277,9 +300,9 @@ static int list(struct utmp *p, time_t t, int what, time_t present)
 	/*
 	 *	Is this something we wanna show?
 	 */
-	if (show) {
+	if (ctl->show) {
 		char **walk;
-		for (walk = show; *walk; walk++) {
+		for (walk = ctl->show; *walk; walk++) {
 			if (strncmp(p->ut_name, *walk, UT_NAMESIZE) == 0 ||
 			    strcmp(utline, *walk) == 0 ||
 			    (strncmp(utline, "tty", 3) == 0 &&
@@ -293,11 +316,11 @@ static int list(struct utmp *p, time_t t, int what, time_t present)
 	 */
 	tmp = (time_t)p->ut_time;
 
-	if (present && (present < tmp || (0 < t && t < present)))
+	if (ctl->present && (ctl->present < tmp || (0 < t && t < ctl->present)))
 		return 0;
 
 	strcpy(logintime, ctime(&tmp));
-	if (fulltime)
+	if (ctl->fulltime)
 		sprintf(logouttime, "- %s", ctime(&t));
 	else {
 		logintime[16] = 0;
@@ -322,7 +345,7 @@ static int list(struct utmp *p, time_t t, int what, time_t present)
 			break;
 		case R_NOW:
 			length[0] = 0;
-			if (fulltime)
+			if (ctl->fulltime)
 				sprintf(logouttime, "  still logged in");
 			else {
 				sprintf(logouttime, "  still");
@@ -331,7 +354,7 @@ static int list(struct utmp *p, time_t t, int what, time_t present)
 			break;
 		case R_PHANTOM:
 			length[0] = 0;
-			if (fulltime)
+			if (ctl->fulltime)
 				sprintf(logouttime, "  gone - no logout");
 			else {
 				sprintf(logouttime, "   gone");
@@ -354,8 +377,8 @@ static int list(struct utmp *p, time_t t, int what, time_t present)
 	 *	Look up host with DNS if needed.
 	 */
 	r = -1;
-	if (usedns || useip)
-		r = dns_lookup(domain, sizeof(domain), useip, p->ut_addr_v6);
+	if (ctl->usedns || ctl->useip)
+		r = dns_lookup(domain, sizeof(domain), ctl->useip, p->ut_addr_v6);
 	if (r < 0) {
 		len = UT_HOSTSIZE;
 		if (len >= (int)sizeof(domain)) len = sizeof(domain) - 1;
@@ -363,28 +386,28 @@ static int list(struct utmp *p, time_t t, int what, time_t present)
 		strncat(domain, p->ut_host, len);
 	}
 
-	if (showhost) {
-		if (!altlist) {
+	if (ctl->showhost) {
+		if (!ctl->altlist) {
 			len = snprintf(final, sizeof(final),
-				fulltime ?
+				ctl->fulltime ?
 				"%-8.*s %-12.12s %-16.*s %-24.24s %-26.26s %-12.12s\n" :
 				"%-8.*s %-12.12s %-16.*s %-16.16s %-7.7s %-12.12s\n",
-				name_len, p->ut_name, utline,
-				domain_len, domain, logintime, logouttime, length);
+				ctl->name_len, p->ut_name, utline,
+				ctl->domain_len, domain, logintime, logouttime, length);
 		} else {
 			len = snprintf(final, sizeof(final),
-				fulltime ?
+				ctl->fulltime ?
 				"%-8.*s %-12.12s %-24.24s %-26.26s %-12.12s %s\n" :
 				"%-8.*s %-12.12s %-16.16s %-7.7s %-12.12s %s\n",
-				name_len, p->ut_name, utline,
+				ctl->name_len, p->ut_name, utline,
 				logintime, logouttime, length, domain);
 		}
 	} else
 		len = snprintf(final, sizeof(final),
-			fulltime ?
+			ctl->fulltime ?
 			"%-8.*s %-12.12s %-24.24s %-26.26s %-12.12s\n" :
 			"%-8.*s %-12.12s %-16.16s %-7.7s %-12.12s\n",
-			name_len, p->ut_name, utline,
+			ctl->name_len, p->ut_name, utline,
 			logintime, logouttime, length);
 
 #if defined(__GLIBC__)
@@ -403,7 +426,7 @@ static int list(struct utmp *p, time_t t, int what, time_t present)
 		putchar('\n');
 
 	recsdone++;
-	if (maxrecs && recsdone >= maxrecs)
+	if (ctl->maxrecs && ctl->maxrecs <= recsdone)
 		return 1;
 
 	return 0;
@@ -441,8 +464,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 }
 
 
-static void process_wtmp_file(char *ufile, int lastb, int extended,
-			      time_t since, time_t until, time_t present)
+static void process_wtmp_file(const struct last_control *ctl)
 {
 	FILE *fp;		/* Filepointer of wtmp file */
 
@@ -478,8 +500,8 @@ static void process_wtmp_file(char *ufile, int lastb, int extended,
 	/*
 	 * Open the utmp file
 	 */
-	if ((fp = fopen(ufile, "r")) == NULL)
-		err(EXIT_FAILURE, _("cannot open %s"), ufile);
+	if ((fp = fopen(ctl->altv[ctl->alti], "r")) == NULL)
+		err(EXIT_FAILURE, _("cannot open %s"), ctl->altv[ctl->alti]);
 
 	/*
 	 * Optimize the buffer size.
@@ -489,7 +511,7 @@ static void process_wtmp_file(char *ufile, int lastb, int extended,
 	/*
 	 * Read first structure to capture the time field
 	 */
-	if (uread(fp, &ut, NULL) == 1)
+	if (uread(ctl, fp, &ut, NULL) == 1)
 		begintime = ut.ut_time;
 	else {
 		fstat(fileno(fp), &st);
@@ -501,26 +523,26 @@ static void process_wtmp_file(char *ufile, int lastb, int extended,
 	 * Go to end of file minus one structure
 	 * and/or initialize utmp reading code.
 	 */
-	uread(fp, NULL, NULL);
+	uread(ctl, fp, NULL, NULL);
 
 	/*
 	 * Read struct after struct backwards from the file.
 	 */
 	while (!quit) {
 
-		if (uread(fp, &ut, &quit) != 1)
+		if (uread(ctl, fp, &ut, &quit) != 1)
 			break;
 
-		if (since && ut.ut_time < since)
+		if (ctl->since && ut.ut_time < ctl->since)
 			continue;
 
-		if (until && until < ut.ut_time)
+		if (ctl->until && ctl->until < ut.ut_time)
 			continue;
 
 		lastdate = ut.ut_time;
 
-		if (lastb) {
-			quit = list(&ut, ut.ut_time, R_NORMAL, present);
+		if (ctl->lastb) {
+			quit = list(ctl, &ut, ut.ut_time, R_NORMAL);
 			continue;
 		}
 
@@ -566,33 +588,33 @@ static void process_wtmp_file(char *ufile, int lastb, int extended,
 #endif
 		switch (ut.ut_type) {
 		case SHUTDOWN_TIME:
-			if (extended) {
+			if (ctl->extended) {
 				strcpy(ut.ut_line, "system down");
-				quit = list(&ut, lastboot, R_NORMAL, present);
+				quit = list(ctl, &ut, lastboot, R_NORMAL);
 			}
 			lastdown = lastrch = ut.ut_time;
 			down = 1;
 			break;
 		case OLD_TIME:
 		case NEW_TIME:
-			if (extended) {
+			if (ctl->extended) {
 				strcpy(ut.ut_line,
 				ut.ut_type == NEW_TIME ? "new time" :
 					"old time");
-				quit = list(&ut, lastdown, R_TIMECHANGE, present);
+				quit = list(ctl, &ut, lastdown, R_TIMECHANGE);
 			}
 			break;
 		case BOOT_TIME:
 			strcpy(ut.ut_line, "system boot");
-			quit = list(&ut, lastdown, R_REBOOT, present);
+			quit = list(ctl, &ut, lastdown, R_REBOOT);
 			lastboot = ut.ut_time;
 			down = 1;
 			break;
 		case RUN_LVL:
 			x = ut.ut_pid & 255;
-			if (extended) {
+			if (ctl->extended) {
 				sprintf(ut.ut_line, "(to lvl %c)", x);
-				quit = list(&ut, lastrch, R_NORMAL, present);
+				quit = list(ctl, &ut, lastrch, R_NORMAL);
 			}
 			if (x == '0' || x == '6') {
 				lastdown = ut.ut_time;
@@ -615,8 +637,7 @@ static void process_wtmp_file(char *ufile, int lastb, int extended,
 				    UT_LINESIZE) == 0) {
 					/* Show it */
 					if (c == 0) {
-						quit = list(&ut, p->ut.ut_time,
-							R_NORMAL, present);
+						quit = list(ctl, &ut, p->ut.ut_time, R_NORMAL);
 						c = 1;
 					}
 					if (p->next) p->next->prev = p->prev;
@@ -641,7 +662,7 @@ static void process_wtmp_file(char *ufile, int lastb, int extended,
 						c = R_PHANTOM;
 				} else
 					c = whydown;
-				quit = list(&ut, lastboot, c, present);
+				quit = list(ctl, &ut, lastboot, c);
 			}
 			/* FALLTHRU */
 
@@ -687,21 +708,18 @@ static void process_wtmp_file(char *ufile, int lastb, int extended,
 		}
 	}
 
-	printf(_("\n%s begins %s"), basename(ufile), ctime(&begintime));
+	printf(_("\n%s begins %s"), basename(ctl->altv[ctl->alti]), ctime(&begintime));
 	fclose(fp);
 }
 
 int main(int argc, char **argv)
 {
-	int c, i;		/* Scratch */
-	char **altv = NULL;	/* Alternate wtmp files */
-	int altc = 0;		/* Number of alternative files */
-	int lastb = 0;		/* Is this 'lastb' ? */
-	int extended = 0;	/* Lots of info. */
-
-	time_t since = 0;	/* at what time to start displaying the file */
-	time_t until = 0;	/* at what time to stop displaying the file */
-	time_t present = 0;	/* who where present at time_t */
+	struct last_control ctl = {
+		.showhost = TRUE,
+		.name_len = LAST_LOGIN_LEN,
+		.domain_len = LAST_DOMAIN_LEN
+	};
+	int c;
 	usec_t p;
 
 	static const struct option long_opts[] = {
@@ -737,58 +755,55 @@ int main(int argc, char **argv)
 			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
 		case 'R':
-			showhost = 0;
+			ctl.showhost = FALSE;
 			break;
 		case 'x':
-			extended = 1;
+			ctl.extended = TRUE;
 			break;
 		case 'n':
-			maxrecs = strtos32_or_err(optarg, _("failed to parse number"));
+			ctl.maxrecs = strtos32_or_err(optarg, _("failed to parse number"));
 			break;
 		case 'f':
-			if (!altv)
-				altv = xmalloc(sizeof(char *) * argc);
-			altv[altc++] = xstrdup(optarg);
+			if (!ctl.altv)
+				ctl.altv = xmalloc(sizeof(char *) * argc);
+			ctl.altv[ctl.altc++] = xstrdup(optarg);
 			break;
 		case 'd':
-			usedns++;
+			ctl.usedns = TRUE;
 			break;
 		case 'i':
-			useip++;
+			ctl.useip = TRUE;
 			break;
 		case 'a':
-			altlist++;
+			ctl.altlist = TRUE;
 			break;
 		case 'F':
-			fulltime++;
+			ctl.fulltime = TRUE;
 			break;
 		case 'p':
 			if (parse_timestamp(optarg, &p) < 0)
 				errx(EXIT_FAILURE, _("invalid time value \"%s\""), optarg);
-			present = (time_t) (p / 1000000);
+			ctl.present = (time_t) (p / 1000000);
 			break;
 		case 's':
-			since = parsetm(optarg);
-			if (since != (time_t) -1)
-				break;
 			if (parse_timestamp(optarg, &p) < 0)
 				errx(EXIT_FAILURE, _("invalid time value \"%s\""), optarg);
-			since = (time_t) (p / 1000000);
+			ctl.since = (time_t) (p / 1000000);
 			break;
 		case 't':
 			if (parse_timestamp(optarg, &p) < 0)
 				errx(EXIT_FAILURE, _("invalid time value \"%s\""), optarg);
-			until = (time_t) (p / 1000000);
+			ctl.until = (time_t) (p / 1000000);
 			break;
 		case 'w':
-			if (UT_NAMESIZE > name_len)
-				name_len = UT_NAMESIZE;
-			if (UT_HOSTSIZE > domain_len)
-				domain_len = UT_HOSTSIZE;
+			if (ctl.name_len < UT_NAMESIZE)
+				ctl.name_len = UT_NAMESIZE;
+			if (ctl.domain_len < UT_HOSTSIZE)
+				ctl.domain_len = UT_HOSTSIZE;
 			break;
 		case '0': case '1': case '2': case '3': case '4':
 		case '5': case '6': case '7': case '8': case '9':
-			maxrecs = 10 * maxrecs + c - '0';
+			ctl.maxrecs = 10 * ctl.maxrecs + c - '0';
 			break;
 		default:
 			usage(stderr);
@@ -797,25 +812,25 @@ int main(int argc, char **argv)
 	}
 
 	if (optind < argc)
-		show = argv + optind;
+		ctl.show = argv + optind;
 
 	/*
 	 * Which file do we want to read?
 	 */
-	lastb = !strcmp(program_invocation_short_name, "lastb");
-	if (!altc) {
-		altv = xmalloc(sizeof(char *));
-		if (lastb)
-			altv[0] = xstrdup(_PATH_BTMP);
+	ctl.lastb = !strcmp(program_invocation_short_name, "lastb");
+	if (!ctl.altc) {
+		ctl.altv = xmalloc(sizeof(char *));
+		if (ctl.lastb)
+			ctl.altv[0] = xstrdup(_PATH_BTMP);
 		else
-			altv[0] = xstrdup(_PATH_WTMP);
-		altc++;
+			ctl.altv[0] = xstrdup(_PATH_WTMP);
+		ctl.altc++;
 	}
 
-	for (i = 0; i < altc; i++) {
-		process_wtmp_file(altv[i], lastb, extended, since, until, present);
-		free(altv[i]);
+	for (; ctl.alti < ctl.altc; ctl.alti++) {
+		process_wtmp_file(&ctl);
+		free(ctl.altv[ctl.alti]);
 	}
-	free(altv);
+	free(ctl.altv);
 	return EXIT_SUCCESS;
 }
-- 
1.8.4



-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
