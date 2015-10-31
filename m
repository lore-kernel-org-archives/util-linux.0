Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35708 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbbJaTVe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 31 Oct 2015 15:21:34 -0400
Received: by wmll128 with SMTP id l128so33767820wml.0
        for <util-linux@vger.kernel.org>; Sat, 31 Oct 2015 12:21:33 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 03/12] fsck: retire stat(3) when access(3) does better job
Date: Sat, 31 Oct 2015 19:21:15 +0000
Message-Id: <1446319284-24778-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
References: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The stat(3) and access(3) are in this case almost interchangeable, so choose
the lightweight function with additional advantage checking the file is
executable.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fsck.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index ff504aa..5be2b44 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -547,14 +547,13 @@ static char *find_fsck(const char *type)
 	const char *tpl;
 	static char prog[256];
 	char *p = xstrdup(fsck_path);
-	struct stat st;
 
 	/* Are we looking for a program or just a type? */
 	tpl = (strncmp(type, "fsck.", 5) ? "%s/fsck.%s" : "%s/%s");
 
 	for(s = strtok(p, ":"); s; s = strtok(NULL, ":")) {
 		sprintf(prog, tpl, s, type);
-		if (stat(prog, &st) == 0)
+		if (access(prog, X_OK) == 0)
 			break;
 	}
 	free(p);
-- 
2.6.2

