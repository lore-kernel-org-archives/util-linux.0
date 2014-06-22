Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f178.google.com ([74.125.82.178]:41523 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbaFVKcM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Jun 2014 06:32:12 -0400
Received: by mail-we0-f178.google.com with SMTP id x48so5506305wes.37
        for <util-linux@vger.kernel.org>; Sun, 22 Jun 2014 03:32:11 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/6] rename: allow renaming in subdirectories
Date: Sun, 22 Jun 2014 11:31:52 +0100
Message-Id: <1403433117-32652-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1403433117-32652-1-git-send-email-kerolasa@iki.fi>
References: <1403433117-32652-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier the rename(1) considered path as possible string to be renamed,
could lead to an issue with none existing destination.  See below for
demonstration of this issue.  After this change all directory elements
are ignored when the match finding happens.

$ cd $(mktemp -d)
$ mkdir aa ab
$ touch a{a,b}/aa
$ rename -v a x */aa
rename: aa/aa: rename to xa/aa failed: No such file or directory

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/rename.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/misc-utils/rename.c b/misc-utils/rename.c
index 9db85fb..b945aaa 100644
--- a/misc-utils/rename.c
+++ b/misc-utils/rename.c
@@ -46,9 +46,14 @@ static int do_rename(char *from, char *to, char *s, int verbose, int symtarget)
 
 		target[sb.st_size] = '\0';
 		where = strstr(target, from);
-	} else
-		where = strstr(s, from);
+	} else {
+		char *file;
 
+		file = rindex(s, '/');
+		if (file == NULL)
+			file = s;
+		where = strstr(file, from);
+	}
 	if (where == NULL) {
 		free(target);
 		return 0;
-- 
2.0.0

