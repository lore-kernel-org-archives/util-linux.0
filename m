Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:51341 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbbBVOoi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:38 -0500
Received: by mail-wi0-f175.google.com with SMTP id r20so11868900wiv.2
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:37 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 25/31] more: add -n <number> posix compliance option
Date: Sun, 22 Feb 2015 14:43:21 +0000
Message-Id: <1424616207-747-26-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The '-n <number>' is an alias of the existing '-number' functionality.

Reference: http://pubs.opengroup.org/onlinepubs/7908799/xcu/more.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/Makemodule.am | 2 +-
 text-utils/more.1        | 5 +++++
 text-utils/more.c        | 7 +++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/text-utils/Makemodule.am b/text-utils/Makemodule.am
index a24c10b..9688578 100644
--- a/text-utils/Makemodule.am
+++ b/text-utils/Makemodule.am
@@ -86,7 +86,7 @@ bin_PROGRAMS += more
 dist_man_MANS += text-utils/more.1
 more_SOURCES = text-utils/more.c text-utils/more-term.h
 more_CFLAGS = $(AM_CFLAGS) $(BSD_WARN_CFLAGS)
-more_LDADD = $(LDADD)
+more_LDADD = $(LDADD) libcommon.la
 if HAVE_TINFO
 more_LDADD += $(TINFO_LIBS)
 more_LDADD += $(TINFO_CFLAGS)
diff --git a/text-utils/more.1 b/text-utils/more.1
index e109e18..c289393 100644
--- a/text-utils/more.1
+++ b/text-utils/more.1
@@ -93,6 +93,11 @@ The screen size to use, in
 .I number
 of lines.
 .TP
+.BI \-n " number"
+Posix compliant alias of
+.BI \- number
+option.
+.TP
 .BI + number
 Start displaying each file at line
 .IR number .
diff --git a/text-utils/more.c b/text-utils/more.c
index d83d5e3..c5a41b8 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -203,6 +203,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -u          suppress underlining\n"), out);
 	fputs(_(" -i          ignore case when searching\n"), out);
 	fputs(_(" -<number>   the number of lines per screenful\n"), out);
+	fputs(_(" -n <number> same as -<number>\n"), out);
 	fputs(_(" +<number>   display file beginning from line number\n"), out);
 	fputs(_(" +/<string>  display file beginning from search string match\n"), out);
 	fputs(_(" -V          display version information and exit\n"), out);
@@ -232,6 +233,12 @@ static void argscan(struct more_control *ctl, char *s)
 			}
 			ctl->lines_per_screen = ctl->lines_per_screen * 10 + *s - '0';
 			break;
+		case 'n':
+			ctl->nfiles--;
+			if (!*++ctl->fnames)
+				errx(EXIT_FAILURE, "%s -- '%c'", _("option requires an argument"), 'n');
+			ctl->lines_per_screen = strtou16_or_err(*ctl->fnames, _("argument error"));
+			break;
 		case 'd':
 			ctl->no_bell = 1;
 			break;
-- 
2.3.0

