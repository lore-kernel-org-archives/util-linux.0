Return-Path: util-linux-owner@vger.kernel.org
Received: from kawka.in.waw.pl ([178.63.212.103]:49932 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874Ab3AUGkq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Jan 2013 01:40:46 -0500
From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: util-linux@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 4/5] nsenter: rename --exec/-e to --no-fork/-F
Date: Mon, 21 Jan 2013 01:38:05 -0500
Message-Id: <1358750287-17732-6-git-send-email-zbyszek@in.waw.pl>
In-Reply-To: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl>
References: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The naming of this option was really confusing.
Just rename it for clarity.

Signed-off-by: Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl>
---
 sys-utils/nsenter.1 | 2 +-
 sys-utils/nsenter.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
index ab1a6f1..7ca0f0e 100644
--- a/sys-utils/nsenter.1
+++ b/sys-utils/nsenter.1
@@ -135,7 +135,7 @@ Set the working directory.  If no directory is specified set the working
 directory to the working directory of the target process.  If directory is
 specified set the working directory to the specified directory.
 .TP
-\fB\-e\fR, \fB\-\-exec\fR
+\fB\-e\fR, \fB\-\-no\-fork\fR
 Do not fork before exec'ing the specified program.  By default when entering a
 pid namespace enter calls fork before calling exec so that the children will be
 in the newly entered pid namespace.
diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index 1f773e1..0a4985c 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -74,7 +74,7 @@ static void usage(int status)
 		" -r, --root  [=<dir>]   set the root directory\n"
 		" -w, --wd    [=<dir>]   set the working directory\n"
 		" -a, --all              set root and cwd and enter namespaces listed above\n"
-		" -e, --exec             don't fork before exec'ing <program>\n"), out);
+		" -F, --no-fork          don't fork before exec'ing <program>\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
@@ -171,7 +171,7 @@ int main(int argc, char *argv[])
 		{ "root", optional_argument, NULL, 'r' },
 		{ "wd", optional_argument, NULL, 'w' },
 		{ "all", no_argument, NULL, 'a' },
-		{ "exec", no_argument, NULL, 'e' },
+		{ "no-fork", no_argument, NULL, 'F' },
 		{ NULL, 0, NULL, 0 }
 	};
 
@@ -186,7 +186,7 @@ int main(int argc, char *argv[])
 	atexit(close_stdout);
 
 	while ((c =
-		getopt_long(argc, argv, "hVt:m::u::i::n::p::U::r::w::ae",
+		getopt_long(argc, argv, "hVt:m::u::i::n::p::U::r::w::aF",
 			    longopts, NULL)) != -1) {
 		switch (c) {
 		case 'h':
@@ -251,7 +251,7 @@ int main(int argc, char *argv[])
 			do_rd = do_wd = true;
 			all_used = true;
 			break;
-		case 'e':
+		case 'F':
 			do_fork = 0;
 			break;
 		default:
-- 
1.7.11.7

