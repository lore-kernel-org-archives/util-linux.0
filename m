Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:61235 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753548Ab2JNUVR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:21:17 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2680285wey.19
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:21:16 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/19] last: stop using MAXHOSTNAMELEN
Date: Sun, 14 Oct 2012 21:20:52 +0100
Message-Id: <1350246070-10544-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use the sysconf(_SC_HOST_NAME_MAX) to determine maximum length of a
hostname.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 77a890a..a3d5a85 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -418,22 +418,19 @@ addtty(char *ttyname) {
  */
 static void
 hostconv(char *arg) {
-	static int	first = 1;
-	static char	*hostdot,
-			name[MAXHOSTNAMELEN];
-	char	*argdot;
+	static char *hostdot;
+	static char *argdot;
+	static char *name;
 
 	if (!(argdot = strchr(arg, '.')))
 		return;
-	if (first) {
-		first = 0;
-		if (gethostname(name, sizeof(name)))
-			err(EXIT_FAILURE, _("gethostname failed"));
-
-		hostdot = strchr(name, '.');
-	}
+	name = xmalloc(sizeof(char) * (sysconf(_SC_HOST_NAME_MAX) + 1));
+	if (gethostname(name, sysconf(_SC_HOST_NAME_MAX)))
+		err(EXIT_FAILURE, _("gethostname failed"));
+	hostdot = strchr(name, '.');
 	if (hostdot && !strcmp(hostdot, argdot))
 		*argdot = '\0';
+	free(name);
 }
 
 /*
-- 
1.7.12.2

