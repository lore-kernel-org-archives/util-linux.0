Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:34092 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab2LWPnd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 23 Dec 2012 10:43:33 -0500
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] Require explicit call to emergency_do_mounts
Date: Sun, 23 Dec 2012 10:43:30 -0500
Message-Id: <1356277410-29666-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Keeping these functions in lib/ with constructor and destructor
attributes causes the code to be run in invocation of a large number of
programs in the util-linux tree. Remove the attributes and call it
explicitly from sulogin, the only place where it (currently) makes sense
to be called from.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
I'd further vote that the flag which enables this behavior be turned off
by default.

 include/consoles.h    | 5 +++++
 lib/consoles.c        | 2 --
 login-utils/sulogin.c | 5 +++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/consoles.h b/include/consoles.h
index 2544263..db2e500 100644
--- a/include/consoles.h
+++ b/include/consoles.h
@@ -49,3 +49,8 @@ struct console {
 
 extern int detect_consoles(const char *device, int fallback,
 			   struct list_head *consoles);
+
+#ifdef USE_SULOGIN_EMERGENCY_MOUNT
+void emergency_do_umounts(void);
+void emergency_do_mounts(void);
+#endif
diff --git a/lib/consoles.c b/lib/consoles.c
index 7175a08..7930e7c 100644
--- a/lib/consoles.c
+++ b/lib/consoles.c
@@ -98,7 +98,6 @@ static uint32_t emergency_flags;
 # define MNT_PROCFS    0x0001
 # define MNT_DEVTMPFS  0x0002
 
-static __attribute__((__destructor__))
 void emergency_do_umounts(void)
 {
 	if (emergency_flags & MNT_DEVTMPFS)
@@ -107,7 +106,6 @@ void emergency_do_umounts(void)
 		umount2("/proc", MNT_DETACH);
 }
 
-static __attribute__((__constructor__))
 void emergency_do_mounts(void)
 {
 	struct stat rt, xt;
diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 8416e3e..42b1b73 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -834,6 +834,11 @@ int main(int argc, char **argv)
 	mask_signal(SIGINT,  SIG_IGN, &saved_sigint);
 	mask_signal(SIGHUP,  SIG_IGN, &saved_sighup);
 
+#ifdef USE_SULOGIN_EMERGENCY_MOUNT
+	emergency_do_mounts();
+	atexit(emergency_do_umounts);
+#endif
+
 	/*
 	 * See if we need to open an other tty device.
 	 */
-- 
1.8.0.2

