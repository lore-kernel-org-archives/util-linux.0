Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48599 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964951Ab2B1Qp3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Feb 2012 11:45:29 -0500
Received: by mail-vx0-f174.google.com with SMTP id p1so2644946vcq.19
        for <util-linux@vger.kernel.org>; Tue, 28 Feb 2012 08:45:29 -0800 (PST)
MIME-Version: 1.0
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 02/13] sulogin: initial import from sysvinit
Date: Tue, 28 Feb 2012 11:45:10 -0500
Message-Id: <1330447521-886-3-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Import the source and manpage of sulogin. Only the selinux #ifdef is
changed to match our autotool setup.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 login-utils/Makefile.am |    6 +-
 login-utils/sulogin.8   |   87 +++++++
 login-utils/sulogin.c   |  605 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 697 insertions(+), 1 deletion(-)
 create mode 100644 login-utils/sulogin.8
 create mode 100644 login-utils/sulogin.c

diff --git a/login-utils/Makefile.am b/login-utils/Makefile.am
index 47274bf..6d5f4e9 100644
--- a/login-utils/Makefile.am
+++ b/login-utils/Makefile.am
@@ -14,6 +14,7 @@ endif
 if BUILD_LOGIN_UTILS
 
 bin_PROGRAMS += login
+sbin_PROGRAMS += sulogin
 usrbin_exec_PROGRAMS += \
 	chfn \
 	chsh \
@@ -26,7 +27,8 @@ dist_man_MANS += \
 	login.1 \
 	newgrp.1 \
 	vigr.8 \
-	vipw.8
+	vipw.8 \
+	sulogin.8
 
 # login, chfn and chsh libs
 login_ldadd_common =
@@ -57,6 +59,7 @@ chsh_LDADD = $(login_ldadd_common)
 login_LDADD = $(login_ldadd_common)
 newgrp_LDADD =
 vipw_LDADD =
+sulogin_LDADD =
 
 chfn_CFLAGS = $(SUID_CFLAGS) $(AM_CFLAGS)
 chsh_CFLAGS = $(SUID_CFLAGS) $(AM_CFLAGS)
@@ -70,6 +73,7 @@ login_ldadd_common += -lpam -lpam_misc
 
 if HAVE_LIBCRYPT
 newgrp_LDADD += -lcrypt
+sulogin_LDADD += -lcrypt
 endif
 
 if HAVE_AUDIT
