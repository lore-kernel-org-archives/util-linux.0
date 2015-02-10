Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:56625 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753771AbbBJVaw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Feb 2015 16:30:52 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 385DEAC27
	for <util-linux@vger.kernel.org>; Tue, 10 Feb 2015 21:30:51 +0000 (UTC)
Message-ID: <54DA788A.4080706@suse.cz>
Date: Tue, 10 Feb 2015 22:30:50 +0100
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH 1/3] script: Split doexec() out of doshell()
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Create doshell() that will be needed by --interactive.
---
 term-utils/script.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 02ba596..14a44e1 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -90,6 +90,7 @@ void getmaster(void);
 void getslave(void);
 void doinput(void);
 void dooutput(void);
+void doexec(void);
 void doshell(void);
 
 char	*shell;
@@ -508,9 +509,32 @@ dooutput(void) {
 }
 
 void
-doshell(void) {
+doexec(void) {
 	char *shname;
 
+	shname = strrchr(shell, '/');
+	if (shname)
+		shname++;
+	else
+		shname = shell;
+
+	if (access(shell, X_OK) == 0) {
+		if (cflg)
+			execl(shell, shname, "-c", cflg, NULL);
+		else
+			execl(shell, shname, "-i", NULL);
+	} else {
+		if (cflg)
+			execlp(shname, "-c", cflg, NULL);
+		else
+			execlp(shname, "-i", NULL);
+	}
+	warn(_("failed to execute %s"), shell);
+	fail();
+}
+
+void
+doshell(void) {
 	getslave();
 
 	/* close things irrelevant for this process */
@@ -528,12 +552,6 @@ doshell(void) {
 
 	master = -1;
 
-	shname = strrchr(shell, '/');
-	if (shname)
-		shname++;
-	else
-		shname = shell;
-
 	/*
 	 * When invoked from within /etc/csh.login, script spawns a csh shell
 	 * that spawns programs that cannot be killed with a SIGTERM. This is
@@ -544,19 +562,7 @@ doshell(void) {
 	 */
 	signal(SIGTERM, SIG_DFL);
 
-	if (access(shell, X_OK) == 0) {
-		if (cflg)
-			execl(shell, shname, "-c", cflg, NULL);
-		else
-			execl(shell, shname, "-i", NULL);
-	} else {
-		if (cflg)
-			execlp(shname, "-c", cflg, NULL);
-		else
-			execlp(shname, "-i", NULL);
-	}
-	warn(_("failed to execute %s"), shell);
-	fail();
+	doexec();
 }
 
 void
-- 
2.2.2

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
