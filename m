Return-Path: werner@suse.de
Date: Tue, 17 May 2016 12:18:38 +0200
From: "Dr. Werner Fink" <werner@suse.de>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Use the plymouth local protocol instead the plymouth
 binary
Message-ID: <20160517101838.2x7fi3zg5u4r2gjz@boole.suse.de>
References: <1461324096-29280-1-git-send-email-werner@suse.de>
 <20160505094245.6frwtvaxoueyrfw7@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lzfsxcvyeckhyxjp"
In-Reply-To: <20160505094245.6frwtvaxoueyrfw7@ws.net.home>
List-ID: <util-linux.vger.kernel.org>


--lzfsxcvyeckhyxjp
Content-Type: multipart/mixed; boundary="t6lood3cu3tqdgqy"
Content-Disposition: inline


--t6lood3cu3tqdgqy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 05, 2016 at 11:42:45AM +0200, Karel Zak wrote:
> > -	int i =3D (plymouth_command("--ping")) ? 20 : 0;
> > -
> > +	int i =3D (plymouth_command(MAGIC_PING)) ? 20 : 0;
> > +	if (i)
> > +		plymouth_command(MAGIC_QUIT);
>=20
> would be possible to #define PLYMOUTH_TERMIOS_FLAGS_DELAY,
> now we have 20s in sulogins and 30s in agetty. Why?
>=20
>     Karel

OK, let's see if the patch in the attachment does it better here.

Werner

--=20
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr

--t6lood3cu3tqdgqy
Content-Type: text/x-patch; charset=iso-8859-1
Content-Description: 0001-Use-the-plymouth-local-protocol-instead-the-plymouth.patch
Content-Disposition: attachment; filename="0001-Use-the-plymouth-local-protocol-instead-the-plymouth.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 137483035afdde9918c9e4b9cabeefda6d63b887 Mon Sep 17 00:00:00 2001
=46rom: Werner Fink <werner@suse.de>
Date: Fri, 22 Apr 2016 12:16:04 +0200
Subject: [PATCH] Use the plymouth local protocol instead the plymouth binary

for stopping plymouthd.  That do not depend on the existence of
the plymouth binary if it e.g. becomes uninstalled or an other
service is providing plymouthd facilities.

Signed-off-by: Werner Fink <werner@suse.de>
---
 include/plymouth-ctrl.h |  65 +++++++++++++++++++++
 lib/Makemodule.am       |   1 +
 lib/plymouth-ctrl.c     | 147 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 login-utils/sulogin.c   |  44 ++-------------
 term-utils/agetty.c     |  48 ++--------------
 5 files changed, 223 insertions(+), 82 deletions(-)
 create mode 100644 include/plymouth-ctrl.h
 create mode 100644 lib/plymouth-ctrl.c

diff --git include/plymouth-ctrl.h include/plymouth-ctrl.h
new file mode 100644
index 0000000..e1df363
--- /dev/null
+++ include/plymouth-ctrl.h
@@ -0,0 +1,65 @@
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
+ * =20
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
+#define PLYMOUTH_TERMIOS_FLAGS_DELAY	30
+extern int plymouth_command(int cmd, ...);
+
+#endif /* UTIL_LINUX_PLYMOUTH_CTRL_H */
diff --git lib/Makemodule.am lib/Makemodule.am
index 054b816..cbf5cee 100644
--- lib/Makemodule.am
+++ lib/Makemodule.am
@@ -16,6 +16,7 @@ libcommon_la_SOURCES =3D \
 	lib/md5.c \
 	lib/pager.c \
 	lib/path.c \
+	lib/plymouth-ctrl.c \
 	lib/randutils.c \
 	lib/setproctitle.c \
 	lib/strutils.c \
