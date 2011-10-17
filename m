Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 03/49] login: move _PATH_BTMP to pathnames.h
Date: Mon, 17 Oct 2011 13:14:42 +0200
Message-Id: <1318850128-23458-4-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 include/pathnames.h |    4 ++++
 login-utils/login.c |    1 -
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/include/pathnames.h b/include/pathnames.h
index d7d2a14..025e4af 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -135,5 +135,9 @@
 # define _PATH_RTC_DEV		"/dev/rtc"
 #endif
 
+#ifndef _PATH_BTMP
+#define _PATH_BTMP		"/var/log/btmp"
+#endif
+
 #endif /* PATHNAMES_H */
 
diff --git a/login-utils/login.c b/login-utils/login.c
index 118bda9..bcac52d 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -206,7 +206,6 @@ consoletty(int fd) {
  * Must be called only with username the name of an actual user.
  * The most common login failure is to give password instead of username.
  */
-#define	_PATH_BTMP	"/var/log/btmp"
 static void
 logbtmp(const char *line, const char *username, const char *hostname) {
 	struct utmp ut;
-- 
1.7.6.4
