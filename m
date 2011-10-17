Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: =?UTF-8?q?=5BPATCH=2004/49=5D=20login=3A=20remove=20non-PAM=20code?=
Date: Mon, 17 Oct 2011 13:14:43 +0200
Message-Id: <1318850128-23458-5-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

If you need non-PAM login(1) then use shadow-utils or busybox.

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/.gitignore  |    1 -
 login-utils/Makefile.am |   11 +-
 login-utils/checktty.c  |  585 -----------------------------------------------
 login-utils/login.c     |  240 +-------------------
 4 files changed, 6 insertions(+), 831 deletions(-)
 delete mode 100644 login-utils/checktty.c

diff --git a/login-utils/.gitignore b/login-utils/.gitignore
index 4d01927..31af9d4 100644
--- a/login-utils/.gitignore
+++ b/login-utils/.gitignore
@@ -1,4 +1,3 @@
-checktty_test
 islocal_test
 chfn
 chsh
diff --git a/login-utils/Makefile.am b/login-utils/Makefile.am
index f009f2d..7866f7b 100644
--- a/login-utils/Makefile.am
+++ b/login-utils/Makefile.am
@@ -42,14 +42,7 @@ chfn_LDFLAGS = $(SUID_LDFLAGS) $(AM_LDFLAGS)
 chsh_LDFLAGS = $(SUID_LDFLAGS) $(AM_LDFLAGS)
 newgrp_LDFLAGS = $(SUID_LDFLAGS) $(AM_LDFLAGS)
 
-if HAVE_PAM
 login_ldadd_common += -lpam -lpam_misc
-else
-if NEED_LIBCRYPT
-login_ldadd_common += -lcrypt
-endif
-login_SOURCES += checktty.c
-endif #! HAVE_PAM
 
 if NEED_LIBCRYPT
 newgrp_LDADD += -lcrypt
@@ -72,9 +65,7 @@ install-exec-hook::
 
 endif
 
-noinst_PROGRAMS = checktty_test islocal_test
-checktty_test_SOURCES = checktty.c login.h
-checktty_test_CPPFLAGS = -DMAIN_TEST_CHECKTTY $(AM_CPPFLAGS)
+noinst_PROGRAMS = islocal_test
 islocal_test_SOURCES = islocal.c
 islocal_test_CPPFLAGS = -DMAIN_TEST_ISLOCAL $(AM_CPPFLAGS)
 
