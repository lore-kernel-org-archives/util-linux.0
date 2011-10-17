Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 45/49] login: use DEFAULT_HOME from login.defs
Date: Mon, 17 Oct 2011 13:15:24 +0200
Message-Id: <1318850128-23458-46-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.1 |    8 ++++++++
 login-utils/login.c |    3 +++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/login-utils/login.1 b/login-utils/login.1
index c72fcfa..ca7c4b3 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -175,6 +175,14 @@ The default is to check "/etc/hushlogins" and if does not exist then
 
 If the \fBHUSHLOGIN_FILE\fR item is empty then all checks are disabled.
 .RE
+.PP
+\fBDEFAULT_HOME\fR (boolean)
+.RS 4
+Indicate if login is allowed if we can\'t cd to the home directory. If set to
+\fIyes\fR, the user will login in the root (/) directory if it is not possible
+to cd to her home directory. The default value is 'yes'.
+.RE
+
 .SH FILES
 .nf
 .I /var/run/utmp
diff --git a/login-utils/login.c b/login-utils/login.c
index 0464a17..0c8cc26 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -1313,6 +1313,9 @@ int main(int argc, char **argv)
 	/* wait until here to change directory! */
 	if (chdir(pwd->pw_dir) < 0) {
 		warn(_("%s: change directory failed"), pwd->pw_dir);
+
+		if (!getlogindefs_bool("DEFAULT_HOME", 1))
+			exit(0);
 		if (chdir("/"))
 			exit(EXIT_FAILURE);
 		pwd->pw_dir = "/";
-- 
1.7.6.4
