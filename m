Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35672 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbbJCSbP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 Oct 2015 14:31:15 -0400
Received: by wicge5 with SMTP id ge5so71214958wic.0
        for <util-linux@vger.kernel.org>; Sat, 03 Oct 2015 11:31:13 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/4] uuidd: use signalfd() and setup_timer()
Date: Sat,  3 Oct 2015 19:31:06 +0100
Message-Id: <1443897067-6005-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1443897067-6005-1-git-send-email-kerolasa@iki.fi>
References: <1443897067-6005-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Point of this change is to replace use of signal() and alarm() system calls
using newer interfaces.  Nice side effect is that the point where timer was
earlier used cannot be distracted by sending rogue SIGALRM.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/Makemodule.am |   4 +-
 misc-utils/uuidd.c       | 135 +++++++++++++++++++++++++++++++++--------------
 2 files changed, 98 insertions(+), 41 deletions(-)

diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index e017952..bc1c346 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -90,10 +90,10 @@ endif
 if BUILD_UUIDD
 usrsbin_exec_PROGRAMS += uuidd
 dist_man_MANS += misc-utils/uuidd.8
-uuidd_LDADD = $(LDADD) libuuid.la libcommon.la
+uuidd_LDADD = $(LDADD) libuuid.la libcommon.la -lrt
 uuidd_CFLAGS = $(DAEMON_CFLAGS) $(AM_CFLAGS) -I$(ul_libuuid_incdir)
 uuidd_LDFLAGS = $(DAEMON_LDFLAGS) $(AM_LDFLAGS)
-uuidd_SOURCES = misc-utils/uuidd.c
+uuidd_SOURCES = misc-utils/uuidd.c lib/monotonic.c lib/timer.c
 if HAVE_SYSTEMD
 uuidd_LDADD += $(SYSTEMD_LIBS) $(SYSTEMD_DAEMON_LIBS)
 uuidd_CFLAGS += $(SYSTEMD_CFLAGS) $(SYSTEMD_DAEMON_CFLAGS)
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index e19be52..c897372 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -22,6 +22,8 @@
 #include <signal.h>
 #include <string.h>
 #include <getopt.h>
+#include <sys/signalfd.h>
+#include <poll.h>
 
 #include "uuid.h"
 #include "uuidd.h"
@@ -30,6 +32,8 @@
 #include "closestream.h"
 #include "strutils.h"
 #include "optutils.h"
+#include "monotonic.h"
+#include "timer.h"
 
 #ifdef HAVE_LIBSYSTEMD
 # include <systemd/sd-daemon.h>
@@ -51,6 +55,8 @@
 
 /* server loop control structure */
 struct uuidd_cxt_t {
+	const char	*cleanup_pidfile;
+	const char	*cleanup_socket;
 	uint32_t	timeout;
 	unsigned int	debug: 1,
 			quiet: 1,
@@ -96,17 +102,6 @@ static void create_daemon(void)
 		err(EXIT_FAILURE, "setreuid");
 }
 
