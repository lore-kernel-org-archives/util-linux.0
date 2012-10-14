Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:61235 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042Ab2JNUVT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:21:19 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2680285wey.19
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:21:18 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/19] write: stop using MAXHOSTNAMELEN
Date: Sun, 14 Oct 2012 21:20:54 +0100
Message-Id: <1350246070-10544-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use the sysconf(_SC_HOST_NAME_MAX) to determine maximum length of a
hostname.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index 6c746b4..29b684b 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -63,6 +63,7 @@
 #include "carefulputc.h"
 #include "closestream.h"
 #include "nls.h"
+#include "xalloc.h"
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out);
 void search_utmp(char *, char *, char *, uid_t);
@@ -312,7 +313,7 @@ void do_write(char *tty, char *mytty, uid_t myuid)
 	char *login, *pwuid, *nows;
 	struct passwd *pwd;
 	time_t now;
-	char path[PATH_MAX], host[MAXHOSTNAMELEN], line[512];
+	char path[PATH_MAX], *host, line[512];
 
 	/* Determine our login name(s) before the we reopen() stdout */
 	if ((pwd = getpwuid(myuid)) != NULL)
@@ -332,7 +333,8 @@ void do_write(char *tty, char *mytty, uid_t myuid)
 	signal(SIGHUP, done);
 
 	/* print greeting */
-	if (gethostname(host, sizeof(host)) < 0)
+	host = xmalloc(sizeof(char) * (sysconf(_SC_HOST_NAME_MAX) + 1));
+	if (gethostname(host, sysconf(_SC_HOST_NAME_MAX)) < 0)
 		strcpy(host, "???");
 	now = time((time_t *) NULL);
 	nows = ctime(&now);
@@ -344,6 +346,7 @@ void do_write(char *tty, char *mytty, uid_t myuid)
 	else
 		printf(_("Message from %s@%s on %s at %s ..."),
 		       login, host, mytty, nows + 11);
+	free(host);
 	printf("\r\n");
 
 	while (fgets(line, sizeof(line), stdin) != NULL)
-- 
1.7.12.2

