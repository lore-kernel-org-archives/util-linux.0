Return-Path: util-linux-owner@vger.kernel.org
Received: from nat.nue.novell.com ([195.135.221.2]:25643 "EHLO boole.suse.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751027AbcBJQTV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Feb 2016 11:19:21 -0500
Date: Wed, 10 Feb 2016 16:59:09 +0100
From: "Dr. Werner Fink" <werner@suse.de>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: sulogin usemask
Message-ID: <20160210155909.GA19495@boole.suse.de>
References: <20150930124638.GE1787@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
In-Reply-To: <20150930124638.GE1787@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--A6N2fC+uXW/VQSAv
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2015 at 02:46:38PM +0200, Karel Zak wrote:
>=20
>=20
>  Hi,
>=20
>  https://github.com/systemd/systemd/pull/1399 this discussion
>  highlights that the code around 'usemask' is not robust enough.
>=20
>  The 'volatile' does not mean atomic.=20
> =20
>  It would be nice to improve the code -- avoid the mask at all, or use
>  pthread_mutex_lock() (note that you can use mmaped shared memory for
>  the muttex and share the lock between forked processes, you don't
>  have to use threads).
>=20
>  Comments?

I agree, I've ported my current status to my local clone of the git
repository.

I've tested the new code even with and without mounted /dev.

Werner

--=20
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr

--r5Pyd7+fXNt84Ff3
Content-Type: text/x-patch; charset=iso-8859-1
Content-Description: 0001-Sulogin-avoid-shared-memory-area-usemask-but-use-wai.patch
Content-Disposition: inline; filename="0001-Sulogin-avoid-shared-memory-area-usemask-but-use-wai.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 70fe80addfdc0f41c011d246711ea8e36794d479 Mon Sep 17 00:00:00 2001
=46rom: Werner Fink <werner@suse.de>
Date: Wed, 10 Feb 2016 16:48:07 +0100
Subject: [PATCH] Sulogin: avoid shared memory area usemask but use waitid()
 for childs

This small patch improves the console detection code and also avoids not
existing device nodes due strdup() which is used in canonicalize_path().
Beside this now the code for emergeny mount does work if enabled at
configure time.

Signed-off-by: Werner Fink <werner@suse.de>
---
 login-utils/sulogin-consoles.c |  53 ++++++++++++++++-----
 login-utils/sulogin.c          | 104 ++++++++++++++++++++++++++++++-------=
----
 2 files changed, 120 insertions(+), 37 deletions(-)

diff --git b/login-utils/sulogin-consoles.c a/login-utils/sulogin-consoles.c
index bc55e9c..fe8eab1 100644
--- b/login-utils/sulogin-consoles.c
+++ a/login-utils/sulogin-consoles.c
@@ -36,8 +36,9 @@
 # include <linux/serial.h>
 # include <linux/major.h>
 #endif
-#include <fcntl.h>
 #include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
 #include <unistd.h>
=20
 #ifdef USE_SULOGIN_EMERGENCY_MOUNT
@@ -226,6 +227,8 @@ dev_t devattr(const char *tty)
=20
 /*
  * Search below /dev for the character device in `dev_t comparedev' variab=
le.
+ * Note that realpath(3) is used here to avoid not existent devices due the
+ * strdup(3) used in our canonicalize_path()!
  */
 static
 #ifdef __GNUC__
@@ -233,16 +236,28 @@ __attribute__((__nonnull__,__malloc__,__hot__))
 #endif
 char* scandev(DIR *dir, dev_t comparedev)
 {
+	char path[PATH_MAX];
 	char *name =3D NULL;
 	struct dirent *dent;
-	int fd;
+	int len, fd;
=20
 	DBG(dbgprint("scanning /dev for %u:%u", major(comparedev), minor(compared=
ev)));
=20
+	/*
+	 * Try udev links on character devices first.
+	 */
+	if ((len =3D snprintf(path, sizeof(path),
+			    "/dev/char/%u:%u", major(comparedev), minor(comparedev))) > 0 &&
+	    (size_t)len < sizeof(path)) {
+
+	    name =3D realpath(path, NULL);
+	    if (name)
+		    goto out;
+	}
+
 	fd =3D dirfd(dir);
 	rewinddir(dir);
 	while ((dent =3D readdir(dir))) {
-		char path[PATH_MAX];
 		struct stat st;
=20
 #ifdef _DIRENT_HAVE_D_TYPE
@@ -255,17 +270,33 @@ char* scandev(DIR *dir, dev_t comparedev)
 			continue;
 		if (comparedev !=3D st.st_rdev)
 			continue;
-		if ((size_t)snprintf(path, sizeof(path), "/dev/%s", dent->d_name) >=3D s=
izeof(path))
+		if ((len =3D snprintf(path, sizeof(path), "/dev/%s", dent->d_name)) < 0 =
||
+		    (size_t)len >=3D sizeof(path))
 			continue;
-#ifdef USE_SULOGIN_EMERGENCY_MOUNT
-		if (emergency_flags & MNT_DEVTMPFS)
-			mknod(path, S_IFCHR|S_IRUSR|S_IWUSR, comparedev);
-#endif
=20
-		name =3D canonicalize_path(path);
-		break;
+		name =3D realpath(path, NULL);
+		if (name)
+			goto out;
 	}
=20
+#ifdef USE_SULOGIN_EMERGENCY_MOUNT
+	/*
+	 * There was no /dev mounted hence and no device was found hence we creat=
e our own.
+	 */
+	if (!name && (emergency_flags & MNT_DEVTMPFS)) {
+
+		if ((len =3D snprintf(path, sizeof(path),
+				    "/dev/tmp-%u:%u", major(comparedev), minor(comparedev))) < 0 ||
+		    (size_t)len >=3D sizeof(path))
+			goto out;
+
+		if (mknod(path, S_IFCHR|S_IRUSR|S_IWUSR, comparedev) < 0 && errno !=3D E=
EXIST)
+			goto out;
+
+		name =3D realpath(path, NULL);
+	}
+#endif
+out:
 	return name;
 }
=20
@@ -307,7 +338,7 @@ int append_console(struct list_head *consoles, const ch=
ar *name)
 	tail->flags =3D 0;
 	tail->fd =3D -1;
 	tail->id =3D last ? last->id + 1 : 0;
-	tail->pid =3D 0;
+	tail->pid =3D -1;
 	memset(&tail->tio, 0, sizeof(tail->tio));
=20
 	return 0;
diff --git b/login-utils/sulogin.c a/login-utils/sulogin.c
index be52141..4b1e44b 100644
--- b/login-utils/sulogin.c
+++ a/login-utils/sulogin.c
@@ -66,7 +66,6 @@
 static unsigned int timeout;
 static int profile;
 static volatile uint32_t openfd;		/* Remember higher file descriptors */
-static volatile uint32_t *usemask;
=20
 struct sigaction saved_sigint;
 struct sigaction saved_sigtstp;
@@ -109,7 +108,8 @@ static int plymouth_command(const char* arg)
 		dup2(fd, 0);
 		dup2(fd, 1);
 		dup2(fd, 2);
-		close(fd);
+		if (fd > 2)
+			close(fd);
 		execl(cmd, cmd, arg, (char *) NULL);
 		exit(127);
 	} else if (pid > 0) {
@@ -857,9 +857,12 @@ int main(int argc, char **argv)
 	struct console *con;
 	char *tty =3D NULL;
 	struct passwd *pwd;
-	int c, status =3D 0;
-	int reconnect =3D 0;
+	struct timespec sigwait =3D {0, 50000000};
+	siginfo_t status =3D {};
+	sigset_t set =3D {};
+	int c, reconnect =3D 0;
 	int opt_e =3D 0;
+	int wait =3D 0;
 	pid_t pid;
=20
 	static const struct option longopts[] =3D {
@@ -985,9 +988,6 @@ int main(int argc, char **argv)
 		tcinit(con);
 	}
 	ptr =3D (&consoles)->next;
-	usemask =3D (uint32_t*) mmap(NULL, sizeof(uint32_t),
-					PROT_READ|PROT_WRITE,
-					MAP_ANONYMOUS|MAP_SHARED, -1, 0);
=20
 	if (ptr->next =3D=3D &consoles) {
 		con =3D list_entry(ptr, struct console, entry);
@@ -1033,9 +1033,7 @@ int main(int argc, char **argv)
 				}
=20
 				if (doshell) {
-					*usemask |=3D (1<<con->id);
 					sushell(pwd);
-					*usemask &=3D ~(1<<con->id);
 					failed++;
 				}
=20
@@ -1068,28 +1066,82 @@ int main(int argc, char **argv)
=20
 	} while (ptr !=3D &consoles);
