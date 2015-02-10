Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:56636 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752827AbbBJVbL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Feb 2015 16:31:11 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 9FFFDAC27
	for <util-linux@vger.kernel.org>; Tue, 10 Feb 2015 21:31:10 +0000 (UTC)
Message-ID: <54DA789E.201@suse.cz>
Date: Tue, 10 Feb 2015 22:31:10 +0100
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH 2/3] script: Initialize isterm and shell earlier in main()
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

isterm and shell initialized early in main() will be needed by --interactive.
---
 term-utils/script.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 14a44e1..ed8e83d 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -236,6 +236,12 @@ main(int argc, char **argv) {
 	argc -= optind;
 	argv += optind;
 
+	shell = getenv("SHELL");
+	if (shell == NULL)
+		shell = _PATH_BSHELL;
+
+	isterm = isatty(STDIN_FILENO);
+
 	if (argc > 0)
 		fname = argv[0];
 	else {
@@ -248,10 +254,6 @@ main(int argc, char **argv) {
 		fail();
 	}
 
-	shell = getenv("SHELL");
-	if (shell == NULL)
-		shell = _PATH_BSHELL;
-
 	getmaster();
 	if (!qflg)
 		printf(_("Script started, file is %s\n"), fname);
@@ -635,8 +637,6 @@ getmaster(void) {
 #if defined(HAVE_LIBUTIL) && defined(HAVE_PTY_H)
 	int rc;
 
-	isterm = isatty(STDIN_FILENO);
-
 	if (isterm) {
 		if (tcgetattr(STDIN_FILENO, &tt) != 0)
 			err(EXIT_FAILURE, _("failed to get terminal attributes"));
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
