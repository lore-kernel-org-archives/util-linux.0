Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:39673 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042Ab2JNUVS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:21:18 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2680278wey.19
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:21:17 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/19] login: stop using MAXHOSTNAMELEN
Date: Sun, 14 Oct 2012 21:20:53 +0100
Message-Id: <1350246070-10544-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use the sysconf(_SC_HOST_NAME_MAX) to determine maximum length of a
hostname.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/login.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index 8ae5266..8cf6865 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -109,7 +109,7 @@ struct login_context {
 	char		vcsan[VCS_PATH_MAX];
 #endif
 
-	char		thishost[MAXHOSTNAMELEN + 1];	/* this machine */
+	char		*thishost;			/* this machine */
 	char		*thisdomain;			/* this machine domain */
 	char		*hostname;			/* remote machine */
 	char		hostaddress[16];		/* remote address */
@@ -209,13 +209,13 @@ static void __attribute__ ((__noreturn__)) sleepexit(int eval)
 
 static const char *get_thishost(struct login_context *cxt, const char **domain)
 {
-	if (!*cxt->thishost) {
-		if (gethostname(cxt->thishost, sizeof(cxt->thishost))) {
+	if (!cxt->thishost) {
+		cxt->thishost = xmalloc(sizeof(char) * (sysconf(_SC_HOST_NAME_MAX) + 1));
+		if (gethostname(cxt->thishost, sysconf(_SC_HOST_NAME_MAX))) {
 			if (domain)
 				*domain = NULL;
 			return NULL;
 		}
-		cxt->thishost[sizeof(cxt->thishost) -1] = '\0';
 		cxt->thisdomain = strchr(cxt->thishost, '.');
 		if (cxt->thisdomain)
 			*cxt->thisdomain++ = '\0';
-- 
1.7.12.2

