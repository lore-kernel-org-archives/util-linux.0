Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f169.google.com ([209.85.212.169]:47898 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbbBHUor (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Feb 2015 15:44:47 -0500
Received: by mail-wi0-f169.google.com with SMTP id z2so1815284wiv.0
        for <util-linux@vger.kernel.org>; Sun, 08 Feb 2015 12:44:45 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/2] rename: use strrchr() instead of rindex()
Date: Sun,  8 Feb 2015 20:44:40 +0000
Message-Id: <1423428281-12040-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The rindex() is marked legacy in POSIX.1-2001, and apparently Androids
bionic libc does not even have it so it is best not to use the legacy
interface.

Reference: https://lists.gnu.org/archive/html/weechat-dev/2014-02/msg00004.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/rename.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/rename.c b/misc-utils/rename.c
index f9cc3a5..7ac068d 100644
--- a/misc-utils/rename.c
+++ b/misc-utils/rename.c
@@ -95,7 +95,7 @@ static int do_file(char *from, char *to, char *s, int verbose)
 	char *newname = NULL, *file;
 	int ret = 1;
 
-	file = rindex(s, '/');
+	file = strrchr(s, '/');
 	if (file == NULL)
 		file = s;
 	if (string_replace(from, to, file, s, &newname))
-- 
2.3.0

