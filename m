Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oa0-f41.google.com ([209.85.219.41]:46380 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbaCIUad (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Mar 2014 16:30:33 -0400
Received: by mail-oa0-f41.google.com with SMTP id j17so6317471oag.28
        for <util-linux@vger.kernel.org>; Sun, 09 Mar 2014 13:30:33 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/10] kill: flip all comparions to be in smaller - greater order
Date: Sun,  9 Mar 2014 15:30:16 -0500
Message-Id: <1394397023-7050-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
References: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This makes code more readable.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/kill.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index e7bf5f4..877c24e 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -170,7 +170,7 @@ int main(int argc, char **argv)
 	/* Loop through the arguments.  Actually, -a is the only option
 	 * can be used with other options.  The 'kill' is basically a
 	 * one-option-at-most program. */
-	for (argc--, argv++; argc > 0; argc--, argv++) {
+	for (argc--, argv++; 0 < argc; argc--, argv++) {
 		arg = *argv;
 		if (*arg != '-')
 			break;
@@ -195,7 +195,7 @@ int main(int argc, char **argv)
 				printsignals(stdout, 0);
 				return EXIT_SUCCESS;
 			}
-			if (argc > 2)
+			if (2 < argc)
 				return usage(EXIT_FAILURE);
 			/* argc == 2, accept "kill -l $?" */
 			arg = argv[1];
@@ -322,7 +322,7 @@ static int rtsig_to_signum(char *sig)
 	if (!ep || sig == ep || errno || num < 0)
 		return -1;
 	num = maxi ? SIGRTMAX - num : SIGRTMIN + num;
-	if (num < SIGRTMIN || num > SIGRTMAX)
+	if (num < SIGRTMIN || SIGRTMAX < num)
 		return -1;
 	return num;
 }
@@ -354,9 +354,9 @@ static int arg_to_signum(char *arg, int maskbit)
 
 	if (isdigit(*arg)) {
 		numsig = strtol(arg, &ep, 10);
-		if (numsig >= NSIG && maskbit && (numsig & 128) != 0)
+		if (NSIG <= numsig && maskbit && (numsig & 128) != 0)
 			numsig -= 128;
-		if (*ep != 0 || numsig < 0 || numsig >= NSIG)
+		if (*ep != 0 || numsig < 0 || NSIG <= numsig)
 			return (-1);
 		return (numsig);
 	}
@@ -380,7 +380,7 @@ static void printsig(int sig)
 		}
 	}
 #ifdef SIGRTMIN
-	if (sig >= SIGRTMIN && sig <= SIGRTMAX) {
+	if (SIGRTMIN <= sig && sig <= SIGRTMAX) {
 		printf("RT%d\n", sig - SIGRTMIN);
 		return;
 	}
@@ -407,7 +407,7 @@ static void printsignals(FILE *fp, int pretty)
 	if (!pretty) {
 		for (n = 0; n < ARRAY_SIZE(sys_signame); n++) {
 			lth = 1 + strlen(sys_signame[n].name);
-			if (lpos + lth > 72) {
+			if (72 < lpos + lth) {
 				fputc('\n', fp);
 				lpos = 0;
 			} else if (lpos)
-- 
1.9.0