diff --git a/login-utils/sulogin.8 b/login-utils/sulogin.8
new file mode 100644
index 0000000..4b5d153
--- /dev/null
+++ b/login-utils/sulogin.8
@@ -0,0 +1,87 @@
+'\" -*- coding: UTF-8 -*-
+.\" Copyright (C) 1998-2006 Miquel van Smoorenburg.
+.\"
+.\" This program is free software; you can redistribute it and/or modify
+.\" it under the terms of the GNU General Public License as published by
+.\" the Free Software Foundation; either version 2 of the License, or
+.\" (at your option) any later version.
+.\"
+.\" This program is distributed in the hope that it will be useful,
+.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+.\" GNU General Public License for more details.
+.\"
+.\" You should have received a copy of the GNU General Public License
+.\" along with this program; if not, write to the Free Software
+.\" Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+.\"
+.TH SULOGIN 8 "17 Jan 2006" "" "Linux System Administrator's Manual"
+.SH NAME
+sulogin \- Single-user login
+.SH SYNOPSIS
+.B sulogin
+[ \fB\-e\fP ]
+[ \fB\-p\fP ]
+[ \fB\-t\fP \fISECONDS\fP ]
+[ \fITTY\fP ]
+.SH DESCRIPTION
+.I sulogin
+is invoked by \fBinit(8)\fP when the system goes into single user mode.
+(This is done through an entry in \fIinittab(5)\fP.)
+\fBInit\fP also
+tries to execute \fIsulogin\fP when
+the boot loader (e.g., \fBgrub\fP(8))
+passes it the \fB\-b\fP option.
+.PP
+The user is prompted
+.IP "" .5i
+Give root password for system maintenance
+.br
+(or type Control\-D for normal startup):
+.PP
+\fIsulogin\fP will be connected to the current terminal, or to the
+optional device that can be specified on the command line
+(typically \fB/dev/console\fP).
+.PP
+If the \fB\-t\fP option is used then the program only waits
+the given number of seconds for user input.
+.PP
+If the \fB\-p\fP option is used then the single-user shell is invoked
+with a \fIdash\fP as the first character in \fIargv[0]\fP.
+This causes the shell process to behave as a login shell.
+The default is \fInot\fP to do this,
+so that the shell will \fInot\fP read \fB/etc/profile\fP
+or \fB$HOME/.profile\fP at startup.
+.PP
+After the user exits the single-user shell,
+or presses control\-D at the prompt,
+the system will (continue to) boot to the default runlevel.
+.SH ENVIRONMENT VARIABLES
+\fIsulogin\fP looks for the environment variable \fBSUSHELL\fP or
+\fBsushell\fP to determine what shell to start. If the environment variable
+is not set, it will try to execute root's shell from /etc/passwd. If that
+fails it will fall back to \fB/bin/sh\fP.
+.PP
+This is very valuable together with the \fB\-b\fP option to init. To boot
+the system into single user mode, with the root file system mounted read/write,
+using a special "fail safe" shell that is statically linked (this example
+is valid for the LILO bootprompt)
+.PP
+boot: linux \-b rw sushell=/sbin/sash
+.SH FALLBACK METHODS
+\fIsulogin\fP checks the root password using the standard method (getpwnam)
+first.
+Then, if the \fB\-e\fP option was specified,
+\fIsulogin\fP examines these files directly to find the root password:
+.PP
+/etc/passwd,
+.br
+/etc/shadow (if present)
+.PP
+If they are damaged or nonexistent, sulogin will start a root shell
+without asking for a password. Only use the \fB\-e\fP option if you
+are sure the console is physically protected against unauthorized access.
+.SH AUTHOR
+Miquel van Smoorenburg <miquels@cistron.nl>
+.SH SEE ALSO
+init(8), inittab(5).
diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
new file mode 100644
index 0000000..969fc52
--- /dev/null
+++ b/login-utils/sulogin.c
@@ -0,0 +1,605 @@
+/*
+ * sulogin	This program gives Linux machines a reasonable
+ *		secure way to boot single user. It forces the
+ *		user to supply the root password before a
+ *		shell is started.
+ *
+ *		If there is a shadow password file and the
+ *		encrypted root password is "x" the shadow
+ *		password will be used.
+ *
+ * Version:	@(#)sulogin 2.85-3 23-Apr-2003 miquels@cistron.nl
+ *
+ * Copyright (C) 1998-2003 Miquel van Smoorenburg.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ * 
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <pwd.h>
+#include <shadow.h>
+#include <termios.h>
+#include <sys/ttydefaults.h>
+#include <errno.h>
+#include <sys/ioctl.h>
+#if defined(__GLIBC__)
+#  include <crypt.h>
+#endif
+
+#ifdef HAVE_LIBSELINUX
+#  include <selinux/selinux.h>
+#  include <selinux/get_context_list.h>
+#endif
+
+#define CHECK_DES	1
+#define CHECK_MD5	1
+
+#define F_PASSWD	"/etc/passwd"
+#define F_SHADOW	"/etc/shadow"
+#define BINSH		"/bin/sh"
+#define STATICSH	"/bin/sash"
+
+static int timeout;
+static int profile;
+
+static void (*saved_sigint)  = SIG_DFL;
+static void (*saved_sigtstp) = SIG_DFL;
+static void (*saved_sigquit) = SIG_DFL;
+
+#ifndef IUCLC
+#  define IUCLC	0
+#endif
+
+#if defined(SANE_TIO) && (SANE_TIO == 1)
+/*
+ *	Fix the tty modes and set reasonable defaults.
+ *	(I'm not sure if this is needed under Linux, but..)
+ */
+static
+void fixtty(void)
+{
+	struct termios tty;
+	int serial;
+
+	/* Skip serial console */
+	if (ioctl (0, TIOCMGET, (char*)&serial) == 0)
+		goto out;
+	/* Expected error */
+	serial = errno = 0;
+
+	tcgetattr(0, &tty);
+
+	/* Use defaults of <sys/ttydefaults.h> for base settings */
+	tty.c_iflag |= TTYDEF_IFLAG;
+	tty.c_oflag |= TTYDEF_OFLAG;
+	tty.c_lflag |= TTYDEF_LFLAG;
+	tty.c_cflag |= (TTYDEF_SPEED | TTYDEF_CFLAG);
+
+	/* Sane setting, allow eight bit characters, no carriage return delay
+	 * the same result as `stty sane cr0 pass8'
+	 */
+	tty.c_iflag |=  (BRKINT | ICRNL | IMAXBEL);
+#ifdef IUTF8 /* Not defined on FreeBSD */
+	tty.c_iflag |= IUTF8;
+#endif /* IUTF8 */
+	tty.c_iflag &= ~(IGNBRK | INLCR | IGNCR | IXOFF | IUCLC | IXANY | ISTRIP);
+	tty.c_oflag |=  (OPOST | ONLCR | NL0 | CR0 | TAB0 | BS0 | VT0 | FF0);
+	tty.c_oflag &= ~(OLCUC | OCRNL | ONOCR | ONLRET | OFILL | OFDEL |\
+			 NLDLY|CRDLY|TABDLY|BSDLY|VTDLY|FFDLY);
+	tty.c_lflag |=  (ISIG | ICANON | IEXTEN | ECHO|ECHOE|ECHOK|ECHOCTL|ECHOKE);
+	tty.c_lflag &= ~(ECHONL | NOFLSH | XCASE | TOSTOP | ECHOPRT);
+	tty.c_cflag |=  (CREAD | CS8 | B9600);
+	tty.c_cflag &= ~(PARENB);
+
+	/* VTIME and VMIN can overlap with VEOF and VEOL since they are
+	 * only used for non-canonical mode. We just set the at the
+	 * beginning, so nothing bad should happen.
+	 */
+	tty.c_cc[VTIME]    = 0;
+	tty.c_cc[VMIN]     = 1;
+	tty.c_cc[VINTR]    = CINTR;
+	tty.c_cc[VQUIT]    = CQUIT;
+	tty.c_cc[VERASE]   = CERASE; /* ASCII DEL (0177) */
+	tty.c_cc[VKILL]    = CKILL;
+	tty.c_cc[VEOF]     = CEOF;
+	tty.c_cc[VSWTC]    = _POSIX_VDISABLE;
+	tty.c_cc[VSTART]   = CSTART;
+	tty.c_cc[VSTOP]    = CSTOP;
+	tty.c_cc[VSUSP]    = CSUSP;
+	tty.c_cc[VEOL]     = _POSIX_VDISABLE;
+	tty.c_cc[VREPRINT] = CREPRINT;
+	tty.c_cc[VDISCARD] = CDISCARD;
+	tty.c_cc[VWERASE]  = CWERASE;
+	tty.c_cc[VLNEXT]   = CLNEXT;
+	tty.c_cc[VEOL2]    = _POSIX_VDISABLE;
+
+	tcsetattr(0, TCSANOW, &tty);
+out:
+	return;
+}
+#endif
+
+
+/*
+ *	Called at timeout.
+ */
+static
+# ifdef __GNUC__
+void alrm_handler(int sig __attribute__((unused)))
+# else
+void alrm_handler(int sig)
+# endif
+{
+}
+
+/*
+ *	See if an encrypted password is valid. The encrypted
+ *	password is checked for traditional-style DES and
+ *	FreeBSD-style MD5 encryption.
+ */
+static
+int valid(const char *pass)
+{
+	const char *s;
+	char id[5];
+	size_t len;
+	off_t off;
+
+	if (pass[0] == 0) return 1;
+#if CHECK_MD5
+	if (pass[0] != '$') goto check_des;
+
+	/*
+	 *	up to 4 bytes for the signature e.g. $1$
+	 */
+	for(s = pass+1; *s && *s != '$'; s++)
+		;
+	if (*s++ != '$') return 0;
+	if ((off = (off_t)(s-pass)) > 4 || off < 3) return 0;
+
+	memset(id, '\0', sizeof(id));
+	strncpy(id, pass, off);
+
+	/*
+	 *	up to 16 bytes for the salt
+	 */
+	for(; *s && *s != '$'; s++)
+		;
+	if (*s++ != '$') return 0;
+	if ((off_t)(s-pass) > 16) return 0;
+	len = strlen(s);
+
+	/*
+	 *	the MD5 hash (128 bits or 16 bytes) encoded in base64 = 22 bytes
+	 */
+	if ((strcmp(id, "$1$") == 0) && (len < 22 || len > 24)) return 0;
+
+	/*
+	 *	the SHA-256 hash 43 bytes
+	 */
+	if ((strcmp(id, "$5$") == 0) && (len < 42 || len > 44)) return 0;
+
+	/*
+	 *      the SHA-512 hash 86 bytes
+	 */
+	if ((strcmp(id, "$6$") == 0) && (len < 85 || len > 87)) return 0;
+
+	/*
+	 *	e.g. Blowfish hash
+	 */
+	return 1;
+check_des:
+#endif
+#if CHECK_DES
+	if (strlen(pass) != 13) return 0;
+	for (s = pass; *s; s++) {
+		if ((*s < '0' || *s > '9') &&
+		    (*s < 'a' || *s > 'z') &&
+		    (*s < 'A' || *s > 'Z') &&
+		    *s != '.' && *s != '/') return 0;
+	}
+#endif
+	return 1;
+}
+
+/*
+ *	Set a variable if the value is not NULL.
+ */
+static
+void set(char **var, char *val)
+{
+	if (val) *var = val;
+}
+
+/*
+ *	Get the root password entry.
+ */
+static
+struct passwd *getrootpwent(int try_manually)
+{
+	static struct passwd pwd;
+	struct passwd *pw;
+	struct spwd *spw;
+	FILE *fp;
+	static char line[256];
+	static char sline[256];
+	char *p;
+
+	/*
+	 *	First, we try to get the password the standard
+	 *	way using normal library calls.
+	 */
+	if ((pw = getpwnam("root")) &&
+	    !strcmp(pw->pw_passwd, "x") &&
+	    (spw = getspnam("root")))
+		pw->pw_passwd = spw->sp_pwdp;
+	if (pw || !try_manually) return pw;
+
+	/*
+	 *	If we come here, we could not retrieve the root
+	 *	password through library calls and we try to
+	 *	read the password and shadow files manually.
+	 */
+	pwd.pw_name = "root";
+	pwd.pw_passwd = "";
+	pwd.pw_gecos = "Super User";
+	pwd.pw_dir = "/";
+	pwd.pw_shell = "";
+	pwd.pw_uid = 0;
+	pwd.pw_gid = 0;
+
+	if ((fp = fopen(F_PASSWD, "r")) == NULL) {
+		perror(F_PASSWD);
+		return &pwd;
+	}
+
+	/*
+	 *	Find root in the password file.
+	 */
+	while((p = fgets(line, 256, fp)) != NULL) {
+		if (strncmp(line, "root:", 5) != 0)
+			continue;
+		p += 5;
+		set(&pwd.pw_passwd, strsep(&p, ":"));
+		(void)strsep(&p, ":");
+		(void)strsep(&p, ":");
+		set(&pwd.pw_gecos, strsep(&p, ":"));
+		set(&pwd.pw_dir, strsep(&p, ":"));
+		set(&pwd.pw_shell, strsep(&p, "\n"));
+		p = line;
+		break;
+	}
+	fclose(fp);
+
+	/*
+	 *	If the encrypted password is valid
+	 *	or not found, return.
+	 */
+	if (p == NULL) {
+		fprintf(stderr, "%s: no entry for root\n", F_PASSWD);
+		return &pwd;
+	}
+	if (valid(pwd.pw_passwd)) return &pwd;
+
+	/*
+	 *	The password is invalid. If there is a
+	 *	shadow password, try it.
+	 */
+	strcpy(pwd.pw_passwd, "");
+	if ((fp = fopen(F_SHADOW, "r")) == NULL) {
+		fprintf(stderr, "%s: root password garbled\n", F_PASSWD);
+		return &pwd;
+	}
+	while((p = fgets(sline, 256, fp)) != NULL) {
+		if (strncmp(sline, "root:", 5) != 0)
+			continue;
+		p += 5;
+		set(&pwd.pw_passwd, strsep(&p, ":"));
+		break;
+	}
+	fclose(fp);
+
+	/*
+	 *	If the password is still invalid,
+	 *	NULL it, and return.
+	 */
+	if (p == NULL) {
+		fprintf(stderr, "%s: no entry for root\n", F_SHADOW);
+		strcpy(pwd.pw_passwd, "");
+	}
+	if (!valid(pwd.pw_passwd)) {
+		fprintf(stderr, "%s: root password garbled\n", F_SHADOW);
+		strcpy(pwd.pw_passwd, ""); }
+	return &pwd;
+}
+
+/*
+ *	Ask for the password. Note that there is no
+ *	default timeout as we normally skip this during boot.
+ */
+static
+char *getpasswd(char *crypted)
+{
+	struct sigaction sa;
+	struct termios old, tty;
+	static char pass[128];
+	char *ret = pass;
+	int i;
+#if defined(USE_ONELINE)
+	if (crypted[0])
+		printf("Give root password for login: ");
+	else
+		printf("Press enter for login: ");
+#else
+	if (crypted[0])
+		printf("Give root password for maintenance\n");
+	else
+		printf("Press enter for maintenance");
+	printf("(or type Control-D to continue): ");
+#endif
+	fflush(stdout);
+
+	tcgetattr(0, &old);
+	tcgetattr(0, &tty);
+	tty.c_iflag &= ~(IUCLC|IXON|IXOFF|IXANY);
+	tty.c_lflag &= ~(ECHO|ECHOE|ECHOK|ECHONL|TOSTOP);
+	tcsetattr(0, TCSANOW, &tty);
+
+	pass[sizeof(pass) - 1] = 0;
+
+	sa.sa_handler = alrm_handler;
+	sa.sa_flags = 0;
+	sigaction(SIGALRM, &sa, NULL);
+	if (timeout) alarm(timeout);
+
+	if (read(0, pass, sizeof(pass) - 1) <= 0)
+		ret = NULL;
+	else {
+		for(i = 0; i < (int)sizeof(pass) && pass[i]; i++)
+			if (pass[i] == '\r' || pass[i] == '\n') {
+				pass[i] = 0;
+				break;
+			}
+	}
+	alarm(0);
+	tcsetattr(0, TCSANOW, &old);
+	printf("\n");
+
+	return ret;
+}
+
+/*
+ *	Password was OK, execute a shell.
+ */
+static
+void sushell(struct passwd *pwd)
+{
+	char shell[128];
+	char home[128];
+	char *p;
+	char *sushell;
+
+	/*
+	 *	Set directory and shell.
+	 */
+	(void)chdir(pwd->pw_dir);
+	if ((p = getenv("SUSHELL")) != NULL)
+		sushell = p;
+	else if ((p = getenv("sushell")) != NULL)
+		sushell = p;
+	else {
+		if (pwd->pw_shell[0])
+			sushell = pwd->pw_shell;
+		else
+			sushell = BINSH;
+	}
+	if ((p = strrchr(sushell, '/')) == NULL)
+		p = sushell;
+	else
+		p++;
+	snprintf(shell, sizeof(shell), profile ? "-%s" : "%s", p);
+
+	/*
+	 *	Set some important environment variables.
+	 */
+	getcwd(home, sizeof(home));
+	setenv("HOME", home, 1);
+	setenv("LOGNAME", "root", 1);
+	setenv("USER", "root", 1);
+	if (!profile)
+		setenv("SHLVL","0",1);
+
+	/*
+	 *	Try to execute a shell.
+	 */
+	setenv("SHELL", sushell, 1);
+	signal(SIGINT,  saved_sigint);
+	signal(SIGTSTP, saved_sigtstp);
+	signal(SIGQUIT, saved_sigquit);
+#ifdef WITH_SELINUX
+	if (is_selinux_enabled() > 0) {
+	  security_context_t scon=NULL;
+	  char *seuser=NULL;
+	  char *level=NULL;
+	  if (getseuserbyname("root", &seuser, &level) == 0)
+		  if (get_default_context_with_level(seuser, level, 0, &scon) == 0) {
+			  if (setexeccon(scon) != 0) 
+				  fprintf(stderr, "setexeccon faile\n");
+			  freecon(scon);
+		  }
+		free(seuser);
+		free(level);
+	}
+#endif
+	execl(sushell, shell, NULL);
+	perror(sushell);
+
+	setenv("SHELL", BINSH, 1);
+	execl(BINSH, profile ? "-sh" : "sh", NULL);
+	perror(BINSH);
+
+	/* Fall back to staticly linked shell if both the users shell
+	   and /bin/sh failed to execute. */
+	setenv("SHELL", STATICSH, 1);
+	execl(STATICSH, STATICSH, NULL);
+	perror(STATICSH);
+}
+
+static
+void usage(void)
+{
+	fprintf(stderr, "Usage: sulogin [-e] [-p] [-t timeout] [tty device]\n");
+}
+
+int main(int argc, char **argv)
+{
+	char *tty = NULL;
+	char *p;
+	struct passwd *pwd;
+	int c, fd = -1;
+	int opt_e = 0;
+	pid_t pid, pgrp, ppgrp, ttypgrp;
+
+	/*
+	 *	See if we have a timeout flag.
+	 */
+	opterr = 0;
+	while((c = getopt(argc, argv, "ept:")) != EOF) switch(c) {
+		case 't':
+			timeout = atoi(optarg);
+			break;
+		case 'p':
+			profile = 1;
+			break;
+		case 'e':
+			opt_e = 1;
+			break;
+		default:
+			usage();
+			/* Do not exit! */
+			break;
+	}
+
+	if (geteuid() != 0) {
+		fprintf(stderr, "sulogin: only root can run sulogin.\n");
+		exit(1);
+	}
+
+	/*
+	 *	See if we need to open an other tty device.
+	 */
+	saved_sigint  = signal(SIGINT,  SIG_IGN);
+	saved_sigtstp = signal(SIGQUIT, SIG_IGN);
+	saved_sigquit = signal(SIGTSTP, SIG_IGN);
+	if (optind < argc) tty = argv[optind];
+
+	if (tty || (tty = getenv("CONSOLE"))) {
+
+		if ((fd = open(tty, O_RDWR)) < 0) {
+			perror(tty);
+			fd = dup(0);
+		}
+
+		if (!isatty(fd)) {
+			fprintf(stderr, "%s: not a tty\n", tty);
+			close(fd);
+		} else {
+
+			/*
+			 *	Only go through this trouble if the new
+			 *	tty doesn't fall in this process group.
+			 */
+			pid = getpid();
+			pgrp = getpgid(0);
+			ppgrp = getpgid(getppid());
+			ttypgrp = tcgetpgrp(fd);
+
+			if (pgrp != ttypgrp && ppgrp != ttypgrp) {
+				if (pid != getsid(0)) {
+					if (pid == getpgid(0))
+						setpgid(0, getpgid(getppid()));
+					setsid();
+				}
+
+				signal(SIGHUP, SIG_IGN);
+				if (ttypgrp > 0)
+					ioctl(0, TIOCNOTTY, (char *)1);
+				signal(SIGHUP, SIG_DFL);
+				close(0);
+				close(1);
+				close(2);
+				if (fd > 2)
+					close(fd);
+				if ((fd = open(tty, O_RDWR|O_NOCTTY)) < 0) {
+					perror(tty);
+				} else {
+					ioctl(0, TIOCSCTTY, (char *)1);
+					tcsetpgrp(fd, ppgrp);
+					dup2(fd, 0);
+					dup2(fd, 1);
+					dup2(fd, 2);
+					if (fd > 2)
+						close(fd);
+				}
+			} else
+				if (fd > 2)
+					close(fd);
+		}
+	} else if (getpid() == 1) {
+		/* We are init. We hence need to set a session anyway */
+		setsid();
+		if (ioctl(0, TIOCSCTTY, (char *)1))
+			perror("ioctl(TIOCSCTTY)");
+	}
+
+#if defined(SANE_TIO) && (SANE_TIO == 1)
+	fixtty();
+#endif
+
+	/*
+	 *	Get the root password.
+	 */
+	if ((pwd = getrootpwent(opt_e)) == NULL) {
+		fprintf(stderr, "sulogin: cannot open password database!\n");
+		sleep(2);
+	}
+
+	/*
+	 *	Ask for the password.
+	 */
+	while(pwd) {
+		if ((p = getpasswd(pwd->pw_passwd)) == NULL) break;
+		if (pwd->pw_passwd[0] == 0 ||
+		    strcmp(crypt(p, pwd->pw_passwd), pwd->pw_passwd) == 0)
+			sushell(pwd);
+		saved_sigquit = signal(SIGQUIT, SIG_IGN);
+		saved_sigtstp = signal(SIGTSTP, SIG_IGN);
+		saved_sigint  = signal(SIGINT,  SIG_IGN);
+		printf("Login incorrect.\n");
+	}
+
+	/*
+	 *	User pressed Control-D.
+	 */
+	return 0;
+}
-- 
1.7.9.2