diff --git a/login-utils/checktty.c b/login-utils/checktty.c
deleted file mode 100644
index 14f3ee1..0000000
--- a/login-utils/checktty.c
+++ /dev/null
@@ -1,585 +0,0 @@
-/* checktty.c - linked into login, checks user against /etc/usertty
-   Created 25-Aug-95 by Peter Orbaek <poe@daimi.aau.dk>
-   Fixed by JDS June 1996 to clear lists and close files
-
-   1999-02-22 Arkadiusz Mi¶kiewicz <misiek@pld.ORG.PL>
-   - added Native Language Support
-
-*/
-
-#include <sys/param.h>
-
-#include <pwd.h>
-#include <grp.h>
-#include <string.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-#include <unistd.h>
-#include <time.h>
-#include <sys/stat.h>
-#include <netdb.h>
-#include <syslog.h>
-#include <sys/socket.h>
-#include <sys/un.h>
-#include <ctype.h>
-#include <limits.h>
-#include <netinet/in.h>
-#include "nls.h"
-
-#include <sys/sysmacros.h>
-#ifdef HAVE_LINUX_MAJOR_H
-#include <linux/major.h>
-#endif
-
-#include "pathnames.h"
-#include "login.h"
-#include "strutils.h"
-
-#ifndef TTY_MAJOR
-#define TTY_MAJOR 4
-#endif
-
-static gid_t mygroups[NGROUPS_MAX];
-static int   num_groups;
-
-#define NAMELEN 128
-
-/* linked list of names */
-struct grplist {
-    struct grplist *next;
-    char name[NAMELEN];
-};
-        
-enum State { StateUsers, StateGroups, StateClasses };
-
-#define CLASSNAMELEN 32
-
-struct ttyclass {
-    struct grplist *first;
-    struct ttyclass *next;
-    char classname[CLASSNAMELEN];
-};
-
-struct ttyclass *ttyclasses = NULL;
-
-static int
-am_in_group(char *group)
-{
-	struct group *g;
-	gid_t *ge;
-	
-	g = getgrnam(group);
-	if (g) {
-		for (ge = mygroups; ge < mygroups + num_groups; ge++) {
-			if (g->gr_gid== *ge) return 1;
-		}
-	}
-    	return 0;
-}
-
-static void
-find_groups()
-{
-	num_groups = getgroups(NGROUPS_MAX, mygroups);
-}
-
-static struct ttyclass *
-new_class(char *class)
-{
-    struct ttyclass *tc;
-
-    tc = (struct ttyclass *)malloc(sizeof(struct ttyclass));
-    if (tc == NULL) {
-	printf(_("login: memory low, login may fail\n"));
-	syslog(LOG_WARNING, _("can't malloc for ttyclass"));
-	return NULL;
-    }
-
-    tc->next = ttyclasses;
-    tc->first = NULL;
-    xstrncpy(tc->classname, class, CLASSNAMELEN);
-    ttyclasses = tc;
-    return tc;
-}
-
-static void
-add_to_class(struct ttyclass *tc, char *tty)
-{
-    struct grplist *ge;
-
-    if (tc == NULL) return;
-
-    ge = (struct grplist *)malloc(sizeof(struct grplist));
-    if (ge == NULL) {
-	printf(_("login: memory low, login may fail\n"));
-	syslog(LOG_WARNING, _("can't malloc for grplist"));
-	return;
-    }
-
-    ge->next = tc->first;
-    xstrncpy(ge->name, tty, NAMELEN);
-    tc->first = ge;
-}
-
-
-/* return true if tty is a pty. Very linux dependent */
-static int
-isapty(const char *tty)
-{
-#ifdef __linux__
-    char devname[100];
-    struct stat stb;
-
-    /* avoid snprintf - old systems do not have it */
-    if (strlen(tty) + 6 > sizeof(devname))
-	    return 0;
-    sprintf(devname, "/dev/%s", tty);
-
-    if((stat(devname, &stb) >= 0) && S_ISCHR(stb.st_mode)) {
-	    int majordev = major(stb.st_rdev);
-
-	    /* this is for linux versions before 1.3: use major 4 */
-	    if(majordev == TTY_MAJOR && minor(stb.st_rdev) >= 192)
-		    return 1;
-
-#if defined(PTY_SLAVE_MAJOR)
-	    /* this is for linux 1.3 and newer: use major 3 */
-	    if(majordev == PTY_SLAVE_MAJOR)
-		    return 1;
-#endif
-
-#if defined(UNIX98_PTY_SLAVE_MAJOR) && defined(UNIX98_PTY_MAJOR_COUNT)
-	    /* this is for linux 2.1.116 and newer: use majors 136-143 */
-	    if(majordev >= UNIX98_PTY_SLAVE_MAJOR &&
-	       majordev < UNIX98_PTY_SLAVE_MAJOR + UNIX98_PTY_MAJOR_COUNT)
-		    return 1;
-#endif
-
-    }
-#endif	/* __linux__ */
-    return 0;
-}
-
-
-/* IPv4 -- pattern is x.x.x.x/y.y.y.y (net/mask)*/
-static int
-hnmatch_ip4(const char *pat)
-{
-	int x1, x2, x3, x4, y1, y2, y3, y4;
-	unsigned long p, mask, a;
-	unsigned char *ha;
-
-	/* pattern is an IP QUAD address and a mask x.x.x.x/y.y.y.y */
-	if (sscanf(pat, "%d.%d.%d.%d/%d.%d.%d.%d",
-			&x1, &x2, &x3, &x4, &y1, &y2, &y3, &y4) < 8)
-		return 0;
-
-	p = (((unsigned long)x1<<24)+((unsigned long)x2<<16)
-	     +((unsigned long)x3<<8)+((unsigned long)x4));
-	mask = (((unsigned long)y1<<24)+((unsigned long)y2<<16)
-		+((unsigned long)y3<<8)+((unsigned long)y4));
-
-	if (hostaddress[0] == 0)
-		return 0;
-
-	ha = (unsigned char *)hostaddress;
-	a = (((unsigned long)ha[0]<<24)+((unsigned long)ha[1]<<16)
-	     +((unsigned long)ha[2]<<8)+((unsigned long)ha[3]));
-	return ((p & mask) == (a & mask));
-}
-
-/* IPv6 -- pattern is [hex:hex:....]/number ([net]/mask) */
-static int
-hnmatch_ip6(const char *pat)
-{
-	char *patnet;
-	char *patmask;
-	struct in6_addr addr;
-	struct addrinfo hints, *res;
-	struct sockaddr_in6 net;
-	int mask_len, i = 0;
-	char *p;
-
-	if (pat == NULL || *pat != '[')
-		return 0;
-
-	memcpy(&addr, hostaddress, sizeof(addr));
-
-	memset(&hints, 0, sizeof(hints));
-	hints.ai_family = AF_INET6;
-	hints.ai_socktype = SOCK_STREAM;
-	hints.ai_flags = AI_PASSIVE | AI_NUMERICHOST;
-
-	patnet = strdup(pat);
-
-	/* match IPv6 address against [netnumber]/prefixlen */
-	if (!(p = strchr(patnet, ']')))
-		goto mismatch;
-
-	*p++ = '\0';
-
-	if (! (*p == '/' && isdigit((unsigned char) *(p + 1))))
-		goto mismatch;
-
-	patmask = p + 1;
-
-	/* prepare net address */
-	if (getaddrinfo(patnet + 1, NULL, &hints, &res) != 0)
-		goto mismatch;
-
-	memcpy(&net, res->ai_addr, sizeof(net));
-	freeaddrinfo(res);
-
-	/* convert mask to number */
-	if ((mask_len = atoi(patmask)) < 0 || mask_len > 128)
-		goto mismatch;
-
-	/* compare */
-	while (mask_len > 0) {
-		if (mask_len < 32) {
-			uint32_t mask = htonl(~(0xffffffff >> mask_len));
-
-			if ((*(uint32_t *)&addr.s6_addr[i] & mask) !=
-			    (*(uint32_t *)&net.sin6_addr.s6_addr[i] & mask))
-				goto mismatch;
-			break;
-		}
-		if (*(uint32_t *)&addr.s6_addr[i] !=
-		    *(uint32_t *)&net.sin6_addr.s6_addr[i])
-			goto mismatch;
-		i += 4;
-		mask_len -= 32;
-	}
-
-	free(patnet);
-	return 1;
-
-mismatch:
-	free(patnet);
-	return 0;
-}
-
-/* match the hostname hn against the pattern pat */
-static int
-hnmatch(const char *hn, const char *pat)
-{
-
-	if ((hn == NULL) && (strcmp(pat, "localhost") == 0))
-		return 1;
-	if ((hn == NULL) || *hn == '\0')
-		return 0;
-
-	if (*pat >= '0' && *pat <= '9')
-		return hostfamily == AF_INET ? hnmatch_ip4(pat) : 0;
-	else if (*pat == '[')
-		return hostfamily == AF_INET6 ? hnmatch_ip6(pat) : 0;
-	else {
-		/* pattern is a suffix of a FQDN */
-		int 	n = strlen(pat),
-			m = strlen(hn);
-
-		if (n > m)
-			return 0;
-		return (strcasecmp(pat, hn + m - n) == 0);
-	}
-}
-
-#ifdef MAIN_TEST_CHECKTTY
-
-char	hostaddress[16];
-sa_family_t hostfamily;
-char	*hostname;
-
-void sleepexit(int eval __attribute__ ((__unused__)))
-{
-	/* dummy for this test */
-}
-
-void badlogin(const char *s __attribute__ ((__unused__)))
-{
-	/* dummy for this test */
-}
-
-int
-main(int argc __attribute__ ((__unused__)),
-     char **argv __attribute__ ((__unused__)))
-{
-	struct addrinfo hints, *info = NULL;
-	struct addrexp {
-		const char *range;
-		const char *ip;
-	} alist[] = {
-		{ "130.225.16.0/255.255.254.0",	"130.225.16.1" },
-		{ "130.225.16.0/255.255.254.0",	"10.20.30.1" },
-		{ "130.225.0.0/255.254.0.0",	"130.225.16.1" },
-		{ "130.225.0.0/255.254.0.0",	"130.225.17.1" },
-		{ "130.225.0.0/255.254.0.0",	"150.160.170.180" },
-		{ "[3ffe:505:2:1::]/64",	"3ffe:505:2:1::" },
-		{ "[3ffe:505:2:1::]/64",	"3ffe:505:2:2::" },
-		{ "[3ffe:505:2:1::]/64",	"3ffe:505:2:1:ffff:ffff::" },
-		{ NULL, NULL }
-	}, *item;
-
-	memset(&hints, 0, sizeof(hints));
-	hints.ai_family = AF_UNSPEC;
-	hints.ai_flags = AI_NUMERICHOST |  AI_PASSIVE | AI_ADDRCONFIG;
-	hints.ai_socktype = SOCK_STREAM;
-
-	for (item = alist; item->range; item++) {
-
-		printf("hnmatch() on %-30s <-- %-15s: ", item->range, item->ip);
-
-		if (getaddrinfo(item->ip, NULL, &hints, &info)==0 && info) {
-			if (info->ai_family == AF_INET)	{
-			    struct sockaddr_in *sa =
-					(struct sockaddr_in *) info->ai_addr;
-			    memcpy(hostaddress, &(sa->sin_addr),
-					sizeof(sa->sin_addr));
-			}
-			else if (info->ai_family == AF_INET6) {
-			    struct sockaddr_in6 *sa =
-					(struct sockaddr_in6 *) info->ai_addr;
-			    memcpy(hostaddress, &(sa->sin6_addr),
-					sizeof(sa->sin6_addr));
-			}
-			hostfamily = info->ai_family;
-			freeaddrinfo(info);
-			printf("%s\n", hnmatch("dummy", item->range) ?
-						"match" : "mismatch");
-		}
-		else
-			printf("getaddrinfo() failed\n");
-
-	}
-	return EXIT_SUCCESS;
-}
-#endif /* MAIN_TEST_CHECKTTY */
-
-static char *wdays[] = { "sun", "mon", "tue", "wed", "thu", "fri", "sat" };
-
-/* example timespecs:
-
-   mon:tue:wed:8-17
-
-   meaning monday, tuesday or wednesday between 8:00 and 17:59
-
-   4:5:13:fri
-
-   meaning fridays from 4:00 to 5:59 and from 13:00 to 13:59
-*/
-static int
-timeok(struct tm *t, char *spec)
-{
-    char *p, *q;
-    int dayok = 0;
-    int hourok = 0;
-    int h, h2;
-    char *sp;
-
-    sp = spec;
-    while ((p = strsep(&sp, ":"))) {
-	if (*p >= '0' && *p <= '9') {
-	    h = atoi(p);
-	    if (h == t->tm_hour) hourok = 1;
-	    if ((q = strchr(p, '-')) && (q[1] >= '0' && q[1] <= '9')) {
-		h2 = atoi(q+1);
-		if (h <= t->tm_hour && t->tm_hour <= h2) hourok = 1;
-	    }
-	} else if (strcasecmp(wdays[t->tm_wday], p) == 0) {
-	    dayok = 1;
-	}
-    }
-
-    return (dayok && hourok);
-}
-
-/* return true if tty equals class or is in the class defined by class.
-   Also return true if hostname matches the hostname pattern, class
-   or a pattern in the class named by class. */
-static int
-in_class(const char *tty, char *class)
-{
-    struct ttyclass *tc;
-    struct grplist *ge;
-    time_t t;
-    char *p;
-    char timespec[256];
-    struct tm *tm;
-    char *n;
-
-    time(&t);
-    tm = localtime(&t);
-
-    if (class[0] == '[') {
-	if ((p = strchr(class, ']'))) {
-	    *p = 0;
-	    xstrncpy(timespec, class+1, sizeof(timespec));
-	    *p = ']';
-	    if(!timeok(tm, timespec)) return 0;
-	    class = p+1;
-	}
-	/* really ought to warn about syntax error */
-    }
-
-    if (strcmp(tty, class) == 0) return 1;
-
-    if ((class[0] == '@') && isapty(tty)
-	&& hnmatch(hostname, class+1)) return 1;
-
-    for (tc = ttyclasses; tc; tc = tc->next) {
-	if (strcmp(tc->classname, class) == 0) {
-	    for (ge = tc->first; ge; ge = ge->next) {
-
-		n = ge->name;
-		if (n[0] == '[') {
-		    if ((p = strchr(n, ']'))) {
-			*p = 0;
-			xstrncpy(timespec, n+1, sizeof(timespec));
-			*p = ']';
-			if(!timeok(tm, timespec)) continue;
-			n = p+1;
-		    }
-		    /* really ought to warn about syntax error */
-		}
-
-		if (strcmp(n, tty) == 0) return 1;
-
-		if ((n[0] == '@') && isapty(tty)
-		    && hnmatch(hostname, n+1)) return 1;
-	    }
-	    return 0;
-	}
-    }
-    return 0;
-}
-
-/* start JDS - SBA */
-static void 
-free_group(struct grplist *ge)
-{
-    if (ge) {
-	memset(ge->name, 0, NAMELEN);
-	free_group(ge->next);
-	free(ge->next);
-	ge->next = NULL;
-    }
-}
-
-static void 
-free_class(struct ttyclass *tc)
-{
-    if (tc) {
-	memset(tc->classname, 0, CLASSNAMELEN);
-	free_group(tc->first);
-	tc->first = NULL;
-	free_class(tc->next);
-	free(tc->next);
-	tc->next = NULL;
-    }
-}
-
-static void 
-free_all(void)
-{
-    free_class(ttyclasses);
-    ttyclasses = NULL;
-}
-/* end JDS - SBA */
-
-void
-checktty(const char *user, const char *tty, struct passwd *pwd)
-{
-    FILE *f;
-    char buf[256], defaultbuf[256];
-    char *ptr;
-    enum State state = StateUsers;
-    int found_match = 0;
-
-    /* no /etc/usertty, default to allow access */
-    if (!(f = fopen(_PATH_USERTTY, "r"))) return;
-
-    if (pwd == NULL) {
-	fclose(f);
-	return;  /* misspelled username handled elsewhere */
-    }
-
-    find_groups();
-
-    defaultbuf[0] = 0;
-    while(fgets(buf, 255, f)) {
-
-	/* strip comments */
-	for(ptr = buf; ptr < buf + 256; ptr++) 
-	  if(*ptr == '#') *ptr = 0;
-
-	if (buf[0] == '*') {
-	    xstrncpy(defaultbuf, buf, 256);
-	    continue;
-	}
-
-	if (strncmp("GROUPS", buf, 6) == 0) {
-	    state = StateGroups;
-	    continue;
-	} else if (strncmp("USERS", buf, 5) == 0) {
-	    state = StateUsers;
-	    continue;
-	} else if (strncmp("CLASSES", buf, 7) == 0) {
-	    state = StateClasses;
-	    continue;
-	}
-
-	strtok(buf, " \t");
-	if((state == StateUsers && (strncmp(user, buf, 8) == 0))
-	   || (state == StateGroups && am_in_group(buf))) {
-	    found_match = 1;  /* we found a line matching the user */
-	    while((ptr = strtok(NULL, "\t\n "))) {
-		if (in_class(tty, ptr)) {
-		    fclose(f);
-		    free_all(); /* JDS */
-		    return;
-		}
-	    }
-	} else if (state == StateClasses) {
-	    /* define a new tty/host class */
-	    struct ttyclass *tc = new_class(buf);
-
-	    while ((ptr = strtok(NULL, "\t\n "))) {
-		add_to_class(tc, ptr);
-	    }
-	}
-    }
-    fclose(f);
-
-    /* user is not explicitly mentioned in /etc/usertty, if there was
-       a default rule, use that */
-    if (defaultbuf[0]) {
-	strtok(defaultbuf, " \t");
-	while((ptr = strtok(NULL, "\t\n "))) {
-	    if (in_class(tty, ptr)) {
-		free_all(); /* JDS */
-		return;
-	    }
-	}
-
-	/* there was a default rule, but user didn't match, reject! */
-	printf(_("Login on %s from %s denied by default.\n"), tty, hostname);
-	badlogin(user);
-	sleepexit(EXIT_FAILURE);
-    }
-
-    if (found_match) {
-	/* if we get here, /etc/usertty exists, there's a line
-	   matching our username, but it doesn't contain the
-	   name of the tty where the user is trying to log in.
-	   So deny access! */
-
-	printf(_("Login on %s from %s denied.\n"), tty, hostname);
-	badlogin(user);
-	sleepexit(EXIT_FAILURE);
-    }
-
-    /* users not matched in /etc/usertty are by default allowed access
-       on all tty's */
-    free_all(); /* JDS */
-}
diff --git a/login-utils/login.c b/login-utils/login.c
index bcac52d..a7d6b02 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -64,21 +64,19 @@
 #include "xalloc.h"
 #include "c.h"
 
