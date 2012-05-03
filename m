Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:53079 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758173Ab2ECTCF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 May 2012 15:02:05 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 96A8E979ED
	for <util-linux@vger.kernel.org>; Thu,  3 May 2012 21:02:04 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 03/15] uuidd: factor out pidfile creation into separate function
Date: Thu,  3 May 2012 21:01:49 +0200
Message-Id: <1336071721-32492-4-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
References: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Introduce create_pidfile() function.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/uuidd.c |   48 ++++++++++++++++++++++++++++++++++--------------
 1 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 0d844fb..704c9e9 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -207,19 +207,18 @@ static int call_daemon(const char *socket_path, int op, char *buf,
 	return ret;
 }
 
-static void server_loop(const char *socket_path, const char *pidfile_path,
-			int debug, int timeout, int quiet)
+/*
+ * Exclusively create and open a pid file with path @pidfile_path
+ *
+ * Set cleanup_pidfile global variable for the cleanup
+ * handler. @pidfile_path must not be NULL.
+ *
+ * Return file descriptor of the created pid_file.
+ */
+static int create_pidfile(const char *pidfile_path, int quiet)
 {
-	struct sockaddr_un	my_addr, from_addr;
-	struct flock		fl;
-	socklen_t		fromlen;
-	int32_t			reply_len = 0;
-	uuid_t			uu;
-	mode_t			save_umask;
-	char			reply_buf[1024], *cp;
-	char			op, str[UUID_STR_LEN];
-	int			i, s, ns, len, num;
-	int			fd_pidfile, ret;
+	int		fd_pidfile;
+	struct flock	fl;
 
 	fd_pidfile = open(pidfile_path, O_CREAT | O_RDWR, 0664);
 	if (fd_pidfile < 0) {
@@ -229,8 +228,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 		exit(EXIT_FAILURE);
 	}
 	cleanup_pidfile = pidfile_path;
-	signal(SIGALRM, terminate_intr);
-	alarm(30);
+
 	fl.l_type = F_WRLCK;
 	fl.l_whence = SEEK_SET;
 	fl.l_start = 0;
@@ -243,6 +241,28 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			fprintf(stderr, _("Failed to lock %s: %m\n"), pidfile_path);
 		exit(EXIT_FAILURE);
 	}
+
+	return fd_pidfile;
+}
+
+static void server_loop(const char *socket_path, const char *pidfile_path,
+			int debug, int timeout, int quiet)
+{
+	struct sockaddr_un	my_addr, from_addr;
+	socklen_t		fromlen;
+	int32_t			reply_len = 0;
+	uuid_t			uu;
+	mode_t			save_umask;
+	char			reply_buf[1024], *cp;
+	char			op, str[UUID_STR_LEN];
+	int			i, s, ns, len, num;
+	int			fd_pidfile, ret;
+
+	signal(SIGALRM, terminate_intr);
+	alarm(30);
+
+	fd_pidfile = create_pidfile(pidfile_path, quiet);
+
 	ret = call_daemon(socket_path, UUIDD_OP_GETPID, reply_buf, sizeof(reply_buf), 0, NULL);
 	if (ret > 0) {
 		if (!quiet)
-- 
1.7.7

