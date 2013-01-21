Return-Path: util-linux-owner@vger.kernel.org
Received: from kawka.in.waw.pl ([178.63.212.103]:49928 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874Ab3AUGkU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Jan 2013 01:40:20 -0500
From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: util-linux@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 3/5] nsenter: respect --exec no matter where it appears
Date: Mon, 21 Jan 2013 01:38:03 -0500
Message-Id: <1358750287-17732-4-git-send-email-zbyszek@in.waw.pl>
In-Reply-To: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl>
References: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl>
---
 sys-utils/nsenter.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index 4ea3c09..1f773e1 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -176,7 +176,7 @@ int main(int argc, char *argv[])
 	};
 
 	struct namespace_file *nsfile;
-	int do_fork = 0;
+	int do_fork = -1; /* unknown yet */
 	int c, namespaces = 0;
 	bool do_rd = false, do_wd = false, all_used = false;
 
@@ -223,7 +223,6 @@ int main(int argc, char *argv[])
 				namespaces |= CLONE_NEWNET;
 			break;
 		case 'p':
-			do_fork = 1;
 			if (optarg)
 				open_namespace_fd(CLONE_NEWPID, optarg);
 			else
@@ -250,7 +249,6 @@ int main(int argc, char *argv[])
 		case 'a':
 			namespaces = ~0;
 			do_rd = do_wd = true;
-			do_fork = 1;
 			all_used = true;
 			break;
 		case 'e':
@@ -283,6 +281,10 @@ int main(int argc, char *argv[])
 
 		if (nsfile->fd < 0)
 			continue;
+
+		if (nsfile->nstype == CLONE_NEWPID && do_fork == -1)
+			do_fork = 1;
+
 		r = setns(nsfile->fd, nsfile->nstype);
 		if (r) {
 			/*
@@ -295,6 +297,7 @@ int main(int argc, char *argv[])
 				    _("reassociate to namespace '%s' failed"),
 				    nsfile->name);
 		}
+
 		close(nsfile->fd);
 		nsfile->fd = -1;
 	}
@@ -330,7 +333,7 @@ int main(int argc, char *argv[])
 		wd_fd = -1;
 	}
 
-	if (do_fork)
+	if (do_fork == 1)
 		continue_as_child();
 
 	execvp(argv[optind], argv + optind);
-- 
1.7.11.7

