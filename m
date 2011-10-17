Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 40/49] login: use LOGIN_TIMEOUT from login.defs
Date: Mon, 17 Oct 2011 13:15:19 +0200
Message-Id: <1318850128-23458-41-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.1 |    5 +++++
 login-utils/login.c |    2 ++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/login-utils/login.1 b/login-utils/login.1
index 8aba16f..ef71539 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -133,6 +133,11 @@ Note that the same functionality is also provided by
 .BR pam_motd (8)
 PAM module.
 .RE
+.PP
+\fBLOGIN_TIMEOUT\fR (number)
+.RS 4
+Max time in seconds for login. The default value is 60.
+.RE
 
 .SH FILES
 .nf
diff --git a/login-utils/login.c b/login-utils/login.c
index 8431af8..9822d9a 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -1105,6 +1105,8 @@ int main(int argc, char **argv)
 		.conv = { misc_conv, NULL }	/* PAM conversation function */
 	};
 
+	timeout = getlogindefs_num("LOGIN_TIMEOUT", LOGIN_TIMEOUT);
+
 	signal(SIGALRM, timedout);
 	siginterrupt(SIGALRM, 1);	/* we have to interrupt syscalls like ioclt() */
 	alarm((unsigned int)timeout);
-- 
1.7.6.4
