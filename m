Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 41/49] login: use FAIL_DELAY from login.defs
Date: Mon, 17 Oct 2011 13:15:20 +0200
Message-Id: <1318850128-23458-42-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.1 |    7 ++++++-
 login-utils/login.c |    2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/login-utils/login.1 b/login-utils/login.1
index ef71539..8cb2450 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -138,7 +138,12 @@ PAM module.
 .RS 4
 Max time in seconds for login. The default value is 60.
 .RE
-
+.PP
+\fBFAIL_DELAY\fR (number)
+.RS 4
+Delay in seconds before being allowed another attempt after a login failure.
+The default value is 5.
+.RE
 .SH FILES
 .nf
 .I /var/run/utmp
diff --git a/login-utils/login.c b/login-utils/login.c
index 9822d9a..a70ce56 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -176,7 +176,7 @@ static void sig_handler(int signal)
 /* Should not be called from PAM code... */
 static void sleepexit(int eval)
 {
-	sleep(LOGIN_EXIT_TIMEOUT);
+	sleep(getlogindefs_num("FAIL_DELAY", LOGIN_EXIT_TIMEOUT));
 	exit(eval);
 }
 
-- 
1.7.6.4
