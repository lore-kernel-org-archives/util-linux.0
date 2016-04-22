Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:45348 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752783AbcDVLWE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 22 Apr 2016 07:22:04 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id F17A5ABE0
	for <util-linux@vger.kernel.org>; Fri, 22 Apr 2016 11:22:00 +0000 (UTC)
From: Werner Fink <werner@suse.de>
To: util-linux@vger.kernel.org
Cc: Werner Fink <werner@suse.de>
Subject: [PATCH] Use the plymouth local protocol instead the plymouth binary
Date: Fri, 22 Apr 2016 13:21:36 +0200
Message-Id: <1461324096-29280-1-git-send-email-werner@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

for stopping plymouthd.  That do not depend on the existence of
the plymouth binary if it e.g. becomes uninstalled or an other
service is providing plymouthd facilities.

Signed-off-by: Werner Fink <werner@suse.de>
---
 include/plymouth-ctrl.h |  64 ++++++++++++++++++++++
 lib/Makemodule.am       |   1 +
 lib/plymouth-ctrl.c     | 140 ++++++++++++++++++++++++++++++++++++++++++++++++
 login-utils/sulogin.c   |  44 ++-------------
 term-utils/agetty.c     |  48 +++--------------
 5 files changed, 215 insertions(+), 82 deletions(-)
 create mode 100644 include/plymouth-ctrl.h
 create mode 100644 lib/plymouth-ctrl.c

diff --git include/plymouth-ctrl.h include/plymouth-ctrl.h
new file mode 100644
index 0000000..27c5ebc
--- /dev/null
+++ include/plymouth-ctrl.h
@@ -0,0 +1,64 @@
+/*
+ * plymouth-ctrl.h	Header file for communcations with plymouthd
+ *
+ * Copyright (c) 2016 SUSE Linux GmbH, All rights reserved.
+ * Copyright (c) 2016 Werner Fink <werner@suse.de>
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
+/*
+ * Taken from plymouth 0.9.0 src/ply-boot-protocol.h
+ */
+
+#ifndef UTIL_LINUX_PLYMOUTH_CTRL_H
+#define UTIL_LINUX_PLYMOUTH_CTRL_H
+
+#define PLYMOUTH_SOCKET_PATH	"\0/org/freedesktop/plymouthd"
+#define ANSWER_TYP		'\x2'
+#define ANSWER_ENQ		'\x5'
+#define ANSWER_ACK		'\x6'
+#define ANSWER_MLT		'\t'
+#define ANSWER_NCK		'\x15'
+
+#define MAGIC_PRG_STOP		'A'
+#define MAGIC_PRG_CONT		'a'
+#define MAGIC_UPDATE		'U'
+#define MAGIC_SYS_UPDATE	'u'
+#define MAGIC_SYS_INIT		'S'
+#define MAGIC_DEACTIVATE	'D'
+#define MAGIC_REACTIVATE	'r'
+#define MAGIC_SHOW_SPLASH	'$'
+#define MAGIC_HIDE_SPLASH	'H'
+#define MAGIC_CHMOD		'C'
+#define MAGIC_CHROOT		'R'
+#define MAGIC_ACTIVE_VT		'V'
+#define MAGIC_QUESTION		'W'
+#define MAGIC_SHOW_MSG		'M'
+#define MAGIC_HIDE_MSG		'm'
+#define MAGIC_KEYSTROKE		'K'
+#define MAGIC_KEYSTROKE_RM	'L'
+#define MAGIC_PING		'P'
+#define MAGIC_QUIT		'Q'
+#define MAGIC_CACHED_PWD	'c'
+#define MAGIC_ASK_PWD		'*'
+#define MAGIC_DETAILS		'!'
+
+extern int plymouth_command(int cmd, ...);
+
+#endif /* UTIL_LINUX_PLYMOUTH_CTRL_H */
diff --git lib/Makemodule.am lib/Makemodule.am
index 054b816..cbf5cee 100644
--- lib/Makemodule.am
+++ lib/Makemodule.am
@@ -16,6 +16,7 @@ libcommon_la_SOURCES = \
 	lib/md5.c \
 	lib/pager.c \
 	lib/path.c \
+	lib/plymouth-ctrl.c \
 	lib/randutils.c \
 	lib/setproctitle.c \
 	lib/strutils.c \
