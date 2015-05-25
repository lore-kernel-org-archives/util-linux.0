Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39829 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbbEYOBU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 25 May 2015 10:01:20 -0400
Date: Mon, 25 May 2015 16:01:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Martin Pitt <martin.pitt@ubuntu.com>
Cc: util-linux@vger.kernel.org, Werner Fink <werner@suse.de>
Subject: sulogin: Don't ask for password when it is locked/disabled 
Message-ID: <20150525140117.GA9697@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi all,

https://github.com/karelzak/util-linux/pull/200
this is Martin's request for a change to sulogin. 

It seems that Debian for last 10 years uses modified sulogin to
don't ask for password when /etc/shadow contains '!' or '*' as 
root password.

>From my point of view the request makes sense, because otherwise it's
impossible to enter shell in emergency more. BUT it also means that
systems with locked root accounts are less secure. 
 
(Note that bootloader maybe password protected and access to console 
 does not always mean physical access to machine in all situations (locked
 racks, console exported over network, virtual machines, etc.))

Any security objections, comments? 

Do we want this feature enabled by default or do we need extra
command line/compile option?

    Karel


 Below is my version of the patch. The original version has ignored
 console setup etc.

>From 9efacab320a06205f663bc317fcd26b50797a99b Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Mon, 25 May 2015 15:30:52 +0200
Subject: [PATCH] sulogin: Don't ask for password when it is locked/disabled

Some installations and distributions don't use a root account password
for security reasons and use sudo instead. In that case, asking for the
password makes no sense, and it is not even considered as valid as it's just
"*" or "!".

In these cases, just start a root shell. As both sulogin and getting
into single user mode/emergency.target require root access or physical
hardware access anyway, this is not a privilege escalation.

Based on patch from Martin Pitt <martin.pitt@ubuntu.com>.

Addresses: https://bugs.debian.org/326678
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/sulogin.8 |  2 ++
 login-utils/sulogin.c | 23 +++++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/login-utils/sulogin.8 b/login-utils/sulogin.8
index 17b07da..774f50c 100644
--- a/login-utils/sulogin.8
+++ b/login-utils/sulogin.8
@@ -33,6 +33,8 @@ Give root password for system maintenance
 .br
 (or type Control\-D for normal startup):
 .PP
+If the root account is locked, no password is required.
+.PP
 .B sulogin
 will be connected to the current terminal, or to the optional \fItty\fR device that
 can be specified on the command line (typically
diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index f376bfc..c6ff702 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -81,6 +81,16 @@ static volatile sig_atomic_t sigchild;
 # define IUCLC		0
 #endif
 
+static int locked_account_password(const char *passwd)
+{
+	if (passwd
+	    && (*passwd == '*' || *passwd == '!')
+	    && *(passwd + 1) == '\0')
+		return 1;
+
+	return 0;
+}
+
 #ifdef TIOCGLCKTRMIOS
 /*
  * For the case plymouth is found on this system
@@ -485,7 +495,6 @@ static struct passwd *getrootpwent(int try_manually)
 		p = line;
 		break;
 	}
-
 	fclose(fp);
 
 	/*
@@ -522,7 +531,8 @@ static struct passwd *getrootpwent(int try_manually)
 		warnx(_("%s: no entry for root"), _PATH_SHADOW_PASSWD);
 		*pwd.pw_passwd = '\0';
 	}
-	if (!valid(pwd.pw_passwd)) {
+	/* locked accont passwords are valid too */
+	if (!locked_account_password(pwd.pw_passwd) && !valid(pwd.pw_passwd)) {
 		warnx(_("%s: root password garbled"), _PATH_SHADOW_PASSWD);
 		*pwd.pw_passwd = '\0';
 	}
@@ -550,15 +560,15 @@ static void doprompt(const char *crypted, struct console *con)
 			goto err;
 	}
 #if defined(USE_ONELINE)
-	if (crypted[0])
+	if (crypted[0] && !locked_account_password(crypted))
 		fprintf(con->file, _("Give root password for login: "));
 	else
 		fprintf(con->file, _("Press Enter for login: "));
 #else
-	if (crypted[0])
+	if (crypted[0] && !locked_account_password(crypted))
 		fprintf(con->file, _("Give root password for maintenance\n"));
 	else
-		fprintf(con->file, _("Press Enter for maintenance"));
+		fprintf(con->file, _("Press Enter for maintenance\n"));
 	fprintf(con->file, _("(or press Control-D to continue): "));
 #endif
 	fflush(con->file);
@@ -1001,7 +1011,8 @@ int main(int argc, char **argv)
 				if ((answer = getpasswd(con)) == NULL)
 					break;
 
-				if (passwd[0] == '\0')
+				/* no password or locked account */
+				if (!passwd[0] || locked_account_password(passwd))
 					doshell++;
 				else {
 					const char *cryptbuf;
-- 
2.1.0


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
