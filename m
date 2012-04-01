Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:62944 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab2DASUc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Apr 2012 14:20:32 -0400
Received: by eekc41 with SMTP id c41so638975eek.19
        for <util-linux@vger.kernel.org>; Sun, 01 Apr 2012 11:20:31 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/3] script: error in usage() output
Date: Sun,  1 Apr 2012 20:19:31 +0200
Message-Id: <1333304372-25944-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1333304372-25944-1-git-send-email-kerolasa@iki.fi>
References: <20120330150457.GE23437@x2.net.home>
 <1333304372-25944-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Error originates to commit 3ff526391fb5c6b33418dc9cfec31c2ff9b4792e
which is bit more than year, and part or releases v2.20 & v2.21.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 0d891b8..effedac 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -133,7 +133,7 @@ usage(FILE *out)
 	fputs(_("\nOptions:\n"), out);
 	fputs(_(" -a, --append            append the output\n"
 		" -c, --command <command> run command rather than interactive shell\n"
-		" -r, --return            return exit code of the child process\n"
+		" -e, --return            return exit code of the child process\n"
 		" -f, --flush             run flush after each write\n"
 		"     --force             use output file even when it is a link\n"
 		" -q, --quiet             be quiet\n"
-- 
1.7.9.5

