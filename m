Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:53098 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758222Ab2ECTCN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 May 2012 15:02:13 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id A5B65979ED
	for <util-linux@vger.kernel.org>; Thu,  3 May 2012 21:02:12 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 14/15] uuidd: introduce uuidd_cxt to pass arguments to server loop
Date: Thu,  3 May 2012 21:02:00 +0200
Message-Id: <1336071721-32492-15-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
References: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/uuidd.c |   56 +++++++++++++++++++++++++++++++++------------------
 1 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 684e494..d20526e 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -55,6 +55,15 @@ extern int optind;
 /* length of binary representation of UUID */
 #define UUID_LEN	(sizeof(uuid_t))
 
+/* server loop control structure */
+struct uuidd_cxt_t {
+	int	timeout;
+	unsigned int	debug: 1,
+			quiet: 1,
+			no_fork: 1,
+			no_sock: 1;
+};
+
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fputs(_("\nUsage:\n"), out);
@@ -307,8 +316,7 @@ static int create_socket(const char *socket_path, int will_fork, int quiet)
 }
 
 static void server_loop(const char *socket_path, const char *pidfile_path,
-			int debug, int timeout, int quiet, int no_fork,
-			int no_sock)
+			const struct uuidd_cxt_t *uuidd_cxt)
 {
 	struct sockaddr_un	from_addr;
 	socklen_t		fromlen;
@@ -322,19 +330,19 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 	int			ret;
 
 #ifdef USE_SOCKET_ACTIVATION
-	if (!no_sock)	/* no_sock implies no_fork and no_pid */
+	if (!uuidd_cxt->no_sock)	/* no_sock implies no_fork and no_pid */
 #endif
 	{
 
 		signal(SIGALRM, terminate_intr);
 		alarm(30);
 		if (pidfile_path)
-			fd_pidfile = create_pidfile(pidfile_path, quiet);
+			fd_pidfile = create_pidfile(pidfile_path, uuidd_cxt->quiet);
 
 		ret = call_daemon(socket_path, UUIDD_OP_GETPID, reply_buf,
 				  sizeof(reply_buf), 0, NULL);
 		if (ret > 0) {
-			if (!quiet)
+			if (!uuidd_cxt->quiet)
 				fprintf(stderr,
 					_("uuidd daemon already running at pid %s\n"),
 				       reply_buf);
@@ -342,15 +350,17 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 		}
 		alarm(0);
 
-		s = create_socket(socket_path, (!debug || !no_fork), quiet);
+		s = create_socket(socket_path,
+				  (!uuidd_cxt->debug || !uuidd_cxt->no_fork),
+				  uuidd_cxt->quiet);
 		if (listen(s, SOMAXCONN) < 0) {
-			if (!quiet)
+			if (!uuidd_cxt->quiet)
 				fprintf(stderr, _("Couldn't listen on unix "
 						  "socket %s: %m\n"), socket_path);
 			exit(EXIT_FAILURE);
 		}
 
-		if (!debug && !no_fork)
+		if (!uuidd_cxt->debug && !uuidd_cxt->no_fork)
 			create_daemon();
 
 		if (pidfile_path) {
@@ -370,7 +380,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 	signal(SIGPIPE, SIG_IGN);
 
 #ifdef USE_SOCKET_ACTIVATION
-	if (no_sock) {
+	if (uuidd_cxt->no_sock) {
 		if (sd_listen_fds(0) != 1) {
 			fprintf(stderr, _("No or too many file descriptors received.\n"));
 			exit(EXIT_FAILURE);
@@ -382,8 +392,8 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 
 	while (1) {
 		fromlen = sizeof(from_addr);
-		if (timeout > 0)
-			alarm(timeout);
+		if (uuidd_cxt->timeout > 0)
+			alarm(uuidd_cxt->timeout);
 		ns = accept(s, (struct sockaddr *) &from_addr, &fromlen);
 		alarm(0);
 		if (ns < 0) {
@@ -405,10 +415,10 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 		    (op == UUIDD_OP_BULK_RANDOM_UUID)) {
 			if (read_all(ns, (char *) &num, sizeof(num)) != 4)
 				goto shutdown_socket;
-			if (debug)
+			if (uuidd_cxt->debug)
 				fprintf(stderr, _("operation %d, incoming num = %d\n"),
 				       op, num);
-		} else if (debug)
+		} else if (uuidd_cxt->debug)
 			fprintf(stderr, _("operation %d\n"), op);
 
 		switch (op) {
@@ -423,7 +433,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 		case UUIDD_OP_TIME_UUID:
 			num = 1;
 			__uuid_generate_time(uu, &num);
-			if (debug) {
+			if (uuidd_cxt->debug) {
 				uuid_unparse(uu, str);
 				fprintf(stderr, _("Generated time UUID: %s\n"), str);
 			}
@@ -433,7 +443,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 		case UUIDD_OP_RANDOM_UUID:
 			num = 1;
 			__uuid_generate_random(uu, &num);
-			if (debug) {
+			if (uuidd_cxt->debug) {
 				uuid_unparse(uu, str);
 				fprintf(stderr, _("Generated random UUID: %s\n"), str);
 			}
@@ -442,7 +452,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			break;
 		case UUIDD_OP_BULK_TIME_UUID:
 			__uuid_generate_time(uu, &num);
-			if (debug) {
+			if (uuidd_cxt->debug) {
 				uuid_unparse(uu, str);
 				fprintf(stderr, P_("Generated time UUID %s "
 						   "and %d following\n",
@@ -464,7 +474,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 				num = (sizeof(reply_buf) - sizeof(num)) / UUID_LEN;
 			__uuid_generate_random((unsigned char *) reply_buf +
 					      sizeof(num), &num);
-			if (debug) {
+			if (uuidd_cxt->debug) {
 				fprintf(stderr, P_("Generated %d UUID:\n",
 						   "Generated %d UUIDs:\n", num), num);
 				for (i = 0, cp = reply_buf + sizeof(num);
@@ -478,7 +488,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			memcpy(reply_buf, &num, sizeof(num));
 			break;
 		default:
-			if (debug)
+			if (uuidd_cxt->debug)
 				fprintf(stderr, _("Invalid operation %d\n"), op);
 			goto shutdown_socket;
 		}
@@ -508,6 +518,7 @@ int main(int argc, char **argv)
 	int		timeout = 0, quiet = 0;
 	int		no_pid = 0, no_fork = 0;
 	int		no_sock = 0, s_flag = 0;
+	struct uuidd_cxt_t uuidd_cxt;
 
 	static const struct option longopts[] = {
 		{"pid", required_argument, NULL, 'p'},
@@ -677,7 +688,12 @@ int main(int argc, char **argv)
 		return EXIT_SUCCESS;
 	}
 
-	server_loop(socket_path, pidfile_path, debug, timeout, quiet, no_fork,
-		    no_sock);
+	uuidd_cxt.timeout = timeout;
+	uuidd_cxt.debug = debug;
+	uuidd_cxt.quiet = quiet;
+	uuidd_cxt.no_fork = no_fork;
+	uuidd_cxt.no_sock = no_sock;
+
+	server_loop(socket_path, pidfile_path, &uuidd_cxt);
 	return EXIT_SUCCESS;
 }
-- 
1.7.7

