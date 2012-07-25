Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:63323 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab2GYTQI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:16:08 -0400
Received: by mail-we0-f174.google.com with SMTP id x8so794233wey.19
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:16:07 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 18/19] script: add noreturn function attributes
Date: Wed, 25 Jul 2012 21:15:39 +0200
Message-Id: <1343243745-1172-22-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 8d7ab65..ccd8873 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -289,7 +289,7 @@ main(int argc, char **argv) {
 	return EXIT_SUCCESS;
 }
 
-void
+void __attribute__((__noreturn__))
 doinput(void) {
 	ssize_t cc;
 	char ibuf[BUFSIZ];
@@ -345,7 +345,7 @@ my_strftime(char *buf, size_t len, const char *fmt, const struct tm *tm) {
 	strftime(buf, len, fmt, tm);
 }
 
-void
+void __attribute__((__noreturn__))
 dooutput(FILE *timingfd) {
 	ssize_t cc;
 	time_t tvec;
@@ -412,7 +412,7 @@ dooutput(FILE *timingfd) {
 	done();
 }
 
-void
+void __attribute__((__noreturn__))
 doshell(void) {
 	char *shname;
 
@@ -462,14 +462,14 @@ fixtty(void) {
 	tcsetattr(STDIN_FILENO, TCSANOW, &rtt);
 }
 
-void
+void __attribute__((__noreturn__))
 fail(void) {
 
 	kill(0, SIGTERM);
 	done();
 }
 
-void
+void __attribute__((__noreturn__))
 done(void) {
 	time_t tvec;
 
-- 
1.7.11.3

