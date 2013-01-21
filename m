Return-Path: util-linux-owner@vger.kernel.org
Received: from kawka.in.waw.pl ([178.63.212.103]:49926 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843Ab3AUGjy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Jan 2013 01:39:54 -0500
From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: util-linux@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 2/5] nsenter: add --all meaning all namespaces and cwd and root
Date: Mon, 21 Jan 2013 01:38:02 -0500
Message-Id: <1358750287-17732-3-git-send-email-zbyszek@in.waw.pl>
In-Reply-To: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl>
References: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I guess that most of the time one will want to enter all
namespaces, and then it is easier not to have to remember
all the option names.

Signed-off-by: Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl>
---
 sys-utils/nsenter.1 |  5 +++++
 sys-utils/nsenter.c | 42 ++++++++++++++++++++++++++++++------------
 2 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
index d133e1f..ab1a6f1 100644
--- a/sys-utils/nsenter.1
+++ b/sys-utils/nsenter.1
@@ -120,6 +120,11 @@ Enter the user namespace.  If no file is specified enter the user namespace of
 the target process.  If file is specified enter the user namespace specified by
 file.
 .TP
+\fB\-a\fR, \fB\-\-all\fR
+Set the root directory and enter the user, pid, net, IPC, uts, and mount namespaces
+of the target process (all namespaces listed above). In case of the user namespace,
+ignore failure to enter own namespace.
+.TP
 \fB\-r\fR, \fB\-\-root\fR [\fIdirectory\fR]
 Set the root directory.  If no directory is specified set the root directory to
 the root directory of the target process.  If directory is specified set the
diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index 1b57cc5..4ea3c09 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -71,9 +71,10 @@ static void usage(int status)
 		" -n, --net   [=<file>]  enter network namespace\n"
 		" -p, --pid   [=<file>]  enter pid namespace\n"
 		" -U, --user  [=<file>]  enter user namespace\n"
-		" -e, --exec             don't fork before exec'ing <program>\n"
 		" -r, --root  [=<dir>]   set the root directory\n"
-		" -w, --wd    [=<dir>]   set the working directory\n"), out);
+		" -w, --wd    [=<dir>]   set the working directory\n"
+		" -a, --all              set root and cwd and enter namespaces listed above\n"
+		" -e, --exec             don't fork before exec'ing <program>\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
@@ -167,16 +168,17 @@ int main(int argc, char *argv[])
 		{ "net", optional_argument, NULL, 'n' },
 		{ "pid", optional_argument, NULL, 'p' },
 		{ "user", optional_argument, NULL, 'U' },
-		{ "exec", no_argument, NULL, 'e' },
 		{ "root", optional_argument, NULL, 'r' },
 		{ "wd", optional_argument, NULL, 'w' },
+		{ "all", no_argument, NULL, 'a' },
+		{ "exec", no_argument, NULL, 'e' },
 		{ NULL, 0, NULL, 0 }
 	};
 
 	struct namespace_file *nsfile;
 	int do_fork = 0;
 	int c, namespaces = 0;
-	bool do_rd = false, do_wd = false;
+	bool do_rd = false, do_wd = false, all_used = false;
 
 	setlocale(LC_MESSAGES, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -184,7 +186,7 @@ int main(int argc, char *argv[])
 	atexit(close_stdout);
 
 	while ((c =
-		getopt_long(argc, argv, "hVt:m::u::i::n::p::U::er::w::",
+		getopt_long(argc, argv, "hVt:m::u::i::n::p::U::r::w::ae",
 			    longopts, NULL)) != -1) {
 		switch (c) {
 		case 'h':
@@ -233,9 +235,6 @@ int main(int argc, char *argv[])
 			else
 				namespaces |= CLONE_NEWUSER;
 			break;
-		case 'e':
-			do_fork = 0;
-			break;
 		case 'r':
 			if (optarg)
 				open_target_fd(&root_fd, "root", optarg);
@@ -248,6 +247,15 @@ int main(int argc, char *argv[])
 			else
 				do_wd = true;
 			break;
+		case 'a':
+			namespaces = ~0;
+			do_rd = do_wd = true;
+			do_fork = 1;
+			all_used = true;
+			break;
+		case 'e':
+			do_fork = 0;
+			break;
 		default:
 			usage(EXIT_FAILURE);
 		}
@@ -271,12 +279,22 @@ int main(int argc, char *argv[])
 	 * Now that we know which namespaces we want to enter, enter them.
 	 */
 	for (nsfile = namespace_files; nsfile->nstype; nsfile++) {
+		int r;
+
 		if (nsfile->fd < 0)
 			continue;
-		if (setns(nsfile->fd, nsfile->nstype))
-			err(EXIT_FAILURE,
-			    _("reassociate to namespace '%s' failed"),
-			    nsfile->name);
+		r = setns(nsfile->fd, nsfile->nstype);
+		if (r) {
+			/*
+			 * Skip EINVAL when trying to enter user namespace
+			 * if it was requested through --all.
+			 */
+			if (!(nsfile->nstype == CLONE_NEWUSER &&
+			      errno == EINVAL && all_used))
+				err(EXIT_FAILURE,
+				    _("reassociate to namespace '%s' failed"),
+				    nsfile->name);
+		}
 		close(nsfile->fd);
 		nsfile->fd = -1;
 	}
-- 
1.7.11.7

