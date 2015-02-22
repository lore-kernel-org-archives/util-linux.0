Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:64444 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbbBVOl5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:41:57 -0500
Received: by mail-wi0-f176.google.com with SMTP id h11so11808045wiw.3
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:41:56 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 01/16] whereis: tell when mandatory option is missing
Date: Sun, 22 Feb 2015 14:41:31 +0000
Message-Id: <1424616106-580-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/whereis.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index 9fc5ee7..c47e122 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -495,7 +495,7 @@ int main(int argc, char **argv)
 {
 	struct wh_dirlist *ls = NULL;
 	int want = ALL_DIRS;
-	int i, want_resetable = 0;
+	int i, want_resetable = 0, opt_f_missing = 0;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -540,6 +540,7 @@ int main(int argc, char **argv)
 
 			switch (*arg) {
 			case 'f':
+				opt_f_missing = 0;
 				break;
 			case 'u':
 				uflag = 1;
@@ -551,6 +552,7 @@ int main(int argc, char **argv)
 				free_dirlist(&ls, BIN_DIR);
 				construct_dirlist_from_argv(
 					&ls, &i, argc, argv, BIN_DIR);
+				opt_f_missing = 1;
 				break;
 			case 'M':
 				if (*(arg + 1))
@@ -559,6 +561,7 @@ int main(int argc, char **argv)
 				free_dirlist(&ls, MAN_DIR);
 				construct_dirlist_from_argv(
 					&ls, &i, argc, argv, MAN_DIR);
+				opt_f_missing = 1;
 				break;
 			case 'S':
 				if (*(arg + 1))
@@ -567,6 +570,7 @@ int main(int argc, char **argv)
 				free_dirlist(&ls, SRC_DIR);
 				construct_dirlist_from_argv(
 					&ls, &i, argc, argv, SRC_DIR);
+				opt_f_missing = 1;
 				break;
 			case 'b':
 				if (want_resetable) {
@@ -607,5 +611,7 @@ int main(int argc, char **argv)
 	}
 
 	free_dirlist(&ls, ALL_DIRS);
+	if (opt_f_missing)
+		errx(EXIT_FAILURE, _("option -f missing"));
 	return EXIT_SUCCESS;
 }
-- 
2.3.0

