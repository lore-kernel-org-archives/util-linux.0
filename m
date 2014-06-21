Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-h31.telenor.se ([213.150.131.4]:51256 "EHLO
	smtprelay-h31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbaFUXgE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 21 Jun 2014 19:36:04 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-h31.telenor.se (Postfix) with ESMTP id EDE65C0DF
	for <util-linux@vger.kernel.org>; Sun, 22 Jun 2014 01:03:13 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: James Hunt <james.hunt@ubuntu.com>, Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] script: --quiet option is not quiet.
Date: Sun, 22 Jun 2014 01:03:04 +0200
Message-Id: <1403391784-9912-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: James Hunt <james.hunt@ubuntu.com>

Specifying 'script --quiet ...' still produces the 'Script started'
message in the typescript file. The --quiet option implies that the
script program should not log any of its output to the typescript file.

Originally reported at:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=693966

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 term-utils/script.1 | 3 ++-
 term-utils/script.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/term-utils/script.1 b/term-utils/script.1
index 60a0e53..67e1066 100644
--- a/term-utils/script.1
+++ b/term-utils/script.1
@@ -82,7 +82,8 @@ Allow the default output destination, i.e. the typescript file, to be a hard
 or symbolic link.  The command will follow a symbolic link.
 .TP
 \fB\-q\fR, \fB\-\-quiet\fR
-Be quiet.
+Be quiet (do not write start and done messages to either standard output
+or the typescript file).
 .TP
 \fB\-t\fR, \fB\-\-timing\fR[=\fIfile\fR]
 Output timing data to standard error, or to
diff --git a/term-utils/script.c b/term-utils/script.c
index 1530e67..21fb5af 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -437,7 +437,8 @@ dooutput(void) {
 
 	tvec = time((time_t *)NULL);
 	my_strftime(obuf, sizeof obuf, "%c\n", localtime(&tvec));
-	fprintf(fscript, _("Script started on %s"), obuf);
+	if (!qflg)
+		fprintf(fscript, _("Script started on %s"), obuf);
 
 	FD_ZERO(&readfds);
 
-- 
2.0.0

