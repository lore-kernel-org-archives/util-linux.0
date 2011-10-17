Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: =?UTF-8?q?=5BPATCH=2002/49=5D=20login=3A=20remove=20dead=20code=20and=20comments?=
Date: Mon, 17 Oct 2011 13:14:41 +0200
Message-Id: <1318850128-23458-3-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |  103 ++++----------------------------------------------
 1 files changed, 9 insertions(+), 94 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index c02ce3b..118bda9 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -1,60 +1,13 @@
-/* This program is derived from 4.3 BSD software and is
-   subject to the copyright notice below.
-
-   The port to HP-UX has been motivated by the incapability
-   of 'rlogin'/'rlogind' as per HP-UX 6.5 (and 7.0) to transfer window sizes.
-
-   Changes:
-
-   - General HP-UX portation. Use of facilities not available
-     in HP-UX (e.g. setpriority) has been eliminated.
-     Utmp/wtmp handling has been ported.
-
-   - The program uses BSD command line options to be used
-     in connection with e.g. 'rlogind' i.e. 'new login'.
-
-   - HP features left out:	    password expiry
-				    '*' as login shell, add it if you need it
-
-   - BSD features left out:         quota checks
-   	                            password expiry
-				    analysis of terminal type (tset feature)
-
-   - BSD features thrown in:        Security logging to syslogd.
-                                    This requires you to have a (ported) syslog
-				    system -- 7.0 comes with syslog
-
-				    'Lastlog' feature.
-
-   - A lot of nitty gritty details have been adjusted in favour of
-     HP-UX, e.g. /etc/securetty, default paths and the environment
-     variables assigned by 'login'.
-
-   - We do *nothing* to setup/alter tty state, under HP-UX this is
-     to be done by getty/rlogind/telnetd/some one else.
-
-   Michael Glad (glad@daimi.dk)
-   Computer Science Department
-   Aarhus University
-   Denmark
-
-   1990-07-04
-
-   1991-09-24 glad@daimi.aau.dk: HP-UX 8.0 port:
-   - now explictly sets non-blocking mode on descriptors
-   - strcasecmp is now part of HP-UX
-
-   1992-02-05 poe@daimi.aau.dk: Ported the stuff to Linux 0.12
-   From 1992 till now (1997) this code for Linux has been maintained at
-   ftp.daimi.aau.dk:/pub/linux/poe/
-
-   1999-02-22 Arkadiusz Mi¶kiewicz <misiek@pld.ORG.PL>
-    - added Native Language Support
-   Sun Mar 21 1999 - Arnaldo Carvalho de Melo <acme@conectiva.com.br>
-    - fixed strerr(errno) in gettext calls
- */
-
 /*
+ * login(1)
+ *
+ * This program is derived from 4.3 BSD software and is subject to the
+ * copyright notice below.
+ *
+ * Michael Glad (glad@daimi.dk)
+ * Computer Science Department, Aarhus University, Denmark
+ * 1990-07-04
+ *
  * Copyright (c) 1980, 1987, 1988 The Regents of the University of California.
  * All rights reserved.
  *
@@ -70,15 +23,7 @@
  * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
-
-/*
- * login [ name ]
- * login -h hostname	(for telnetd, etc.)
- * login -f name	(for pre-authenticated login: datakit, xterm, etc.)
- */
-
 #include <sys/param.h>
-
 #include <stdio.h>
 #include <ctype.h>
 #include <unistd.h>
@@ -91,8 +36,6 @@
 #include <sys/file.h>
 #include <termios.h>
 #include <string.h>
-#define index strchr
-#define rindex strrchr
 #include <sys/ioctl.h>
 #include <sys/wait.h>
 #include <signal.h>
@@ -567,12 +510,6 @@ main(int argc, char **argv)
 
     openlog("login", LOG_ODELAY, LOG_AUTHPRIV);
 
-#if 0
-    /* other than iso-8859-1 */
-    printf("\033(K");
-    fprintf(stderr,"\033(K");
-#endif
-
 #ifdef HAVE_SECURITY_PAM_MISC_H
     /*
      * username is initialized to NULL
@@ -603,15 +540,6 @@ main(int argc, char **argv)
     retcode = pam_set_item(pamh, PAM_USER_PROMPT, _("login: "));
     PAM_FAIL_CHECK;
 
-#if 0
-    /*
-     * other than iso-8859-1
-     * one more time due to reset tty by PAM
-     */
-    printf("\033(K");
-    fprintf(stderr,"\033(K");
-#endif
-
     if (username) {
 	/* we need't the original username. We have to follow PAM. */
 	free(username);
@@ -963,18 +891,6 @@ Michael Riepe <michael@stud.uni-hannover.de>
 #if HAVE_UPDWTMP
 	updwtmp(_PATH_WTMP, &ut);
 #else
-#if 0
-	/* The O_APPEND open() flag should be enough to guarantee
-	   atomic writes at end of file. */
-	{
-	    int wtmp;
-
-	    if((wtmp = open(_PATH_WTMP, O_APPEND|O_WRONLY)) >= 0) {
-		write(wtmp, (char *)&ut, sizeof(ut));
-		close(wtmp);
-	    }
-	}
-#else
 	/* Probably all this locking below is just nonsense,
 	   and the short version is OK as well. */
 	{
@@ -990,7 +906,6 @@ Michael Riepe <michael@stud.uni-hannover.de>
 	    }
 	}
 #endif
-#endif
     }
 
     logaudit(tty_name, username, hostname, pwd, 1);
-- 
1.7.6.4
