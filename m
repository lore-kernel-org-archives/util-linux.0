Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f176.google.com ([209.85.214.176]:57263 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbaCIUal (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Mar 2014 16:30:41 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp18so6211746obc.35
        for <util-linux@vger.kernel.org>; Sun, 09 Mar 2014 13:30:40 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/10] kill: tell what is wrong rather than output usage()
Date: Sun,  9 Mar 2014 15:30:21 -0500
Message-Id: <1394397023-7050-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
References: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Getting usage as error message is not specific enough.  As a user I want
to know what is wrong, and if it is unclear after error message how to
recover then I run command with --help.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/kill.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index 34bd00e..30c209f 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -212,7 +212,7 @@ int main(int argc, char **argv)
 				return EXIT_SUCCESS;
 			}
 			if (2 < argc)
-				usage(stderr);
+				errx(EXIT_FAILURE, _("too many arguments"));
 			/* argc == 2, accept "kill -l $?" */
 			arg = argv[1];
 			if ((ctl.numsig = arg_to_signum(arg, 1)) < 0)
@@ -236,15 +236,15 @@ int main(int argc, char **argv)
 		if (!strcmp(arg, "-p") || !strcmp(arg, "--pid")) {
 			ctl.do_pid = 1;
 			if (ctl.do_kill)
-				usage(stderr);
+				errx(EXIT_FAILURE, _("%s and %s are mutually exclusive"), "--pid", "--signal");
 			continue;
 		}
 		if (!strcmp(arg, "-s") || !strcmp(arg, "--signal")) {
 			if (argc < 2)
-				usage(stderr);
+				errx(EXIT_FAILURE, _("not enough arguments"));
 			ctl.do_kill = 1;
 			if (ctl.do_pid)
-				usage(stderr);
+				errx(EXIT_FAILURE, _("%s and %s are mutually exclusive"), "--pid", "--signal");
 			argc--, argv++;
 			arg = *argv;
 			if ((ctl.numsig = arg_to_signum(arg, 0)) < 0) {
@@ -255,7 +255,7 @@ int main(int argc, char **argv)
 		}
 		if (!strcmp(arg, "-q") || !strcmp(arg, "--queue")) {
 			if (argc < 2)
-				usage(stderr);
+				errx(EXIT_FAILURE, _("option '%s' requires an argument"), arg);
 			argc--, argv++;
 			arg = *argv;
 #ifdef HAVE_SIGQUEUE
@@ -277,14 +277,14 @@ int main(int argc, char **argv)
 			break;
 		arg++;
 		if ((ctl.numsig = arg_to_signum(arg, 0)) < 0)
-			usage(stderr);
+			errx(EXIT_FAILURE, _("invalid sigval argument"));
 		ctl.do_kill = 1;
 		if (ctl.do_pid)
-			usage(stderr);
+			errx(EXIT_FAILURE, _("%s and %s are mutually exclusive"), "--pid", "--signal");
 		continue;
 	}
 	if (!*argv)
-		usage(stderr);
+		errx(EXIT_FAILURE, _("not enough arguments"));
 	if (ctl.do_pid)
 		ctl.numsig = -1;
 
-- 
1.9.0

