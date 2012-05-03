Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:53082 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758214Ab2ECTCH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 May 2012 15:02:07 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id ACCAF975D0
	for <util-linux@vger.kernel.org>; Thu,  3 May 2012 21:02:06 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 06/15] uuidd: implement --no-fork option
Date: Thu,  3 May 2012 21:01:52 +0200
Message-Id: <1336071721-32492-7-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
References: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

With this option, uuidd does not daemonize itself but stays
in the foreground.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/uuidd.8 |    3 +++
 misc-utils/uuidd.c |   18 ++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/misc-utils/uuidd.8 b/misc-utils/uuidd.8
index 07e533b..e3ccf6f 100644
--- a/misc-utils/uuidd.8
+++ b/misc-utils/uuidd.8
@@ -39,6 +39,9 @@ the pid file is written to /var/run/uuidd/uuidd.pid.
 .BR \-P , " \-\-no-pid "
 Do not create pid file.
 .TP
+.BR \-F , " \-\-no-fork "
+Do not daemonize using double-fork.
+.TP
 .B \-q
 Suppress some failure messages.
 .TP
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 50ae61f..5e86077 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -66,6 +66,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 		" -t, --time          test time-based generation\n"
 		" -n, --uuids <num>   request number of uuids\n"
 		" -P, --no-pid        do not create pid file\n"
+		" -F, --no-fork       do not daemonize using double-fork\n"
 		" -d, --debug         run in debugging mode\n"
 		" -q, --quiet         turn on quiet mode\n"
 		" -V, --version       output version information and exit\n"
@@ -249,7 +250,7 @@ static int create_pidfile(const char *pidfile_path, int quiet)
 }
 
 static void server_loop(const char *socket_path, const char *pidfile_path,
-			int debug, int timeout, int quiet)
+			int debug, int timeout, int quiet, int no_fork)
 {
 	struct sockaddr_un	my_addr, from_addr;
 	socklen_t		fromlen;
@@ -287,7 +288,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 	 * Make sure the socket isn't using fd numbers 0-2 to avoid it
 	 * getting closed by create_daemon()
 	 */
-	while (!debug && s <= 2) {
+	while ((!debug || no_fork) && s <= 2) {
 		s = dup(s);
 		if (s < 0)
 			err(EXIT_FAILURE, "dup");
@@ -318,7 +319,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 	}
 
 	cleanup_socket = socket_path;
-	if (!debug)
+	if (!debug && !no_fork)
 		create_daemon();
 	signal(SIGHUP, terminate_intr);
 	signal(SIGINT, terminate_intr);
@@ -462,7 +463,7 @@ int main(int argc, char **argv)
 	int		i, c, ret;
 	int		debug = 0, do_type = 0, do_kill = 0, num = 0;
 	int		timeout = 0, quiet = 0, drop_privs = 0;
-	int		no_pid = 0;
+	int		no_pid = 0, no_fork = 0;
 
 	static const struct option longopts[] = {
 		{"pid", required_argument, NULL, 'p'},
@@ -473,6 +474,7 @@ int main(int argc, char **argv)
 		{"time", no_argument, NULL, 't'},
 		{"uuids", required_argument, NULL, 'n'},
 		{"no-pid", no_argument, NULL, 'P'},
+		{"no-fork", no_argument, NULL, 'F'},
 		{"debug", no_argument, NULL, 'd'},
 		{"quiet", no_argument, NULL, 'q'},
 		{"version", no_argument, NULL, 'V'},
@@ -486,7 +488,7 @@ int main(int argc, char **argv)
 	atexit(close_stdout);
 
 	while ((c =
-		getopt_long(argc, argv, "p:s:T:krtn:PdqVh", longopts,
+		getopt_long(argc, argv, "p:s:T:krtn:PFdqVh", longopts,
 			    NULL)) != -1) {
 		switch (c) {
 		case 'd':
@@ -512,6 +514,10 @@ int main(int argc, char **argv)
 			no_pid = 1;
 			drop_privs = 1;
 			break;
+		case 'F':
+			no_fork = 1;
+			drop_privs = 1;
+			break;
 		case 'q':
 			quiet++;
 			break;
@@ -637,6 +643,6 @@ int main(int argc, char **argv)
 		return EXIT_SUCCESS;
 	}
 
-	server_loop(socket_path, pidfile_path, debug, timeout, quiet);
+	server_loop(socket_path, pidfile_path, debug, timeout, quiet, no_fork);
 	return EXIT_SUCCESS;
 }
-- 
1.7.7

