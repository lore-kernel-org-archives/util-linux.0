Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35279 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbdFHTwY (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 8 Jun 2017 15:52:24 -0400
Received: by mail-wr0-f193.google.com with SMTP id g76so4710712wrd.2
        for <util-linux@vger.kernel.org>; Thu, 08 Jun 2017 12:52:24 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 03/11] rename: notice when expression and replacement are the same string
Date: Thu,  8 Jun 2017 20:52:07 +0100
Message-Id: <20170608195215.1702-4-kerolasa@iki.fi>
In-Reply-To: <20170608195215.1702-1-kerolasa@iki.fi>
References: <20170608195215.1702-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The rename(1) can exit early when replace expression and replacement are
identical string.  It is also appropriate to change return value in this
case to 'nothing was renamed'.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/rename.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/misc-utils/rename.c b/misc-utils/rename.c
index a7671fa11..1cee40697 100644
--- a/misc-utils/rename.c
+++ b/misc-utils/rename.c
@@ -204,6 +204,9 @@ int main(int argc, char **argv)
 	from = argv[0];
 	to = argv[1];
 
+	if (!strcmp(from, to))
+		return RENAME_EXIT_NOTHING;
+
 	for (i = 2; i < argc; i++)
 		ret |= do_rename(from, to, argv[i], verbose, noact, nooverwrite);
 
-- 
2.13.1

