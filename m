Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:50658 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752105AbdFVChu (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Jun 2017 22:37:50 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHal6-1dMl0K1EOC-003MXY for
 <util-linux@vger.kernel.org>; Thu, 22 Jun 2017 04:37:48 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 07/13] setarch: use errtryhelp()
Date: Thu, 22 Jun 2017 04:37:40 +0200
Message-Id: <1498099066-24235-8-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
References: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/setarch.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index 6481eb2..9aec34f 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -84,7 +84,7 @@
 
 static int archwrapper;
 
-static void __attribute__((__noreturn__)) show_help(void)
+static void __attribute__((__noreturn__)) usage(void)
 {
 	fputs(USAGE_HEADER, stdout);
 	if (!archwrapper)
@@ -121,17 +121,6 @@ static void __attribute__((__noreturn__)) show_help(void)
 	exit(EXIT_SUCCESS);
 }
 
-static void __attribute__((__noreturn__)) show_usage(const char *s)
-{
-	if (s)
-		errx(EXIT_FAILURE,
-		     _("%s\nTry `%s --help' for more information."), s,
-		     program_invocation_short_name);
-	else
-		errx(EXIT_FAILURE, _("Try `%s --help' for more information."),
-		     program_invocation_short_name);
-}
-
 static void __attribute__((__noreturn__))
     show_version(void)
 {
@@ -301,9 +290,10 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	if (argc < 2)
-		show_usage(_("Not enough arguments"));
-
+	if (argc < 2) {
+		warnx(_("Not enough arguments"));
+		errtryhelp(EXIT_FAILURE);
+	}
 	archwrapper = strcmp(program_invocation_short_name, "setarch") != 0;
 	if (archwrapper)
 		arch = program_invocation_short_name;	/* symlinks to setarch */
@@ -328,7 +318,7 @@ int main(int argc, char *argv[])
 	while ((c = getopt_long(argc, argv, "+hVv3BFILRSTXZ", longopts, NULL)) != -1) {
 		switch (c) {
 		case 'h':
-			show_help();
+			usage();
 			break;
 		case 'V':
 			show_version();
-- 
1.8.5.6

