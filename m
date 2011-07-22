Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41148 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132Ab1GVUPq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 22 Jul 2011 16:15:46 -0400
Received: by ewy4 with SMTP id 4so1851188ewy.19
        for <util-linux@vger.kernel.org>; Fri, 22 Jul 2011 13:15:44 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] scriptreplay: fscanf portability fix
Date: Fri, 22 Jul 2011 22:15:40 +0200
Message-Id: <1311365740-6251-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a fix to an issue with llvm clang which I reported
earlier.

http://www.spinics.net/lists/util-linux-ng/msg04331.html

When compiling with clang fscanf format string %[\n] will not
work. For now using %c in format string seems to be best option.

p.s. The llvm people are informed about the issue.
http://llvm.org/bugs/show_bug.cgi?id=10443

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/scriptreplay.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/term-utils/scriptreplay.c b/term-utils/scriptreplay.c
index 96993d5..7f1b497 100644
--- a/term-utils/scriptreplay.c
+++ b/term-utils/scriptreplay.c
@@ -203,7 +203,7 @@ main(int argc, char *argv[])
 		size_t blk;
 		char nl;
 
-		if ((fscanf(tfile, "%lf %zd%[\n]\n", &delay, &blk, &nl) != 3) ||
+		if ((fscanf(tfile, "%lf %zd%c\n", &delay, &blk, &nl) != 3) ||
 							(nl != '\n')) {
 			if (feof(tfile))
 				break;
-- 
1.7.6

