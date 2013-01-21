Return-Path: util-linux-owner@vger.kernel.org
Received: from kawka.in.waw.pl ([178.63.212.103]:49924 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897Ab3AUGjj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Jan 2013 01:39:39 -0500
From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: util-linux@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 1/5] nsenter: allow arguments to be specified in any order
Date: Mon, 21 Jan 2013 01:38:01 -0500
Message-Id: <1358750287-17732-2-git-send-email-zbyszek@in.waw.pl>
In-Reply-To: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl>
References: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Allows 'nsenter -mt $PID', which would fail previously.

Signed-off-by: Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl>
---
 sys-utils/nsenter.c | 55 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index 04ac314..1b57cc5 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -25,6 +25,7 @@
 #include <sched.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <unistd.h>
 #include <assert.h>
 
@@ -174,7 +175,8 @@ int main(int argc, char *argv[])
 
 	struct namespace_file *nsfile;
 	int do_fork = 0;
-	int c;
+	int c, namespaces = 0;
+	bool do_rd = false, do_wd = false;
 
 	setlocale(LC_MESSAGES, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -195,32 +197,56 @@ int main(int argc, char *argv[])
 			    strtoul_or_err(optarg, _("failed to parse pid"));
 			break;
 		case 'm':
-			open_namespace_fd(CLONE_NEWNS, optarg);
+			if (optarg)
+				open_namespace_fd(CLONE_NEWNS, optarg);
+			else
+				namespaces |= CLONE_NEWNS;
 			break;
 		case 'u':
-			open_namespace_fd(CLONE_NEWUTS, optarg);
+			if (optarg)
+				open_namespace_fd(CLONE_NEWUTS, optarg);
+			else
+				namespaces |= CLONE_NEWUTS;
 			break;
 		case 'i':
-			open_namespace_fd(CLONE_NEWIPC, optarg);
+			if (optarg)
+				open_namespace_fd(CLONE_NEWIPC, optarg);
+			else
+				namespaces |= CLONE_NEWIPC;
 			break;
 		case 'n':
-			open_namespace_fd(CLONE_NEWNET, optarg);
+			if (optarg)
+				open_namespace_fd(CLONE_NEWNET, optarg);
+			else
+				namespaces |= CLONE_NEWNET;
 			break;
 		case 'p':
 			do_fork = 1;
-			open_namespace_fd(CLONE_NEWPID, optarg);
+			if (optarg)
+				open_namespace_fd(CLONE_NEWPID, optarg);
+			else
+				namespaces |= CLONE_NEWPID;
 			break;
 		case 'U':
-			open_namespace_fd(CLONE_NEWUSER, optarg);
+			if (optarg)
+				open_namespace_fd(CLONE_NEWUSER, optarg);
+			else
+				namespaces |= CLONE_NEWUSER;
 			break;
 		case 'e':
 			do_fork = 0;
 			break;
 		case 'r':
-			open_target_fd(&root_fd, "root", optarg);
+			if (optarg)
+				open_target_fd(&root_fd, "root", optarg);
+			else
+				do_rd = true;
 			break;
 		case 'w':
-			open_target_fd(&wd_fd, "cwd", optarg);
+			if (optarg)
+				open_target_fd(&wd_fd, "cwd", optarg);
+			else
+				do_wd = true;
 			break;
 		default:
 			usage(EXIT_FAILURE);
@@ -231,6 +257,17 @@ int main(int argc, char *argv[])
 		usage(EXIT_FAILURE);
 
 	/*
+	 * Open remaining namespace and directory descriptors.
+	 */
+	for (nsfile = namespace_files; nsfile->nstype; nsfile++)
+		if (nsfile->nstype & namespaces)
+			open_namespace_fd(nsfile->nstype, NULL);
+	if (do_rd)
+		open_target_fd(&root_fd, "root", optarg);
+	if (do_wd)
+		open_target_fd(&wd_fd, "cwd", optarg);
+
+	/*
 	 * Now that we know which namespaces we want to enter, enter them.
 	 */
 	for (nsfile = namespace_files; nsfile->nstype; nsfile++) {
-- 
1.7.11.7

