Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50606 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759093Ab2C2Qpf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Mar 2012 12:45:35 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 50AE78FB75
	for <util-linux@vger.kernel.org>; Thu, 29 Mar 2012 18:45:34 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 06/20] uuidd: factor out socket creation into separate function
Date: Thu, 29 Mar 2012 18:45:14 +0200
Message-Id: <1333039528-24784-7-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/uuidd.c |   74 ++++++++++++++++++++++++++++++++-------------------
 1 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index c5886fd..a135816 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -247,34 +247,20 @@ static int create_pidfile(const char *pidfile_path, int quiet)
 	return fd_pidfile;
 }
 
-static void server_loop(const char *socket_path, const char *pidfile_path,
-			int debug, int timeout, int quiet, int no_fork)
+/*
+ * Create AF_UNIX, SOCK_STREAM socket and bind to @socket_path
+ *
+ * If @will_fork is true, then make sure the descriptor
+ * of the socket is >2, so that it wont be later closed
+ * during create_daemon().
+ *
+ * Return file descriptor corresponding to created socket.
+ */
+static int create_socket(const char *socket_path, int will_fork, int quiet)
 {
-	struct sockaddr_un	my_addr, from_addr;
-	socklen_t		fromlen;
-	int32_t			reply_len = 0;
-	uuid_t			uu;
+	struct sockaddr_un	my_addr;
 	mode_t			save_umask;
-	char			reply_buf[1024], *cp;
-	char			op, str[UUID_STR_LEN];
-	int			i, s, ns, len, num;
-	int			fd_pidfile = -1;
-	int			ret;
-
-	signal(SIGALRM, terminate_intr);
-	alarm(30);
-
-	if (pidfile_path)
-		fd_pidfile = create_pidfile(pidfile_path, quiet);
-
-	ret = call_daemon(socket_path, UUIDD_OP_GETPID, reply_buf, sizeof(reply_buf), 0, NULL);
-	if (ret > 0) {
-		if (!quiet)
-			printf(_("uuidd daemon already running at pid %s\n"),
-			       reply_buf);
-		exit(EXIT_FAILURE);
-	}
-	alarm(0);
+	int 			s;
 
 	if ((s = socket(AF_UNIX, SOCK_STREAM, 0)) < 0) {
 		if (!quiet)
@@ -286,7 +272,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 	 * Make sure the socket isn't using fd numbers 0-2 to avoid it
 	 * getting closed by create_daemon()
 	 */
-	while ((!debug || no_fork) && s <= 2) {
+	while (will_fork && s <= 2) {
 		s = dup(s);
 		if (s < 0)
 			err(EXIT_FAILURE, "dup");
@@ -308,7 +294,40 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 		exit(EXIT_FAILURE);
 	}
 	umask(save_umask);
+	cleanup_socket = socket_path;
 
+	return s;
+}
+
+static void server_loop(const char *socket_path, const char *pidfile_path,
+			int debug, int timeout, int quiet, int no_fork)
+{
+	struct sockaddr_un	from_addr;
+	socklen_t		fromlen;
+	int32_t			reply_len = 0;
+	uuid_t			uu;
+	char			reply_buf[1024], *cp;
+	char			op, str[UUID_STR_LEN];
+	int			i, s, ns, len, num;
+	int			fd_pidfile = -1;
+	int			ret;
+
+	signal(SIGALRM, terminate_intr);
+	alarm(30);
+
+	if (pidfile_path)
+		fd_pidfile = create_pidfile(pidfile_path, quiet);
+
+	ret = call_daemon(socket_path, UUIDD_OP_GETPID, reply_buf, sizeof(reply_buf), 0, NULL);
+	if (ret > 0) {
+		if (!quiet)
+			printf(_("uuidd daemon already running at pid %s\n"),
+			       reply_buf);
+		exit(EXIT_FAILURE);
+	}
+	alarm(0);
+
+	s = create_socket(socket_path, (!debug || !no_fork), quiet);
 	if (listen(s, SOMAXCONN) < 0) {
 		if (!quiet)
 			fprintf(stderr, _("Couldn't listen on unix "
@@ -316,7 +335,6 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 		exit(EXIT_FAILURE);
 	}
 
-	cleanup_socket = socket_path;
 	if (!debug && !no_fork)
 		create_daemon();
 	signal(SIGHUP, terminate_intr);
-- 
1.7.7

