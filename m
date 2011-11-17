Return-Path: kukuk@suse.de
Date: Thu, 17 Nov 2011 11:31:47 +0100
From: Thorsten Kukuk <kukuk@suse.de>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Ludwig Nussel <ludwig.nussel@suse.de>
Subject: Re: login: PAM-only, login.defs, -H
Message-ID: <20111117103147.GA6195@suse.de>
References: <20111017110210.GA22648@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20111017110210.GA22648@nb.net.home>
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 17, Karel Zak wrote:

>  Git tree: https://karelzak@github.com/karelzak/util-linux.git branch 'login'.
>  URL: https://github.com/karelzak/util-linux/tree/login

Ok, I found one bug: pam_setcred() is only called after pam_open_session(),
but has to be called before:

--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -868,15 +868,15 @@ static void loginpam_session(struct login_context *cxt)
        int rc;
        pam_handle_t *pamh = cxt->pamh;
 
-       rc = pam_open_session(pamh, 0);
-       if (is_pam_failure(rc))
-               loginpam_err(pamh, rc);
-
        rc = pam_setcred(pamh, PAM_ESTABLISH_CRED);
        if (is_pam_failure(rc)) {
                pam_close_session(pamh, 0);
                loginpam_err(pamh, rc);
        }
+
+       rc = pam_open_session(pamh, 0);
+       if (is_pam_failure(rc))
+               loginpam_err(pamh, rc);
 }
 


Another problem with current git is:
prlimit.c: In function ‘prlimit’:
prlimit.c:142:17: error: ‘SYS_prlimit64’ undeclared (first use in this function)
prlimit.c:142:17: note: each undeclared identifier is reported only once for each function it appears in

  Thorsten

-- 
Thorsten Kukuk, Project Manager/Release Manager SLES
SUSE LINUX Products GmbH, Maxfeldstr. 5, D-90409 Nuernberg
GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer, HRB 16746 (AG Nürnberg)
