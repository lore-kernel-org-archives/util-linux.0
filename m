Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35192 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbcEIV1o (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 9 May 2016 17:27:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id e201so22544587wme.2
        for <util-linux@vger.kernel.org>; Mon, 09 May 2016 14:27:44 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 05/12] write: use xstrncpy() from strutils.h
Date: Mon,  9 May 2016 22:27:21 +0100
Message-Id: <1462829248-6935-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
References: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier if the tty path was exactly length of the maximum ut_line then last
character of the path was overwrote by \0.  In practise this is a
theoretical bug as it is unheard that a tty device path could be 32
characters long.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index dd31f59..ed508d4 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -63,6 +63,7 @@
 #include "carefulputc.h"
 #include "closestream.h"
 #include "nls.h"
+#include "strutils.h"
 #include "xalloc.h"
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
@@ -164,8 +165,7 @@ static void search_utmp(char *user, char *tty, char *mytty, uid_t myuid)
 		memcpy(&u, uptr, sizeof(u));
 		if (strncmp(user, u.ut_user, sizeof(u.ut_user)) == 0) {
 			++nloggedttys;
-			strncpy(atty, u.ut_line, sizeof(u.ut_line));
-			atty[sizeof(u.ut_line)] = '\0';
+			xstrncpy(atty, u.ut_line, sizeof(atty));
 			if (term_chk(atty, &msgsok, &atime, 0))
 				/* bad term? skip */
 				continue;
-- 
2.8.2