diff --git lib/plymouth-ctrl.c lib/plymouth-ctrl.c
new file mode 100644
index 0000000..3a038c8
--- /dev/null
+++ lib/plymouth-ctrl.c
@@ -0,0 +1,140 @@
+/*
+ * plymouth-ctrl.c	Simply communcations with plymouthd
+ *			to avoid forked sub processes and/or
+ *			misssed plymouth send commands tool
+ *			due a plymouthd replacment.
+ *
+ * Copyright (c) 2016 SUSE Linux GmbH, All rights reserved.
+ * Copyright (c) 2016 Werner Fink <werner@suse.de>
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
+#include <errno.h>
+#include <limits.h>
+#include <poll.h>
+#include <signal.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <unistd.h>
+
+#include "all-io.h"
+#include "c.h"
+#include "nls.h"
+#include "plymouth-ctrl.h"
+
+static int can_read(int fd, const long timeout)
+{
+	struct pollfd fds = {
+		.fd = fd,
+		.events = POLLIN|POLLPRI,
+		.revents = 0,
+	};
+	int ret;
+
+	do {
+		ret = poll(&fds, 1, timeout);
+	} while ((ret < 0) && (errno == EINTR));
+
+	return (ret == 1) && (fds.revents & (POLLIN|POLLPRI));
+}
+
+static int open_un_socket_and_connect(void)
+{
+	struct sockaddr_un su = {		/* The abstract UNIX socket of plymouth */
+		.sun_family = AF_UNIX,
+		.sun_path = PLYMOUTH_SOCKET_PATH,
+	};
+	const int one = 1;
+	int fd, ret;
+
+	fd = socket(PF_UNIX, SOCK_STREAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0);
+	if (fd < 0) {
+		warnx(_("can not open UNIX socket"));
+		goto err;
+	}
+
+	ret = setsockopt(fd, SOL_SOCKET, SO_PASSCRED, &one, (socklen_t)sizeof(one));
+	if (ret < 0) {
+		warnx(_("can not set option for UNIX socket"));
+		close(fd);
+		fd = -1;
+		goto err;
+	}
+
+	ret = connect(fd, &su, offsetof(struct sockaddr_un, sun_path) + 1 + strlen(su.sun_path+1));
+	if (ret < 0) {
+		if (errno != ECONNREFUSED)
+			warnx(_("can not connect on UNIX socket"));
+		close(fd);
+		fd = -1;
+		goto err;
+	}
+err:
+	return fd;
+}
+
+int plymouth_command(int cmd, ...)
+{
+	char answer[2], command[2];
+	struct sigaction sp, op;
+	int fdsock = -1, ret = 0;
+
+	sigemptyset (&sp.sa_mask);
+	sp.sa_handler = SIG_IGN;
+	sp.sa_flags = SA_RESTART;
+	sigaction(SIGPIPE, &sp, &op);
+
+	command[1] = '\0';
+	switch (cmd) {
+	case MAGIC_PING:
+		fdsock = open_un_socket_and_connect();
+		if (fdsock >= 0) {
+			command[0] = cmd;
+			write_all(fdsock, command, strlen(command)+1);
+		}
+		break;
+	case MAGIC_QUIT:
+		fdsock = open_un_socket_and_connect();
+		if (fdsock >= 0) {
+			command[0] = cmd;
+			write_all(fdsock, command, strlen(command)+1);
+		}
+		break;
+	default:
+		warnx(_("the plymouth request %c is not implemented"), cmd);
+	case '?':
+		goto err;
+	}
+
+	answer[0] = '\0';
+	if (fdsock >= 0) {
+		if (can_read(fdsock, 1000))
+			read_all(fdsock, &answer[0], sizeof(answer));
+		close(fdsock);
+	}
+	sigaction(SIGPIPE, &op, NULL);
+	ret = (answer[0] == ANSWER_ACK) ? 1 : 0;
+err:
+	return ret;
+}
+
diff --git login-utils/sulogin.c login-utils/sulogin.c
index 601d38c..9d941e1 100644
--- login-utils/sulogin.c
+++ login-utils/sulogin.c
@@ -58,6 +58,7 @@
 #include "closestream.h"
 #include "nls.h"
 #include "pathnames.h"
+#include "plymouth-ctrl.h"
 #include "strutils.h"
 #include "ttyutils.h"
 #include "sulogin-consoles.h"
@@ -92,42 +93,6 @@ static int locked_account_password(const char *passwd)
 	return 0;
 }
 
-#ifdef TIOCGLCKTRMIOS
-/*
- * For the case plymouth is found on this system
- */
-static int plymouth_command(const char* arg)
-{
-	const char *cmd = "/usr/bin/plymouth";
-	static int has_plymouth = 1;
-	pid_t pid;
-
-	if (!has_plymouth)
-		return 127;
-
-	pid = fork();
-	if (!pid) {
-		int fd = open("/dev/null", O_RDWR);
-		if (fd < 0)
-			exit(127);
-		dup2(fd, 0);
-		dup2(fd, 1);
-		dup2(fd, 2);
-		if (fd > 2)
-			close(fd);
-		execl(cmd, cmd, arg, (char *) NULL);
-		exit(127);
-	} else if (pid > 0) {
-		int status;
-		waitpid(pid, &status, 0);
-		if (status == 127)
-			has_plymouth = 0;
-		return status;
-	}
-	return 1;
-}
-#endif
-
 /*
  * Fix the tty modes and set reasonable defaults.
  */
