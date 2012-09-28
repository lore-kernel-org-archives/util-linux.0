Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:33621 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757302Ab2I1Mre (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 28 Sep 2012 08:47:34 -0400
Date: Fri, 28 Sep 2012 14:47:32 +0200
From: Philipp Thomas <pth@suse.de>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Werner Fink <werner@suse.de>
Subject: Re: Merge of sulogin in 2.22
Message-ID: <20120928124732.GB12510@paradies.suse.de>
References: <20120927143458.GB31742@paradies.suse.de>
 <20120927231811.GB9064@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rS8CxjVDS/+yyDmU"
In-Reply-To: <20120927231811.GB9064@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Karel,
* Karel Zak (kzak@redhat.com) [20120928 01:18]:

>  Sure, send the patch. Thanks!

Alas, I tried to adapt the patch but as I'm not familiar with the code and
you've done quite a few changes to it, would you be able to help me with the
patch? Attached is the working part that adds the new files consoles.[c,h]
plus that part of the original patch that would add the needed feature but
doesn't apply.

Thanks in advance
Philipp

--rS8CxjVDS/+yyDmU
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="util-linux-multiple_consoles_support.patch"

Index: login-utils/consoles.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ login-utils/consoles.c	2012-09-28 14:41:29.773529762 +0200
@@ -0,0 +1,507 @@
+/*
+ * consoles.c	    Routines to detect the system consoles
+ *
+ * Copyright (c) 2011 SuSE LINUX Products GmbH, All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program (see the file COPYING); if not, write to the
+ * Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ *
+ * Author: Werner Fink <werner@suse.de>
+ */
+
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#ifdef __linux__
+#  include <sys/vt.h>
+#  include <sys/kd.h>
+#  include <linux/serial.h>
+#endif
+#include <fcntl.h>
+#include <dirent.h>
+#include <unistd.h>
+#include "consoles.h"
+
+#ifdef __linux__
+# include <linux/major.h>
+#endif
+
+#if !defined(__STDC_VERSION__) || (__STDC_VERSION__ < 199901L)
+# ifndef  typeof
+#  define typeof		__typeof__
+# endif
+# ifndef  restrict
+#  define restrict		__restrict__
+# endif
+#endif
+
+#define alignof(type)		((sizeof(type)+(sizeof(void*)-1)) & ~(sizeof(void*)-1))
+
+struct console *consoles;
+
+/*
+ * Read and allocate one line from file,
+ * the caller has to free the result
+ */
+static
+#ifdef __GNUC__
+__attribute__((__nonnull__))
+#endif
+char *oneline(const char *file)
+{
+	FILE *fp;
+	char *ret = (char*)0, *nl;
+	size_t len = 0;
+
+	if ((fp = fopen(file, "re")) == (FILE*)0)
+		goto err;
+	if (getline(&ret, &len, fp) < 0)
+		goto out;
+	if (len)
+		ret[len-1] = '\0';
+	if ((nl = strchr(ret, '\n')))
+		*nl = '\0';
+out:
+	fclose(fp);
+err:
+	return ret;
+}
+
+#ifdef __linux__
+/*
+ *  Read and determine active attribute for tty below
+ *  /sys/class/tty, the caller has to free the result.
+ */
+static
+__attribute__((__malloc__))
+char *actattr(const char *tty)
+{
+	char *ret = (char*)0;
+	char *path;
+
+	if (!tty || *tty == '\0')
+		goto err;
+
+	if (asprintf(&path, "/sys/class/tty/%s/active", tty) < 0)
+		goto err;
+
+	if ((ret = oneline(path)) == (char*)0)
+		goto out;
+out:
+	free(path);
+err:
+	return ret;
+}
+
+/*
+ * Read and determine device attribute for tty below
+ * /sys/class/tty.
+ */
+static
+dev_t devattr(const char *tty)
+{
+	unsigned int maj, min;
+	dev_t dev = 0;
+	char *path, *value;
+
+	if (!tty || *tty == '\0')
+		goto err;
+
+	if (asprintf(&path, "/sys/class/tty/%s/dev", tty) < 0)
+		goto err;
+
+	if ((value = oneline(path)) == (char*)0)
+		goto out;
+
+	if (sscanf(value, "%u:%u", &maj, &min) == 2)
+		dev = makedev(maj, min);
+	free(value);
+out:
+	free(path);
+err:
+	return dev;
+}
+#endif /* __linux__ */
+
+/*
+ * Search below /dev for the characer device in
+ * the local `dev_t comparedev' variable.
+ */
+static dev_t comparedev;
+static
+#ifdef __GNUC__
+__attribute__((__nonnull__,__malloc__,__hot__))
+#endif
+char* scandev(DIR *dir)
+{
+	char *name = (char*)0;
+	struct dirent *dent;
+	int fd;
+
+	fd = dirfd(dir);
+	rewinddir(dir);
+	while ((dent = readdir(dir))) {
+		char path[PATH_MAX];
+		struct stat st;
+		if (fstatat(fd, dent->d_name, &st, 0) < 0)
+			continue;
+		if (!S_ISCHR(st.st_mode))
+			continue;
+		if (comparedev != st.st_rdev)
+			continue;
+		if ((size_t)snprintf(path, sizeof(path), "/dev/%s", dent->d_name) >= sizeof(path))
+			continue;
+		name = realpath(path, NULL);
+		break;
+	}
+	return name;
+}
+
+/*
+ * Default control characters for an unknown terminal line.
+ */
+static
+struct chardata initcp = {
+	CERASE,
+	CKILL,
+	CTRL('r'),
+	0
+};
+
+/*
+ * Allocate an aligned `struct console' memory area,
+ * initialize its default values, and append it to
+ * the global linked list.
+ */
+
+static int concount;		/* Counter for console IDs */
+
+static
+#ifdef __GNUC__
+__attribute__((__nonnull__,__hot__))
+#endif
+void consalloc(char * name)
+{
+	struct console *restrict tail;
+
+	if (posix_memalign((void*)&tail, sizeof(void*), alignof(typeof(struct console))) != 0)
+		perror("memory allocation");
+
+	tail->next = (struct console*)0;
+	tail->tty = name;
+
+	tail->file = (FILE*)0;
+	tail->flags = 0;
+	tail->fd = -1;
+	tail->id = concount++;
+	tail->pid = 0;
+	memset(&tail->tio, 0, sizeof(tail->tio));
+	memcpy(&tail->cp, &initcp, sizeof(struct chardata));
+
+	if (!consoles)
+		consoles = tail;
+	else
+		consoles->next = tail;
+}
+
+/*
+ * Try to detect the real device(s) used for the system console
+ * /dev/console if but only if /dev/console is used.  On Linux
+ * this can be more than one device, e.g. a serial line as well
+ * as a virtual console as well as a simple printer.
+ *
+ * Returns 1 if stdout and stderr should be reconnected and 0
+ * otherwise.
+ */
+int detect_consoles(const char *device, int fallback)
+{
+	int fd, ret = 0;
+#ifdef __linux__
+	char *attrib, *cmdline;
+	FILE *fc;
+#endif
+	if (!device || *device == '\0')
+		fd = dup(fallback);
+	else {
+		fd = open(device, O_RDWR|O_NONBLOCK|O_NOCTTY|O_CLOEXEC);
+		ret = 1;
+	}
+
+	if (fd >= 0) {
+		DIR *dir;
+		char *name;
+		struct stat st;
+#ifdef TIOCGDEV
+		unsigned int devnum;
+#endif
+
+		if (fstat(fd, &st) < 0) {
+			close(fd);
+			goto fallback;
+		}
+		comparedev = st.st_rdev;
+
+		if (ret && (fstat(fallback, &st) < 0 || comparedev != st.st_rdev))
+			dup2(fd, fallback);
+#ifdef __linux__
+		/*
+		 * Check if the device detection for Linux system console should be used.
+		 */
+		if (comparedev == makedev(TTYAUX_MAJOR, 0)) {	/* /dev/tty	*/
+			close(fd);
+			device = "/dev/tty";
+			goto fallback;
+		}
+		if (comparedev == makedev(TTYAUX_MAJOR, 1)) {	/* /dev/console */
+			close(fd);
+			goto console;
+		}
+		if (comparedev == makedev(TTYAUX_MAJOR, 2)) {	/* /dev/ptmx	*/
+			close(fd);
+			device = "/dev/tty";
+			goto fallback;
+		}
+		if (comparedev == makedev(TTY_MAJOR, 0)) {	/* /dev/tty0	*/
+			struct vt_stat vt;
+			if (ioctl(fd, VT_GETSTATE, &vt) < 0) {
+				close(fd);
+				goto fallback;
+			}
+			comparedev = makedev(TTY_MAJOR, (int)vt.v_active);
+		}
+#endif
+#ifdef TIOCGDEV
+		if (ioctl (fd, TIOCGDEV, &devnum) < 0) {
+			close(fd);
+			goto fallback;
+		}
+		comparedev = (dev_t)devnum;
+#endif
+		close(fd);
+		dir = opendir("/dev");
+		if (!dir)
+			goto fallback;
+		name = scandev(dir);
+		if (name)
+			consalloc(name);
+		closedir(dir);
+		if (!consoles)
+			goto fallback;
+		return ret;
+	}
+#ifdef __linux__
+console:
+	/*
+	 * Detection of devices used for Linux system consolei using
+	 * the /proc/consoles API with kernel 2.6.38 and higher.
+	 */
+	if ((fc = fopen("/proc/consoles", "re"))) {
+		char fbuf[16];
+		int maj, min;
+		DIR *dir;
+		dir = opendir("/dev");
+		if (!dir) {
+			fclose(fc);
+			goto fallback;
+		}
+		while ((fscanf(fc, "%*s %*s (%[^)]) %d:%d", &fbuf[0], &maj, &min) == 3)) {
+			char * name;
+
+			if (!strchr(fbuf, 'E'))
+				continue;
+			comparedev = makedev(maj, min);
+
+			name = scandev(dir);
+			if (!name)
+				continue;
+			consalloc(name);
+		}
+		closedir(dir);
+		fclose(fc);
+		return ret;
+	}
+	/*
+	 * Detection of devices used for Linux system console using
+	 * the sysfs /sys/class/tty/ API with kernel 2.6.37 and higher.
+	 */
+	if ((attrib = actattr("console"))) {
+		char *words = attrib, *token;
+		DIR *dir;
+
+		dir = opendir("/dev");
+		if (!dir) {
+			free(attrib);
+			goto fallback;
+		}
+		while ((token = strsep(&words, " \t\r\n"))) {
+			char * name;
+
+			if (*token == '\0')
+				continue;
+			comparedev = devattr(token);
+			if (comparedev == makedev(TTY_MAJOR, 0)) {
+				char *tmp = actattr(token);
+				if (!tmp)
+					continue;
+				comparedev = devattr(tmp);
+				free(tmp);
+			}
+
+			name = scandev(dir);
+			if (!name)
+				continue;
+			consalloc(name);
+		}
+		closedir(dir);
+		free(attrib);
+		if (!consoles)
+			goto fallback;
+		return ret;
+
+	}
+	/*
+	 * Detection of devices used for Linux system console using
+	 * kernel parameter on the kernels command line.
+	 */
+	if ((cmdline = oneline("/proc/cmdline"))) {
+		char *words= cmdline, *token;
+		DIR *dir;
+
+		dir = opendir("/dev");
+		if (!dir) {
+			free(cmdline);
+			goto fallback;
+		}
+		while ((token = strsep(&words, " \t\r\n"))) {
+#ifdef TIOCGDEV
+			unsigned int devnum;
+#else
+			struct vt_stat vt;
+			struct stat st;
+#endif
+			char *colon, *name;
+
+			if (*token != 'c')
+				continue;
+
+			if (strncmp(token, "console=", 8) != 0)
+				continue;
+			token += 8;
+
+			if (strcmp(token, "brl") == 0)
+				token += 4;
+			if ((colon = strchr(token, ',')))
+				*colon = '\0';
+
+			if (asprintf(&name, "/dev/%s", token) < 0)
+				continue;
+
+			if ((fd = open(name, O_RDWR|O_NONBLOCK|O_NOCTTY|O_CLOEXEC)) < 0) {
+				free(name);
+				continue;
+			}
+			free(name);
+#ifdef TIOCGDEV
+			if (ioctl (fd, TIOCGDEV, &devnum) < 0) {
+				close(fd);
+				continue;
+			}
+			comparedev = (dev_t)devnum;
+#else
+			if (fstat(fd, &st) < 0) {
+				close(fd);
+				continue;
+			}
+			comparedev = st.st_rdev;
+			if (comparedev == makedev(TTY_MAJOR, 0)) {
+				if (ioctl(fd, VT_GETSTATE, &vt) < 0) {
+					close(fd);
+					continue;
+				}
+				comparedev = makedev(TTY_MAJOR, (int)vt.v_active);
+			}
+#endif
+			close(fd);
+
+			name = scandev(dir);
+			if (!name)
+				continue;
+			consalloc(name);
+		}
+		closedir(dir);
+		free(cmdline);
+		/*
+		 * Detection of the device used for Linux system console using
+		 * the ioctl TIOCGDEV if available (e.g. official 2.6.38).
+		 */
+		if (!consoles) {
+#ifdef TIOCGDEV
+			unsigned int devnum;
+			const char *name;
+
+			if (!device || *device == '\0')
+				fd = dup(fallback);
+			else	fd = open(device, O_RDWR|O_NONBLOCK|O_NOCTTY|O_CLOEXEC);
+
+			if (fd < 0)
+				goto fallback;
+
+			if (ioctl (fd, TIOCGDEV, &devnum) < 0) {
+				close(fd);
+				goto fallback;
+			}
+			comparedev = (dev_t)devnum;
+			close(fd);
+
+			if (device && *device != '\0')
+				name = device;
+			else	name = ttyname(fallback);
+
+			if (!name)
+				name = "/dev/tty1";
+
+			consalloc(strdup(name));
+			if (consoles) {
+				if (!device || *device == '\0')
+					consoles->fd = fallback;
+				return ret;
+			}
+#endif
+			goto fallback;
+		}
+		return ret;
+	}
+#endif /* __linux __ */
+fallback:
+	if (fallback >= 0) {
+		const char *name;
+
+		if (device && *device != '\0')
+			name = device;
+		else	name = ttyname(fallback);
+
+		if (!name)
+			name = "/dev/tty";
+
+		consalloc(strdup(name));
+		if (consoles)
+			consoles->fd = fallback;
+	}
+	return ret;
+}
Index: login-utils/consoles.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ login-utils/consoles.h	2012-09-28 14:41:29.773529762 +0200
@@ -0,0 +1,49 @@
+/*
+ * consoles.h	    Header file for routines to detect the system consoles
+ *
+ * Copyright (c) 2011 SuSE LINUX Products GmbH, All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program (see the file COPYING); if not, write to the
+ * Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ *
+ * Author: Werner Fink <werner@suse.de>
+ */
+
+#include <sys/types.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <termios.h>
+
+struct chardata {
+	uint8_t	erase;
+	uint8_t kill;
+	uint8_t eol;
+	uint8_t parity;
+};
+struct console {
+	char *tty;
+	FILE *file;
+	uint32_t flags;
+	int fd, id;
+#define	CON_SERIAL	0x0001
+#define	CON_NOTTY	0x0002
+#define	CON_EIGHTBIT	0x1000
+	pid_t pid;
+	struct chardata cp;
+	struct termios tio;
+	struct console *next;
+};
+extern struct console *consoles;
+extern int detect_consoles(const char *, int);
Index: login-utils/Makemodule.am
===================================================================
--- login-utils/Makemodule.am.orig	2012-08-29 19:40:17.140456784 +0200
+++ login-utils/Makemodule.am	2012-09-28 14:43:03.171293278 +0200
@@ -9,7 +9,7 @@ if BUILD_SULOGIN
 sbin_PROGRAMS += sulogin
 dist_man_MANS += login-utils/sulogin.8
 sulogin_SOURCES = \
-	login-utils/sulogin.c
+	login-utils/sulogin.c login-utils/consoles.c login-utils/consoles.h
 sulogin_LDADD = $(LDADD) libcommon.la
 if HAVE_LIBCRYPT
 sulogin_LDADD += -lcrypt

--rS8CxjVDS/+yyDmU
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="sysvinit-multiple-sulogin.patch"

--- src/sulogin.c
+++ src/sulogin.c	2011-07-26 14:01:55.543926269 +0200
@@ -28,8 +28,10 @@
  *
  */
 
+#include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/wait.h>
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
@@ -44,13 +46,34 @@
 #include <sys/ioctl.h>
 #if defined(__GLIBC__)
 #  include <crypt.h>
+#  define dovoid(f)		if ((f)){}
 #endif
+#ifdef __linux__
+#  include <sys/statfs.h>
+#  include <sys/mount.h>
+#  include <linux/fs.h>
+#  include <linux/magic.h>
+#  include <linux/major.h>
+#  ifndef TMPFS_MAGIC
+#    define TMPFS_MAGIC		0x01021994
+#  endif
+#  ifndef MNT_DETACH
+#    define MNT_DETACH		2
+#  endif
+#endif
+
+#define BS  CTRL('h')
+#define NL  CTRL('j')
+#define CR  CTRL('m')
 
 #ifdef WITH_SELINUX
 #  include <selinux/selinux.h>
 #  include <selinux/get_context_list.h>
 #endif
 
+#include "consoles.h"
+#define CONMAX		16
+
 #define CHECK_DES	1
 #define CHECK_MD5	1
 
@@ -63,102 +86,245 @@ char *Version = "@(#)sulogin 2.85-3 23-A
 
 static int timeout;
 static int profile;
+static volatile uint32_t openfd;		/* Remember higher file descriptors */
+static volatile uint32_t *usemask;
 
-static void (*saved_sigint)  = SIG_DFL;
-static void (*saved_sigtstp) = SIG_DFL;
-static void (*saved_sigquit) = SIG_DFL;
+static sighandler_t saved_sigint  = SIG_DFL;
+static sighandler_t saved_sigtstp = SIG_DFL;
+static sighandler_t saved_sigquit = SIG_DFL;
+static sighandler_t saved_sighup  = SIG_DFL;
 
 static volatile sig_atomic_t alarm_rised;
+static volatile sig_atomic_t sigchild;
 
 #ifndef IUCLC
 #  define IUCLC	0
 #endif
 
-#if defined(SANE_TIO) && (SANE_TIO == 1)
 /*
  *	Fix the tty modes and set reasonable defaults.
- *	(I'm not sure if this is needed under Linux, but..)
  */
 static
-void fixtty(void)
+void tcinit(struct console *con)
 {
-	struct termios tty;
-	int serial;
+	int serial, flags;
+	struct termios *tio = &con->tio;
+	int fd = con->fd;
 
-	/* Skip serial console */
-	if (ioctl (0, TIOCMGET, (char*)&serial) == 0)
-		goto out;
 	/* Expected error */
 	serial = errno = 0;
 
-	tcgetattr(0, &tty);
+	/* Get line attributes */
+	if (tcgetattr(fd, tio) < 0) {
+		con->flags |= CON_NOTTY;
+		return;
+	}
+
+	/* Handle serial lines here */
+	if (ioctl (fd, TIOCMGET, (char*)&serial) == 0) {
+		speed_t ispeed, ospeed;
+		struct winsize ws;
+
+		/* this is a modem line */
+		con->flags |= CON_SERIAL;
+
+		/* Flush input and output queues on modem lines */
+		(void) tcflush(fd, TCIOFLUSH);
+
+		ispeed = cfgetispeed(tio);
+		ospeed = cfgetospeed(tio);
+		
+		if (!ispeed) ispeed = TTYDEF_SPEED;
+		if (!ospeed) ospeed = TTYDEF_SPEED;
+
+		tio->c_iflag = tio->c_lflag = tio->c_oflag = 0;
+		tio->c_cflag = CREAD | CS8 | HUPCL | (tio->c_cflag & CLOCAL);
+
+		cfsetispeed(tio, ispeed);
+		cfsetospeed(tio, ospeed);
+
+		tio->c_line         = 0;
+		tio->c_cc[VTIME]    = 0;
+		tio->c_cc[VMIN]     = 1;
+
+		if (ioctl(fd, TIOCGWINSZ, &ws) == 0) {
+			int set = 0;
+			if (ws.ws_row == 0) {
+				ws.ws_row = 24;
+				set++;
+			}
+			if (ws.ws_col == 0) {
+				ws.ws_col = 80;
+				set++;
+			}
+			(void)ioctl(fd, TIOCSWINSZ, &ws);
+		}
 
-	/* Use defaults of <sys/ttydefaults.h> for base settings */
-	tty.c_iflag |= TTYDEF_IFLAG;
-	tty.c_oflag |= TTYDEF_OFLAG;
-	tty.c_lflag |= TTYDEF_LFLAG;
-	tty.c_cflag |= (TTYDEF_SPEED | TTYDEF_CFLAG);
+		goto setattr;
+	}
+#if defined(SANE_TIO) && (SANE_TIO == 1)
+	/*
+	 * Use defaults of <sys/ttydefaults.h> for base settings
+	 * of a local terminal line like a virtual console.
+	 */
+	tio->c_iflag |= TTYDEF_IFLAG;
+	tio->c_oflag |= TTYDEF_OFLAG;
+	tio->c_lflag |= TTYDEF_LFLAG;
+# ifdef CBAUD
+	tio->c_lflag &= ~CBAUD;
+# endif
+	tio->c_cflag |= (B38400 | TTYDEF_CFLAG);
 
 	/* Sane setting, allow eight bit characters, no carriage return delay
 	 * the same result as `stty sane cr0 pass8'
 	 */
-	tty.c_iflag |=  (BRKINT | ICRNL | IMAXBEL);
-	tty.c_iflag &= ~(IGNBRK | INLCR | IGNCR | IXOFF | IUCLC | IXANY | ISTRIP);
-	tty.c_oflag |=  (OPOST | ONLCR | NL0 | CR0 | TAB0 | BS0 | VT0 | FF0);
-	tty.c_oflag &= ~(OLCUC | OCRNL | ONOCR | ONLRET | OFILL | OFDEL |\
+	tio->c_iflag |=  (BRKINT | ICRNL | IMAXBEL);
+	tio->c_iflag &= ~(IGNBRK | INLCR | IGNCR | IXOFF | IUCLC | IXANY | INPCK | ISTRIP);
+	tio->c_oflag |=  (OPOST | ONLCR | NL0 | CR0 | TAB0 | BS0 | VT0 | FF0);
+	tio->c_oflag &= ~(OLCUC | OCRNL | ONOCR | ONLRET | OFILL | OFDEL |\
 			 NLDLY|CRDLY|TABDLY|BSDLY|VTDLY|FFDLY);
-	tty.c_lflag |=  (ISIG | ICANON | IEXTEN | ECHO|ECHOE|ECHOK|ECHOCTL|ECHOKE);
-	tty.c_lflag &= ~(ECHONL | NOFLSH | XCASE | TOSTOP | ECHOPRT);
-	tty.c_cflag |=  (CREAD | CS8 | B9600);
-	tty.c_cflag &= ~(PARENB);
+	tio->c_lflag |=  (ISIG | ICANON | IEXTEN | ECHO|ECHOE|ECHOK|ECHOKE);
+	tio->c_lflag &= ~(ECHONL|ECHOCTL|ECHOPRT | NOFLSH | XCASE | TOSTOP);
+	tio->c_cflag |=  (CREAD | CS8 | HUPCL);
+	tio->c_cflag &= ~(PARODD | PARENB);
 
-	/* VTIME and VMIN can overlap with VEOF and VEOL since they are
+	/*
+	 * VTIME and VMIN can overlap with VEOF and VEOL since they are
 	 * only used for non-canonical mode. We just set the at the
 	 * beginning, so nothing bad should happen.
 	 */
-	tty.c_cc[VTIME]    = 0;
-	tty.c_cc[VMIN]     = 1;
-	tty.c_cc[VINTR]    = CINTR;
-	tty.c_cc[VQUIT]    = CQUIT;
-	tty.c_cc[VERASE]   = CERASE; /* ASCII DEL (0177) */
-	tty.c_cc[VKILL]    = CKILL;
-	tty.c_cc[VEOF]     = CEOF;
-	tty.c_cc[VSWTC]    = _POSIX_VDISABLE;
-	tty.c_cc[VSTART]   = CSTART;
-	tty.c_cc[VSTOP]    = CSTOP;
-	tty.c_cc[VSUSP]    = CSUSP;
-	tty.c_cc[VEOL]     = _POSIX_VDISABLE;
-	tty.c_cc[VREPRINT] = CREPRINT;
-	tty.c_cc[VDISCARD] = CDISCARD;
-	tty.c_cc[VWERASE]  = CWERASE;
-	tty.c_cc[VLNEXT]   = CLNEXT;
-	tty.c_cc[VEOL2]    = _POSIX_VDISABLE;
-
-	tcsetattr(0, TCSANOW, &tty);
-out:
-	return;
+	tio->c_cc[VTIME]    = 0;
+	tio->c_cc[VMIN]     = CMIN;
+	tio->c_cc[VINTR]    = CINTR;
+	tio->c_cc[VQUIT]    = CQUIT;
+	tio->c_cc[VERASE]   = CERASE; /* ASCII DEL (0177) */
+	tio->c_cc[VKILL]    = CKILL;
+	tio->c_cc[VEOF]     = CEOF;
+# ifdef VSWTC
+	tio->c_cc[VSWTC]    = _POSIX_VDISABLE;
+# else
+	tio->c_cc[VSWTCH]   = _POSIX_VDISABLE;
+# endif
+	tio->c_cc[VSTART]   = CSTART;
+	tio->c_cc[VSTOP]    = CSTOP;
+	tio->c_cc[VSUSP]    = CSUSP;
+	tio->c_cc[VEOL]     = _POSIX_VDISABLE;
+	tio->c_cc[VREPRINT] = CREPRINT;
+	tio->c_cc[VDISCARD] = CDISCARD;
+	tio->c_cc[VWERASE]  = CWERASE;
+	tio->c_cc[VLNEXT]   = CLNEXT;
+	tio->c_cc[VEOL2]    = _POSIX_VDISABLE;
+#endif
+setattr:
+	/* Set line attributes */
+	tcsetattr(fd, TCSANOW, tio);
+
+	/* Enable blocking mode for read and write */
+	if ((flags = fcntl(fd, F_GETFL, 0)) != -1)
+		(void)fcntl(fd, F_SETFL, flags & ~O_NONBLOCK);
 }
+
+
+/*
+ *	Finalize the tty modes on modem lines.
+ */
+static
+void tcfinal(struct console *con)
+{
+	int serial;
+	struct termios *tio = &con->tio;
+	int fd = con->fd;
+
+	/* Expected error */
+	serial = errno = 0;
+
+	if ((con->flags & CON_SERIAL) == 0) {
+#ifdef __linux__
+		setenv("TERM", "linux", 1);
+#else
+		setenv("TERM", "vt100", 1);
 #endif
+		return;
+	}
+	if (con->flags & CON_NOTTY)
+		return;
+	setenv("TERM", "vt100", 1);
+
+	tio->c_iflag |= (IXON | IXOFF);
+	tio->c_lflag |= (ICANON | ISIG | ECHO|ECHOE|ECHOK|ECHOKE);
+	tio->c_oflag |= OPOST;
+
+	tio->c_cc[VINTR]    = CINTR;
+	tio->c_cc[VQUIT]    = CQUIT;
+	tio->c_cc[VERASE]   = con->cp.erase;
+	tio->c_cc[VKILL]    = con->cp.kill;
+	tio->c_cc[VEOF]     = CEOF;
+#ifdef VSWTC
+	tio->c_cc[VSWTC]    = _POSIX_VDISABLE;
+#else
+	tio->c_cc[VSWTCH]   = _POSIX_VDISABLE;
+#endif
+	tio->c_cc[VSTART]   = CSTART;
+	tio->c_cc[VSTOP]    = CSTOP;
+	tio->c_cc[VSUSP]    = CSUSP;
+	tio->c_cc[VEOL]     = _POSIX_VDISABLE;
+
+	if (con->cp.eol == CR) {
+		tio->c_iflag |= ICRNL;
+		tio->c_iflag &= ~(INLCR|IGNCR);
+		tio->c_oflag |= ONLCR;
+		tio->c_oflag &= ~(OCRNL|ONLRET);
+	}
+
+	switch (con->cp.parity) {
+	default:
+	case 0:
+		tio->c_cflag &= ~(PARODD | PARENB);
+		tio->c_iflag &= ~(INPCK | ISTRIP);
+		break;
+	case 1:				/* odd parity */
+		tio->c_cflag |= PARODD;
+		/* fall through */
+	case 2:				/* even parity */
+		tio->c_cflag |= PARENB;
+		tio->c_iflag |= (INPCK | ISTRIP);
+		/* fall through */
+	case (1 | 2):			/* no parity bit */
+		tio->c_cflag &= ~CSIZE;
+		tio->c_cflag |= CS7;
+		break;
+	}
 
+	/* Set line attributes */
+	(void)tcsetattr(fd, TCSANOW, tio);
+}
 
 /*
  *	Called at timeout.
  */
 static
 # ifdef __GNUC__
+__attribute__((__noinline__))
 void alrm_handler(int sig __attribute__((unused)))
 # else
 void alrm_handler(int sig)
 # endif
 {
-	/* Timeout expired */
 	alarm_rised++;
+}
 
-	signal(SIGINT,  saved_sigint);
-	signal(SIGTSTP, saved_sigtstp);
-	signal(SIGQUIT, saved_sigquit);
-
-	/* Never use exit(3) or stdio(3) within a signal handler */
+/*
+ *	Called at timeout.
+ */
+static
+# ifdef __GNUC__
+__attribute__((__noinline__))
+void chld_handler(int sig __attribute__((unused)))
+# else
+void chld_handler(int sig)
+# endif
+{
+	sigchild++;
 }
 
 /*
@@ -305,7 +471,7 @@ struct passwd *getrootpwent(int try_manu
 	 *	or not found, return.
 	 */
 	if (p == NULL) {
-		fprintf(stderr, "%s: no entry for root\n", F_PASSWD);
+		fprintf(stderr, "sulogin: %s: no entry for root\n\r", F_PASSWD);
 		return &pwd;
 	}
 	if (valid(pwd.pw_passwd)) return &pwd;
@@ -316,7 +482,7 @@ struct passwd *getrootpwent(int try_manu
 	 */
 	strcpy(pwd.pw_passwd, "");
 	if ((fp = fopen(F_SHADOW, "r")) == NULL) {
-		fprintf(stderr, "%s: root password garbled\n", F_PASSWD);
+		fprintf(stderr, "sulogin: %s: root password garbled\n\r", F_PASSWD);
 		return &pwd;
 	}
 	while((p = fgets(sline, 256, fp)) != NULL) {
@@ -333,67 +499,215 @@ struct passwd *getrootpwent(int try_manu
 	 *	NULL it, and return.
 	 */
 	if (p == NULL) {
-		fprintf(stderr, "%s: no entry for root\n", F_SHADOW);
+		fprintf(stderr, "sulogin: %s: no entry for root\n\r", F_SHADOW);
 		strcpy(pwd.pw_passwd, "");
 	}
 	if (!valid(pwd.pw_passwd)) {
-		fprintf(stderr, "%s: root password garbled\n", F_SHADOW);
+		fprintf(stderr, "sulogin: %s: root password garbled\n\r", F_SHADOW);
 		strcpy(pwd.pw_passwd, ""); }
 	return &pwd;
 }
 
 /*
- *	Ask for the password. Note that there is no
- *	default timeout as we normally skip this during boot.
+ *	Ask by prompt for the password.
  */
 static
-char *getpasswd(char *crypted)
+void doprompt(const char *crypted, struct console *con)
 {
-	struct sigaction sa;
-	struct termios old, tty;
-	static char pass[128];
-	char *ret = pass;
-	int i;
+	struct termios tty;
+
+	if (con->flags & CON_SERIAL) {
+		tty = con->tio;
+		/*
+		 * For prompting: map NL in output to CR-NL
+		 * otherwise we may see stairs in the output.
+		 */
+		tty.c_oflag |= (ONLCR | OPOST);
+		(void) tcsetattr(con->fd, TCSADRAIN, &tty);
+	}
+	if (con->file == (FILE*)0) {
+		if  ((con->file = fdopen(con->fd, "r+")) == (FILE*)0)
+			goto err;
+	}
 #if defined(USE_ONELINE)
 	if (crypted[0])
-		printf("Give root password for login: ");
+		fprintf(con->file, "Give root password for login: ");
 	else
-		printf("Press enter for login: ");
+		fprintf(con->file, "Press enter for login: ");
 #else
 	if (crypted[0])
-		printf("Give root password for maintenance\n");
+		fprintf(con->file, "Give root password for maintenance\n\r");
 	else
-		printf("Press enter for maintenance");
-	printf("(or type Control-D to continue): ");
+		fprintf(con->file, "Press enter for maintenance");
+	fprintf(con->file, "(or type Control-D to continue): ");
 #endif
-	fflush(stdout);
+	fflush(con->file);
+err:
+	if (con->flags & CON_SERIAL)
+		(void) tcsetattr(con->fd, TCSADRAIN, &con->tio);
+}
 
-	tcgetattr(0, &old);
-	tcgetattr(0, &tty);
-	tty.c_iflag &= ~(IUCLC|IXON|IXOFF|IXANY);
-	tty.c_lflag &= ~(ECHO|ECHOE|ECHOK|ECHONL|TOSTOP);
-	tcsetattr(0, TCSANOW, &tty);
+/*
+ * Make sure to have an own session and controlling terminal
+ */
+static
+void setup(struct console *con)
+{
+	pid_t pid, pgrp, ppgrp, ttypgrp;
+	int fd;
+
+	if (con->flags & CON_NOTTY)
+		return;
+	fd = con->fd;
+
+	/*
+	 *	Only go through this trouble if the new
+	 *	tty doesn't fall in this process group.
+	 */
+	pid = getpid();
+	pgrp = getpgid(0);
+	ppgrp = getpgid(getppid());
+	ttypgrp = tcgetpgrp(fd);
+
+	if (pgrp != ttypgrp && ppgrp != ttypgrp) {
+		if (pid != getsid(0)) {
+			if (pid == getpgid(0))
+				setpgid(0, getpgid(getppid()));
+			setsid();
+		}
 
-	pass[sizeof(pass) - 1] = 0;
+		signal(SIGHUP, SIG_IGN);
+		if (ttypgrp > 0)
+			ioctl(0, TIOCNOTTY, (char *)1);
+		signal(SIGHUP, saved_sighup);
+		if (fd > 0) close(0);
+		if (fd > 1) close(1);
+		if (fd > 2) close(2);
+
+		ioctl(fd, TIOCSCTTY, (char *)1);
+		tcsetpgrp(fd, ppgrp);
+	}
+	dup2(fd, 0);
+	dup2(fd, 1);
+	dup2(fd, 2);
+	con->fd = 0;
+
+	for (fd = 3; fd < 32; fd++) {
+		if (openfd & (1<<fd)) {
+			close(fd);
+			openfd &= ~(1<<fd);
+		}
+	}
+}
+
+/*
+ *	Fetch the password. Note that there is no
+ *	default timeout as we normally skip this during boot.
+ */
+static
+char *getpasswd(struct console *con)
+{
+	static char pass[128], *ptr;
+	struct sigaction sa;
+	struct chardata *cp;
+	struct termios tty;
+	char *ret = pass;
+	unsigned char tc;
+	char c, ascval;
+	int eightbit;
+	int fd;
+
+	if (con->flags & CON_NOTTY)
+		goto out;
+	fd = con->fd;
+	cp = &con->cp;
+
+	tty = con->tio;
+	tty.c_iflag &= ~(IUCLC|IXON|IXOFF|IXANY);
+	tty.c_lflag &= ~(ECHO|ECHOE|ECHOK|ECHONL|TOSTOP|ISIG);
+	tc = (tcsetattr(fd, TCSAFLUSH, &tty) == 0);
 
 	sa.sa_handler = alrm_handler;
 	sa.sa_flags = 0;
 	sigaction(SIGALRM, &sa, NULL);
 	if (timeout) alarm(timeout);
 
-	if (read(0, pass, sizeof(pass) - 1) <= 0)
-		ret = NULL;
-	else {
-		for(i = 0; i < (int)sizeof(pass) && pass[i]; i++)
-			if (pass[i] == '\r' || pass[i] == '\n') {
-				pass[i] = 0;
+	ptr = &pass[0];
+	cp->eol = *ptr = '\0';
+
+	eightbit = ((con->flags & CON_SERIAL) == 0 || (tty.c_cflag & (PARODD|PARENB)) == 0);
+	while (cp->eol == '\0') {
+		if (read(fd, &c, 1) < 1) {
+			if (errno == EINTR || errno == EAGAIN) {
+				usleep(1000);
+				continue;
+			}
+			ret = (char*)0;
+			switch (errno) {
+			case 0:
+			case EIO:
+			case ESRCH:
+			case EINVAL:
+			case ENOENT:
 				break;
+			default:
+				fprintf(stderr, "sulogin: read(%s): %m\n\r", con->tty);
+				break;
+			}
+			goto quit;
+		}
+
+		if (eightbit)
+			ascval = c;
+		else if (c != (ascval = (c & 0177))) {
+			uint32_t bits, mask;
+			for (bits = 1, mask = 1; mask & 0177; mask <<= 1) {
+				if (mask & ascval)
+					bits++;
+			}
+			cp->parity |= ((bits & 1) ? 1 : 2);
+		}
+
+		switch (ascval) {
+		case 0:
+			*ptr = '\0';
+			goto quit; 
+		case CR:
+		case NL:
+			*ptr = '\0';
+			cp->eol = ascval;
+			break;
+		case BS:
+		case CERASE:
+			cp->erase = ascval;
+			if (ptr > &pass[0])
+				ptr--;
+			break;
+		case CKILL:
+			cp->kill = ascval;
+			while (ptr > &pass[0])
+				ptr--;
+			break;
+		case CEOF:
+			goto quit;		
+		default:
+			if ((size_t)(ptr - &pass[0]) >= (sizeof(pass) -1 )) {
+				 fprintf(stderr, "sulogin: input overrun at %s\n\r", con->tty);
+				 ret = (char*)0;
+				 goto quit;
 			}
+			*ptr++ = ascval;
+			break;
+		}
 	}
+quit:
 	alarm(0);
-	tcsetattr(0, TCSANOW, &old);
-	printf("\n");
-
+	if (tc)
+		(void)tcsetattr(fd, TCSAFLUSH, &con->tio);
+	if (ret && *ret != '\0')
+		tcfinal(con);
+	printf("\r\n");
+out:
 	return ret;
 }
 
@@ -411,7 +725,10 @@ void sushell(struct passwd *pwd)
 	/*
 	 *	Set directory and shell.
 	 */
-	(void)chdir(pwd->pw_dir);
+	if (chdir(pwd->pw_dir) < 0) {
+		if (chdir("/") < 0)
+			fprintf(stderr, "sulogin: change of working directory failed: %m\n\r");
+	}
 	if ((p = getenv("SUSHELL")) != NULL)
 		sushell = p;
 	else if ((p = getenv("sushell")) != NULL)
@@ -431,7 +748,8 @@ void sushell(struct passwd *pwd)
 	/*
 	 *	Set some important environment variables.
 	 */
-	getcwd(home, sizeof(home));
+	if (getcwd(home, sizeof(home)) == (char*)0)
+		strcpy(home, "/");
 	setenv("HOME", home, 1);
 	setenv("LOGNAME", "root", 1);
 	setenv("USER", "root", 1);
@@ -445,17 +763,18 @@ void sushell(struct passwd *pwd)
 	signal(SIGINT,  saved_sigint);
 	signal(SIGTSTP, saved_sigtstp);
 	signal(SIGQUIT, saved_sigquit);
+	signal(SIGHUP,  SIG_DFL);
 #ifdef WITH_SELINUX
 	if (is_selinux_enabled() > 0) {
-	  security_context_t scon=NULL;
-	  char *seuser=NULL;
-	  char *level=NULL;
-	  if (getseuserbyname("root", &seuser, &level) == 0)
-		  if (get_default_context_with_level(seuser, level, 0, &scon) == 0) {
-			  if (setexeccon(scon) != 0) 
-				  fprintf(stderr, "setexeccon faile\n");
-			  freecon(scon);
-		  }
+		security_context_t scon=NULL;
+		char *seuser=NULL;
+		char *level=NULL;
+		if (getseuserbyname("root", &seuser, &level) == 0)
+			if (get_default_context_with_level(seuser, level, 0, &scon) == 0) {
+				if (setexeccon(scon) != 0) 
+					fprintf(stderr, "sulogin: setexeccon failed\n\r");
+				freecon(scon);
+			}
 		free(seuser);
 		free(level);
 	}
@@ -474,23 +793,72 @@ void sushell(struct passwd *pwd)
 	perror(STATICSH);
 }
 
+#ifdef __linux__
+/*
+ * Make C library standard calls like ttyname(3) work.
+ */
+static uint32_t mounts;
+#define MNT_PROCFS	0x0001
+#define MNT_DEVTMPFS	0x0002
+
+static __attribute__((__noinline__))
+void putmounts(void)
+{
+	if (mounts & MNT_DEVTMPFS)
+		umount2("/dev", MNT_DETACH);
+	if (mounts & MNT_PROCFS)
+		umount2("/proc", MNT_DETACH);
+}
+
+static __attribute__((__constructor__))
+void getmounts(void)
+{
+	struct statfs st;
+	if (statfs("/proc", &st) == 0 && st.f_type != PROC_SUPER_MAGIC) {
+		if (mount("proc", "/proc", "proc", MS_RELATIME, NULL) == 0)
+			mounts |= MNT_PROCFS;
+	}
+	if (statfs("/dev", &st) == 0 && st.f_type != TMPFS_MAGIC) {
+		if (mount("devtmpfs", "/dev", "devtmpfs", MS_RELATIME, "mode=0755,nr_inodes=0") == 0) {
+			mounts |= MNT_DEVTMPFS;
+			(void)mknod("/dev/console", S_IFCHR|S_IRUSR|S_IWUSR, makedev(TTYAUX_MAJOR, 1));
+			if (symlink("/proc/self/fd", "/dev/fd") == 0) {
+				dovoid(symlink("fd/0", "/dev/stdin"));
+				dovoid(symlink("fd/1", "/dev/stdout"));
+				dovoid(symlink("fd/2", "/dev/stderr"));
+			}
+		}
+	}
+	if (mounts) atexit(putmounts);
+}
+#endif
+
 static
 void usage(void)
 {
-	fprintf(stderr, "Usage: sulogin [-e] [-p] [-t timeout] [tty device]\n");
+	fprintf(stderr, "Usage: sulogin [-e] [-p] [-t timeout] [tty device]\n\r");
 }
 
 int main(int argc, char **argv)
 {
 	char *tty = NULL;
-	char *p;
 	struct passwd *pwd;
-	int c, fd = -1;
+	int c, status = 0;
+	int reconnect = 0;
 	int opt_e = 0;
-	pid_t pid, pgrp, ppgrp, ttypgrp;
+	struct console *con;
+	pid_t pid;
+
+	/*
+	 * We are init. We hence need to set uo a session.
+	 */
+	if ((pid = getpid()) == 1) {
+		setsid();
+		(void)ioctl(0, TIOCSCTTY, (char *)1);
+	}
 
 	/*
-	 *	See if we have a timeout flag.
+	 * See if we have a timeout flag.
 	 */
 	opterr = 0;
 	while((c = getopt(argc, argv, "ept:")) != EOF) switch(c) {
@@ -510,115 +878,151 @@ int main(int argc, char **argv)
 	}
 
 	if (geteuid() != 0) {
-		fprintf(stderr, "sulogin: only root can run sulogin.\n");
+		fprintf(stderr, "sulogin: only root can run sulogin.\n\r");
 		exit(1);
 	}
 
-	/*
-	 *	See if we need to open an other tty device.
-	 */
 	saved_sigint  = signal(SIGINT,  SIG_IGN);
 	saved_sigquit = signal(SIGQUIT, SIG_IGN);
 	saved_sigtstp = signal(SIGTSTP, SIG_IGN);
-	if (optind < argc) tty = argv[optind];
-
-	if (tty || (tty = getenv("CONSOLE"))) {
+	saved_sighup  = signal(SIGHUP,  SIG_IGN);
 
-		if ((fd = open(tty, O_RDWR)) < 0) {
-			perror(tty);
-			fd = dup(0);
-		}
-
-		if (!isatty(fd)) {
-			fprintf(stderr, "%s: not a tty\n", tty);
-			close(fd);
-		} else {
+	/*
+	 * See if we need to open an other tty device.
+	 */
+	if (optind < argc)
+		tty = argv[optind];
+	if (!tty || *tty == '\0') 
+		tty = getenv("CONSOLE");
 
-			/*
-			 *	Only go through this trouble if the new
-			 *	tty doesn't fall in this process group.
-			 */
-			pid = getpid();
-			pgrp = getpgid(0);
-			ppgrp = getpgid(getppid());
-			ttypgrp = tcgetpgrp(fd);
-
-			if (pgrp != ttypgrp && ppgrp != ttypgrp) {
-				if (pid != getsid(0)) {
-					if (pid == getpgid(0))
-						setpgid(0, getpgid(getppid()));
-					setsid();
-				}
+	/*
+	 * Detect possible consoles, use stdin as fallback.
+	 * If an optional tty is given, reconnect it to stdin.
+	 */
+	reconnect = detect_consoles(tty, 0);
 
-				signal(SIGHUP, SIG_IGN);
-				if (ttypgrp > 0)
-					ioctl(0, TIOCNOTTY, (char *)1);
-				signal(SIGHUP, SIG_DFL);
-				close(0);
-				close(1);
-				close(2);
-				if (fd > 2)
-					close(fd);
-				if ((fd = open(tty, O_RDWR|O_NOCTTY)) < 0) {
-					perror(tty);
-				} else {
-					ioctl(0, TIOCSCTTY, (char *)1);
-					tcsetpgrp(fd, ppgrp);
-					dup2(fd, 0);
-					dup2(fd, 1);
-					dup2(fd, 2);
-					if (fd > 2)
-						close(fd);
-				}
-			} else
-				if (fd > 2)
-					close(fd);
-		}
-	} else if (getpid() == 1) {
-		/* We are init. We hence need to set a session anyway */
-		setsid();
-		if (ioctl(0, TIOCSCTTY, (char *)1))
-			perror("ioctl(TIOCSCTTY)");
+	/*
+	 * Should not happen
+	 */
+	if (!consoles) {
+		if (!errno)
+			errno = ENOMEM;
+		fprintf(stderr, "sulogin: cannot open console: %m\n\r");
+		exit(1);
 	}
 
-#if defined(SANE_TIO) && (SANE_TIO == 1)
-	fixtty();
-#endif
+	/*
+	 * If previous stdin was not the speified tty and therefore reconnected
+	 * to the specified tty also reconnect stdout and stderr.
+	 */
+	if (reconnect) {
+		if (isatty(1) == 0)
+			dup2(0, 1);
+		if (isatty(2) == 0)
+			dup2(0, 2);
+	}
 
 	/*
 	 *	Get the root password.
 	 */
 	if ((pwd = getrootpwent(opt_e)) == NULL) {
-		fprintf(stderr, "sulogin: cannot open password database!\n");
+		fprintf(stderr, "sulogin: cannot open password database!\n\r");
 		sleep(2);
 	}
 
 	/*
-	 *	Ask for the password.
+	 * Prompt for input on the consoles
 	 */
-	while(pwd) {
-		int failed = 0;
-		if ((p = getpasswd(pwd->pw_passwd)) == NULL) break;
-		if (pwd->pw_passwd[0] == 0 ||
-		    strcmp(crypt(p, pwd->pw_passwd), pwd->pw_passwd) == 0) {
-			sushell(pwd);
-			failed++;
+	for (con = consoles; con && con->id < CONMAX; con = con->next) {
+		if (con->fd >= 0) {
+			openfd |= (1<<con->fd);
+			tcinit(con);
+			continue;
 		}
-		signal(SIGQUIT, SIG_IGN);
-		signal(SIGTSTP, SIG_IGN);
-		signal(SIGINT,  SIG_IGN);
-		if (failed) {
-			printf("Can not execute su shell.\n");
-			break;
-		} else
-			printf("Login incorrect.\n");
+		if ((con->fd = open(con->tty, O_RDWR | O_NOCTTY | O_NONBLOCK)) < 0)
+			continue;
+		openfd |= (1<<con->fd);
+		tcinit(con);
 	}
+	con = consoles;
+	usemask = (uint32_t*)mmap(NULL, sizeof(uint32_t), PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_SHARED, -1, 0);
 
-	if (alarm_rised)
-		printf("Timed out.\n");
+	if (con->next == (struct console*)0)
+		goto nofork;
+
+	signal(SIGCHLD, chld_handler);
+	do {
+		switch ((con->pid = fork())) {
+		case 0:
+			signal(SIGCHLD,  SIG_DFL);
+			/* fall through */
+		nofork:
+			setup(con);
+			while (1) {
+				char *passwd = pwd->pw_passwd;
+				char *answer;
+				int failed = 0;
+
+				doprompt(passwd, con);
+				if ((answer = getpasswd(con)) == NULL)
+					break;
+
+				if (passwd[0] == '\0' ||
+				    strcmp(crypt(answer, passwd), passwd) == 0) {
+					*usemask |= (1<<con->id);
+					sushell(pwd);
+					*usemask &= ~(1<<con->id);
+					failed++;
+				}
+				signal(SIGQUIT, SIG_IGN);
+				signal(SIGTSTP, SIG_IGN);
+				signal(SIGINT,  SIG_IGN);
+
+				if (failed) {
+					fprintf(stderr, "sulogin: can not execute su shell.\n\r");
+					break;
+				}
+				fprintf(stderr, "Login incorrect.\n\r");
+				sleep(3);
+			}
+			if (alarm_rised) {
+				tcfinal(con);
+				printf("Timed out.\n\r");
+			}
+			/*
+			 *	User may pressed Control-D.
+			 */
+			exit(0);
+		case -1:
+			fprintf(stderr, "sulogin: can not fork: %m\n\r");
+			/* fall through */
+		default:
+			break;
+		}
+	} while ((con = con->next) && (con->id < CONMAX));
+
+	while ((pid = wait(&status))) {
+		if (errno == ECHILD)
+			break;
+		if (pid < 0)
+			continue;
+		for (con = consoles; con && con->id < CONMAX; con = con->next) {
+			if (con->pid == pid) {
+				*usemask &= ~(1<<con->id);
+				continue;
+			}
+			if (kill(con->pid, 0) < 0) {
+				*usemask &= ~(1<<con->id);
+				continue;
+			}
+			if (*usemask & (1<<con->id))
+				continue;
+			kill(con->pid, SIGHUP);
+			usleep(5000);
+			kill(con->pid, SIGKILL);
+		}
+	}
+	signal(SIGCHLD,  SIG_DFL);
 
-	/*
-	 *	User may pressed Control-D.
-	 */
 	return 0;
 }

--rS8CxjVDS/+yyDmU--
