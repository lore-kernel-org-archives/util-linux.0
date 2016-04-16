Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36417 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbcDPSeQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Apr 2016 14:34:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id l6so13962981wml.3
        for <util-linux@vger.kernel.org>; Sat, 16 Apr 2016 11:34:15 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 5/7] script: check status of writes when closing outputs
Date: Sat, 16 Apr 2016 19:34:07 +0100
Message-Id: <1460831649-11484-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1460831649-11484-1-git-send-email-kerolasa@iki.fi>
References: <1460831649-11484-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This should make possible output issues more obvious, for example when a
disk will get full.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index d691c22..d2eaafb 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -204,9 +204,11 @@ static void __attribute__((__noreturn__)) done(struct script_control *ctl)
 	kill(ctl->child, SIGTERM);	/* make sure we don't create orphans */
 
 	if (ctl->timingfp)
-		fclose(ctl->timingfp);
+		if (close_stream(ctl->timingfp) != 0)
+			err(EXIT_FAILURE, "write failed: %s", ctl->tname);
 	if (ctl->typescriptfp)
-		fclose(ctl->typescriptfp);
+		if (close_stream(ctl->typescriptfp) != 0)
+			err(EXIT_FAILURE, "write failed: %s", ctl->fname);
 
 	if (ctl->rc_wanted) {
 		if (WIFSIGNALED(ctl->childstatus))
-- 
2.8.0