-#ifdef HAVE_SECURITY_PAM_MISC_H
-#  include <security/pam_appl.h>
-#  include <security/pam_misc.h>
-#  define PAM_MAX_LOGIN_TRIES	3
-#  define PAM_FAIL_CHECK if (retcode != PAM_SUCCESS) { \
+#include <security/pam_appl.h>
+#include <security/pam_misc.h>
+#define PAM_MAX_LOGIN_TRIES	3
+#define PAM_FAIL_CHECK if (retcode != PAM_SUCCESS) { \
        fprintf(stderr,"\n%s\n",pam_strerror(pamh, retcode)); \
        syslog(LOG_ERR,"%s",pam_strerror(pamh, retcode)); \
        pam_end(pamh, retcode); exit(EXIT_FAILURE); \
    }
-#  define PAM_END { \
+#define PAM_END { \
 	pam_setcred(pamh, PAM_DELETE_CRED); \
 	retcode = pam_close_session(pamh,0); \
 	pam_end(pamh,retcode); \
 }
-#endif
 
 #include <lastlog.h>
 
@@ -116,9 +114,7 @@ int     timeout = 60;
 
 struct passwd *pwd;
 
-#ifdef HAVE_SECURITY_PAM_MISC_H
 static struct passwd pwdcopy;
