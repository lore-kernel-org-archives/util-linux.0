Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34668 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbaIGMn0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Sep 2014 08:43:26 -0400
Received: by mail-wi0-f177.google.com with SMTP id cc10so1374845wib.10
        for <util-linux@vger.kernel.org>; Sun, 07 Sep 2014 05:43:24 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/17] last: make is_phantom() when kernel config does not include audit support
Date: Sun,  7 Sep 2014 13:42:54 +0100
Message-Id: <1410093785-17537-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When kernel CONFIG_AUDIT is not set the /proc/<pid>/loginuid information
is not present resulting live sessions to be marked 'gone - no logout' in
last(1) print out.  To go-around this change makes last(1) to look
/dev/<tty> device ownership as a substitute of loginuid.

The go-around seems to work fairly well, but it has it short comings.
For example after closing a X window session the /dev/ttyN file seems to
be owned by root, not the user who had it before entering to the X
session.  While that is suboptimal it is still better than an attmempt to
determine uid_t by looking owner of the /proc/<struct utmp ut_pid>, that
is a login(1) process running as root.

The issue was found using Archlinux installation.

$ pacman -Qi linux
Name           : linux
Version        : 3.16-2
[...]
Build Date     : Mon Aug 4 18:06:51 2014

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index f7a2576..fb82f31 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -582,8 +582,6 @@ static int is_phantom(const struct last_control *ctl, struct utmp *ut)
 {
 	struct passwd *pw;
 	char path[32];
-	FILE *f = NULL;
-	unsigned int loginuid;
 	int ret = 0;
 
 	if (ut->UL_UT_TIME < ctl->boot_time.tv_sec)
@@ -592,14 +590,26 @@ static int is_phantom(const struct last_control *ctl, struct utmp *ut)
 	if (!pw)
 		return 1;
 	sprintf(path, "/proc/%u/loginuid", ut->ut_pid);
-	if (access(path, R_OK) != 0 || !(f = fopen(path, "r")))
-		return 1;
+	if (access(path, R_OK) == 0) {
+		unsigned int loginuid;
+		FILE *f = NULL;
+
+		if (!(f = fopen(path, "r")))
+			return 1;
+		if (fscanf(f, "%u", &loginuid) != 1)
+			ret = 1;
+		fclose(f);
+		if (!ret && pw->pw_uid != loginuid)
+			return 1;
+	} else {
+		struct stat st;
 
-	if (fscanf(f, "%u", &loginuid) != 1)
-		ret = 1;
-	fclose(f);
-	if (!ret && pw->pw_uid != loginuid)
-		return 1;
+		sprintf(path, "/dev/%s", ut->ut_line);
+		if (stat(path, &st))
+			return 1;
+		if (pw->pw_uid != st.st_uid)
+			return 1;
+	}
 	return ret;
 }
 
-- 
2.1.0

