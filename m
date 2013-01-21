Return-Path: util-linux-owner@vger.kernel.org
Received: from kawka.in.waw.pl ([178.63.212.103]:49936 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874Ab3AUGlG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Jan 2013 01:41:06 -0500
From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: util-linux@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 5/5] unshare: add --all meaning all namespaces
Date: Mon, 21 Jan 2013 01:38:07 -0500
Message-Id: <1358750287-17732-8-git-send-email-zbyszek@in.waw.pl>
In-Reply-To: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl>
References: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl>
---
 sys-utils/unshare.1 | 3 +++
 sys-utils/unshare.c | 9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 8cdc6e5..d91c86e 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -61,6 +61,9 @@ Unshare the pid namespace.
 .TP
 .BR \-U , " \-\-user"
 Unshare the user namespace.
+.TP
+.BR \-U , " \-\-user"
+Unshare all the namespaces listed above.
 .SH NOTES
 .SH SEE ALSO
 .BR unshare (2),
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 9b849ee..c891cb5 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -54,6 +54,10 @@ static void usage(int status)
 	exit(status);
 }
 
+#define ALL_CLONE_FLAGS (CLONE_NEWNS|CLONE_NEWUTS|CLONE_NEWIPC|CLONE_NEWNET\
+			 |CLONE_NEWPID|CLONE_NEWUSER)
+
+
 int main(int argc, char *argv[])
 {
 	static const struct option longopts[] = {
@@ -65,6 +69,7 @@ int main(int argc, char *argv[])
 		{ "net", no_argument, 0, 'n' },
 		{ "pid", no_argument, 0, 'p' },
 		{ "user", no_argument, 0, 'U' },
+		{ "all", no_argument, 0, 'a' },
 		{ NULL, 0, 0, 0 }
 	};
 
@@ -77,7 +82,7 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while((c = getopt_long(argc, argv, "hVmuinpU", longopts, NULL)) != -1) {
+	while((c = getopt_long(argc, argv, "hVmuinpUa", longopts, NULL)) != -1) {
 		switch(c) {
 		case 'h':
 			usage(EXIT_SUCCESS);
@@ -102,6 +107,8 @@ int main(int argc, char *argv[])
 		case 'U':
 			unshare_flags |= CLONE_NEWUSER;
 			break;
+		case 'a':
+			unshare_flags |= ALL_CLONE_FLAGS;
 		default:
 			usage(EXIT_FAILURE);
 		}
-- 
1.7.11.7

