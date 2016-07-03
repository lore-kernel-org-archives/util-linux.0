Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36860 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163AbcGCVYE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Jul 2016 17:24:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id c82so17534654wme.3
        for <util-linux@vger.kernel.org>; Sun, 03 Jul 2016 14:24:03 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 01/15] write: remove unused variable
Date: Sun,  3 Jul 2016 22:23:44 +0100
Message-Id: <20160703212358.1218-2-kerolasa@iki.fi>
In-Reply-To: <20160703212358.1218-1-kerolasa@iki.fi>
References: <20160703212358.1218-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index 7c15231..0afa46a 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -73,8 +73,6 @@ static void __attribute__ ((__noreturn__)) done(int);
 int term_chk(char *, int *, time_t *, int);
 int utmp_chk(char *, char *);
 
-static gid_t root_access;
-
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
@@ -122,8 +120,6 @@ int main(int argc, char **argv)
 			usage(stderr);
 		}
 
-	root_access = !getegid();
-
 	/* check that sender has write enabled */
 	if (isatty(fileno(stdin)))
 		myttyfd = fileno(stdin);
-- 
2.9.0

