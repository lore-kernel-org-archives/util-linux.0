Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:64056 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527AbaLVLrk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Dec 2014 06:47:40 -0500
Received: by mail-wg0-f48.google.com with SMTP id y19so6456564wgg.7
        for <util-linux@vger.kernel.org>; Mon, 22 Dec 2014 03:47:39 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 12/14] newgrp: set function arguments read-only when possible
Date: Mon, 22 Dec 2014 11:47:15 +0000
Message-Id: <1419248837-4619-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
References: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/newgrp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/login-utils/newgrp.c b/login-utils/newgrp.c
index 0fae087..b1134e9 100644
--- a/login-utils/newgrp.c
+++ b/login-utils/newgrp.c
@@ -74,7 +74,7 @@ static int memset_s(void *v, size_t sz, const int c)
 }
 
 /* try to read password from gshadow */
-static char *get_gshadow_pwd(char *groupname)
+static char *get_gshadow_pwd(const char *groupname)
 {
 #ifdef HAVE_GETSGNAM
 	struct sgrp *sgrp;
@@ -117,7 +117,7 @@ static char *get_gshadow_pwd(char *groupname)
 #endif	/* HAVE_GETSGNAM */
 }
 
-static int allow_setgid(struct passwd *pe, struct group *ge)
+static int allow_setgid(const struct passwd *pe, const struct group *ge)
 {
 	char **look;
 	int notfound = 1;
@@ -160,7 +160,7 @@ static int allow_setgid(struct passwd *pe, struct group *ge)
 	return FALSE;
 }
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fprintf(out, USAGE_HEADER);
 	fprintf(out, _(" %s <group>\n"), program_invocation_short_name);
-- 
2.2.1

