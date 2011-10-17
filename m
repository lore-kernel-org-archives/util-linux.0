Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 48/49] login: use ENV_PATH and ENV_{ROOT,SU}PATH from login.defs
Date: Mon, 17 Oct 2011 13:15:27 +0200
Message-Id: <1318850128-23458-49-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.1 |   12 ++++++++++++
 login-utils/login.c |   10 +++++++++-
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/login-utils/login.1 b/login-utils/login.1
index 1f4aa69..54b7562 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -198,6 +198,18 @@ Enable display of unknown usernames when login failures are recorded\&.
 Note that logging unknown usernames may be a security issue if an user enter
 her password instead of her login name.
 .RE
+.PP
+\fBENV_PATH\fR (string)
+.RS 4
+If set, it will be used to define the PATH environment variable when a regular
+user login. The default value is "/usr/local/bin:/bin:/usr/bin".
+.RE
+.PP
+\fBENV_ROOTPATH\fR (string), \fBENV_SUPATH\fR (string)
+.RS 4
+If set, it will be used to define the PATH environment variable when the superuser
+login. The default value is "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin".
+.RE
 .SH FILES
 .nf
 .I /var/run/utmp
diff --git a/login-utils/login.c b/login-utils/login.c
index 2d9a847..f688307 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -1111,10 +1111,18 @@ static void init_environ(struct login_context *cxt)
 	}
 
 	setenv("HOME", pwd->pw_dir, 0);	/* legal to override */
-	setenv("PATH", pwd->pw_uid ? _PATH_DEFPATH : _PATH_DEFPATH_ROOT, 1);
 	setenv("SHELL", pwd->pw_shell, 1);
 	setenv("TERM", termenv, 1);
 
+	if (pwd->pw_uid)
+		setenv("PATH", getlogindefs_str("ENV_PATH", _PATH_DEFPATH), 1);
+	else {
+		const char *x = getlogindefs_str("ENV_ROOTPATH", NULL);
+		if (!x)
+			x = getlogindefs_str("ENV_SUPATH", _PATH_DEFPATH_ROOT);
+		setenv("PATH", x, 1);
+	}
+
 	/* mailx will give a funny error msg if you forget this one */
 	len = snprintf(tmp, sizeof(tmp), "%s/%s", _PATH_MAILDIR, pwd->pw_name);
 	if (len > 0 && (size_t) len + 1 <= sizeof(tmp))
-- 
1.7.6.4
