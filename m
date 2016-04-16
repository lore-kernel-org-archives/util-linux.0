Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36406 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbcDPSeP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Apr 2016 14:34:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id l6so13962875wml.3
        for <util-linux@vger.kernel.org>; Sat, 16 Apr 2016 11:34:14 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 4/7] script: avoid trying fclose(NULL)
Date: Sat, 16 Apr 2016 19:34:06 +0100
Message-Id: <1460831649-11484-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1460831649-11484-1-git-send-email-kerolasa@iki.fi>
References: <1460831649-11484-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Here is a one-liner to reproduce the issue.

$ mkdir example && cd example && chmod 0500 . && script
Script started, file is typescript
script: cannot open typescript: Permission denied
                                                 Script done, file is typescript
Segmentation fault (core dumped)

Addresses: https://bugs.launchpad.net/bugs/1537518
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 279b9ec..d691c22 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -205,7 +205,8 @@ static void __attribute__((__noreturn__)) done(struct script_control *ctl)
 
 	if (ctl->timingfp)
 		fclose(ctl->timingfp);
-	fclose(ctl->typescriptfp);
+	if (ctl->typescriptfp)
+		fclose(ctl->typescriptfp);
 
 	if (ctl->rc_wanted) {
 		if (WIFSIGNALED(ctl->childstatus))
-- 
2.8.0

