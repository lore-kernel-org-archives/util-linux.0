Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33095 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbbF1Tnb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Jun 2015 15:43:31 -0400
Received: by wiwl6 with SMTP id l6so82589175wiw.0
        for <util-linux@vger.kernel.org>; Sun, 28 Jun 2015 12:43:29 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <sami.kerola@lastminute.com>
Subject: [PATCH 1/7] last-deprecated: remove from source tree
Date: Sun, 28 Jun 2015 20:43:19 +0100
Message-Id: <1435520605-4296-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1435520605-4296-1-git-send-email-kerolasa@iki.fi>
References: <1435520605-4296-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Sami Kerola <sami.kerola@lastminute.com>

The last/lastb(1) from sysvinit has been around for about two years,
and the better implementation is already part of releases 2.24 to 2.26.
It should be safe to remove the unused last code from the source tree.

Reference: ce60272039ea11952b15fefb653892dd0da02217
Signed-off-by: Sami Kerola <sami.kerola@lastminute.com>
---
 Documentation/deprecated.txt  |   5 -
 configure.ac                  |  10 -
 login-utils/Makemodule.am     |   7 -
 login-utils/last-deprecated.1 |  62 ------
 login-utils/last-deprecated.c | 483 ------------------------------------------
 5 files changed, 567 deletions(-)
 delete mode 100644 login-utils/last-deprecated.1
 delete mode 100644 login-utils/last-deprecated.c

diff --git a/Documentation/deprecated.txt b/Documentation/deprecated.txt
index 11f4d1f..a32833f 100644
--- a/Documentation/deprecated.txt
+++ b/Documentation/deprecated.txt
@@ -91,11 +91,6 @@ What:   losetup output format without --list
 What:	tunelp
 Why:	parallel port printers are probably almost extinct devices
 
---------------------------
-
-What:	deprecated_last(1)
-Why:	nobody uses this implementation
-
 ----------------------------
 
 The Single UNIX(TM) Specification, Version 2
diff --git a/configure.ac b/configure.ac
index 5b95d09..58feb22 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1471,22 +1471,12 @@ UL_BUILD_INIT([kill])
 UL_REQUIRES_LINUX([kill])
 AM_CONDITIONAL([BUILD_KILL], [test "x$build_kill" = xyes])
 
-dnl Don't use UL_DEFAULT_ENABLE() here, deprecated stuff has to be insensitive
-dnl to --enable-all-programs.
-AC_ARG_ENABLE([deprecated-last],
-  AS_HELP_STRING([--enable-deprecated-last], [build old deprecated last]),
-  [], [enable_deprecated_last=no]
-)
-UL_BUILD_INIT([deprecated_last])
-AM_CONDITIONAL([BUILD_DEPRECATED_LAST], [test "x$build_deprecated_last" = xyes])
-
 
 AC_ARG_ENABLE([last],
   AS_HELP_STRING([--disable-last], [do not build last]),
   [], [UL_DEFAULT_ENABLE([last], [check])]
 )
 UL_BUILD_INIT([last])
-UL_CONFLICTS_BUILD([last], [deprecated_last], [old deprecated last version])
 AM_CONDITIONAL([BUILD_LAST], [test "x$build_last" = xyes])
 
 
diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
index 1b413c6..fb58b46 100644
--- a/login-utils/Makemodule.am
+++ b/login-utils/Makemodule.am
@@ -13,13 +13,6 @@ install-exec-hook-last:
 INSTALL_EXEC_HOOKS += install-exec-hook-last
 endif
 
-if BUILD_DEPRECATED_LAST
-usrbin_exec_PROGRAMS += last
-dist_man_MANS += login-utils/last-deprecated.1
-last_SOURCES = login-utils/last-deprecated.c
-endif # BUILD_DEPRECATED_LAST
-
-
 if BUILD_SULOGIN
 sbin_PROGRAMS += sulogin
 dist_man_MANS += login-utils/sulogin.8
