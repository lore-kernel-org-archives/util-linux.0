Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:51811 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752390AbcBZDDh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 25 Feb 2016 22:03:37 -0500
Received: from tenfore.ga-group.nl ([95.114.239.233]) by mail.gmx.com
 (mrgmx101) with ESMTPSA (Nemesis) id 0M97Nh-1aePco1hV7-00CRCI for
 <util-linux@vger.kernel.org>; Fri, 26 Feb 2016 04:03:35 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 08/14] login-utils: minor utmp cleanup
Date: Fri, 26 Feb 2016 04:03:31 +0100
Message-Id: <1456455812-19453-9-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
References: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

- consistently use ut->ut_user instead of ut->ut_name
- don't include obsolete lastlog.h BSD header

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 login-utils/last.c  | 2 +-
 login-utils/login.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index dbfa8ae..38b92ef 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -586,7 +586,7 @@ static int is_phantom(const struct last_control *ctl, struct utmp *ut)
 
 	if (ut->UL_UT_TIME < ctl->boot_time.tv_sec)
 		return 1;
-	pw = getpwnam(ut->ut_name);
+	pw = getpwnam(ut->ut_user);
 	if (!pw)
 		return 1;
 	sprintf(path, "/proc/%u/loginuid", ut->ut_pid);
diff --git a/login-utils/login.c b/login-utils/login.c
index e1f11eb..c5ce188 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -55,7 +55,6 @@
 # include <linux/major.h>
 #endif
 #include <netdb.h>
-#include <lastlog.h>
 #include <security/pam_appl.h>
 #ifdef HAVE_SECURITY_PAM_MISC_H
 # include <security/pam_misc.h>
-- 
1.8.4.5

