Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 01/49] login: remove kerberos specific code
Date: Mon, 17 Oct 2011 13:14:40 +0200
Message-Id: <1318850128-23458-2-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

The code has not been used ever. If you want to use kerberos then us
PAM...

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |   24 ------------------------
 1 files changed, 0 insertions(+), 24 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index 9662336..c02ce3b 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -842,30 +842,6 @@ main(int argc, char **argv)
 	p = crypt(pp, salt);
 	setpriority(PRIO_PROCESS, 0, 0);
 
-#  ifdef KERBEROS
-	/*
-	 * If not present in pw file, act as we normally would.
-	 * If we aren't Kerberos-authenticated, try the normal
-	 * pw file for a password.  If that's ok, log the user
-	 * in without issueing any tickets.
-	 */
-
-	if (pwd && !krb_get_lrealm(realm,1)) {
-	    /*
-	     * get TGT for local realm; be careful about uid's
-	     * here for ticket file ownership
-	     */
-	    setreuid(geteuid(),pwd->pw_uid);
-	    kerror = krb_get_pw_in_tkt(pwd->pw_name, "", realm,
-				       "krbtgt", realm, DEFAULT_TKT_LIFE, pp);
-	    setuid(0);
-	    if (kerror == INTK_OK) {
-		memset(pp, 0, strlen(pp));
-		notickets = 0;	/* user got ticket */
-		break;
-	    }
-	}
-#  endif /* KERBEROS */
 	memset(pp, 0, strlen(pp));
 
 	if (pwd && !strcmp(p, pwd->pw_passwd))
-- 
1.7.6.4