-#endif
 char    hostaddress[16];	/* used in checktty.c */
 sa_family_t hostfamily;		/* used in checktty.c */
 char	*hostname;		/* idem */
@@ -200,7 +196,6 @@ consoletty(int fd) {
 }
 #endif
 
-#ifdef HAVE_SECURITY_PAM_MISC_H
 /*
  * Log failed login attempts in _PATH_BTMP if that exists.
  * Must be called only with username the name of an actual user.
@@ -266,8 +261,6 @@ sig_handler(int signal)
 		kill(-child_pid, SIGHUP); /* because the shell often ignores SIGTERM */
 }
 
-#endif	/* HAVE_SECURITY_PAM_MISC_H */
-
 #ifdef HAVE_LIBAUDIT
 static void
 logaudit(const char *tty, const char *username, const char *hostname,
@@ -291,7 +284,6 @@ logaudit(const char *tty, const char *username, const char *hostname,
 # define logaudit(tty, username, hostname, pwd, status)
 #endif /* HAVE_LIBAUDIT */
 
-#ifdef HAVE_SECURITY_PAM_MISC_H
 /* encapsulate stupid "void **" pam_get_item() API */
 int
 get_pam_username(pam_handle_t *pamh, char **name)
@@ -302,7 +294,6 @@ get_pam_username(pam_handle_t *pamh, char **name)
 	*name = (char *) item;
 	return rc;
 }
-#endif
 
 /*
  * We need to check effective UID/GID. For example $HOME could be on root
@@ -335,15 +326,10 @@ main(int argc, char **argv)
     char *childArgv[10];
     char *buff;
     int childArgc = 0;
-#ifdef HAVE_SECURITY_PAM_MISC_H
     int retcode;
     pam_handle_t *pamh = NULL;
     struct pam_conv conv = { misc_conv, NULL };
     struct sigaction sa, oldsa_hup, oldsa_term;
-#else
-    int ask;
-    char *salt, *pp;
-#endif
 #ifdef LOGIN_CHOWN_VCS
     char vcsn[20], vcsan[20];
 #endif
@@ -435,10 +421,6 @@ main(int argc, char **argv)
     argc -= optind;
     argv += optind;
 
-#ifndef HAVE_SECURITY_PAM_MISC_H
-    ask = *argv ? 0 : 1;		/* Do we need ask for login name? */
-#endif
-
     if (*argv) {
 	char *p = *argv;
 	username = strdup(p);
@@ -509,7 +491,6 @@ main(int argc, char **argv)
 
     openlog("login", LOG_ODELAY, LOG_AUTHPRIV);
 
-#ifdef HAVE_SECURITY_PAM_MISC_H
     /*
      * username is initialized to NULL
      * and if specified on the command line it is set.
@@ -676,118 +657,6 @@ main(int argc, char **argv)
 	    pam_close_session(pamh, 0);
     PAM_FAIL_CHECK;
 
-#else /* ! HAVE_SECURITY_PAM_MISC_H */
-
-    for (cnt = 0;; ask = 1) {
-
-	if (ask) {
-	    fflag = 0;
-	    getloginname();
-	}
-
-	/* Dirty patch to fix a gigantic security hole when using
-	   yellow pages. This problem should be solved by the
-	   libraries, and not by programs, but this must be fixed
-	   urgently! If the first char of the username is '+', we
-	   avoid login success.
-	   Feb 95 <alvaro@etsit.upm.es> */
-
-	if (username[0] == '+') {
-	    puts(_("Illegal username"));
-	    badlogin(username);
-	    sleepexit(EXIT_FAILURE);
-	}
-
-	/* (void)strcpy(tbuf, username); why was this here? */
-	if ((pwd = getpwnam(username))) {
-#  ifdef SHADOW_PWD
-	    struct spwd *sp;
-
-	    if ((sp = getspnam(username)))
-	      pwd->pw_passwd = sp->sp_pwdp;
-#  endif
-	    salt = pwd->pw_passwd;
-	} else
-	  salt = "xx";
-
-	if (pwd) {
-	    initgroups(username, pwd->pw_gid);
-	    checktty(username, tty_name, pwd); /* in checktty.c */
-	}
-
-	/* if user not super-user, check for disabled logins */
-	if (pwd == NULL || pwd->pw_uid)
-	  checknologin();
-
-	/*
-	 * Disallow automatic login to root; if not invoked by
-	 * root, disallow if the uid's differ.
-	 */
-	if (fflag && pwd) {
-	    int uid = getuid();
-
-	    passwd_req = pwd->pw_uid == 0 ||
-	      (uid && uid != pwd->pw_uid);
-	}
-
-	/*
-	 * If trying to log in as root, but with insecure terminal,
-	 * refuse the login attempt.
-	 */
-	if (pwd && pwd->pw_uid == 0 && !rootterm(tty_name)) {
-	    warnx(_("%s login refused on this terminal."),
-		    pwd->pw_name);
-
-	    if (hostname)
-	      syslog(LOG_NOTICE,
-		     _("LOGIN %s REFUSED FROM %s ON TTY %s"),
-		     pwd->pw_name, hostname, tty_name);
-	    else
-	      syslog(LOG_NOTICE,
-		     _("LOGIN %s REFUSED ON TTY %s"),
-		     pwd->pw_name, tty_name);
-	    logaudit(tty_name, pwd->pw_name, hostname, pwd, 0);
-	    continue;
-	}
-
-	/*
-	 * If no pre-authentication and a password exists
-	 * for this user, prompt for one and verify it.
-	 */
-	if (!passwd_req || (pwd && !*pwd->pw_passwd))
-	  break;
-
-	setpriority(PRIO_PROCESS, 0, -4);
-	pp = getpass(_("Password: "));
-
-#  ifdef CRYPTOCARD
-	if (strncmp(pp, "CRYPTO", 6) == 0) {
-	    if (pwd && cryptocard()) break;
-	}
-#  endif /* CRYPTOCARD */
-
-	p = crypt(pp, salt);
-	setpriority(PRIO_PROCESS, 0, 0);
-
-	memset(pp, 0, strlen(pp));
-
-	if (pwd && !strcmp(p, pwd->pw_passwd))
-	  break;
-
-	printf(_("Login incorrect\n"));
-	badlogin(username); /* log ALL bad logins */
-	failures++;
-
-	/* we allow 10 tries, but after 3 we start backing off */
-	if (++cnt > 3) {
-	    if (cnt >= 10) {
-		sleepexit(EXIT_FAILURE);
-	    }
-	    sleep((unsigned int)((cnt - 3) * 5));
-	}
-    }
-#endif /* !HAVE_SECURITY_PAM_MISC_H */
-
     /* committed to login -- turn off timeout */
     alarm((unsigned int)0);
 
@@ -979,7 +848,6 @@ Michael Riepe <michael@stud.uni-hannover.de>
        */
     setenv("LOGNAME", pwd->pw_name, 1);
 
-#ifdef HAVE_SECURITY_PAM_MISC_H
     {
 	int i;
 	char ** env = pam_getenvlist(pamh);
@@ -991,7 +859,6 @@ Michael Riepe <michael@stud.uni-hannover.de>
 	    }
 	}
     }
