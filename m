Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:50674 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933AbaLGKNI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Dec 2014 05:13:08 -0500
Received: by mail-wi0-f170.google.com with SMTP id bs8so4843066wib.3
        for <util-linux@vger.kernel.org>; Sun, 07 Dec 2014 02:13:07 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/3] login-utils: use libc error printing facility
Date: Sun,  7 Dec 2014 10:13:02 +0000
Message-Id: <1417947184-24178-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/islocal.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/login-utils/islocal.c b/login-utils/islocal.c
index 13ce28e..7c4e775 100644
--- a/login-utils/islocal.c
+++ b/login-utils/islocal.c
@@ -82,13 +82,10 @@ static int is_local_in_file(const char *user, const char *filename)
 int is_local(const char *user)
 {
 	int rv;
-	if ((rv = is_local_in_file(user, _PATH_PASSWD)) < 0) {
-		perror(_PATH_PASSWD);
-		fprintf(stderr, _("cannot open %s"), _PATH_PASSWD);
-		exit(1);
-	} else {
-		return rv;
-	}
+
+	if ((rv = is_local_in_file(user, _PATH_PASSWD)) < 0)
+		err(EXIT_FAILURE, _("cannot open %s"), _PATH_PASSWD);
+	return rv;
 }
 
 #ifdef TEST_PROGRAM
-- 
2.1.3

