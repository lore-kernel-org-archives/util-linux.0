Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:47033 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932611Ab2JLOIB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 12 Oct 2012 10:08:01 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 1AD4EA329D
	for <util-linux@vger.kernel.org>; Fri, 12 Oct 2012 16:08:00 +0200 (CEST)
Date: Fri, 12 Oct 2012 16:07:57 +0200
From: "Dr. Werner Fink" <werner@suse.de>
To: util-linux@vger.kernel.org
Subject: Re: [util-linux] [PATCH 00/13] Initial import of sulogin
Message-ID: <20121012140757.GA10101@boole.suse.de>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
 <20120228164840.GH21406@rampage>
 <20121012125309.GA20273@boole.suse.de>
 <20121012132336.GC23945@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
In-Reply-To: <20121012132336.GC23945@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

On Fri, Oct 12, 2012 at 03:23:36PM +0200, Karel Zak wrote:
> On Fri, Oct 12, 2012 at 02:53:09PM +0200, Dr. Werner Fink wrote:
> > On Tue, Feb 28, 2012 at 11:48:40AM -0500, Dave Reisner wrote:
> > > On Tue, Feb 28, 2012 at 11:45:08AM -0500, Dave Reisner wrote:
> > > > This is an initial stab at importing sulogin from sysvinit and making it a bit
> > > > more universal. I've removed the distro specific code and brought the rest of
> > > > it more in line with the style of the remainder of the repo. I've also added
> > > > internationalization and cleaned up the manpage.
> > > 
> > > Err, forgot... these patches live in a repo below on the 'sulogin'
> > > branch:
> > 
> > Question: Why the code for multi console support was not included?
> 
>  Time... (the patch is one huge rewrite, I'd like to split it to more
>  patches). I'm busy with some others things, so next week.

Yep, this missing feature is also known here ;)
Maybe the attached patch help as it only adds the /proc/consoles and
/sys/class/tty/ scanner into common lib and leave sulogin untouched.

The integration into sulogin.c could then be done later

   Werner

-- 
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr

--ikeVEW9yuYc//A+q
Content-Type: text/x-patch; charset=iso-8859-1
Content-Disposition: attachment; filename="util-linux-consoles.patch"

>From 308abe7d8d567adb22b48d242bcffe3d6e16aa68 Mon Sep 17 00:00:00 2001
From: Werner Fink <werner@suse.de>
Date: Fri, 12 Oct 2012 14:35:22 +0200
Subject: [PATCH] Add code to detect all system consoles

Signed-off-by: Werner Fink <werner@suse.de>
---
 include/Makemodule.am |    1 +
 include/consoles.h    |   48 +++++
 lib/Makemodule.am     |    1 +
 lib/consoles.c        |  507 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 557 insertions(+), 0 deletions(-)
 create mode 100644 include/consoles.h
 create mode 100644 lib/consoles.c

diff --git a/include/Makemodule.am b/include/Makemodule.am
index 9f9b78e..8905237 100644
--- a/include/Makemodule.am
+++ b/include/Makemodule.am
@@ -8,6 +8,7 @@ dist_noinst_HEADERS += \
 	include/canonicalize.h \
 	include/carefulputc.h \
 	include/closestream.h \
+	include/consoles.h \
 	include/cpuset.h \
 	include/crc32.h \
 	include/env.h \
diff --git a/include/consoles.h b/include/consoles.h
new file mode 100644
index 0000000..c669eb2
--- /dev/null
+++ b/include/consoles.h
@@ -0,0 +1,48 @@
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
+	pid_t pid;
+	struct chardata cp;
+	struct termios tio;
+	struct console *next;
+};
+extern struct console *consoles;
+extern int detect_consoles(const char *, int);
diff --git a/lib/Makemodule.am b/lib/Makemodule.am
index 33a3eb8..e51bd27 100644
--- a/lib/Makemodule.am
+++ b/lib/Makemodule.am
@@ -27,6 +27,7 @@ libcommon_la_SOURCES = \
 
 if LINUX
 libcommon_la_SOURCES += \
+	lib/consoles.c
 	lib/linux_version.c \
 	lib/loopdev.c
 endif
diff --git a/lib/consoles.c b/lib/consoles.c
new file mode 100644
index 0000000..7b3be9b
--- /dev/null
+++ b/lib/consoles.c
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
-- 
1.7.7


--ikeVEW9yuYc//A+q--
