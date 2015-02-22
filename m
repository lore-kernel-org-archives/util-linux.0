Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f42.google.com ([74.125.82.42]:47916 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbbBVOoE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:04 -0500
Received: by mail-wg0-f42.google.com with SMTP id n12so21299807wgh.1
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:03 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 06/31] more: use paths.h to find bourne shell and vi editor
Date: Sun, 22 Feb 2015 14:43:02 +0000
Message-Id: <1424616207-747-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 940d429..ba5459a 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -46,6 +46,7 @@
 #include <ctype.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <paths.h>
 #include <regex.h>
 #include <setjmp.h>
 #include <signal.h>
@@ -83,8 +84,6 @@
 # define XTABS	TAB3
 #endif
 
-#define VI	"vi"	/* found on the user's path */
-
 #define Fopen(s, m)	(ctl->Currline = 0, ctl->file_pos=0, fopen(s,m))
 #define Ftell(f)	ctl->file_pos
 #define Fseek(f, off)	(ctl->file_pos=off, fseek(f, off, 0))
@@ -1578,7 +1577,7 @@ static int command(struct more_control *ctl, char *filename, register FILE *f)
 				if (editor == NULL || *editor == '\0')
 					editor = getenv("EDITOR");
 				if (editor == NULL || *editor == '\0')
-					editor = VI;
+					editor = _PATH_VI;
 
 				p = strrchr(editor, '/');
 				if (p)
@@ -1839,7 +1838,7 @@ static void initterm(struct more_control *ctl)
 
 		}
 		if ((ctl->shell = getenv("SHELL")) == NULL)
-			ctl->shell = "/bin/sh";
+			ctl->shell = _PATH_BSHELL;
 	}
 	ctl->no_intty = tcgetattr(fileno(stdin), &ctl->otty);
 	tcgetattr(fileno(stderr), &ctl->otty);
-- 
2.3.0

