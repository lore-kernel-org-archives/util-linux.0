Return-Path: util-linux-owner@vger.kernel.org
Received: from charybdis-ext.suse.de ([195.135.221.2]:54505 "EHLO
	boole.suse.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751017AbcBKMfb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 11 Feb 2016 07:35:31 -0500
From: Werner Fink <werner@suse.de>
To: util-linux@vger.kernel.org
Cc: Werner Fink <werner@suse.de>
Subject: [PATCH] Sulogin: avoid shared memory area usemask but use waitid() for childs
Date: Thu, 11 Feb 2016 13:35:26 +0100
Message-Id: <1455194126-29497-1-git-send-email-werner@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This small patch improves the console detection code and also avoids not
existing device nodes due strdup() which is used in canonicalize_path().
Beside this now the code for emergeny mount does work if enabled at
configure time.

Signed-off-by: Werner Fink <werner@suse.de>
---
 login-utils/sulogin-consoles.c |  53 ++++++++++++++++-----
 login-utils/sulogin.c          | 104 ++++++++++++++++++++++++++++++-----------
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
 
 #ifdef USE_SULOGIN_EMERGENCY_MOUNT
@@ -226,6 +227,8 @@ dev_t devattr(const char *tty)
 
 /*
  * Search below /dev for the character device in `dev_t comparedev' variable.
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
 	char *name = NULL;
 	struct dirent *dent;
-	int fd;
+	int len, fd;
 
 	DBG(dbgprint("scanning /dev for %u:%u", major(comparedev), minor(comparedev)));
 
+	/*
+	 * Try udev links on character devices first.
+	 */
+	if ((len = snprintf(path, sizeof(path),
+			    "/dev/char/%u:%u", major(comparedev), minor(comparedev))) > 0 &&
+	    (size_t)len < sizeof(path)) {
+
+	    name = realpath(path, NULL);
+	    if (name)
+		    goto out;
+	}
+
 	fd = dirfd(dir);
 	rewinddir(dir);
 	while ((dent = readdir(dir))) {
-		char path[PATH_MAX];
 		struct stat st;
 
 #ifdef _DIRENT_HAVE_D_TYPE
@@ -255,17 +270,33 @@ char* scandev(DIR *dir, dev_t comparedev)
 			continue;
 		if (comparedev != st.st_rdev)
 			continue;
-		if ((size_t)snprintf(path, sizeof(path), "/dev/%s", dent->d_name) >= sizeof(path))
+		if ((len = snprintf(path, sizeof(path), "/dev/%s", dent->d_name)) < 0 ||
+		    (size_t)len >= sizeof(path))
 			continue;
-#ifdef USE_SULOGIN_EMERGENCY_MOUNT
-		if (emergency_flags & MNT_DEVTMPFS)
-			mknod(path, S_IFCHR|S_IRUSR|S_IWUSR, comparedev);
-#endif
 
-		name = canonicalize_path(path);
-		break;
+		name = realpath(path, NULL);
+		if (name)
+			goto out;
 	}
 
+#ifdef USE_SULOGIN_EMERGENCY_MOUNT
+	/*
+	 * There was no /dev mounted hence and no device was found hence we create our own.
+	 */
+	if (!name && (emergency_flags & MNT_DEVTMPFS)) {
+
+		if ((len = snprintf(path, sizeof(path),
+				    "/dev/tmp-%u:%u", major(comparedev), minor(comparedev))) < 0 ||
+		    (size_t)len >= sizeof(path))
+			goto out;
+
+		if (mknod(path, S_IFCHR|S_IRUSR|S_IWUSR, comparedev) < 0 && errno != EEXIST)
+			goto out;
+
+		name = realpath(path, NULL);
+	}
+#endif
+out:
 	return name;
 }
 
@@ -307,7 +338,7 @@ int append_console(struct list_head *consoles, const char *name)
 	tail->flags = 0;
 	tail->fd = -1;
 	tail->id = last ? last->id + 1 : 0;
-	tail->pid = 0;
+	tail->pid = -1;
 	memset(&tail->tio, 0, sizeof(tail->tio));
 
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
 	char *tty = NULL;
 	struct passwd *pwd;
-	int c, status = 0;
-	int reconnect = 0;
+	struct timespec sigwait = {0, 50000000};
+	siginfo_t status = {};
+	sigset_t set = {};
+	int c, reconnect = 0;
 	int opt_e = 0;
+	int wait = 0;
 	pid_t pid;
 
 	static const struct option longopts[] = {
@@ -985,9 +988,6 @@ int main(int argc, char **argv)
 		tcinit(con);
 	}
 	ptr = (&consoles)->next;
-	usemask = (uint32_t*) mmap(NULL, sizeof(uint32_t),
-					PROT_READ|PROT_WRITE,
-					MAP_ANONYMOUS|MAP_SHARED, -1, 0);
 
 	if (ptr->next == &consoles) {
 		con = list_entry(ptr, struct console, entry);
@@ -1033,9 +1033,7 @@ int main(int argc, char **argv)
 				}
 
 				if (doshell) {
-					*usemask |= (1<<con->id);
 					sushell(pwd);
-					*usemask &= ~(1<<con->id);
 					failed++;
 				}
 
@@ -1068,28 +1066,82 @@ int main(int argc, char **argv)
 
 	} while (ptr != &consoles);
 
-	while ((pid = wait(&status))) {
-		if (errno == ECHILD)
+	do {
+		int ret;
+
+		status.si_pid = 0;
+		ret = waitid(P_ALL, 0, &status, WEXITED);
+
+		if (ret == 0)
 			break;
-		if (pid < 0)
-			continue;
-		list_for_each(ptr, &consoles) {
-			con = list_entry(ptr, struct console, entry);
-			if (con->pid == pid) {
-				*usemask &= ~(1<<con->id);
+		if (ret < 0) {
+			if (errno == ECHILD)
+				break;
+			if (errno == EINTR)
 				continue;
-			}
-			if (kill(con->pid, 0) < 0) {
-				*usemask &= ~(1<<con->id);
+		}
+
+		errx(EXIT_FAILURE, _("Can not wait on su shell\n\n"));
+
+	} while (1);
+
+	list_for_each(ptr, &consoles) {
+		con = list_entry(ptr, struct console, entry);
+
+		if (con->fd < 0)
+			continue;
+		if (con->pid < 0)
+			continue;
+		if (con->pid == status.si_pid)
+			con->pid = -1;
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
+		status.si_pid = 0;
+		ret = waitid(P_ALL, 0, &status, WEXITED|WNOHANG);
+
+		if (ret < 0) {
+			if (errno == ECHILD)
+				break;
+			if (errno == EINTR)
 				continue;
+		}
+
+		if (!ret && status.si_pid > 0) {
+			list_for_each(ptr, &consoles) {
+				con = list_entry(ptr, struct console, entry);
+
+				if (con->fd < 0)
+					continue;
+				if (con->pid < 0)
+					continue;
+				if (con->pid == status.si_pid) {
+					con->pid = -1;
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
+		signum = sigtimedwait(&set, NULL, &sigwait);
+		if (signum != SIGCHLD) {
+			if (signum < 0 && errno == EAGAIN)
+				break;
+		}
+
+	} while (1);
 
 	mask_signal(SIGCHLD, SIG_DFL, NULL);
 	return EXIT_SUCCESS;
-- 
2.6.2

