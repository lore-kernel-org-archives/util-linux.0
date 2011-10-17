Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 44/49] login:  use HUSHLOGIN_FILE from login.defs
Date: Mon, 17 Oct 2011 13:15:23 +0200
Message-Id: <1318850128-23458-45-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Note that Suse login(1) does not use any default for HUSHLOGIN_FILE.
We use /etc/hushlogins and ~/.hushlogin as default.

The another difference is that *empty* global (e.g. /etc/hushlogins)
means that hushed mode will be enabled for all accounts.

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.1 |   16 ++++++++++++++++
 login-utils/login.c |   15 ++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/login-utils/login.1 b/login-utils/login.1
index cce4672..c72fcfa 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -158,7 +158,23 @@ then the ownership of the terminal is set to the user\'s primary group.
 .SP
 The \fBTTYGROUP\fR can be either the name of a group or a numeric group identifier.
 .RE
+.PP
+\fBHUSHLOGIN_FILE\fR (string)
+.RS 4
+If defined, this file can inhibit all the usual chatter during the login
+sequence.  If a full pathname (e.g. /etc/hushlogins) is specified, then hushed
+mode will be enabled if the user\'s name or shell are found in the file. If
+this global hush login file is empty then the hushed mode will be enabled for
+all users.
+
+If not a full pathname is specified, then hushed mode will be enabled if the
+file exists in the user\'s home directory.
 
+The default is to check "/etc/hushlogins" and if does not exist then
+"~/.hushlogin".
+
+If the \fBHUSHLOGIN_FILE\fR item is empty then all checks are disabled.
+.RE
 .SH FILES
 .nf
 .I /var/run/utmp
diff --git a/login-utils/login.c b/login-utils/login.c
index 3d6d73a..0464a17 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -845,6 +845,8 @@ static int effective_access(const char *path, int mode)
  *
  * The ~/.hushlogin is ignored if the global hush file exists.
  *
+ * The HUSHLOGIN_FILE login.def variable overwrites the default hush filename.
+ *
  * Note that shadow-utils login(1) does not support "a1)". The "a1)" is
  * necessary if you want to use PAM for "Last login" message.
  *
@@ -862,13 +864,24 @@ static int effective_access(const char *path, int mode)
 static int get_hushlogin_status(struct passwd *pwd)
 {
 	const char *files[] = { _PATH_HUSHLOGINS, _PATH_HUSHLOGIN, NULL };
+	const char *file;
 	char buf[BUFSIZ];
 	int i;
 
+	file = getlogindefs_str("HUSHLOGIN_FILE", NULL);
+	if (file) {
+		if (!*file)
+			return 0;	/* empty HUSHLOGIN_FILE defined */
+
+		files[0] = file;
+		files[1] = NULL;
+	}
+
 	for (i = 0; files[i]; i++) {
-		const char *file = files[i];
 		int ok = 0;
 
+		file = files[i];
+
 		/* Global hush-file*/
 		if (*file == '/') {
 			struct stat st;
-- 
1.7.6.4