-static const char *cleanup_pidfile, *cleanup_socket;
-
-static void terminate_intr(int signo CODE_ATTR((unused)))
-{
-	if (cleanup_pidfile)
-		unlink(cleanup_pidfile);
-	if (cleanup_socket)
-		unlink(cleanup_socket);
-	exit(EXIT_SUCCESS);
-}
-
 static int call_daemon(const char *socket_path, int op, char *buf,
 		       size_t buflen, int *num, const char **err_context)
 {
@@ -199,12 +194,10 @@ static int call_daemon(const char *socket_path, int op, char *buf,
 /*
  * Exclusively create and open a pid file with path @pidfile_path
  *
- * Set cleanup_pidfile global variable for the cleanup
- * handler. @pidfile_path must not be NULL.
- *
  * Return file descriptor of the created pid_file.
  */
-static int create_pidfile(const char *pidfile_path, int quiet)
+static int create_pidfile(struct uuidd_cxt_t *uuidd_cxt,
+			  const char *pidfile_path, int quiet)
 {
 	int		fd_pidfile;
 	struct flock	fl;
@@ -215,7 +208,7 @@ static int create_pidfile(const char *pidfile_path, int quiet)
 			warn(_("cannot open %s"), pidfile_path);
 		exit(EXIT_FAILURE);
 	}
-	cleanup_pidfile = pidfile_path;
+	uuidd_cxt->cleanup_pidfile = pidfile_path;
 
 	fl.l_type = F_WRLCK;
 	fl.l_whence = SEEK_SET;
@@ -242,14 +235,15 @@ static int create_pidfile(const char *pidfile_path, int quiet)
  *
  * Return file descriptor corresponding to created socket.
  */
-static int create_socket(const char *socket_path, int will_fork, int quiet)
+static int create_socket(struct uuidd_cxt_t *uuidd_cxt,
+			 const char *socket_path, int will_fork)
 {
 	struct sockaddr_un	my_addr;
 	mode_t			save_umask;
 	int 			s;
 
 	if ((s = socket(AF_UNIX, SOCK_STREAM, 0)) < 0) {
-		if (!quiet)
+		if (!uuidd_cxt->quiet)
 			warn(_("couldn't create unix stream socket"));
 		exit(EXIT_FAILURE);
 	}
@@ -274,18 +268,52 @@ static int create_socket(const char *socket_path, int will_fork, int quiet)
 	save_umask = umask(0);
 	if (bind(s, (const struct sockaddr *) &my_addr,
 		 sizeof(struct sockaddr_un)) < 0) {
-		if (!quiet)
+		if (!uuidd_cxt->quiet)
 			warn(_("couldn't bind unix socket %s"), socket_path);
 		exit(EXIT_FAILURE);
 	}
 	umask(save_umask);
-	cleanup_socket = socket_path;
+	uuidd_cxt->cleanup_socket = socket_path;
 
 	return s;
 }
 
+static void __attribute__((__noreturn__)) all_done(const struct uuidd_cxt_t *uuidd_cxt, int ret)
+{
+	if (uuidd_cxt->cleanup_pidfile)
+		unlink(uuidd_cxt->cleanup_pidfile);
+	if (uuidd_cxt->cleanup_socket)
+		unlink(uuidd_cxt->cleanup_socket);
+	exit(ret);
+}
+
+static void handle_signal(const struct uuidd_cxt_t *uuidd_cxt, int fd)
+{
+	struct signalfd_siginfo info;
+	ssize_t bytes;
+
+	bytes = read(fd, &info, sizeof(info));
+	if (bytes != sizeof(info)) {
+		if (errno == EAGAIN)
+			return;
+		warn(_("receiving signal failed"));
+		info.ssi_signo = 0;
+	}
+	if (info.ssi_signo == SIGPIPE)
+		return;		/* ignored */
+	all_done(uuidd_cxt, EXIT_SUCCESS);
+}
+
+static void timeout_handler(int sig __attribute__((__unused__)),
+			    siginfo_t * info,
+			    void *context __attribute__((__unused__)))
+{
+	if (info->si_code == SI_TIMER)
+		errx(EXIT_FAILURE, _("timed out"));
+}
+
 static void server_loop(const char *socket_path, const char *pidfile_path,
-			const struct uuidd_cxt_t *uuidd_cxt)
+			struct uuidd_cxt_t *uuidd_cxt)
 {
 	struct sockaddr_un	from_addr;
 	socklen_t		fromlen;
@@ -297,30 +325,39 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 	int			s = 0;
 	int			fd_pidfile = -1;
 	int			ret;
+	struct pollfd 		pfd[2];
+	sigset_t		sigmask;
+	int			sigfd;
+	enum {
+				POLLFD_SIGNAL = 0,
+				POLLFD_SOCKET
+	};
 
 #ifdef HAVE_LIBSYSTEMD
 	if (!uuidd_cxt->no_sock)	/* no_sock implies no_fork and no_pid */
 #endif
 	{
+		static timer_t t_id;
+		struct itimerval timeout;
 
-		signal(SIGALRM, terminate_intr);
-		alarm(30);
+		memset(&timeout, 0, sizeof timeout);
+		timeout.it_value.tv_sec = 30;
+		if (setup_timer(&t_id, &timeout, &timeout_handler))
+			err(EXIT_FAILURE, _("cannot not setup timer"));
 		if (pidfile_path)
-			fd_pidfile = create_pidfile(pidfile_path, uuidd_cxt->quiet);
-
+			fd_pidfile = create_pidfile(uuidd_cxt, pidfile_path, uuidd_cxt->quiet);
 		ret = call_daemon(socket_path, UUIDD_OP_GETPID, reply_buf,
 				  sizeof(reply_buf), 0, NULL);
+		cancel_timer(&t_id);
 		if (ret > 0) {
 			if (!uuidd_cxt->quiet)
 				warnx(_("uuidd daemon is already running at pid %s"),
-				       reply_buf);
+					reply_buf);
 			exit(EXIT_FAILURE);
 		}
-		alarm(0);
 
-		s = create_socket(socket_path,
-				  (!uuidd_cxt->debug || !uuidd_cxt->no_fork),
-				  uuidd_cxt->quiet);
+		s = create_socket(uuidd_cxt, socket_path,
+				  (!uuidd_cxt->debug || !uuidd_cxt->no_fork));
 		if (listen(s, SOMAXCONN) < 0) {
 			if (!uuidd_cxt->quiet)
 				warn(_("couldn't listen on unix socket %s"), socket_path);
@@ -342,12 +379,6 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 
 	}
 
-	signal(SIGHUP, terminate_intr);
-	signal(SIGINT, terminate_intr);
-	signal(SIGTERM, terminate_intr);
-	signal(SIGALRM, terminate_intr);
-	signal(SIGPIPE, SIG_IGN);
-
 #ifdef HAVE_LIBSYSTEMD
 	if (uuidd_cxt->no_sock) {
 		const int ret = sd_listen_fds(0);
@@ -365,12 +396,38 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 	}
 #endif
 
+	sigemptyset(&sigmask);
+	sigaddset(&sigmask, SIGHUP);
+	sigaddset(&sigmask, SIGINT);
+	sigaddset(&sigmask, SIGTERM);
+	sigaddset(&sigmask, SIGALRM);
+	sigaddset(&sigmask, SIGPIPE);
+	/* Block signals so that they aren't handled according to their
+	 * default dispositions */
+	sigprocmask(SIG_BLOCK, &sigmask, NULL);
+	if ((sigfd = signalfd(-1, &sigmask, 0)) < 0)
+		err(EXIT_FAILURE, _("cannot set signal handler"));
+
+	pfd[POLLFD_SIGNAL].fd = sigfd;
+	pfd[POLLFD_SOCKET].fd = s;
+	pfd[POLLFD_SIGNAL].events = pfd[POLLFD_SOCKET].events = POLLIN | POLLERR | POLLHUP;
+
 	while (1) {
+		ret = poll(pfd, ARRAY_SIZE(pfd), (uuidd_cxt->timeout == 0 ? -1 : uuidd_cxt->timeout * 1000));
+		if (ret < 0) {
+			if (errno == EAGAIN)
+				continue;
+			warn(_("poll failed"));
+				all_done(uuidd_cxt, EXIT_FAILURE);
+		}
+		if (ret == 0)		/* truen when poll() times out */
+			all_done(uuidd_cxt, EXIT_SUCCESS);
+		if (pfd[POLLFD_SIGNAL].revents != 0)
+			handle_signal(uuidd_cxt, sigfd);
+		if (pfd[POLLFD_SOCKET].revents == 0)
+			continue;
 		fromlen = sizeof(from_addr);
-		if (uuidd_cxt->timeout != 0)
-			alarm(uuidd_cxt->timeout);
 		ns = accept(s, (struct sockaddr *) &from_addr, &fromlen);
-		alarm(0);
 		if (ns < 0) {
 			if ((errno == EAGAIN) || (errno == EINTR))
 				continue;
-- 
2.6.0