@@ -138,8 +103,9 @@ static void tcinit(struct console *con)
 	struct termios lock;
 	int fd = con->fd;
 #ifdef TIOCGLCKTRMIOS
-	int i = (plymouth_command("--ping")) ? 20 : 0;
-
+	int i = (plymouth_command(MAGIC_PING)) ? 20 : 0;
+	if (i)
+		plymouth_command(MAGIC_QUIT);
 	while (i-- > 0) {
 		/*
 		 * With plymouth the termios flags become changed after this
@@ -150,8 +116,6 @@ static void tcinit(struct console *con)
 			break;
 		if (!lock.c_iflag && !lock.c_oflag && !lock.c_cflag && !lock.c_lflag)
 			break;
-		if (i == 15 && plymouth_command("quit") != 0)
-			break;
 		sleep(1);
 	}
 	memset(&lock, 0, sizeof(struct termios));
diff --git term-utils/agetty.c term-utils/agetty.c
index 6d610c6..a00ae3d 100644
--- term-utils/agetty.c
+++ term-utils/agetty.c
@@ -41,6 +41,7 @@
 #include "all-io.h"
 #include "nls.h"
 #include "pathnames.h"
+#include "plymouth-ctrl.h"
 #include "c.h"
 #include "widechar.h"
 #include "ttyutils.h"
@@ -138,9 +139,6 @@ static int inotify_fd = AGETTY_RELOAD_FDNONE;
 static int netlink_fd = AGETTY_RELOAD_FDNONE;
 #endif
 
-#define AGETTY_PLYMOUTH		"/usr/bin/plymouth"
-#define AGETTY_PLYMOUTH_FDFILE	"/dev/null"
-
 /*
  * When multiple baud rates are specified on the command line, the first one
  * we will try is the first one specified.
@@ -309,7 +307,6 @@ static void log_warn (const char *, ...)
 static ssize_t append(char *dest, size_t len, const char  *sep, const char *src);
 static void check_username (const char* nm);
 static void login_options_to_argv(char *argv[], int *argc, char *str, char *username);
-static int plymouth_command(const char* arg);
 static void reload_agettys(void);
 
 /* Fake hostname for ut_host specified on command line. */
@@ -1180,8 +1177,9 @@ static void termio_init(struct options *op, struct termios *tp)
 	struct winsize ws;
 	struct termios lock;
 #ifdef TIOCGLCKTRMIOS
-	int i =  (plymouth_command("--ping") == 0) ? 30 : 0;
-
+	int i =  (plymouth_command(MAGIC_PING) == 0) ? 30 : 0;
+	if (i)
+		plymouth_command(MAGIC_QUIT);
 	while (i-- > 0) {
 		/*
 		 * Even with TTYReset=no it seems with systemd or plymouth
@@ -1194,8 +1192,6 @@ static void termio_init(struct options *op, struct termios *tp)
 		if (!lock.c_iflag && !lock.c_oflag && !lock.c_cflag && !lock.c_lflag)
 			break;
 		debug("termios locked\n");
-		if (i == 15 && plymouth_command("quit") != 0)
-			break;
 		sleep(1);
 	}
 	memset(&lock, 0, sizeof(struct termios));
@@ -1725,7 +1721,9 @@ static void print_issue_file(struct options *op, struct termios *tp)
 /* Show login prompt, optionally preceded by /etc/issue contents. */
 static void do_prompt(struct options *op, struct termios *tp)
 {
+#ifdef AGETTY_RELOAD
 again:
+#endif
 	print_issue_file(op, tp);
 
 	if (op->flags & F_LOGINPAUSE) {
@@ -2596,40 +2594,6 @@ err:
 	log_err(_("checkname failed: %m"));
 }
 
-/*
- * For the case plymouth is found on this system
- */
-static int plymouth_command(const char* arg)
-{
-	static int has_plymouth = 1;
-	pid_t pid;
-
-	if (!has_plymouth)
-		return 127;
-
-	pid = fork();
-	if (!pid) {
-		int fd = open(AGETTY_PLYMOUTH_FDFILE, O_RDWR);
-
-		if (fd < 0)
-			err(EXIT_FAILURE,_("cannot open %s"),
-					AGETTY_PLYMOUTH_FDFILE);
-		dup2(fd, 0);
-		dup2(fd, 1);
-		dup2(fd, 2);
-		close(fd);
-		execl(AGETTY_PLYMOUTH, AGETTY_PLYMOUTH, arg, (char *) NULL);
-		exit(127);
-	} else if (pid > 0) {
-		int status;
-		waitpid(pid, &status, 0);
-		if (status == 127)
-			has_plymouth = 0;
-		return status;
-	}
-	return 1;
-}
-
 static void reload_agettys(void)
 {
 #ifdef AGETTY_RELOAD
-- 
2.6.6

