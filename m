Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50611 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759062Ab2C2Qpm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Mar 2012 12:45:42 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 6A365906EB
	for <util-linux@vger.kernel.org>; Thu, 29 Mar 2012 18:45:41 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 09/20] uuidd: factor out dropping of privileges into separate function
Date: Thu, 29 Mar 2012 18:45:17 +0200
Message-Id: <1333039528-24784-10-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Simplify main by moving dropping of privileges into newly
introduced drop_privileges() function.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/uuidd.c |   47 +++++++++++++++++++++++++++++------------------
 1 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index aae5dbf..10c3019 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -486,6 +486,33 @@ socket_ready:
 	}
 }
 
+/*
+ * Drop privileges of the process
+ *
+ * Set real uid, effective uid and - if supported by the system - also
+ * saved set-user-id. Similarly for gid.
+ *
+ * Exits the program with error upon failure.
+ */
+static void drop_privileges(uid_t uid, gid_t gid)
+{
+#ifdef HAVE_SETRESGID
+	if (setresgid(gid, gid, gid) < 0)
+		err(EXIT_FAILURE, "setresgid");
+#else
+	if (setregid(gid, gid) < 0)
+		err(EXIT_FAILURE, "setregid");
+#endif
+
+#ifdef HAVE_SETRESUID
+	if (setresuid(uid, uid, uid) < 0)
+		err(EXIT_FAILURE, "setresuid");
+#else
+	if (setreuid(uid, uid) < 0)
+		err(EXIT_FAILURE, "setreuid");
+#endif
+}
+
 static void __attribute__ ((__noreturn__)) unexpected_size(int size)
 {
 	errx(EXIT_FAILURE, _("Unexpected reply length from server %d"), size);
@@ -501,7 +528,6 @@ int main(int argc, char **argv)
 	char		str[UUID_STR_LEN], *tmp;
 	uuid_t		uu;
 	uid_t		uid;
-	gid_t		gid;
 	int		i, c, ret;
 	int		debug = 0, do_type = 0, do_kill = 0, num = 0;
 	int		timeout = 0, quiet = 0, drop_privs = 0;
@@ -624,24 +650,9 @@ int main(int argc, char **argv)
 				  "Ignoring --socket\n"));
 
 	uid = getuid();
-	if (uid && drop_privs) {
-		gid = getgid();
-#ifdef HAVE_SETRESGID
-		if (setresgid(gid, gid, gid) < 0)
-			err(EXIT_FAILURE, "setresgid");
-#else
-		if (setregid(gid, gid) < 0)
-			err(EXIT_FAILURE, "setregid");
-#endif
+	if (uid && drop_privs)
+		drop_privileges(uid, getgid());
 
-#ifdef HAVE_SETRESUID
-		if (setresuid(uid, uid, uid) < 0)
-			err(EXIT_FAILURE, "setresuid");
-#else
-		if (setreuid(uid, uid) < 0)
-			err(EXIT_FAILURE, "setreuid");
-#endif
-	}
 	if (num && do_type) {
 		ret = call_daemon(socket_path, do_type + 2, buf,
 				  sizeof(buf), &num, &err_context);
-- 
1.7.7

