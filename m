Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bk0-f42.google.com ([209.85.214.42]:42988 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbaAXUDN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 24 Jan 2014 15:03:13 -0500
Received: by mail-bk0-f42.google.com with SMTP id 6so1455816bkj.15
        for <util-linux@vger.kernel.org>; Fri, 24 Jan 2014 12:03:11 -0800 (PST)
From: Andy Lutomirski <luto@amacapital.net>
To: util-linux@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH] setpriv: Fix --apparmor-profile
Date: Fri, 24 Jan 2014 12:02:59 -0800
Message-Id: <f995bb644f1349c842e686c876355a68d10eb09e.1390593743.git.luto@amacapital.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There were two bugs.  First, trying to access /proc/self/attr/exec
with O_CREAT | O_EXCL has no chance of working.  Second, it turns
out that the correct command to send is "exec", not "changeprofile".
Of course, there was no way to know this until:

    commit 3eea57c26e49a5add4c053a031cc2a1977b7c48e
    Author: John Johansen <john.johansen@canonical.com>
    Date:   Wed Feb 27 03:44:40 2013 -0800

        apparmor: fix setprocattr arg processing for onexec

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---

I obviously never tested this particular flag very well.  I take solace
in the fact that all of my development machines use selinux, not apparmor.

 sys-utils/setpriv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index a17f925..7bea626 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -538,12 +538,12 @@ static void do_apparmor_profile(const char *label)
 	if (access(_PATH_SYS_APPARMOR, F_OK) != 0)
 		errx(SETPRIV_EXIT_PRIVERR, _("AppArmor is not running"));
 
-	f = fopen(_PATH_PROC_ATTR_EXEC, "wx");
+	f = fopen(_PATH_PROC_ATTR_EXEC, "r+");
 	if (!f)
 		err(SETPRIV_EXIT_PRIVERR,
 		    _("cannot open %s"), _PATH_PROC_ATTR_EXEC);
 
-	fprintf(f, "changeprofile %s", label);
+	fprintf(f, "exec %s", label);
 
 	if (close_stream(f) != 0)
 		err(SETPRIV_EXIT_PRIVERR,
-- 
1.8.5.3

