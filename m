Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.higgsboson.tk ([148.251.132.243]:34432 "EHLO
	mail.higgsboson.tk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755226AbbCRJ6f (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 18 Mar 2015 05:58:35 -0400
Received: from turingmachine (wh0254.dip.tu-dresden.de [141.76.188.254])
	by mail.higgsboson.tk (Postfix) with ESMTPSA id B34AE168EB
	for <util-linux@vger.kernel.org>; Wed, 18 Mar 2015 09:53:21 +0000 (UTC)
Date: Wed, 18 Mar 2015 10:53:19 +0100
From: =?UTF-8?B?SsO2cmc=?= Thalheim <joerg@higgsboson.tk>
To: util-linux@vger.kernel.org
Subject: [PATCH] nsenter: add support for pty
Message-ID: <20150318105319.2c6bab99@turingmachine>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/ChYG.+HQLV2eoY4sG7r7i6="; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--Sig_/ChYG.+HQLV2eoY4sG7r7i6=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

If mount namespaces are used, the issued command, will not have access to t=
he
tty device attached to its stdin/stdout/stderr. This patch adds an option to
allocate a new pseudo tty in the entered mount namespace and bridge between=
 the
origin standard file descriptors and the standard file descriptors of the
executed command.

Signed-off-by: J=C3=B6rg Thalheim <joerg@higgsboson.tk>
---
 sys-utils/nsenter.1 |   6 ++
 sys-utils/nsenter.c | 203 ++++++++++++++++++++++++++++++++++++++++++++++++=
++--
 2 files changed, 202 insertions(+), 7 deletions(-)

diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
index 8a3b25e..15218cb 100644
--- a/sys-utils/nsenter.1
+++ b/sys-utils/nsenter.1
@@ -140,6 +140,12 @@ always sets UID for user namespaces, the default is 0.
 Don't modify UID and GID when enter user namespace. The default is to
 drops supplementary groups and sets GID and UID to 0.
 .TP
+\fB\-P\fR, \fB\-\-pty\fR\fR
+Allocate a pseudo-tty and attach the standart input/output of the command.=
  This
+option can be used for interactive programs, which requires access to its =
tty
+device, if mount namespaces are in use. If this option is set, nsenter wil=
l always
+fork, before execu'ing the command.
+.TP
 \fB\-r\fR, \fB\-\-root\fR[=3D\fIdirectory\fR]
 Set the root directory.  If no directory is specified, set the root direct=
ory to
 the root directory of the target process.  If directory is specified, set =
the
diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index b029f80..c6e899b 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -2,6 +2,7 @@
  * nsenter(1) - command-line interface for setns(2)
  *
  * Copyright (C) 2012-2013 Eric Biederman <ebiederm@xmission.com>
+ * Copyright (C) 2015 J=C3=B6rg Thalheim <joerg@higgsboson.tk>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -28,6 +29,9 @@
 #include <assert.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/ioctl.h>
+#include <sys/select.h>
+#include <term.h>
 #include <grp.h>
=20
 #include "strutils.h"
@@ -79,6 +83,7 @@ static void usage(int status)
 	fputs(_(" -S, --setuid <uid>     set uid in entered namespace\n"), out);
 	fputs(_(" -G, --setgid <gid>     set gid in entered namespace\n"), out);
 	fputs(_("     --preserve-credentials do not touch uids or gids\n"), out);
+	fputs(_(" -P, --pty              allocate a pseudo-TTY (this implies fork=
ing)\n"), out);
 	fputs(_(" -r, --root[=3D<dir>]     set the root directory\n"), out);
 	fputs(_(" -w, --wd[=3D<dir>]       set the working directory\n"), out);
 	fputs(_(" -F, --no-fork          do not fork before exec'ing <program>\n"=
), out);
@@ -94,6 +99,8 @@ static void usage(int status)
 static pid_t namespace_target_pid =3D 0;
 static int root_fd =3D -1;
 static int wd_fd =3D -1;
+static struct termios stdin_termios, stdout_termios;
+static int tty_master_fd;
=20
 static void open_target_fd(int *fd, const char *type, const char *path)
 {
@@ -132,20 +139,198 @@ static void open_namespace_fd(int nstype, const char=
 *path)
 	assert(nsfile->nstype);
 }
=20
-static void continue_as_child(void)
+static void resize_on_signal(int signo __attribute__((__unused__)))
 {
-	pid_t child =3D fork();
+	struct winsize winsize;
+
+	if (ioctl(STDIN_FILENO, TIOCGWINSZ, &winsize) !=3D -1)
+		ioctl(tty_master_fd, TIOCSWINSZ, &winsize);
+}
+
+static void restore_stdin(void)
+{
+	if (tcsetattr(STDIN_FILENO, TCSANOW, &stdin_termios) =3D=3D -1)
+		errx(EXIT_FAILURE,
+				_("failed to restore stdin terminal attributes"));
+}
+
+static void restore_stdout(void)
+{
+	if (tcsetattr(STDOUT_FILENO, TCSANOW, &stdout_termios) =3D=3D -1)
+		errx(EXIT_FAILURE,
+				_("failed to restore stdout terminal attributes"));
+}
+
+
+static int set_tty_raw(int fd, struct termios *origin_attr)
+{
+	struct termios attr[1];
+
+	if (tcgetattr(fd, attr) =3D=3D -1)
+		return -1;
+
+	memcpy(origin_attr, attr, sizeof(struct termios));
+
+	cfmakeraw(attr);
+
+	return tcsetattr(fd, TCSANOW, attr);
+}
+
+static void shovel_tty(int master_fd, int in_fd) {
+	fd_set read_fds[1];
+	int max_fd;
+	char buf[BUFSIZ];
+	ssize_t bytes;
+	int n;
+	while (master_fd !=3D -1) {
+
+		FD_ZERO(read_fds);
+
+		if (in_fd !=3D -1)
+			FD_SET(in_fd, read_fds);
+
+		if (master_fd !=3D -1)
+			FD_SET(master_fd, read_fds);
+
+		max_fd =3D (master_fd > in_fd) ? master_fd : in_fd;
+
+		if ((n =3D select(max_fd + 1, read_fds, NULL, NULL, NULL)) =3D=3D -1 && =
errno !=3D EINTR)
+			break;
+
+		if (n =3D=3D -1 && errno =3D=3D EINTR)
+			continue;
+
+		if (in_fd !=3D -1 && FD_ISSET(in_fd, read_fds)) {
+			if ((bytes =3D read(in_fd, buf, BUFSIZ)) > 0) {
+				if (master_fd !=3D -1 && write(master_fd, buf, bytes) =3D=3D -1)
+					break;
+			} else if (n =3D=3D -1 && errno =3D=3D EINTR) {
+				continue;
+			} else {
+				in_fd =3D -1;
+				continue;
+			}
+		}
+
+		if (master_fd !=3D -1 && FD_ISSET(master_fd, read_fds)) {
+			if ((bytes =3D read(master_fd, buf, BUFSIZ)) > 0) {
+				if (write(STDOUT_FILENO, buf, bytes) =3D=3D -1)
+					break;
+			} else if (n =3D=3D -1 && errno =3D=3D EINTR) {
+				continue;
+			} else {
+				close(master_fd);
+				master_fd =3D -1;
+				continue;
+			}
+		}
+	}
+}
+
+static void setup_pty_parent(int master_fd)
+{
+	struct sigaction sa;
+	struct winsize ws;
+
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags =3D 0;
+	sa.sa_handler =3D resize_on_signal;
+	sigaction(SIGWINCH, &sa, NULL);
+
+	if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws) >=3D 0)
+		(void) ioctl(master_fd, TIOCSWINSZ, &ws);
+
+	if (set_tty_raw(STDIN_FILENO, &stdin_termios) !=3D -1) {
+		atexit((void (*)(void))restore_stdin);
+	}
+
+	if (set_tty_raw(STDOUT_FILENO, &stdout_termios) !=3D -1) {
+		atexit((void (*)(void))restore_stdout);
+	}
+}
+
+static int setup_pty_child(int master_fd)
+{
+	pid_t pid;
+	int slave_fd;
+
+	char* slave_name =3D ptsname(master_fd);
+	if (slave_name =3D=3D NULL)
+		return -errno;
+
+	slave_fd =3D open(slave_name, O_RDWR | O_NOCTTY | O_CLOEXEC);
+	if (slave_fd < -1)
+		return -errno;
+
+	pid =3D setsid();
+	if (pid < 0 && errno !=3D EPERM)
+		return -errno;
+
+	if (ioctl(slave_fd, TIOCSCTTY, 0) < 0)
+		return -errno;
+
+	if (dup2(slave_fd, STDIN_FILENO) !=3D STDIN_FILENO ||
+			dup2(slave_fd, STDOUT_FILENO) !=3D STDOUT_FILENO ||
+			dup2(slave_fd, STDERR_FILENO) !=3D STDERR_FILENO)
+		return -errno;
+
+	/*only close, if slave_fd is not std-fd*/
+	if (slave_fd > 2)
+		close(slave_fd);
+
+	return 0;
+}
+
+static int new_pty(void)
+{
+	int fd =3D posix_openpt(O_RDWR | O_NOCTTY);
+
+	if (fd < 0)
+		return -errno;
+
+	if (grantpt(fd) < 0)
+		return -errno;
+
+	if (unlockpt(fd) < 0)
+		return -errno;
+
+	return fd;
+}
+
+static void continue_as_child(bool open_pty)
+{
+	pid_t child;
 	int status;
 	pid_t ret;
+	int master_fd =3D -1;
+
+	if (open_pty) {
+		master_fd =3D new_pty();
+		if (master_fd < 0)
+			err(EXIT_FAILURE, _("open pseudo tty failed"));
+	}
+
+	child =3D fork();
=20
 	if (child < 0)
 		err(EXIT_FAILURE, _("fork failed"));
=20
 	/* Only the child returns */
-	if (child =3D=3D 0)
+	if (child =3D=3D 0) {
+		if (open_pty && setup_pty_child(master_fd) < 0)
+			err(EXIT_FAILURE, _("failed to setup slave of pseudo tty"));
+		close(master_fd);
 		return;
+	}
+
+	if (open_pty) {
+		tty_master_fd =3D master_fd;
+		setup_pty_parent(master_fd);
+	}
=20
 	for (;;) {
+		if (open_pty)
+			shovel_tty(master_fd, STDIN_FILENO);
 		ret =3D waitpid(child, &status, WUNTRACED);
 		if ((ret =3D=3D child) && (WIFSTOPPED(status))) {
 			/* The child suspended so suspend us as well */
@@ -171,6 +356,7 @@ int main(int argc, char *argv[])
 	};
 	static const struct option longopts[] =3D {
 		{ "help", no_argument, NULL, 'h' },
+		{ "pty", no_argument, NULL, 'P' },
 		{ "version", no_argument, NULL, 'V'},
 		{ "target", required_argument, NULL, 't' },
 		{ "mount", optional_argument, NULL, 'm' },
@@ -190,7 +376,7 @@ int main(int argc, char *argv[])
=20
 	struct namespace_file *nsfile;
 	int c, namespaces =3D 0, setgroups_nerrs =3D 0, preserve_cred =3D 0;
-	bool do_rd =3D false, do_wd =3D false, force_uid =3D false, force_gid =3D=
 false;
+	bool do_rd =3D false, do_wd =3D false, force_uid =3D false, force_gid =3D=
 false, open_pty =3D false;
 	int do_fork =3D -1; /* unknown yet */
 	uid_t uid =3D 0;
 	gid_t gid =3D 0;
@@ -201,7 +387,7 @@ int main(int argc, char *argv[])
 	atexit(close_stdout);
=20
 	while ((c =3D
-		getopt_long(argc, argv, "+hVt:m::u::i::n::p::U::S:G:r::w::F",
+		getopt_long(argc, argv, "+hPVt:m::u::i::n::p::U::S:G:r::w::F",
 			    longopts, NULL)) !=3D -1) {
 		switch (c) {
 		case 'h':
@@ -243,6 +429,9 @@ int main(int argc, char *argv[])
 			else
 				namespaces |=3D CLONE_NEWPID;
 			break;
+		case 'P':
+			open_pty =3D true;
+			break;
 		case 'U':
 			if (optarg)
 				open_namespace_fd(CLONE_NEWUSER, optarg);
@@ -358,8 +547,8 @@ int main(int argc, char *argv[])
 		wd_fd =3D -1;
 	}
=20
-	if (do_fork =3D=3D 1)
-		continue_as_child();
+	if (do_fork =3D=3D 1 || open_pty)
+		continue_as_child(open_pty);
=20
 	if (force_uid || force_gid) {
 		if (force_gid && setgroups(0, NULL) !=3D 0 && setgroups_nerrs)	/* drop s=
upplementary groups */
--=20
2.3.3

--Sig_/ChYG.+HQLV2eoY4sG7r7i6=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJVCUsPXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXQ0QUJBMDczODJBRDU3RTZCOUFBNEU4OERD
QTQxMDZCOEQ3Q0M3OUZBAAoJEMpBBrjXzHn6CjgH/2UDW9x7LYEJ+P/kq7Cb2T1l
516XCAeifuQSpk5cc/byKz85tQzo+xXTOf79vyffQtycy6LhVd0yNwMe/8z/r0Lr
IohqmDU9s7XKvf1cwvp544tvKhHxB0+xvR+vfiwxf5aY/9JYi47F2+yZbXgEV7Id
BtjhU/G2bvzveInsObGQFzrO2c2qEJzFAKz0h5lkNs+3fFhbyd3e8U09n0TTKzhI
DtXGYeKTzu4eBcNI0zadrX5LDMgqrEJcHdrsD2+Wm8BCtpgAgvUxrqLE6luhyI6/
dX925VAWrmR7rwhp6jFcADc40a1pxB0ecIBX/65PBbAzH3E3fm2aZinDiDdQ+vY=
=BRPb
-----END PGP SIGNATURE-----

--Sig_/ChYG.+HQLV2eoY4sG7r7i6=--
