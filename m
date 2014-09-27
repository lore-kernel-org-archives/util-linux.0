Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qc0-f175.google.com ([209.85.216.175]:36020 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbaI0TEc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 27 Sep 2014 15:04:32 -0400
Received: by mail-qc0-f175.google.com with SMTP id o8so8011101qcw.34
        for <util-linux@vger.kernel.org>; Sat, 27 Sep 2014 12:04:31 -0700 (PDT)
From: pcpa <paulo.cesar.pereira.de.andrade@gmail.com>
To: util-linux@vger.kernel.org
Cc: pcpa <paulo.cesar.pereira.de.andrade@gmail.com>
Subject: [PATCH] su: print proper core dump message when killed
Date: Sat, 27 Sep 2014 16:04:16 -0300
Message-Id: <1411844656-13266-1-git-send-email-paulo.cesar.pereira.de.andrade@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

An example is, in one terminal "sudo su -; echo $$", and in
another terminal, "kill -9  $PID" (the pid of the su -). It
should not print "(core dumped)", unless the kill signal
specified so, e.g. kill -7 or kill -11.

Signed-off-by: pcpa <paulo.cesar.pereira.de.andrade@gmail.com>
---
 login-utils/su-common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index db72826..eb3b844 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -363,10 +363,9 @@ create_watching_parent (void)
         {
           if (WIFSIGNALED (status))
             {
+              fprintf (stderr, "%s%s\n", strsignal (WTERMSIG (status)),
+                       WCOREDUMP (status) ? _(" (core dumped)") : "");
               status = WTERMSIG (status) + 128;
-              if (WCOREDUMP (status))
-                fprintf (stderr, _("%s (core dumped)\n"),
-                   strsignal (WTERMSIG (status)));
             }
           else
             status = WEXITSTATUS (status);
-- 
1.9.3