=20
-	while ((pid =3D wait(&status))) {
-		if (errno =3D=3D ECHILD)
+	do {
+		int ret;
+
+		status.si_pid =3D 0;
+		ret =3D waitid(P_ALL, 0, &status, WEXITED);
+
+		if (ret =3D=3D 0)
 			break;
-		if (pid < 0)
-			continue;
-		list_for_each(ptr, &consoles) {
-			con =3D list_entry(ptr, struct console, entry);
-			if (con->pid =3D=3D pid) {
-				*usemask &=3D ~(1<<con->id);
+		if (ret < 0) {
+			if (errno =3D=3D ECHILD)
+				break;
+			if (errno =3D=3D EINTR)
 				continue;
-			}
-			if (kill(con->pid, 0) < 0) {
-				*usemask &=3D ~(1<<con->id);
+		}
+
+		errx(EXIT_FAILURE, _("Can not wait on su shell\n\n"));
+
+	} while (1);
+
+	list_for_each(ptr, &consoles) {
+		con =3D list_entry(ptr, struct console, entry);
+
+		if (con->fd < 0)
+			continue;
+		if (con->pid < 0)
+			continue;
+		if (con->pid =3D=3D status.si_pid)
+			con->pid =3D -1;
+		else {
+			kill(con->pid, SIGTERM);
+			wait++;
+		}
+	}
+
+	sigemptyset(&set);
+	sigaddset(&set, SIGCHLD);
+
+	do {
+		int signum, ret;
+
+		if (!wait)
+			break;
+
+		status.si_pid =3D 0;
+		ret =3D waitid(P_ALL, 0, &status, WEXITED|WNOHANG);
+
+		if (ret < 0) {
+			if (errno =3D=3D ECHILD)
+				break;
+			if (errno =3D=3D EINTR)
 				continue;
+		}
+
+		if (!ret && status.si_pid > 0) {
+			list_for_each(ptr, &consoles) {
+				con =3D list_entry(ptr, struct console, entry);
+
+				if (con->fd < 0)
+					continue;
+				if (con->pid < 0)
+					continue;
+				if (con->pid =3D=3D status.si_pid) {
+					con->pid =3D -1;
+					wait--;
+				}
 			}
-			if (*usemask & (1<<con->id))
-				continue;
-			kill(con->pid, SIGHUP);
-			xusleep(50000);
-			kill(con->pid, SIGKILL);
+			continue;
 		}
-	}
+
+		signum =3D sigtimedwait(&set, NULL, &sigwait);
+		if (signum !=3D SIGCHLD) {
+			if (signum < 0 && errno =3D=3D EAGAIN)
+				break;
+		}
+
+	} while (1);
=20
 	mask_signal(SIGCHLD, SIG_DFL, NULL);
 	return EXIT_SUCCESS;
--=20
2.6.2


--r5Pyd7+fXNt84Ff3--

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJWu15MAAoJEFDpDVUdwWsuxk8P/2uMxY5UlUX+CuIHaDuEe4qu
FYLY7cLwveoT2uDs6tE0wNp2T4X5WioDQ0FA5YRVrdcQZiX9THcSyAipdBxiBq5I
jeZsibqQM0st2RE6BZMrihNpLz1fZh6ImeSfTLWFb1FSOqUdSw7I+5Msu3DXN/rp
F4hEzeg+ovjgmAg8TBX6f69e+Hc/VvZGTF8wJxBwI4n7xxX/pnQ0r3QGnbmQ315L
VmIyxuYeeXlqzhWSRSKGKV8weSHV2d/lf5Gk7HqG+erCY9ckMzZ3HjXGArW75Nkz
bAhoOIx4CNtfXpy6nAMxiwEmLYYW2FYaM1+8emI+5NISxtjWn5aT9AEGggNz977X
88OABMcu+07V7L0vB6o3/Z4cyy+GLgmUJ9wfdPPpmyqA3FXSJBU2Pwl/Ui866hX0
U8lw8d55sBwcodqF8mbceFENGVKKHPemeBc1AGwjqW2HqjE5y1IFPblFUC1i5oEC
Cndhl8vxfk3AoScRGG7r5PGR1Bi1+u5ES8ojOP0VNG18EbQXgoiCKx8+RJJMB5iQ
psCxi/gtGnpzVl8oW3THy0vGi/CYn+wbVREKoRIvBN2Bj4jpZkH8Uosqc0aSIhkQ
kP0r6/bwfOP71+41l84UZr3QqQ524Q+aBrPTs1nW0Ak/tG1epqtIN+er/PTGiAjZ
qj1Pg8fEM8MUpm6J2263
=C7lc
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