diff --git lib/plymouth-ctrl.c lib/plymouth-ctrl.c
new file mode 100644
index 0000000..9001134
--- /dev/null
+++ lib/plymouth-ctrl.c
@@ -0,0 +1,147 @@
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
+	struct pollfd fds =3D {
+		.fd =3D fd,
+		.events =3D POLLIN|POLLPRI,
+		.revents =3D 0,
+	};
+	int ret;
+
+	do {
+		ret =3D poll(&fds, 1, timeout);
+	} while ((ret < 0) && (errno =3D=3D EINTR));
+
+	return (ret =3D=3D 1) && (fds.revents & (POLLIN|POLLPRI));
+}
+
+static int open_un_socket_and_connect(void)
+{
+	struct sockaddr_un su =3D {		/* The abstract UNIX socket of plymouth */
+		.sun_family =3D AF_UNIX,
+		.sun_path =3D PLYMOUTH_SOCKET_PATH,
+	};
+	const int one =3D 1;
+	int fd, ret;
+
+	fd =3D socket(PF_UNIX, SOCK_STREAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0);
+	if (fd < 0) {
+		warnx(_("can not open UNIX socket"));
+		goto err;
+	}
+
+	ret =3D setsockopt(fd, SOL_SOCKET, SO_PASSCRED, &one, (socklen_t)sizeof(o=
ne));
+	if (ret < 0) {
+		warnx(_("can not set option for UNIX socket"));
+		close(fd);
+		fd =3D -1;
+		goto err;
+	}
+
+	/*
+	 * Please note that the PLYMOUTH_SOCKET_PATH has a
+	 * leading NULL byte to mark it as an abstract socket
+	 */
+	ret =3D connect(fd, &su, offsetof(struct sockaddr_un, sun_path) + 1 + str=
len(su.sun_path+1));
+	if (ret < 0) {
+		if (errno !=3D ECONNREFUSED)
+			warnx(_("can not connect on UNIX socket"));
+		close(fd);
+		fd =3D -1;
+		goto err;
+	}
+err:
+	return fd;
+}
+
+int plymouth_command(int cmd, ...)
+{
+	uint8_t answer[2], command[2];
+	struct sigaction sp, op;
+	int fdsock =3D -1, ret =3D 0;
+
+	sigemptyset (&sp.sa_mask);
+	sp.sa_handler =3D SIG_IGN;
+	sp.sa_flags =3D SA_RESTART;
+	sigaction(SIGPIPE, &sp, &op);
+
+	/*
+	 * The plymouthd does read at least two bytes.
+	 */
+	command[1] =3D '\0';
+	switch (cmd) {
+	case MAGIC_PING:
+		fdsock =3D open_un_socket_and_connect();
+		if (fdsock >=3D 0) {
+			command[0] =3D cmd;
+			write_all(fdsock, command, strlen(command)+1);
+		}
+		break;
+	case MAGIC_QUIT:
+		fdsock =3D open_un_socket_and_connect();
+		if (fdsock >=3D 0) {
+			command[0] =3D cmd;
+			write_all(fdsock, command, strlen(command)+1);
+		}
+		break;
+	default:
+		warnx(_("the plymouth request %c is not implemented"), cmd);
+	case '?':
+		goto err;
+	}
+
+	answer[0] =3D '\0';
+	if (fdsock >=3D 0) {
+		if (can_read(fdsock, 1000))
+			read_all(fdsock, &answer[0], sizeof(answer));
+		close(fdsock);
+	}
+	sigaction(SIGPIPE, &op, NULL);
+	ret =3D (answer[0] =3D=3D ANSWER_ACK) ? 1 : 0;
+err:
+	return ret;
+}
+
diff --git login-utils/sulogin.c login-utils/sulogin.c
index 601d38c..8d6e652 100644
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
=20
-#ifdef TIOCGLCKTRMIOS
-/*
- * For the case plymouth is found on this system
- */
-static int plymouth_command(const char* arg)
-{
-	const char *cmd =3D "/usr/bin/plymouth";
-	static int has_plymouth =3D 1;
-	pid_t pid;
-
-	if (!has_plymouth)
-		return 127;
-
-	pid =3D fork();
-	if (!pid) {
-		int fd =3D open("/dev/null", O_RDWR);
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
-		if (status =3D=3D 127)
-			has_plymouth =3D 0;
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
 	int fd =3D con->fd;
 #ifdef TIOCGLCKTRMIOS
-	int i =3D (plymouth_command("--ping")) ? 20 : 0;
-
+	int i =3D (plymouth_command(MAGIC_PING)) ? PLYMOUTH_TERMIOS_FLAGS_DELAY :=
 0;
+	if (i)
+		plymouth_command(MAGIC_QUIT);
 	while (i-- > 0) {
 		/*
 		 * With plymouth the termios flags become changed after this
@@ -150,8 +116,6 @@ static void tcinit(struct console *con)
 			break;
 		if (!lock.c_iflag && !lock.c_oflag && !lock.c_cflag && !lock.c_lflag)
 			break;
-		if (i =3D=3D 15 && plymouth_command("quit") !=3D 0)
-			break;
 		sleep(1);
 	}
 	memset(&lock, 0, sizeof(struct termios));
diff --git term-utils/agetty.c term-utils/agetty.c
index 6d610c6..ab82fdb 100644
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
@@ -138,9 +139,6 @@ static int inotify_fd =3D AGETTY_RELOAD_FDNONE;
 static int netlink_fd =3D AGETTY_RELOAD_FDNONE;
 #endif
=20
-#define AGETTY_PLYMOUTH		"/usr/bin/plymouth"
-#define AGETTY_PLYMOUTH_FDFILE	"/dev/null"
-
 /*
  * When multiple baud rates are specified on the command line, the first o=
ne
  * we will try is the first one specified.
@@ -309,7 +307,6 @@ static void log_warn (const char *, ...)
 static ssize_t append(char *dest, size_t len, const char  *sep, const char=
 *src);
 static void check_username (const char* nm);
 static void login_options_to_argv(char *argv[], int *argc, char *str, char=
 *username);
-static int plymouth_command(const char* arg);
 static void reload_agettys(void);
=20
 /* Fake hostname for ut_host specified on command line. */
@@ -1180,8 +1177,9 @@ static void termio_init(struct options *op, struct te=
rmios *tp)
 	struct winsize ws;
 	struct termios lock;
 #ifdef TIOCGLCKTRMIOS
-	int i =3D  (plymouth_command("--ping") =3D=3D 0) ? 30 : 0;
-
+	int i =3D  (plymouth_command(MAGIC_PING) =3D=3D 0) ? PLYMOUTH_TERMIOS_FLA=
GS_DELAY : 0;
+	if (i)
+		plymouth_command(MAGIC_QUIT);
 	while (i-- > 0) {
 		/*
 		 * Even with TTYReset=3Dno it seems with systemd or plymouth
@@ -1194,8 +1192,6 @@ static void termio_init(struct options *op, struct te=
rmios *tp)
 		if (!lock.c_iflag && !lock.c_oflag && !lock.c_cflag && !lock.c_lflag)
 			break;
 		debug("termios locked\n");
-		if (i =3D=3D 15 && plymouth_command("quit") !=3D 0)
-			break;
 		sleep(1);
 	}
 	memset(&lock, 0, sizeof(struct termios));
@@ -1725,7 +1721,9 @@ static void print_issue_file(struct options *op, stru=
ct termios *tp)
 /* Show login prompt, optionally preceded by /etc/issue contents. */
 static void do_prompt(struct options *op, struct termios *tp)
 {
+#ifdef AGETTY_RELOAD
 again:
+#endif
 	print_issue_file(op, tp);
=20
 	if (op->flags & F_LOGINPAUSE) {
@@ -2596,40 +2594,6 @@ err:
 	log_err(_("checkname failed: %m"));
 }
=20
-/*
- * For the case plymouth is found on this system
- */
-static int plymouth_command(const char* arg)
-{
-	static int has_plymouth =3D 1;
-	pid_t pid;
-
-	if (!has_plymouth)
-		return 127;
-
-	pid =3D fork();
-	if (!pid) {
-		int fd =3D open(AGETTY_PLYMOUTH_FDFILE, O_RDWR);
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
-		if (status =3D=3D 127)
-			has_plymouth =3D 0;
-		return status;
-	}
-	return 1;
-}
-
 static void reload_agettys(void)
 {
 #ifdef AGETTY_RELOAD
--=20
2.6.6


--t6lood3cu3tqdgqy--

--lzfsxcvyeckhyxjp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJXOu/+AAoJEFDpDVUdwWsuiakQAKgVvstl0zd6F/GqsTiT7rn9
1N1+GcFcyqBO/6CFO2N7bVWJ+gxZiQxruO19BiFmXDcO236KTXPx2gAcGY4jLB+7
Kqj0zK4ClLtixXz3d1avF0ZMy8GI+WUWKYQKTkxhckt2L9b+SIzYijaEkRIYuCYt
5CA/PpIQxI1DQlZ0rg94aGtWIvUK31HGgRxP5i1MOqknl6YRXD4dbyrTWxyDfioq
Rr4kFu/ozrpPfGRhDowA0iJJmjOoIRgc5DpQmXPLJ0nBSJclQbQeYU9nxazk9y19
mpN7vxZP8iM4Cdeo3WILFTIJpTufYDYTmqm+dEfcWIIDDgUkmaMpL6jEx9rRafVJ
3WPww9F9Vn762K9hBUopblJTSgMR8Due1EWLXAwUSdVqG3vhC07wDBozSCnaT69s
IEnU1P5+NQ3trLzLXhJJy+wITXrd2rmFqGAvtkfYNYPJI5VQ/ng7AK9+q0FbPHjO
FecVdz0t2GzQKFmmyx+mypHKS6pl3E411R6Mz695J+nNn514EpZgLrF0jnkAINx6
LxwrxLK3TgXwnKQSaSmZzkuQt4FovJdpK0TmhawX7VLHFs0ru7eoRu7829hR8eIg
MemZwO+dBPRXhvOESvJzBFUagphyahIcOeV3QDw1iK2qp9kNeIps+2dZUviDdN5m
W105Af7EuVTMIA4UnyoZ
=zGLd
-----END PGP SIGNATURE-----

--lzfsxcvyeckhyxjp--
