Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:36708 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbaBHRP5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Feb 2014 12:15:57 -0500
From: Phillip Susi <psusi@ubuntu.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] more: comply with howto-usage-function.txt
Date: Sat,  8 Feb 2014 12:15:55 -0500
Message-Id: <1391879755-11534-1-git-send-email-psusi@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add angle brackets around the -<num> argument to make it
clear that this is a number, and not the word "NUM"

Signed-off-by: Phillip Susi <psusi@ubuntu.com>
---
 text-utils/more.1 | 4 ++--
 text-utils/more.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/text-utils/more.1 b/text-utils/more.1
index 479f037..b6b6585 100644
--- a/text-utils/more.1
+++ b/text-utils/more.1
@@ -59,7 +59,7 @@ environment variable
 override them.
 .It Fl num
 .TP
-.B \-number
+.B \-<number>
 This option specifies an integer
 .I number
 which is the screen size (in lines).
@@ -106,7 +106,7 @@ The
 option specifies a string that will be searched for before each file is
 displayed.
 .TP
-.B +number
+.B +<number>
 Start at line
 .IR number .
 .SH COMMANDS
diff --git a/text-utils/more.c b/text-utils/more.c
index 4c39887..1a93257 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -327,8 +327,8 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		  "  -c        do not scroll, display text and clean line ends\n"
 		  "  -u        suppress underlining\n"
 		  "  -s        squeeze multiple blank lines into one\n"
-		  "  -NUM      specify the number of lines per screenful\n"
-		  "  +NUM      display file beginning from line number NUM\n"
+		  "  -<NUM>    specify NUM number of lines per screenful\n"
+		  "  +<NUM>    display file beginning from line number NUM\n"
 		  "  +/STRING  display file beginning from search string match\n"
 		  "  -V        output version information and exit\n"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
-- 
1.8.3.2

