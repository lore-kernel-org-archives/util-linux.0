Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35530 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbbBVOnT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:43:19 -0500
Received: by mail-wg0-f44.google.com with SMTP id k14so21307423wgh.3
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:43:18 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 09/12] script: replace strftime() workaround with CFLAGS = -Wno-format-y2k
Date: Sun, 22 Feb 2015 14:42:46 +0000
Message-Id: <1424616169-693-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
References: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Nowadays, gcc(1) provides the -Wno-format-y2k option to prevent the
warning, so that the above workaround is no longer required.

Reference: http://man7.org/linux/man-pages/man3/strftime.3.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/Makemodule.am |  1 +
 term-utils/script.c      | 11 +----------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/term-utils/Makemodule.am b/term-utils/Makemodule.am
index e7ac707..2bf916c 100644
--- a/term-utils/Makemodule.am
+++ b/term-utils/Makemodule.am
@@ -2,6 +2,7 @@ if BUILD_SCRIPT
 usrbin_exec_PROGRAMS += script
 dist_man_MANS += term-utils/script.1
 script_SOURCES = term-utils/script.c
+script_CFLAGS = $(AM_CFLAGS) -Wno-format-y2k
 script_LDADD = $(LDADD)
 if HAVE_UTIL
 script_LDADD += -lutil
diff --git a/term-utils/script.c b/term-utils/script.c
index 08bd922..4709e10 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -149,15 +149,6 @@ static void die_if_link(const struct script_control *ctl)
 		       "Program not started."), ctl->fname);
 }
 
-/*
- * Stop extremely silly gcc complaint on %c:
- *  warning: `%c' yields only last 2 digits of year in some locales
- */
-static void my_strftime(char *buf, size_t len, const char *fmt, const struct tm *tm)
-{
-	strftime(buf, len, fmt, tm);
-}
-
 static void __attribute__((__noreturn__)) done(struct script_control *ctl)
 {
 	if (ctl->isterm)
@@ -291,7 +282,7 @@ static void do_io(struct script_control *ctl)
 	pfd[2].fd = ctl->sigfd;
 	pfd[2].events = POLLIN | POLLERR | POLLHUP;
 
-	my_strftime(buf, sizeof buf, "%c\n", localtime(&tvec));
+	strftime(buf, sizeof buf, "%c\n", localtime(&tvec));
 	fprintf(ctl->typescriptfp, _("Script started on %s"), buf);
 
 	while (!ctl->die) {
-- 
2.3.0

