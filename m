Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:56911 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686Ab2JHHI6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Oct 2012 03:08:58 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so3448340wib.1
        for <util-linux@vger.kernel.org>; Mon, 08 Oct 2012 00:08:56 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/14] pg: add noreturn function attributes
Date: Mon,  8 Oct 2012 08:08:13 +0100
Message-Id: <1349680100-18120-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
References: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/pg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/text-utils/pg.c b/text-utils/pg.c
index 0168ebc..4b3b668 100644
--- a/text-utils/pg.c
+++ b/text-utils/pg.c
@@ -208,7 +208,7 @@ static my_sighandler_t my_sigset(int sig, my_sighandler_t disp) {
 /*
  * Quit pg.
  */
-static void
+static void __attribute__((__noreturn__))
 quit(int status)
 {
 	exit(status < 0100 ? status : 077);
@@ -217,7 +217,7 @@ quit(int status)
 /*
  * Usage message and similar routines.
  */
-static void usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
@@ -240,14 +240,14 @@ static void usage(FILE * out)
 	quit(out == stderr ? 2 : 0);
 }
 
-static void
+static void __attribute__((__noreturn__))
 needarg(const char *s)
 {
 	warnx(_("option requires an argument -- %s"), s);
 	usage(stderr);
 }
 
-static void
+static void __attribute__((__noreturn__))
 invopt(const char *s)
 {
 	warnx(_("illegal option -- %s"), s);
@@ -926,7 +926,7 @@ makepat(void)
 /*
  * Process errors that occurred in temporary file operations.
  */
-static void
+static void __attribute__((__noreturn__))
 tmperr(FILE *f, const char *ftype)
 {
 	if (ferror(f))
-- 
1.7.12.2