diff --git a/login-utils/last-deprecated.1 b/login-utils/last-deprecated.1
deleted file mode 100644
index beb6917..0000000
--- a/login-utils/last-deprecated.1
+++ /dev/null
@@ -1,62 +0,0 @@
-.TH LAST 1 "March 1992" "util-linux" "User Commands"
-.SH NAME
-last \(em indicate last logins by user or terminal
-.SH SYNOPSIS
-.ad l
-.B last
-.RB [ \-\fP\fInumber\fP ]
-.RB [ \-f
-.IR filename ]
-.RB [ \-t
-.IR tty ]
-.RB [ \-h
-.IR hostname ]
-.RB [ \-i
-.IR address ]
-.RB [ \-l ]
-.RB [ \-y ]
-.RI [ name ...]
-.ad b
-.SH DESCRIPTION
-\fBLast\fP looks back in the \fBwtmp\fP file which records all logins
-and logouts for information about a user, a teletype or any group of
-users and teletypes.  Arguments specify names of users or teletypes of
-interest.  If multiple arguments are given, the information which
-applies to any of the arguments is printed.  For example ``\fBlast root
-console\fP'' would list all of root's sessions as well as all sessions
-on the console terminal.  \fBLast\fP displays the sessions of the
-specified users and teletypes, most recent first, indicating the times
-at which the session began, the duration of the session, and the
-teletype which the session took place on.  If the session is still
-continuing or was cut short by a reboot, \fBlast\fP so indicates.
-.LP
-The pseudo-user \fBreboot\fP logs in at reboots of the system.
-.LP
-\fBLast\fP with no arguments displays a record of all logins and
-logouts, in reverse order.
-.LP
-If \fBlast\fP is interrupted, it indicates how far the search has
-progressed in \fBwtmp\fP.  If interrupted with a quit signal \fBlast\fP
-indicates how far the search has progressed so far, and the search
-continues.
-.SH OPTIONS
-.IP \fB\-\fP\fInumber\fP
-limit the number of entries displayed to that specified by \fInumber\fP.
-.IP "\fB\-f\fP \fIfilename\fP"
-Use \fIfilename\fP as the name of the accounting file instead of
-.BR /var/log/wtmp .
-.IP "\fB\-h\fP \fIhostname\fP"
-List only logins from \fIhostname\fP.
-.IP "\fB\-i\fP \fIIP address\fP"
-List only logins from \fIIP address\fP.
-.IP "\fB\-l\fP"
-List IP addresses of remote hosts instead of truncated host names.
-.IP "\fB\-t\fP \fItty\fP"
-List only logins on \fItty\fP.
-.IP "\fB\-y\fP"
-Also report year of dates.
-.SH FILES
-/var/log/wtmp \(em login data base
-.SH AVAILABILITY
-The last command is part of the util-linux package and is available from
-ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/login-utils/last-deprecated.c b/login-utils/last-deprecated.c
deleted file mode 100644
index d3fdc8c..0000000
--- a/login-utils/last-deprecated.c
+++ /dev/null
@@ -1,483 +0,0 @@
-/*
- * Berkeley last for Linux. Currently maintained by poe@daimi.aau.dk at
- * ftp://ftp.daimi.aau.dk/pub/linux/poe/admutil*
- *
- * Copyright (c) 1987 Regents of the University of California.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms are permitted
- * provided that the above copyright notice and this paragraph are
- * duplicated in all such forms and that any documentation,
- * advertising materials, and other materials related to such
- * distribution and use acknowledge that the software was developed
- * by the University of California, Berkeley.  The name of the
- * University may not be used to endorse or promote products derived
- * from this software without specific prior written permission.
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
- */
-
- /* 1999-02-22 Arkadiusz Miśkiewicz <misiek@pld.ORG.PL>
-  * - added Native Language Support
-  */
-
- /* 2001-02-14 Marek Zelem <marek@fornax.sk>
-  * - using mmap() on Linux - great speed improvement
-  */
-
-/*
- * This command is deprecated.  The utility is in maintenance mode,
- * meaning we keep them in source tree for backward compatibility
- * only.  Do not waste time making this command better, unless the
- * fix is about security or other very critical issue.
- *
- * See Documentation/deprecated.txt for more information.
- */
-
-/*
- * last
- */
-#include <sys/param.h>
-#include <sys/stat.h>
-#include <sys/file.h>
-#include <sys/types.h>
-#include <sys/mman.h>
-#include <signal.h>
-#include <string.h>
-#include <time.h>
-#include <utmp.h>
-#include <stdio.h>
-#include <getopt.h>
-#include <stdlib.h>
-#include <unistd.h>
-
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
-
-#include "closestream.h"
-#include "pathnames.h"
-#include "nls.h"
-#include "xalloc.h"
-#include "c.h"
-
-#define	SECDAY	(24*60*60)			/* seconds in a day */
-#define	NO	0				/* false/no */
-#define	YES	1				/* true/yes */
-
-static struct utmp	utmpbuf;
-
-#define	HMAX	(int)sizeof(utmpbuf.ut_host)	/* size of utmp host field */
-#define	LMAX	(int)sizeof(utmpbuf.ut_line)	/* size of utmp tty field */
-#define	NMAX	(int)sizeof(utmpbuf.ut_name)	/* size of utmp name field */
-
-/* maximum sizes used for printing */
-/* probably we want a two-pass version that computes the right length */
-#define P_HMAX	min(HMAX, 16)
-#define P_LMAX	min(LMAX, 8)
-#define P_NMAX	min(NMAX, 16)
-
-typedef struct arg {
-	char	*name;				/* argument */
-#define	HOST_TYPE	-2
-#define	TTY_TYPE	-3
-#define	USER_TYPE	-4
-#define INET_TYPE	-5
-	int	type;				/* type of arg */
-	struct arg	*next;			/* linked list pointer */
-} ARG;
-ARG	*arglist;				/* head of linked list */
-
-typedef struct ttytab {
-	long	logout;				/* log out time */
-	char	tty[LMAX + 1];			/* terminal name */
-	struct ttytab	*next;			/* linked list pointer */
-} TTY;
-TTY	*ttylist;				/* head of linked list */
-
-static long	currentout,			/* current logout value */
-		maxrec;				/* records to display */
-static char	*file = _PATH_WTMP;		/* wtmp file */
-
-static int	doyear = 0;			/* output year in dates */
-static int	dolong = 0;			/* print also ip-addr */
-
-static void wtmp(void);
-static void addarg(int, char *);
-static void hostconv(char *);
-static void onintr(int);
-static int want(struct utmp *, int);
-TTY *addtty(char *);
-static char *ttyconv(char *);
-
-int
-main(int argc, char **argv) {
-	int	ch;
-
-	setlocale(LC_ALL, "");
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	textdomain(PACKAGE);
-	atexit(close_stdout);
-
-	while ((ch = getopt(argc, argv, "0123456789yli:f:h:t:")) != -1)
-		switch((char)ch) {
-		case '0': case '1': case '2': case '3': case '4':
-		case '5': case '6': case '7': case '8': case '9':
-			/*
-			 * kludge: last was originally designed to take
-			 * a number after a dash.
-			 */
-			if (!maxrec)
-				maxrec = atol(argv[optind - 1] + 1);
-			break;
-		case 'f':
-			file = optarg;
-			break;
-		case 'h':
-			hostconv(optarg);
-			addarg(HOST_TYPE, optarg);
-			break;
-		case 't':
-			addarg(TTY_TYPE, ttyconv(optarg));
-			break;
-		case 'y':
-			doyear = 1;
-			break;
-		case 'l':
-			dolong = 1;
-			break;
-		case 'i':
-			addarg(INET_TYPE, optarg);
-			break;
-		case '?':
-		default:
-			fputs(_("usage: last [-#] [-f file] [-t tty] [-h hostname] [user ...]\n"), stderr);
-			exit(EXIT_FAILURE);
-		}
-	for (argv += optind; *argv; ++argv) {
-#define	COMPATIBILITY
-#ifdef	COMPATIBILITY
-		/* code to allow "last p5" to work */
-		addarg(TTY_TYPE, ttyconv(*argv));
-#endif
-		addarg(USER_TYPE, *argv);
-	}
-	wtmp();
-
-	return EXIT_SUCCESS;
-}
-
-static char *utmp_ctime(struct utmp *u)
-{
-	time_t t = (time_t) u->ut_time;
-	return ctime(&t);
-}
-
-/*
- * print_partial_line --
- *	print the first part of each output line according to specified format
- */
-static void
-print_partial_line(struct utmp *bp) {
-    char *ct;
-
-    ct = utmp_ctime(bp);
-    printf("%-*.*s  %-*.*s ", P_NMAX, P_NMAX, bp->ut_name,
-	   P_LMAX, P_LMAX, bp->ut_line);
-
-    if (dolong) {
-	if (bp->ut_addr) {
-	    struct in_addr foo;
-	    foo.s_addr = bp->ut_addr;
-	    printf("%-*.*s ", P_HMAX, P_HMAX, inet_ntoa(foo));
-	} else {
-	    printf("%-*.*s ", P_HMAX, P_HMAX, "");
-	}
-    } else {
-	printf("%-*.*s ", P_HMAX, P_HMAX, bp->ut_host);
-    }
-
-    if (doyear) {
-	printf("%10.10s %4.4s %5.5s ", ct, ct + 20, ct + 11);
-    } else {
-	printf("%10.10s %5.5s ", ct, ct + 11);
-    }
-}
-
-/*
- * wtmp --
- *	read through the wtmp file
- */
-static void
-wtmp(void) {
-	register struct utmp	*bp;		/* current structure */
-	register TTY	*T;			/* tty list entry */
-	long	delta;				/* time difference */
-	char *crmsg = NULL;
-	char *ct = NULL;
-	int fd;
-	struct utmp *utl;
-	struct stat st;
-	int utl_len;
-	int listnr = 0;
-	int i;
-
-	utmpname(file);
-
-	{
-#if defined(_HAVE_UT_TV)
-		struct timeval tv;
-		gettimeofday(&tv, NULL);
-		utmpbuf.ut_tv.tv_sec = tv.tv_sec;
-		utmpbuf.ut_tv.tv_usec = tv.tv_usec;
-#else
-		time_t t;
-		time(&t);
-		utmpbuf.ut_time = t;
-#endif
-	}
-
-	(void)signal(SIGINT, onintr);
-	(void)signal(SIGQUIT, onintr);
-
-	if ((fd = open(file,O_RDONLY)) < 0)
-		err(EXIT_FAILURE, _("cannot open %s"), file);
-
-	fstat(fd, &st);
-	utl_len = st.st_size;
-	utl = mmap(NULL, utl_len, PROT_READ|PROT_WRITE,
-		   MAP_PRIVATE|MAP_FILE, fd, 0);
-	if (utl == NULL)
-		err(EXIT_FAILURE, _("%s: mmap failed"), file);
-
-	listnr = utl_len/sizeof(struct utmp);
-
-	if(listnr)
-		ct = utmp_ctime(&utl[0]);
-
-	for(i = listnr - 1; i >= 0; i--) {
-		bp = utl+i;
-		/*
-		 * if the terminal line is '~', the machine stopped.
-		 * see utmp(5) for more info.
-		 */
-		if (!strncmp(bp->ut_line, "~", LMAX)) {
-		    /*
-		     * utmp(5) also mentions that the user
-		     * name should be 'shutdown' or 'reboot'.
-		     * Not checking the name causes e.g. runlevel
-		     * changes to be displayed as 'crash'. -thaele
-		     */
-		    if (!strncmp(bp->ut_user, "reboot", NMAX) ||
-			!strncmp(bp->ut_user, "shutdown", NMAX)) {
-			/* everybody just logged out */
-			for (T = ttylist; T; T = T->next)
-			    T->logout = -bp->ut_time;
-		    }
-
-		    currentout = -bp->ut_time;
-		    crmsg = (strncmp(bp->ut_name, "shutdown", NMAX)
-			    ? "crash" : "down ");
-		    if (!bp->ut_name[0])
-			(void)strcpy(bp->ut_name, "reboot");
-		    if (want(bp, NO)) {
-			ct = utmp_ctime(bp);
-			if(bp->ut_type != LOGIN_PROCESS) {
-			    print_partial_line(bp);
-			    putchar('\n');
-			}
-			if (maxrec && !--maxrec)
-			    return;
-		    }
-		    continue;
-		}
-		/* find associated tty */
-		for (T = ttylist;; T = T->next) {
-		    if (!T) {
-			/* add new one */
-			T = addtty(bp->ut_line);
-			break;
-		    }
-		    if (!strncmp(T->tty, bp->ut_line, LMAX))
-			break;
-		}
-		if (bp->ut_name[0] && bp->ut_type != LOGIN_PROCESS
-		    && bp->ut_type != DEAD_PROCESS
-		    && want(bp, YES)) {
-
-		    print_partial_line(bp);
-
-		    if (!T->logout)
-			puts(_("  still logged in"));
-		    else {
-			if (T->logout < 0) {
-			    T->logout = -T->logout;
-			    printf("- %s", crmsg);
-			}
-			else
-			    printf("- %5.5s", ctime(&T->logout)+11);
-			delta = T->logout - bp->ut_time;
-			if (delta < SECDAY)
-			    printf("  (%5.5s)\n", asctime(gmtime(&delta))+11);
-			else
-			    printf(" (%ld+%5.5s)\n", delta / SECDAY, asctime(gmtime(&delta))+11);
-		    }
-		    if (maxrec != -1 && !--maxrec)
-			return;
-		}
-		T->logout = bp->ut_time;
-		utmpbuf.ut_time = bp->ut_time;
-	}
-	munmap(utl,utl_len);
-	close(fd);
-	if(ct) printf(_("\nwtmp begins %s"), ct); 	/* ct already ends in \n */
-}
-
-/*
- * want --
- *	see if want this entry
- */
-static int
-want(struct utmp *bp, int check) {
-	register ARG	*step;
-
-	if (check) {
-		/*
-		 * when uucp and ftp log in over a network, the entry in
-		 * the utmp file is the name plus their process id.  See
-		 * etc/ftpd.c and usr.bin/uucp/uucpd.c for more information.
-		 */
-		if (!strncmp(bp->ut_line, "ftp", sizeof("ftp") - 1))
-			bp->ut_line[3] = '\0';
-		else if (!strncmp(bp->ut_line, "uucp", sizeof("uucp") - 1))
-			bp->ut_line[4] = '\0';
-	}
-	if (!arglist)
-		return YES;
-
-	for (step = arglist; step; step = step->next)
-		switch(step->type) {
-		case HOST_TYPE:
-			if (!strncmp(step->name, bp->ut_host, HMAX))
-				return YES;
-			break;
-		case TTY_TYPE:
-			if (!strncmp(step->name, bp->ut_line, LMAX))
-				return YES;
-			break;
-		case USER_TYPE:
-			if (!strncmp(step->name, bp->ut_name, NMAX))
-				return YES;
-			break;
-		case INET_TYPE:
-			if ((in_addr_t) bp->ut_addr == inet_addr(step->name))
-			  return YES;
-			break;
-		default:
-			abort();
-		}
-	return NO;
-}
-
-/*
- * addarg --
- *	add an entry to a linked list of arguments
- */
-static void
-addarg(int type, char *arg) {
-	register ARG	*cur;
-
-	cur = xmalloc(sizeof(ARG));
-	cur->next = arglist;
-	cur->type = type;
-	cur->name = arg;
-	arglist = cur;
-}
-
-/*
- * addtty --
- *	add an entry to a linked list of ttys
- */
-TTY *
-addtty(char *ttyname) {
-	register TTY	*cur;
-
-	cur = xmalloc(sizeof(TTY));
-	cur->next = ttylist;
-	cur->logout = currentout;
-	memcpy(cur->tty, ttyname, LMAX);
-	return(ttylist = cur);
-}
-
-/*
- * hostconv --
- *	convert the hostname to search pattern; if the supplied host name
- *	has a domain attached that is the same as the current domain, rip
- *	off the domain suffix since that's what login(1) does.
- */
-static void
-hostconv(char *arg) {
-	static int	first = 1;
-	static char	*hostdot, *name;
-
-	char	*argdot;
-
-	if (!(argdot = strchr(arg, '.')))
-		return;
-
-	if (first) {
-		first = 0;
-		name = xgethostname();
-		if (!name)
-			err(EXIT_FAILURE, _("gethostname failed"));
-
-		hostdot = strchr(name, '.');
-	}
-	if (hostdot && !strcmp(hostdot, argdot))
-		*argdot = '\0';
-}
-
-/*
- * ttyconv --
- *	convert tty to correct name.
- */
-static char *
-ttyconv(char *arg) {
-	char	*mval;
-
-	/*
-	 * kludge -- we assume that all tty's end with
-	 * a two character suffix.
-	 */
-	if (strlen(arg) == 2) {
-		/* either 6 for "ttyxx" or 8 for "console" */
-		mval = xmalloc(8);
-		if (!strncmp(arg, "co", 2))
-			(void)strcpy(mval, "console");
-		else {
-			(void)strcpy(mval, "tty");
-			(void)strncpy(mval + 3, arg, 4);
-		}
-		return mval;
-	}
-	if (!strncmp(arg, "/dev/", sizeof("/dev/") - 1))
-		return arg + 5;
-
-	return arg;
-}
-
-/*
- * onintr --
- *	on interrupt, we inform the user how far we've gotten
- */
-static void
-onintr(int signo) {
-	char	*ct;
-
-	ct = utmp_ctime(&utmpbuf);
-	printf(_("\ninterrupted %10.10s %5.5s \n"), ct, ct + 11);
-	if (signo == SIGINT)
-		_exit(EXIT_FAILURE);
-	fflush(stdout);			/* fix required for rsh */
-}
-- 
2.4.4

