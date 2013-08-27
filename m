Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f44.google.com ([74.125.83.44]:50524 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab3H0SHE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Aug 2013 14:07:04 -0400
Received: by mail-ee0-f44.google.com with SMTP id b47so2459381eek.31
        for <util-linux@vger.kernel.org>; Tue, 27 Aug 2013 11:07:02 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/17] write: change determination can user write to a terminal
Date: Tue, 27 Aug 2013 19:06:11 +0100
Message-Id: <1377626779-26030-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier test failed when user had write permission, but was not in
special group that owns terminal devices, usually tty.

This made write(1) to fail for root, if the root did not happen to be in
tty group.  In this commit root is granted ot write to anyone, even if
they have mesg(1) turned off.  For an user who is trying to write to own
other session the group write bit is significant only for whether mesg(1)
are enabled.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index cb3b044..1738694 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -73,7 +73,7 @@ static void __attribute__ ((__noreturn__)) done(int);
 int term_chk(char *, int *, time_t *, int);
 int utmp_chk(char *, char *);
 
-static gid_t myegid;
+static gid_t root_access;
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
@@ -120,7 +120,7 @@ int main(int argc, char **argv)
 			usage(stderr);
 		}
 
-	myegid = getegid();
+	root_access = !getegid();
 
 	/* check that sender has write enabled */
 	if (isatty(fileno(stdin)))
@@ -299,8 +299,9 @@ int term_chk(char *tty, int *msgsokP, time_t * atimeP, int showerror)
 		return 1;
 	}
 
-	/* group write bit and group ownership */
-	*msgsokP = (s.st_mode & (S_IWRITE >> 3)) && myegid == s.st_gid;
+	*msgsokP = !access(path, W_OK);
+	if (!root_access && *msgsokP)
+		*msgsokP = s.st_mode & S_IWGRP;
 	*atimeP = s.st_atime;
 	return 0;
 }
-- 
1.8.4

