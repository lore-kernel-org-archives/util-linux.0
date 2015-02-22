Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f49.google.com ([74.125.82.49]:50693 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbbBVOoh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:37 -0500
Received: by mail-wg0-f49.google.com with SMTP id l18so21239207wgh.8
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:36 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 24/31] more: add -i ignore-case posix compliance option
Date: Sun, 22 Feb 2015 14:43:20 +0000
Message-Id: <1424616207-747-25-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reference: http://pubs.opengroup.org/onlinepubs/7908799/xcu/more.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.1 |  3 +++
 text-utils/more.c | 10 +++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/text-utils/more.1 b/text-utils/more.1
index af1fdd4..e109e18 100644
--- a/text-utils/more.1
+++ b/text-utils/more.1
@@ -85,6 +85,9 @@ Squeeze multiple blank lines into one.
 .B \-u
 Suppress underlining.
 .TP
+.B \-i
+Ignore case distinctions in the pattern searches.
+.TP
 .BI \- number
 The screen size to use, in
 .I number
diff --git a/text-utils/more.c b/text-utils/more.c
index 15fd3a0..d83d5e3 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -163,6 +163,7 @@ struct more_control {
 		fold_opt:1,		/* fold long lines */
 		hard_term:1,		/* is this hard copy terminal */
 		hardtabs:1,		/* print spaces instead of '\t' */
+		ignore_case_opt:1,	/* case insensitive pattern search */
 		jumpopt:1,		/* is jumpline defined */
 		no_bell:1,		/* suppress bell */
 		no_intty:1,		/* is input in interactive mode */
@@ -200,6 +201,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -p          do not scroll, clean screen and display text\n"), out);
 	fputs(_(" -s          squeeze multiple blank lines into one\n"), out);
 	fputs(_(" -u          suppress underlining\n"), out);
+	fputs(_(" -i          ignore case when searching\n"), out);
 	fputs(_(" -<number>   the number of lines per screenful\n"), out);
 	fputs(_(" +<number>   display file beginning from line number\n"), out);
 	fputs(_(" +/<string>  display file beginning from search string match\n"), out);
@@ -251,6 +253,9 @@ static void argscan(struct more_control *ctl, char *s)
 		case 'u':
 			ctl->ul_opt = 0;
 			break;
+		case 'i':
+			ctl->ignore_case_opt = 1;
+			break;
 		case '-':
 		case ' ':
 		case '\t':
@@ -1252,13 +1257,16 @@ static void search(struct more_control *ctl, char buf[], FILE *file, int n)
 	long line3;
 	int lncount = 0;
 	int saveln, rc;
+	int flags = REG_NOSUB;
 	regex_t re;
 
 	ctl->context.line = saveln = ctl->current_line;
 	ctl->context.nrow = startline;
+	if (ctl->ignore_case_opt)
+		flags |= REG_ICASE;
 	if (!buf)
 		goto notfound;
-	if ((rc = regcomp(&re, buf, REG_NOSUB)) != 0) {
+	if ((rc = regcomp(&re, buf, flags)) != 0) {
 		char s[REGERR_BUF];
 		regerror(rc, &re, s, sizeof s);
 		more_error(ctl, s);
-- 
2.3.0