-#endif
 
     setproctitle("login", username);
 
@@ -1045,8 +912,6 @@ Michael Riepe <michael@stud.uni-hannover.de>
     signal(SIGQUIT, SIG_DFL);
     signal(SIGTSTP, SIG_IGN);
 
-#ifdef HAVE_SECURITY_PAM_MISC_H
-
     memset(&sa, 0, sizeof(sa));
     sa.sa_handler = SIG_IGN;
     sigaction(SIGINT, &sa, NULL);
@@ -1126,7 +991,6 @@ Michael Riepe <michael@stud.uni-hannover.de>
      */
     if (ioctl(0, TIOCSCTTY, 1))
 	    syslog(LOG_ERR, _("TIOCSCTTY failed: %m"));
-#endif
     signal(SIGINT, SIG_DFL);
 
     /* discard permissions last so can't get killed and drop core */
@@ -1176,50 +1040,6 @@ Michael Riepe <michael@stud.uni-hannover.de>
     exit(EXIT_SUCCESS);
 }
 
-#ifndef HAVE_SECURITY_PAM_MISC_H
-static void
-getloginname(void) {
-    int ch, cnt, cnt2;
-    char *p;
-    static char nbuf[UT_NAMESIZE + 1];
-
-    cnt2 = 0;
-    for (;;) {
-	cnt = 0;
-	printf(_("\n%s login: "), thishost); fflush(stdout);
-	for (p = nbuf; (ch = getchar()) != '\n'; ) {
-	    if (ch == EOF) {
-		badlogin("EOF");
-		exit(EXIT_FAILURE);
-	    }
-	    if (p < nbuf + UT_NAMESIZE)
-	      *p++ = ch;
-
-	    cnt++;
-	    if (cnt > UT_NAMESIZE + 20) {
-		badlogin(_("NAME too long"));
-		errx(EXIT_FAILURE, _("login name much too long."));
-	    }
-	}
-	if (p > nbuf) {
-	  if (nbuf[0] == '-')
-	     warnx(_("login names may not start with '-'."));
-	  else {
-	      *p = '\0';
-	      username = nbuf;
-	      break;
-	  }
-	}
-
-	cnt2++;
-	if (cnt2 > 50) {
-	    badlogin(_("EXCESSIVE linefeeds"));
-	    errx(EXIT_FAILURE, _("too many bare linefeeds."));
-	}
-    }
-}
-#endif
-
 /*
  * Robert Ambrose writes:
  * A couple of my users have a problem with login processes hanging around
@@ -1252,38 +1072,6 @@ timedout(int sig __attribute__((__unused__))) {
 	timedout2(0);
 }
 
-#ifndef HAVE_SECURITY_PAM_MISC_H
-int
-rootterm(char * ttyn)
-{
-    int fd;
-    char buf[100],*p;
-    int cnt, more = 0;
-
-    fd = open(_PATH_SECURETTY, O_RDONLY);
-    if(fd < 0) return 1;
-
-    /* read each line in /etc/securetty, if a line matches our ttyline
-       then root is allowed to login on this tty, and we should return
-       true. */
-    for(;;) {
-	p = buf; cnt = 100;
-	while(--cnt >= 0 && (more = read(fd, p, 1)) == 1 && *p != '\n') p++;
-	if(more && *p == '\n') {
-	    *p = '\0';
-	    if(!strcmp(buf, ttyn)) {
-		close(fd);
-		return 1;
-	    } else
-	      continue;
-	} else {
-	    close(fd);
-	    return 0;
-	}
-    }
-}
-#endif /* !HAVE_SECURITY_PAM_MISC_H */
-
 jmp_buf motdinterrupt;
 
 void
@@ -1310,24 +1098,6 @@ sigint(int sig  __attribute__((__unused__))) {
     longjmp(motdinterrupt, 1);
 }
 
-#ifndef HAVE_SECURITY_PAM_MISC_H			/* PAM takes care of this */
-void
-checknologin(void) {
-    int fd, nchars;
-    char tbuf[8192];
-
-    if ((fd = open(_PATH_NOLOGIN, O_RDONLY, 0)) >= 0) {
-	while ((nchars = read(fd, tbuf, sizeof(tbuf))) > 0) {
-	  if (write(fileno(stdout), tbuf, nchars)) {
-		;	/* glibc warn_unused_result */
-	  }
-	}
-	close(fd);
-	sleepexit(EXIT_SUCCESS);
-    }
-}
-#endif
-
 void
 dolastlog(int quiet) {
     struct lastlog ll;
-- 
1.7.6.4
