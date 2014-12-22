Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f54.google.com ([74.125.82.54]:54038 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581AbaLVLrc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Dec 2014 06:47:32 -0500
Received: by mail-wg0-f54.google.com with SMTP id l2so6479463wgh.41
        for <util-linux@vger.kernel.org>; Mon, 22 Dec 2014 03:47:31 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 05/14] chsh: allow user to set shell to /bin/sh if none is set
Date: Mon, 22 Dec 2014 11:47:08 +0000
Message-Id: <1419248837-4619-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
References: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier setting a /bin/sh was impossible for users that had nothing set
as shell, as that was seen as no change.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/chsh.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index a316415..0112fa4 100644
--- a/login-utils/chsh.c
+++ b/login-utils/chsh.c
@@ -252,6 +252,7 @@ static int check_shell(const char *shell)
 int main(int argc, char **argv)
 {
 	char *oldshell;
+	int nullshell = 0;
 	const uid_t uid = getuid();
 	struct sinfo info = { 0 };
 	struct passwd *pw;
@@ -302,8 +303,10 @@ int main(int argc, char **argv)
 #endif
 
 	oldshell = pw->pw_shell;
-	if (oldshell == NULL || *oldshell == '\0')
+	if (oldshell == NULL || *oldshell == '\0') {
 		oldshell = _PATH_BSHELL;	/* default */
+		nullshell = 1;
+	}
 
 	/* reality check */
 #ifdef HAVE_LIBUSER
@@ -339,7 +342,7 @@ int main(int argc, char **argv)
 	if (check_shell(info.shell) < 0)
 		return EXIT_FAILURE;
 
-	if (strcmp(oldshell, info.shell) == 0)
+	if (!nullshell && strcmp(oldshell, info.shell) == 0)
 		errx(EXIT_SUCCESS, _("Shell not changed."));
 
 #ifdef HAVE_LIBUSER
-- 
2.2.1

