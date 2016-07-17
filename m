Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33622 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbcGQNAa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Jul 2016 09:00:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id o80so8770313wme.0
        for <util-linux@vger.kernel.org>; Sun, 17 Jul 2016 06:00:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 04/13] lslogins: simplify if clause and move definition and comments [oclint]
Date: Sun, 17 Jul 2016 14:00:06 +0100
Message-Id: <20160717130015.31760-5-kerolasa@iki.fi>
In-Reply-To: <20160717130015.31760-1-kerolasa@iki.fi>
References: <20160717130015.31760-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The if clause change is pretty trivial.  Moving the macro near to where it
is used makes sense to people who want to read the code.  And finally the
comment about user list was at wrong spot.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/lslogins.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 3ff7725..60a1b50 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -766,14 +766,6 @@ static struct lslogins_user *get_user_info(struct lslogins_control *ctl, const c
 	return user;
 }
 
-/* some UNIX implementations set errno iff a passwd/grp/...
- * entry was not found. The original UNIX logins(1) utility always
- * ignores invalid login/group names, so we're going to as well.*/
-#define IS_REAL_ERRNO(e) !((e) == ENOENT || (e) == ESRCH || \
-		(e) == EBADF || (e) == EPERM || (e) == EAGAIN)
-
-/* get a definitive list of users we want info about... */
-
 static int str_to_uint(char *s, unsigned int *ul)
 {
 	char *end;
@@ -785,6 +777,7 @@ static int str_to_uint(char *s, unsigned int *ul)
 	return 1;
 }
 
+/* get a definitive list of users we want info about... */
 static int get_ulist(struct lslogins_control *ctl, char *logins, char *groups)
 {
 	char *u, *g;
@@ -878,13 +871,18 @@ static struct lslogins_user *get_next_user(struct lslogins_control *ctl)
 	return u;
 }
 
+/* some UNIX implementations set errno iff a passwd/grp/...
+ * entry was not found. The original UNIX logins(1) utility always
+ * ignores invalid login/group names, so we're going to as well.*/
+#define IS_REAL_ERRNO(e) !((e) == ENOENT || (e) == ESRCH || \
+		(e) == EBADF || (e) == EPERM || (e) == EAGAIN)
+
 static int get_user(struct lslogins_control *ctl, struct lslogins_user **user,
 		    const char *username)
 {
 	*user = get_user_info(ctl, username);
-	if (!*user)
-		if (IS_REAL_ERRNO(errno))
-			return -1;
+	if (!*user && IS_REAL_ERRNO(errno))
+		return -1;
 	return 0;
 }
 
-- 
2.9.0

