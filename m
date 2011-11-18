Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35989 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753502Ab1KRMOY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 18 Nov 2011 07:14:24 -0500
Date: Fri, 18 Nov 2011 13:14:20 +0100
From: Karel Zak <kzak@redhat.com>
To: Thorsten Kukuk <kukuk@suse.de>
Cc: util-linux@vger.kernel.org, Ludwig Nussel <ludwig.nussel@suse.de>
Subject: Re: login: PAM-only, login.defs, -H
Message-ID: <20111118121420.GQ7916@nb.net.home>
References: <20111017110210.GA22648@nb.net.home> <20111117103147.GA6195@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20111117103147.GA6195@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 17, 2011 at 11:31:47AM +0100, Thorsten Kukuk wrote:
> On Mon, Oct 17, Karel Zak wrote:
> 
> >  Git tree: https://karelzak@github.com/karelzak/util-linux.git branch 'login'.
> >  URL: https://github.com/karelzak/util-linux/tree/login
> 
> Ok, I found one bug: pam_setcred() is only called after pam_open_session(),
> but has to be called before:

 Well, this is discussable... login(1) for years called pam_setcred()
 after pam_open_session(), but I agree it's not optional.
 
 After discussion with our PAM maintainer we decided that the best is
 probably to use PAM_ESTABLISH_CRED before and PAM_REINITIALIZE_CRED
 after pam_open_session(). This solution should be probably the most
 robust (it's probably used by openssh). 
 
 For example pam_krb5 should be ready for such usage.

 Please, git pull (or see the patch below) and test it.

> Another problem with current git is:
> prlimit.c: In function ‘prlimit’:
> prlimit.c:142:17: error: ‘SYS_prlimit64’ undeclared (first use in this function)
> prlimit.c:142:17: note: each undeclared identifier is reported only once for each function it appears in

 Fixed.

 Thanks!
    Karel

>From 34f7ea15c10fb72db73257c697156797832337c6 Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Fri, 18 Nov 2011 12:26:19 +0100
Subject: [PATCH] login: improve pam_setcred() usage

Reported-by: Thorsten Kukuk <kukuk@suse.de>
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index 93ed2d6..0d6c390 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -863,16 +863,37 @@ static void loginpam_acct(struct login_context *cxt)
 	}
 }
 
+/*
+ * Note that position of the pam_setcred() call is discussable:
+ *
+ *  - the PAM docs recommends pam_setcred() before pam_open_session()
+ *  - but the original RFC http://www.opengroup.org/rfc/mirror-rfc/rfc86.0.txt
+ *    uses pam_setcred() after pam_open_session()
+ *
+ * The old login versions (before year 2011) followed the RFC. This is probably
+ * not optimal, because there could be dependence between some session modules
+ * and user's credentials.
+ *
+ * The best is probably to follow openssh and call pam_setcred() before and
+ * after pam_open_session().                -- kzak@redhat.com (18-Nov-2011)
+ *
+ */
 static void loginpam_session(struct login_context *cxt)
 {
 	int rc;
 	pam_handle_t *pamh = cxt->pamh;
 
-	rc = pam_open_session(pamh, 0);
+	rc = pam_setcred(pamh, PAM_ESTABLISH_CRED);
 	if (is_pam_failure(rc))
 		loginpam_err(pamh, rc);
 
-	rc = pam_setcred(pamh, PAM_ESTABLISH_CRED);
+	rc = pam_open_session(pamh, 0);
+	if (is_pam_failure(rc)) {
+		pam_setcred(cxt->pamh, PAM_DELETE_CRED);
+		loginpam_err(pamh, rc);
+	}
+
+	rc = pam_setcred(pamh, PAM_REINITIALIZE_CRED);
 	if (is_pam_failure(rc)) {
 		pam_close_session(pamh, 0);
 		loginpam_err(pamh, rc);
-- 
1.7.6.4

