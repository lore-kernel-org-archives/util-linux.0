Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.134]:59679 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932107AbdIYTzh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 25 Sep 2017 15:55:37 -0400
Received: from localhost ([217.87.201.56]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPSA (Nemesis) id
 0LqYLt-1dRcN41umP-00e2Wv for <util-linux@vger.kernel.org>; Mon, 25 Sep 2017
 21:55:35 +0200
Date: Mon, 25 Sep 2017 21:55:34 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] setproctitle: fix out of boundary access
Message-ID: <20170925195534.GB25565@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

A program using setproctitle can trigger an out of boundary access
if an attacker was able to clear the environment before execution.

The check in setproctitle prevents overflows, but does not take into
account that the whole length of the arguments could be 1, which is
possible by supplying such a program name to execlp(3) or using a
symbolic link, e.g. argv[0] = "l", argv[1] = NULL.

Only login uses setproctitle, which is not affected by this
problem due to initializing the environment right before the call.
---
 lib/setproctitle.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/setproctitle.c b/lib/setproctitle.c
index 93bc82e47..7168e4658 100644
--- a/lib/setproctitle.c
+++ b/lib/setproctitle.c
@@ -17,7 +17,7 @@
 extern char **environ;
 
 static char **argv0;
-static int argv_lth;
+static size_t argv_lth;
 
 void initproctitle (int argc, char **argv)
 {
@@ -42,16 +42,17 @@ void initproctitle (int argc, char **argv)
 			return;
 	environ[i] = NULL;
 
-	argv0 = argv;
 	if (i > 0)
-		argv_lth = envp[i-1] + strlen(envp[i-1]) - argv0[0];
+		argv_lth = envp[i-1] + strlen(envp[i-1]) - argv[0];
 	else
-		argv_lth = argv0[argc-1] + strlen(argv0[argc-1]) - argv0[0];
+		argv_lth = argv[argc-1] + strlen(argv[argc-1]) - argv[0];
+	if (argv_lth > 1)
+		argv0 = argv;
 }
 
 void setproctitle (const char *prog, const char *txt)
 {
-        int i;
+        size_t i;
         char buf[SPT_BUFSIZE];
 
         if (!argv0)
-- 
2.14.1

