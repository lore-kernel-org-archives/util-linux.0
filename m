Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 43/49] login:  use TTYGROUP from login.defs
Date: Mon, 17 Oct 2011 13:15:22 +0200
Message-Id: <1318850128-23458-44-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Note that Suse login(1) does not use any default for TTYGROUP, it
means that TTYGROUP has to be explicitly defined otherwise user\'s
primary group is used.

The util-linux login(1) uses 'tty' group name as a default value.

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.1 |    9 +++++++++
 login-utils/login.c |   15 +++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/login-utils/login.1 b/login-utils/login.1
index 1d3ae1a..cce4672 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -149,6 +149,15 @@ The default value is 5.
 .RS 4
 The terminal permissions. The default value is 0600.
 .RE
+.PP
+\fBTTYGROUP\fR (string)
+.RS 4
+The login tty will be owned by the
+\fBTTYGROUP\fR. The default value is 'tty'. If the \fBTTYGROUP\fR does not exist
+then the ownership of the terminal is set to the user\'s primary group.
+.SP
+The \fBTTYGROUP\fR can be either the name of a group or a numeric group identifier.
+.RE
 
 .SH FILES
 .nf
diff --git a/login-utils/login.c b/login-utils/login.c
index 857240d..3d6d73a 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -264,13 +264,20 @@ static void open_tty(const char *tty)
 
 static void chown_tty(struct login_context *cxt)
 {
-	struct group *gr;
+	const char *grname;
 	uid_t uid = cxt->pwd->pw_uid;
 	gid_t gid = cxt->pwd->pw_gid;
 
-	gr = getgrnam(TTYGRPNAME);
-	if (gr)
-		gid = gr->gr_gid;
+	grname = getlogindefs_str("TTYGROUP", TTYGRPNAME);
+	if (grname && *grname) {
+		if (*grname >= 0 && *grname <= 9)		/* group by ID */
+			gid = getlogindefs_num("TTYGROUP", gid);
+		else {						/* group by name */
+			struct group *gr = getgrnam(grname);
+			if (gr)
+				gid = gr->gr_gid;
+		}
+	}
 
 	if (fchown(0, uid, gid))				/* tty */
 		chown_err(cxt->tty_name, uid, gid);
-- 
1.7.6.4
