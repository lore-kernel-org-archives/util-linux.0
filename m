Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32992 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbdCEUwv (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Mar 2017 15:52:51 -0500
Received: by mail-wm0-f67.google.com with SMTP id n11so10897591wma.0
        for <util-linux@vger.kernel.org>; Sun, 05 Mar 2017 12:52:50 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 12/13] docs: improve boilerplate.c options example
Date: Sun,  5 Mar 2017 20:52:31 +0000
Message-Id: <20170305205232.24030-13-kerolasa@iki.fi>
In-Reply-To: <20170305205232.24030-1-kerolasa@iki.fi>
References: <20170305205232.24030-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Make usage() translations to contain complete option help in single
translation unit.  And make -z option example complete.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/boilerplate.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/boilerplate.c b/Documentation/boilerplate.c
index b210cc363..7da9374d4 100644
--- a/Documentation/boilerplate.c
+++ b/Documentation/boilerplate.c
@@ -39,11 +39,11 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -r, --required <arg>    option requires an argument\n"), out);
 	fputs(_(" -z                      no long option\n"), out);
 	fputs(_("     --xyzzy             a long option only\n"), out);
-	fputs(_(" -e, --extremely-long-long-option\n"), out);
-	fputs(_("                         use next line for description when needed\n"), out);
-	fputs(_(" -l, --long-explanation  an example of very verbose, and chatty option\n"), out);
-	fputs(_("                           description on two, or multiple lines, where the\n"), out);
-	fputs(_("                           consecutive lines are intended by two spaces\n"), out);
+	fputs(_(" -e, --extremely-long-long-option\n"
+		"                         use next line for description when needed\n"), out);
+	fputs(_(" -l, --long-explanation  an example of very verbose, and chatty option\n"
+		"                           description on two, or multiple lines, where the\n"
+		"                           consecutive lines are intended by two spaces\n"), out);
 	fputs(_(" -f, --foobar            next option description resets indent\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
@@ -77,11 +77,12 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((c = getopt_long(argc, argv, "nr:elfVh", longopts, NULL)) != -1)
+	while ((c = getopt_long(argc, argv, "nr:zelfVh", longopts, NULL)) != -1)
 		switch (c) {
 		case 'n':
 		case OPT_OPTIONAL:
 		case 'r':
+		case 'z':
 		case OPT_XYZZY:
 		case 'e':
 		case 'l':
-- 
2.12.0

