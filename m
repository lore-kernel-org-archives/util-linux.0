Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f169.google.com ([209.85.212.169]:62774 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527AbaLVLrj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Dec 2014 06:47:39 -0500
Received: by mail-wi0-f169.google.com with SMTP id r20so10231811wiv.4
        for <util-linux@vger.kernel.org>; Mon, 22 Dec 2014 03:47:38 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 11/14] newgrp: move shell determination closer where it is used
Date: Mon, 22 Dec 2014 11:47:14 +0000
Message-Id: <1419248837-4619-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
References: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/newgrp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/login-utils/newgrp.c b/login-utils/newgrp.c
index 3f5c720..0fae087 100644
--- a/login-utils/newgrp.c
+++ b/login-utils/newgrp.c
@@ -202,9 +202,6 @@ int main(int argc, char *argv[])
 	if (!(pw_entry = getpwuid(getuid())))
 		err(EXIT_FAILURE, _("who are you?"));
 
-	shell = (pw_entry->pw_shell && *pw_entry->pw_shell ?
-				pw_entry->pw_shell : _PATH_BSHELL);
-
 	if (argc < 2) {
 		if (setgid(pw_entry->pw_gid) < 0)
 			err(EXIT_FAILURE, _("setgid failed"));
@@ -225,8 +222,9 @@ int main(int argc, char *argv[])
 	if (setuid(getuid()) < 0)
 		err(EXIT_FAILURE, _("setuid failed"));
 
-	fflush(stdout);
-	fflush(stderr);
+	fflush(NULL);
+	shell = (pw_entry->pw_shell && *pw_entry->pw_shell ?
+				pw_entry->pw_shell : _PATH_BSHELL);
 	execl(shell, shell, (char *)0);
 	warn(_("failed to execute %s"), shell);
 	fflush(stderr);
-- 
2.2.1

