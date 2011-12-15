Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52330 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756375Ab1LOTCN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 15 Dec 2011 14:02:13 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so2430546eek.19
        for <util-linux@vger.kernel.org>; Thu, 15 Dec 2011 11:02:12 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH] agetty: add static and const qualifiers
Date: Thu, 15 Dec 2011 20:02:06 +0100
Message-Id: <1323975726-21812-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Remove also a static qualifier in main() function.

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 term-utils/agetty.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 041e1f7..86902a1 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -190,7 +190,7 @@ struct chardata {
 };
 
 /* Initial values for the above. */
-struct chardata init_chardata = {
+static const struct chardata init_chardata = {
 	DEF_ERASE,		/* default erase character */
 	DEF_KILL,		/* default kill character */
 	13,			/* default eol char */
@@ -203,7 +203,7 @@ struct Speedtab {
 	speed_t code;
 };
 
-static struct Speedtab speedtab[] = {
+static const struct Speedtab speedtab[] = {
 	{50, B50},
 	{75, B75},
 	{110, B110},
@@ -282,7 +282,7 @@ int main(int argc, char **argv)
 	char *username = NULL;			/* login name, given to /bin/login */
 	struct chardata chardata;		/* will be set by get_logname() */
 	struct termios termios;			/* terminal mode bits */
-	static struct options options = {
+	struct options options = {
 		.flags  =  F_ISSUE,		/* show /etc/issue (SYSV_STYLE) */
 		.login  =  _PATH_LOGIN,		/* default login program */
 		.tty    = "tty1",		/* default tty line */
@@ -1636,7 +1636,7 @@ static int caps_lock(char *s)
 /* Convert speed string to speed code; return 0 on failure. */
 static speed_t bcode(char *s)
 {
-	struct Speedtab *sp;
+	const struct Speedtab *sp;
 	long speed = atol(s);
 
 	for (sp = speedtab; sp->speed; sp++)
-- 
1.7.3.4

