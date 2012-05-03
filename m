Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:53080 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758121Ab2ECTCG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 May 2012 15:02:06 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 50634975D0
	for <util-linux@vger.kernel.org>; Thu,  3 May 2012 21:02:05 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 04/15] uuidd: implement --no-pid option
Date: Thu,  3 May 2012 21:01:50 +0200
Message-Id: <1336071721-32492-5-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
References: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

With this option, uuidd does not create the PID file.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/uuidd.8 |    3 +++
 misc-utils/uuidd.c |   48 ++++++++++++++++++++++++++++++++++++------------
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/misc-utils/uuidd.8 b/misc-utils/uuidd.8
index 8e82b10..07e533b 100644
--- a/misc-utils/uuidd.8
+++ b/misc-utils/uuidd.8
@@ -36,6 +36,9 @@ UUIDs.
 Specify the pathname where the pid file should be written.  By default,
 the pid file is written to /var/run/uuidd/uuidd.pid.
 .TP
+.BR \-P , " \-\-no-pid "
+Do not create pid file.
+.TP
 .B \-q
 Suppress some failure messages.
 .TP
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 704c9e9..be3e3cf 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -64,6 +64,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 		" -r, --random        test random-based generation\n"
 		" -t, --time          test time-based generation\n"
 		" -n, --uuids <num>   request number of uuids\n"
+		" -P, --no-pid        do not create pid file\n"
 		" -d, --debug         run in debugging mode\n"
 		" -q, --quiet         turn on quiet mode\n"
 		" -V, --version       output version information and exit\n"
@@ -112,7 +113,8 @@ static const char *cleanup_pidfile, *cleanup_socket;
 
 static void terminate_intr(int signo CODE_ATTR((unused)))
 {
-	unlink(cleanup_pidfile);
+	if (cleanup_pidfile)
+		unlink(cleanup_pidfile);
 	if (cleanup_socket)
 		unlink(cleanup_socket);
 	exit(EXIT_SUCCESS);
@@ -256,12 +258,14 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 	char			reply_buf[1024], *cp;
 	char			op, str[UUID_STR_LEN];
 	int			i, s, ns, len, num;
-	int			fd_pidfile, ret;
+	int			fd_pidfile = -1;
+	int			ret;
 
 	signal(SIGALRM, terminate_intr);
 	alarm(30);
 
-	fd_pidfile = create_pidfile(pidfile_path, quiet);
+	if (pidfile_path)
+		fd_pidfile = create_pidfile(pidfile_path, quiet);
 
 	ret = call_daemon(socket_path, UUIDD_OP_GETPID, reply_buf, sizeof(reply_buf), 0, NULL);
 	if (ret > 0) {
@@ -321,13 +325,15 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 	signal(SIGALRM, terminate_intr);
 	signal(SIGPIPE, SIG_IGN);
 
-	sprintf(reply_buf, "%8d\n", getpid());
-	if (ftruncate(fd_pidfile, 0)) {
-		/* Silence warn_unused_result */
+	if (pidfile_path) {
+		sprintf(reply_buf, "%8d\n", getpid());
+		if (ftruncate(fd_pidfile, 0)) {
+			/* Silence warn_unused_result */
+		}
+		write_all(fd_pidfile, reply_buf, strlen(reply_buf));
+		if (fd_pidfile > 1)
+			close(fd_pidfile); /* Unlock the pid file */
 	}
-	write_all(fd_pidfile, reply_buf, strlen(reply_buf));
-	if (fd_pidfile > 1)
-		close(fd_pidfile); /* Unlock the pid file */
 
 	while (1) {
 		fromlen = sizeof(from_addr);
@@ -446,7 +452,8 @@ static void __attribute__ ((__noreturn__)) unexpected_size(int size)
 int main(int argc, char **argv)
 {
 	const char	*socket_path = UUIDD_SOCKET_PATH;
-	const char	*pidfile_path = UUIDD_PIDFILE_PATH;
+	const char	*pidfile_path = NULL;
+	const char	*pidfile_path_param = NULL;
 	const char	*err_context;
 	char		buf[1024], *cp;
 	char		str[UUID_STR_LEN], *tmp;
@@ -456,6 +463,7 @@ int main(int argc, char **argv)
 	int		i, c, ret;
 	int		debug = 0, do_type = 0, do_kill = 0, num = 0;
 	int		timeout = 0, quiet = 0, drop_privs = 0;
+	int		no_pid = 0;
 
 	static const struct option longopts[] = {
 		{"pid", required_argument, NULL, 'p'},
@@ -465,6 +473,7 @@ int main(int argc, char **argv)
 		{"random", no_argument, NULL, 'r'},
 		{"time", no_argument, NULL, 't'},
 		{"uuids", required_argument, NULL, 'n'},
+		{"no-pid", no_argument, NULL, 'P'},
 		{"debug", no_argument, NULL, 'd'},
 		{"quiet", no_argument, NULL, 'q'},
 		{"version", no_argument, NULL, 'V'},
@@ -478,7 +487,7 @@ int main(int argc, char **argv)
 	atexit(close_stdout);
 
 	while ((c =
-		getopt_long(argc, argv, "p:s:T:krtn:dqVh", longopts,
+		getopt_long(argc, argv, "p:s:T:krtn:PdqVh", longopts,
 			    NULL)) != -1) {
 		switch (c) {
 		case 'd':
@@ -497,7 +506,11 @@ int main(int argc, char **argv)
 			}
 			break;
 		case 'p':
-			pidfile_path = optarg;
+			pidfile_path_param = optarg;
+			drop_privs = 1;
+			break;
+		case 'P':
+			no_pid = 1;
 			drop_privs = 1;
 			break;
 		case 'q':
@@ -533,6 +546,17 @@ int main(int argc, char **argv)
 			usage(stderr);
 		}
 	}
+
+	if (no_pid && pidfile_path_param && !quiet)
+		fprintf(stderr, _("Both --pid and --no-pid specified. "
+				  "Ignoring --no-pid.\n"));
+
+	if (!no_pid && !pidfile_path_param)
+		pidfile_path = UUIDD_PIDFILE_PATH;
+	else if (pidfile_path_param)
+		pidfile_path = pidfile_path_param;
+
+
 	uid = getuid();
 	if (uid && drop_privs) {
 		gid = getgid();
-- 
1.7.7

